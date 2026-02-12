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
        writer.write("const endpoint = try config.getEndpoint(\"\$L\", alloc);", ctx.settings.packageName)
        writer.blankLine()

        // Parse host from endpoint
        writer.write("const host = parseHost(endpoint);")
        writer.write("const tls = !std.mem.startsWith(u8, endpoint, \"http://\");")
        writer.write("const port = parsePort(endpoint);")
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
        writer.write("const type_str = findJsonValue(body, \"__type\") orelse break :blk @as([]const u8, \"Unknown\");")
        writer.openBlock("if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {")
        writer.write("break :blk type_str[idx + 1 ..];")
        writer.closeBlock("}")
        writer.write("break :blk type_str;")
        writer.closeBlock("};")

        // Extract error message (try both "message" and "Message")
        writer.write("const error_message = findJsonValue(body, \"message\") orelse findJsonValue(body, \"Message\") orelse \"\";")
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
        writer.blankLine()

        // Helper functions
        writeJsonHelperFunctions(writer)
    }

    private fun writeJsonHelperFunctions(writer: ZigWriter) {
        writeFindJsonValueHelper(writer)
        writer.blankLine()
        writeHostParseHelpers(writer)
    }

    private fun writeFindJsonValueHelper(writer: ZigWriter) {
        // Generates a simple JSON value finder that searches for "key": value
        // Uses 0x22 for double-quote char to avoid Kotlin/Zig escaping issues
        writer.openBlock("fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {")
        writer.write("// Build search pattern: \"key\"")
        writer.write("var buf: [258]u8 = undefined;")
        writer.write("if (key.len + 2 > buf.len) return null;")
        writer.write("buf[0] = 0x22; // double-quote")
        writer.write("@memcpy(buf[1..][0..key.len], key);")
        writer.write("buf[key.len + 1] = 0x22; // double-quote")
        writer.write("const search = buf[0 .. key.len + 2];")
        writer.write("const key_start = std.mem.indexOf(u8, json, search) orelse return null;")
        writer.write("var pos = key_start + search.len;")
        writer.blankLine()

        // Skip whitespace and colon
        writer.write("// Skip whitespace and colon")
        writer.openBlock("while (pos < json.len) : (pos += 1) {")
        writer.write("if (json[pos] != ' ' and json[pos] != ':') break;")
        writer.closeBlock("}")
        writer.write("if (pos >= json.len) return null;")
        writer.blankLine()

        // String value - check for 0x22 (double-quote)
        writer.openBlock("if (json[pos] == 0x22) {")
        writer.write("const start = pos + 1;")
        writer.write("const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;")
        writer.write("return json[start..end];")
        writer.closeBlock("}")
        writer.blankLine()

        // Boolean or number - read until delimiter
        writer.write("const start = pos;")
        writer.openBlock("while (pos < json.len) : (pos += 1) {")
        writer.write("if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;")
        writer.closeBlock("}")
        writer.write("return json[start..pos];")

        writer.closeBlock("}")
    }

    private fun writeHostParseHelpers(writer: ZigWriter) {
        writer.openBlock("fn parseHost(endpoint: []const u8) []const u8 {")
        writer.write("// Strip scheme")
        writer.write("const after_scheme = if (std.mem.indexOf(u8, endpoint, \"://\")) |idx| endpoint[idx + 3 ..] else endpoint;")
        writer.write("// Strip port and path")
        writer.write("const end = std.mem.indexOfAny(u8, after_scheme, \":/\") orelse after_scheme.len;")
        writer.write("return after_scheme[0..end];")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("fn parsePort(endpoint: []const u8) ?u16 {")
        writer.write("const after_scheme = if (std.mem.indexOf(u8, endpoint, \"://\")) |idx| endpoint[idx + 3 ..] else endpoint;")
        writer.write("const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;")
        writer.write("const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;")
        writer.write("return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;")
        writer.closeBlock("}")
    }
}
