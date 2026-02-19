package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.aws.traits.ServiceTrait
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.aws.AwsZigIntegration
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class AwsProtocolProvider : AwsZigIntegration {
    override fun preprocessModel(model: Model, settings: ZigSettings): Model {
        val serviceTrait = model.expectShape(settings.service)
            .getTrait(ServiceTrait::class.java)
        settings.sdkId = serviceTrait.map { it.sdkId }.orElse(settings.packageName)
        return model
    }

    override fun resolveProtocol(service: ServiceShape, model: Model): ProtocolGenerator? {
        return when {
            service.hasTrait("aws.protocols#awsQuery") -> AwsQueryProtocol()
            service.hasTrait("aws.protocols#ec2Query") -> Ec2QueryProtocol()
            service.hasTrait("aws.protocols#awsJson1_0") -> AwsJsonProtocol("1.0")
            service.hasTrait("aws.protocols#awsJson1_1") -> AwsJsonProtocol("1.1")
            service.hasTrait("aws.protocols#restJson1") -> RestJsonProtocol()
            service.hasTrait("aws.protocols#restXml") -> RestXmlProtocol()
            else -> null
        }
    }
}
