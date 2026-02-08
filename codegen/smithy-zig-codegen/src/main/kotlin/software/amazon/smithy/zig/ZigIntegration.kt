package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.SmithyIntegration
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.protocols.ProtocolGenerator

interface ZigIntegration : SmithyIntegration<ZigSettings, ZigWriter, ZigContext> {
    fun resolveProtocol(service: ServiceShape, model: Model): ProtocolGenerator? = null
}
