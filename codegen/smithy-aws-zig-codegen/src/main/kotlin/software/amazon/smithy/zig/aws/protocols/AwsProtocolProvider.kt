package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.aws.AwsZigIntegration
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class AwsProtocolProvider : AwsZigIntegration {
    override fun resolveProtocol(service: ServiceShape, model: Model): ProtocolGenerator? {
        return when {
            service.hasTrait("aws.protocols#awsQuery") -> AwsQueryProtocol()
            else -> null
        }
    }
}
