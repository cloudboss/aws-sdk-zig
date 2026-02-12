package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext

class Ec2QueryProtocol : AwsQueryProtocol() {

    override fun writeSkipToResultWrapper(writer: ZigWriter, ctx: OperationContext) {
        // EC2 Query: members are directly under root element, no Result wrapper
        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.write(".element_start => break,")
        writer.write("else => {},")
        writer.closeBlock("}")
        writer.closeBlock("}")
    }

    override fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        writer.write("const error_code = findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = findElement(body, \"RequestID\") orelse \"\";")
        writer.blankLine()

        // Match error codes to ServiceError variants
        for (info in ctx.errorInfos) {
            writer.openBlock("if (std.mem.eql(u8, error_code, \"\$L\")) {", info.smithyName)
            writer.write("return .{ .\$L = .{", info.variantName)
            writer.write("    .message = error_message,")
            writer.write("    .request_id = request_id,")
            writer.write("} };")
            writer.closeBlock("}")
        }

        writer.blankLine()
        writer.write("return .{ .unknown = .{")
        writer.write("    .code = error_code,")
        writer.write("    .message = error_message,")
        writer.write("    .request_id = request_id,")
        writer.write("    .http_status = status,")
        writer.write("} };")

        writer.closeBlock("}")
        writer.blankLine()

        // Helper functions
        writeHelperFunctions(writer)
    }
}
