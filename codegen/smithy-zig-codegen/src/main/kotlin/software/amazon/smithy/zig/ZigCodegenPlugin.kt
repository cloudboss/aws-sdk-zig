package software.amazon.smithy.zig

import software.amazon.smithy.build.PluginContext
import software.amazon.smithy.build.SmithyBuildPlugin
import software.amazon.smithy.codegen.core.directed.CodegenDirector

class ZigCodegenPlugin : SmithyBuildPlugin {
    override fun getName(): String = "zig-codegen"

    override fun execute(context: PluginContext) {
        val settings = ZigSettings.fromNode(context.settings)

        val runner = CodegenDirector<ZigWriter, ZigIntegration, ZigContext, ZigSettings>()
        runner.directedCodegen(DirectedZigCodegen())
        runner.integrationClass(ZigIntegration::class.java)
        runner.fileManifest(context.fileManifest)
        runner.model(context.model)
        runner.settings(settings)
        runner.service(settings.service)
        runner.performDefaultCodegenTransforms()
        runner.changeStringEnumsToEnumShapes(false)
        runner.sortMembers()
        runner.run()
    }
}
