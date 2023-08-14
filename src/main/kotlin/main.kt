import org.json.JSONObject
import org.json.JSONArray
import org.json.XML

import edu.mit.csail.sdg.alloy4.A4Reporter
import edu.mit.csail.sdg.alloy4.ErrorWarning
import edu.mit.csail.sdg.alloy4compiler.parser.CompUtil
import edu.mit.csail.sdg.alloy4compiler.translator.A4Options
import edu.mit.csail.sdg.alloy4compiler.translator.TranslateAlloyToKodkod
import edu.mit.csail.sdg.alloy4viz.VizGUI
import java.io.File

fun main(args: Array<String>) {
    val PRETTY_PRINT_INDENT_FACTOR = 2
    val reporter = object: A4Reporter() {
        override fun warning(msg: ErrorWarning) {
            for (line in msg.message!!.lines()) {
                println("# $msg")
            }
        }
    }
    val options = A4Options()
    options.solver = A4Options.SatSolver.SAT4J

    if (args.size < 1) {
        usage()
    }

    var modeVisualize = false
    var file: String? = null
    for (arg in args) {
        if (arg == "-V") {
            modeVisualize = true
        } else if (arg[0] == '-') {
            usage()
        } else {
            file = arg
        }
    }

    if (file == null) {
        usage()
    } else {
        val world = CompUtil.parseEverything_fromFile(reporter, null, file)
        val commands = world.allCommands
        var failed = false
        //println("1..${commands.indices.last + 1}")
        val output = JSONObject();
        for (i in commands.indices) {
            val command = commands[i]
            val solution = TranslateAlloyToKodkod.execute_command(reporter, world.allReachableSigs, command, options);
            java.lang.System.err.println(solution.toString())
            val fileName = "bonk.xml";
            solution.writeXML(fileName);
            val f = File(fileName).readText();
            val jsonObj = XML.toJSONObject(f);
            if (command.check != solution.satisfiable()) {
                output.accumulate(
                  "$command", 
                  jsonObj.getJSONObject("alloy").getJSONObject("instance").getJSONArray("skolem"))
            } else {
                java.lang.System.err.println("failed: $command")
                if (modeVisualize) {
                    val outputXML = kotlin.io.createTempFile()
                    solution.writeXML(outputXML.path)
                    VizGUI(false, outputXML.path, null)
                }
                failed = true
                output.accumulate("$command", jsonObj.getJSONObject("alloy"))
            }
        }
        val jsonPrettyPrintString = output.toString(PRETTY_PRINT_INDENT_FACTOR)
        java.lang.System.out.println(jsonPrettyPrintString)
        if (failed && !modeVisualize) {
            kotlin.system.exitProcess(2)
        }
        else { kotlin.system.exitProcess(0) }
    }
}

fun usage() {
    println("usage: alloy-run [-V] <file>")
    kotlin.system.exitProcess(1)
}
