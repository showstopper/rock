import io/File
import structs/[List, ArrayList]
import ../[BuildParams]
import ../../middle/Module
import ../../backend/cnaughty/CGenerator
import Driver

/**
   Dummy driver, which only generates the .c source code

   Use it with --onlygen or --driver=dummy

   :author: Amos Wenger (nddrylliog)
 */
DummyDriver: class extends Driver {

    init: func (.params) {
        super(params)
    }

    compile: func (module: Module) -> Int {

        params outPath mkdirs()
        for(candidate in module collectDeps()) {
            CGenerator new(params, candidate) write()
        }

        params compiler reset()

        copyLocalHeaders(module, params, ArrayList<Module> new())

        if (params verbose) {
            "Generated sources in %s, enjoy!" format(params outPath path) println()
        }

        0

    }

}
