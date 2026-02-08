package software.amazon.smithy.zig.protocols

import software.amazon.smithy.zig.ZigWriter

interface ProtocolGenerator {
    fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext)
    fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext)
    fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext)
    fun contentType(): String
}
