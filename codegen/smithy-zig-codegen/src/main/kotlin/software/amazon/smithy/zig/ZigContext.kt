package software.amazon.smithy.zig

import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.CodegenContext
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ServiceShape
import java.util.Optional

class ZigContext(
    private val model: Model,
    private val settings: ZigSettings,
    private val symbolProvider: SymbolProvider,
    private val fileManifest: FileManifest,
    private val writerDelegator: WriterDelegator<ZigWriter>,
    private val integrations: List<ZigIntegration>,
    val service: ServiceShape,
) : CodegenContext<ZigSettings, ZigWriter, ZigIntegration> {

    override fun model(): Model = model

    override fun settings(): ZigSettings = settings

    override fun symbolProvider(): SymbolProvider = symbolProvider

    override fun fileManifest(): FileManifest = fileManifest

    override fun sharedFileManifest(): Optional<FileManifest> = Optional.empty()

    override fun writerDelegator(): WriterDelegator<ZigWriter> = writerDelegator

    override fun integrations(): List<ZigIntegration> = integrations
}
