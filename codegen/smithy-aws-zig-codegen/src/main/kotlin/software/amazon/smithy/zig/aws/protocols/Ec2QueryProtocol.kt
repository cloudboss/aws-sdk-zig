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
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {")

        writer.write("const error_code = aws.xml.findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = aws.xml.findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = aws.xml.findElement(body, \"RequestID\") orelse \"\";")
        writer.write("var arena = std.heap.ArenaAllocator.init(alloc);")
        writer.write("errdefer arena.deinit();")
        writer.write("const arena_alloc = arena.allocator();")
        writer.write("const owned_message = try arena_alloc.dupe(u8, error_message);")
        writer.write("const owned_request_id = try arena_alloc.dupe(u8, request_id);")
        writer.blankLine()

        // Match error codes to ServiceError variants
        for (info in ctx.errorInfos) {
            writer.openBlock("if (std.mem.eql(u8, error_code, \"\$L\")) {", info.smithyName)
            writer.write("return .{ .arena = arena, .kind = .{ .\$L = .{", info.variantName)
            writer.write("    .message = owned_message,")
            writer.write("    .request_id = owned_request_id,")
            writer.write("} } };")
            writer.closeBlock("}")
        }

        writer.blankLine()
        writer.write("const owned_code = try arena_alloc.dupe(u8, error_code);")
        writer.write("return .{ .arena = arena, .kind = .{ .unknown = .{")
        writer.write("    .code = owned_code,")
        writer.write("    .message = owned_message,")
        writer.write("    .request_id = owned_request_id,")
        writer.write("    .http_status = status,")
        writer.write("} } };")

        writer.closeBlock("}")
    }
}
