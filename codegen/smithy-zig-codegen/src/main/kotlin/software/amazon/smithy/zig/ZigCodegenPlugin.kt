package software.amazon.smithy.zig

import software.amazon.smithy.build.PluginContext
import software.amazon.smithy.build.SmithyBuildPlugin
import software.amazon.smithy.codegen.core.directed.CodegenDirector
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.InternalTrait
import software.amazon.smithy.model.transform.ModelTransformer

internal fun removeInternalOperations(model: Model): Model =
    ModelTransformer.create().removeShapesIf(model) { declaration ->
        if (!declaration.isOperationShape) {
            false
        } else {
            val documentation = DocConverter.convert(
                declaration.getTrait(DocumentationTrait::class.java).map { it.value }.orElse(null),
            ).joinToString(" ").replace(Regex("\\s+"), " ").trim().lowercase()
            declaration.hasTrait(InternalTrait::class.java) ||
                documentation.startsWith("this is for internal use.") ||
                documentation.startsWith("this is for internal use only.") ||
                documentation.startsWith("for internal use only.") ||
                listOf(
                    "for internal aws use only",
                    "for aws internal use only",
                    "not yet available to external customers",
                    "not available to external customers",
                ).any { it in documentation }
        }
    }

class ZigCodegenPlugin : SmithyBuildPlugin {
    override fun getName(): String = "zig-codegen"

    override fun execute(context: PluginContext) {
        val settings = ZigSettings.fromNode(context.settings)

        val runner = CodegenDirector<ZigWriter, ZigIntegration, ZigContext, ZigSettings>()
        runner.directedCodegen(DirectedZigCodegen())
        runner.integrationClass(ZigIntegration::class.java)
        runner.fileManifest(context.fileManifest)
        runner.model(removeInternalOperations(context.model))
        runner.settings(settings)
        runner.service(settings.service)
        runner.performDefaultCodegenTransforms()
        runner.changeStringEnumsToEnumShapes(false)
        runner.sortMembers()
        runner.run()
    }
}
