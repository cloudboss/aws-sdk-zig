package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.codegen.core.directed.CreateContextDirective
import software.amazon.smithy.codegen.core.directed.CreateSymbolProviderDirective
import software.amazon.smithy.codegen.core.directed.CustomizeDirective
import software.amazon.smithy.codegen.core.directed.DirectedCodegen
import software.amazon.smithy.codegen.core.directed.GenerateEnumDirective
import software.amazon.smithy.codegen.core.directed.GenerateErrorDirective
import software.amazon.smithy.codegen.core.directed.GenerateIntEnumDirective
import software.amazon.smithy.codegen.core.directed.GenerateServiceDirective
import software.amazon.smithy.codegen.core.directed.GenerateStructureDirective
import software.amazon.smithy.codegen.core.directed.GenerateUnionDirective
import software.amazon.smithy.zig.generators.EnumGenerator
import software.amazon.smithy.zig.generators.IntEnumGenerator
import software.amazon.smithy.zig.generators.ServiceGenerator
import software.amazon.smithy.zig.generators.StructureGenerator
import software.amazon.smithy.zig.generators.UnionGenerator

class DirectedZigCodegen :
    DirectedCodegen<ZigContext, ZigSettings, ZigIntegration> {

    override fun createSymbolProvider(
        directive: CreateSymbolProviderDirective<ZigSettings>,
    ): SymbolProvider {
        return ZigSymbolVisitor(directive.model(), directive.settings().packageName)
    }

    override fun createContext(
        directive: CreateContextDirective<ZigSettings, ZigIntegration>,
    ): ZigContext {
        val delegator = WriterDelegator(
            directive.fileManifest(),
            directive.symbolProvider(),
            ZigWriter.factory(),
        )
        return ZigContext(
            model = directive.model(),
            settings = directive.settings(),
            symbolProvider = directive.symbolProvider(),
            fileManifest = directive.fileManifest(),
            writerDelegator = delegator,
            integrations = directive.integrations(),
            service = directive.service(),
        )
    }

    override fun generateService(
        directive: GenerateServiceDirective<ZigContext, ZigSettings>,
    ) {
        ServiceGenerator(
            directive.context(),
            directive.service(),
            directive.model(),
        ).run()
    }

    override fun generateStructure(
        directive: GenerateStructureDirective<ZigContext, ZigSettings>,
    ) {
        StructureGenerator(directive).run()
    }

    override fun generateError(
        directive: GenerateErrorDirective<ZigContext, ZigSettings>,
    ) {
        StructureGenerator(
            directive.context(),
            directive.shape(),
            directive.symbolProvider(),
            directive.symbol(),
        ).run()
    }

    override fun generateUnion(
        directive: GenerateUnionDirective<ZigContext, ZigSettings>,
    ) {
        UnionGenerator(directive).run()
    }

    override fun generateEnumShape(
        directive: GenerateEnumDirective<ZigContext, ZigSettings>,
    ) {
        EnumGenerator(directive).run()
    }

    override fun generateIntEnumShape(
        directive: GenerateIntEnumDirective<ZigContext, ZigSettings>,
    ) {
        IntEnumGenerator(directive).run()
    }

    override fun customizeAfterIntegrations(
        directive: CustomizeDirective<ZigContext, ZigSettings>,
    ) {
        directive.context().writerDelegator().flushWriters()
    }
}
