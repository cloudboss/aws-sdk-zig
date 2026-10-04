package software.amazon.smithy.zig.protocols

import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.StreamingTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.generators.ErrorGenerator

interface ProtocolGenerator {
    fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext)
    fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext)
    fun writeDeserializeStreamingResponse(writer: ZigWriter, ctx: OperationContext) {
        val payload = ctx.outputShape.allMembers.entries.first { (_, member) ->
            val target = ctx.model.expectShape(member.target)
            target is UnionShape && target.hasTrait(StreamingTrait::class.java)
        }
        writer.openBlock(
            "fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !\$L {",
            "${ctx.operationName}Output",
        )
        writer.openBlock("const result: \$L = .{", "${ctx.operationName}Output")
        writer.openBlock(
            ".\$L = try aws.event_stream_reader.EventStreamReader.init(",
            NamingUtil.toFieldName(payload.key),
        )
        writer.write("allocator,")
        writer.write("stream_resp.body,")
        writer.closeBlock("),")
        writer.closeBlock("};")
        writer.write("stream_resp.deinitHeaders();")
        writer.write("return result;")
        writer.closeBlock("}")
    }
    fun writeParseErrorResponse(writer: ZigWriter, errorInfos: List<ErrorGenerator.ErrorInfo>)
    fun contentType(): String
    fun needsXmlSerde(): Boolean = false
}
