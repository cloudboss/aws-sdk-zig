package software.amazon.smithy.zig.protocols

import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.generators.ErrorGenerator

interface ProtocolGenerator {
    fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext)
    fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext)
    fun writeDeserializeStreamingResponse(writer: ZigWriter, ctx: OperationContext) {
        // Default: no-op. Only REST protocols (JSON, XML) implement this.
    }
    fun writeParseErrorResponse(writer: ZigWriter, errorInfos: List<ErrorGenerator.ErrorInfo>)
    fun contentType(): String
    fun needsXmlSerde(): Boolean = false
}
