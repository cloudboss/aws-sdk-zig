package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class AwsJsonProtocol(private val version: String) : ProtocolGenerator {

    override fun contentType(): String = "application/x-amz-json-$version"

    override fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext) {
        val inputName = "${ctx.operationName}Input"
        val targetPrefix = ctx.service.id.name
        val amzTarget = "$targetPrefix.${ctx.operationName}"

        writer.openBlock(
            "fn serializeRequest(alloc: std.mem.Allocator, input: \$L, config: *aws.Config) !aws.http.Request {",
            inputName,
        )

        val hasMembers = ctx.inputShape.allMembers.isNotEmpty()

        if (!hasMembers) {
            writer.write("_ = input;")
        }

        // Build endpoint
        writer.write(
            "const endpoint = try config.getEndpointForService(\"\$L\", \"\$L\", alloc);",
            ctx.settings.packageName, ctx.settings.sdkId,
        )
        writer.blankLine()

        // Parse host from endpoint
        writer.write("const host = aws.url.parseHost(endpoint);")
        writer.write("const tls = !std.mem.startsWith(u8, endpoint, \"http://\");")
        writer.write("const port = aws.url.parsePort(endpoint);")
        writer.blankLine()

        // Build JSON body
        if (hasMembers) {
            writer.write("const body = try aws.json.jsonStringify(input, alloc);")
        } else {
            writer.write("const body = \"{}\";")
        }
        writer.blankLine()

        // Build request
        writer.write("var request = aws.http.Request.init(host);")
        writer.write("request.method = .POST;")
        writer.write("request.path = \"/\";")
        writer.write("request.tls = tls;")
        writer.write("request.port = port;")
        writer.write("request.body = body;")
        writer.write("try request.headers.put(alloc, \"Content-Type\", \"\$L\");", contentType())
        writer.write("try request.headers.put(alloc, \"X-Amz-Target\", \"\$L\");", amzTarget)
        writer.blankLine()

        writer.write("return request;")
        writer.closeBlock("}")
    }

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val hasMembers = ctx.outputShape.allMembers.isNotEmpty()

        writer.openBlock(
            "fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )
        writer.write("_ = status;")
        writer.write("_ = headers;")

        if (!hasMembers) {
            writer.write("_ = body;")
            writer.write("_ = alloc;")
            writer.write("return .{};")
        } else {
            writer.write("if (body.len == 0) return .{};")
            writer.write("return aws.json.parseJsonObject(\$L, body, alloc);", outputName)
        }

        writer.closeBlock("}")
    }

    override fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        // Extract error code from __type, stripping namespace prefix
        writer.openBlock("const error_code = blk: {")
        writer.write("const type_str = aws.json.findJsonValue(body, \"__type\") orelse break :blk @as([]const u8, \"Unknown\");")
        writer.openBlock("if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {")
        writer.write("break :blk type_str[idx + 1 ..];")
        writer.closeBlock("}")
        writer.write("break :blk type_str;")
        writer.closeBlock("};")

        // Extract error message (try both "message" and "Message")
        writer.write("const error_message = aws.json.findJsonValue(body, \"message\") orelse aws.json.findJsonValue(body, \"Message\") orelse \"\";")
        writer.blankLine()

        // Match error codes to ServiceError variants
        for (info in ctx.errorInfos) {
            writer.openBlock("if (std.mem.eql(u8, error_code, \"\$L\")) {", info.smithyName)
            writer.write("return .{ .\$L = .{", info.variantName)
            writer.write("    .message = error_message,")
            writer.write("    .request_id = \"\",")
            writer.write("} };")
            writer.closeBlock("}")
        }

        writer.blankLine()
        writer.write("return .{ .unknown = .{")
        writer.write("    .code = error_code,")
        writer.write("    .message = error_message,")
        writer.write("    .request_id = \"\",")
        writer.write("    .http_status = status,")
        writer.write("} };")

        writer.closeBlock("}")
    }
}
