package software.amazon.smithy.zig

import software.amazon.smithy.model.node.ObjectNode
import software.amazon.smithy.model.shapes.ShapeId

class ZigSettings(
    val service: ShapeId,
    val packageName: String,
    val outputDir: String,
    var sdkId: String = "",
    var endpointPrefix: String = "",
    var signingName: String = "",
) {
    init {
        if (sdkId.isEmpty()) sdkId = packageName
        if (endpointPrefix.isEmpty()) endpointPrefix = packageName
        if (signingName.isEmpty()) signingName = packageName
    }

    companion object {
        @JvmStatic
        fun fromNode(node: ObjectNode): ZigSettings {
            val service = node.expectStringMember("service").expectShapeId()
            val packageName = node.expectStringMember("package").value
            val outputDir = node.getStringMemberOrDefault("outputDir", ".")
            return ZigSettings(service, packageName, outputDir)
        }
    }
}
