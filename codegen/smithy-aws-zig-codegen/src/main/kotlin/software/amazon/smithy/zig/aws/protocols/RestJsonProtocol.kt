package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.HttpHeaderTrait
import software.amazon.smithy.model.traits.HttpLabelTrait
import software.amazon.smithy.model.traits.HttpPayloadTrait
import software.amazon.smithy.model.traits.HttpQueryTrait
import software.amazon.smithy.model.traits.HttpResponseCodeTrait
import software.amazon.smithy.model.traits.HttpTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class RestJsonProtocol : ProtocolGenerator {

    override fun contentType(): String = "application/json"

    /**
     * Categorize input members into HTTP binding locations.
     */
    private data class InputBindings(
        val labels: Map<String, MemberShape>,       // @httpLabel
        val queryParams: Map<String, MemberShape>,   // @httpQuery
        val headers: Map<String, MemberShape>,       // @httpHeader (headerName -> member)
        val payload: Pair<String, MemberShape>?,     // @httpPayload
        val bodyMembers: Map<String, MemberShape>,   // everything else -> JSON body
    )

    private fun resolveInputBindings(ctx: OperationContext): InputBindings {
        val labels = mutableMapOf<String, MemberShape>()
        val queryParams = mutableMapOf<String, MemberShape>()
        val headers = mutableMapOf<String, MemberShape>()
        var payload: Pair<String, MemberShape>? = null
        val bodyMembers = mutableMapOf<String, MemberShape>()

        for ((memberName, memberShape) in ctx.inputShape.allMembers) {
            when {
                memberShape.hasTrait(HttpLabelTrait::class.java) ->
                    labels[memberName] = memberShape
                memberShape.hasTrait(HttpQueryTrait::class.java) ->
                    queryParams[memberName] = memberShape
                memberShape.hasTrait(HttpHeaderTrait::class.java) ->
                    headers[memberName] = memberShape
                memberShape.hasTrait(HttpPayloadTrait::class.java) ->
                    payload = memberName to memberShape
                else ->
                    bodyMembers[memberName] = memberShape
            }
        }

        return InputBindings(labels, queryParams, headers, payload, bodyMembers)
    }

    private data class OutputBindings(
        val headers: Map<String, MemberShape>,       // @httpHeader (headerName -> member)
        val responseCode: Pair<String, MemberShape>?, // @httpResponseCode
        val payload: Pair<String, MemberShape>?,      // @httpPayload
        val bodyMembers: Map<String, MemberShape>,    // everything else -> JSON body
    )

    private fun resolveOutputBindings(ctx: OperationContext): OutputBindings {
        val headers = mutableMapOf<String, MemberShape>()
        var responseCode: Pair<String, MemberShape>? = null
        var payload: Pair<String, MemberShape>? = null
        val bodyMembers = mutableMapOf<String, MemberShape>()

        for ((memberName, memberShape) in ctx.outputShape.allMembers) {
            when {
                memberShape.hasTrait(HttpHeaderTrait::class.java) ->
                    headers[memberName] = memberShape
                memberShape.hasTrait(HttpResponseCodeTrait::class.java) ->
                    responseCode = memberName to memberShape
                memberShape.hasTrait(HttpPayloadTrait::class.java) ->
                    payload = memberName to memberShape
                else ->
                    bodyMembers[memberName] = memberShape
            }
        }

        return OutputBindings(headers, responseCode, payload, bodyMembers)
    }

    override fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext) {
        val inputName = "${ctx.operationName}Input"
        val httpTrait = ctx.operation.expectTrait(HttpTrait::class.java)
        val bindings = resolveInputBindings(ctx)

        writer.openBlock(
            "fn serializeRequest(alloc: std.mem.Allocator, input: \$L, config: *aws.Config) !aws.http.Request {",
            inputName,
        )

        // Check if input is used at all
        val inputUsed = bindings.labels.isNotEmpty() || bindings.queryParams.isNotEmpty() ||
            bindings.headers.isNotEmpty() || bindings.payload != null ||
            bindings.bodyMembers.any { (_, ms) ->
                val ts = ctx.model.expectShape(ms.target)
                ctx.isScalarType(ts)
            }

        if (!inputUsed) {
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

        // Split URI pattern into path and static query
        val uriString = httpTrait.uri.toString()
        val questionMark = uriString.indexOf('?')
        val pathPattern = if (questionMark >= 0) uriString.substring(0, questionMark) else uriString
        val staticQuery = if (questionMark >= 0) uriString.substring(questionMark + 1) else null

        // Build URI path
        writeUriBuilder(writer, pathPattern, bindings)
        writer.blankLine()

        // Build query string
        val hasQuery = bindings.queryParams.isNotEmpty() || staticQuery != null
        writeQueryBuilder(writer, ctx, bindings, staticQuery)

        // Build body
        writeBodyBuilder(writer, ctx, bindings)

        // Build request
        writer.write("var request = aws.http.Request.init(host);")
        writer.write("request.method = .\$L;", httpTrait.method.uppercase())
        writer.write("request.path = path;")
        writer.write("request.tls = tls;")
        writer.write("request.port = port;")
        writer.write("request.body = body;")

        if (hasQuery) {
            writer.write("request.query = query;")
        }

        writer.write("try request.headers.put(alloc, \"Content-Type\", \"\$L\");", contentType())

        // Set bound headers
        for ((memberName, memberShape) in bindings.headers) {
            val headerName = memberShape.expectTrait(HttpHeaderTrait::class.java).value
            val fieldName = NamingUtil.toFieldName(memberName)

            if (memberShape.isRequired) {
                writeHeaderValuePut(writer, ctx, memberShape, headerName, "input.$fieldName")
            } else {
                writer.openBlock("if (input.\$L) |v| {", fieldName)
                writeHeaderValuePut(writer, ctx, memberShape, headerName, "v")
                writer.closeBlock("}")
            }
        }

        writer.blankLine()
        writer.write("return request;")
        writer.closeBlock("}")
    }

    private fun writeHeaderValuePut(writer: ZigWriter, ctx: OperationContext, memberShape: MemberShape, headerName: String, varName: String) {
        val targetShape = ctx.model.expectShape(memberShape.target)
        val isEnum = targetShape is EnumShape ||
            (targetShape is software.amazon.smithy.model.shapes.StringShape && targetShape.hasTrait(EnumTrait::class.java))
        val zigType = ctx.resolveBaseZigType(targetShape)

        when {
            zigType == "[]const u8" -> {
                writer.write("try request.headers.put(alloc, \"\$L\", \$L);", headerName, varName)
            }
            isEnum -> {
                writer.write("try request.headers.put(alloc, \"\$L\", @tagName(\$L));", headerName, varName)
            }
            zigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", varName)
                writer.write("try request.headers.put(alloc, \"\$L\", num_str);", headerName)
                writer.closeBlock("}")
            }
            zigType == "bool" -> {
                writer.write("try request.headers.put(alloc, \"\$L\", if (\$L) \"true\" else \"false\");", headerName, varName)
            }
            else -> {
                writer.write("try request.headers.put(alloc, \"\$L\", \$L);", headerName, varName)
            }
        }
    }

    private fun writeUriBuilder(writer: ZigWriter, pathPattern: String, bindings: InputBindings) {
        if (bindings.labels.isEmpty()) {
            // Static path, no substitution needed
            writer.write("const path = \"\$L\";", pathPattern)
            return
        }

        // Build path dynamically by substituting {Label} placeholders
        writer.write("var path_buf: std.ArrayList(u8) = .{};")

        // Split URI into segments around {labels}
        val parts = mutableListOf<Any>() // String for literal, Pair<String,MemberShape> for label
        var remaining = pathPattern
        while (remaining.isNotEmpty()) {
            val openBrace = remaining.indexOf('{')
            if (openBrace == -1) {
                parts.add(remaining)
                break
            }
            if (openBrace > 0) {
                parts.add(remaining.substring(0, openBrace))
            }
            val closeBrace = remaining.indexOf('}', openBrace)
            // Strip '+' suffix from greedy labels (e.g., {Key+} -> Key)
            val labelName = remaining.substring(openBrace + 1, closeBrace).removeSuffix("+")
            val memberShape = bindings.labels[labelName]
            if (memberShape != null) {
                parts.add(labelName to memberShape)
            }
            remaining = remaining.substring(closeBrace + 1)
        }

        for (part in parts) {
            when (part) {
                is String -> {
                    writer.write("try path_buf.appendSlice(alloc, \"\$L\");", part)
                }
                is Pair<*, *> -> {
                    val memberName = part.first as String
                    val fieldName = NamingUtil.toFieldName(memberName)
                    writer.write("try path_buf.appendSlice(alloc, input.\$L);", fieldName)
                }
            }
        }

        writer.write("const path = try path_buf.toOwnedSlice(alloc);")
    }

    private fun writeQueryBuilder(writer: ZigWriter, ctx: OperationContext, bindings: InputBindings, staticQuery: String? = null) {
        if (bindings.queryParams.isEmpty() && staticQuery == null) return

        writer.write("var query_buf: std.ArrayList(u8) = .{};")
        writer.write("var query_has_prev = false;")

        if (staticQuery != null) {
            writer.write("try query_buf.appendSlice(alloc, \"\$L\");", staticQuery)
            writer.write("query_has_prev = true;")
        }

        for ((memberName, memberShape) in bindings.queryParams) {
            val queryKey = memberShape.expectTrait(HttpQueryTrait::class.java).value
            val fieldName = NamingUtil.toFieldName(memberName)

            if (memberShape.isRequired) {
                writer.write("if (query_has_prev) try query_buf.appendSlice(alloc, \"&\");")
                writer.write("try query_buf.appendSlice(alloc, \"\$L=\");", queryKey)
                writeQueryValueAppend(writer, ctx, memberShape, "input.$fieldName")
                writer.write("query_has_prev = true;")
            } else {
                writer.openBlock("if (input.\$L) |v| {", fieldName)
                writer.write("if (query_has_prev) try query_buf.appendSlice(alloc, \"&\");")
                writer.write("try query_buf.appendSlice(alloc, \"\$L=\");", queryKey)
                writeQueryValueAppend(writer, ctx, memberShape, "v")
                writer.write("query_has_prev = true;")
                writer.closeBlock("}")
            }
        }

        writer.write("const query = try query_buf.toOwnedSlice(alloc);")
        writer.blankLine()
    }

    /**
     * Generate code to append a query parameter value, handling type conversion for
     * enums, integers, and booleans.
     */
    private fun writeQueryValueAppend(writer: ZigWriter, ctx: OperationContext, memberShape: MemberShape, varName: String) {
        val targetShape = ctx.model.expectShape(memberShape.target)
        val isEnum = targetShape is EnumShape ||
            (targetShape is software.amazon.smithy.model.shapes.StringShape && targetShape.hasTrait(EnumTrait::class.java))
        val zigType = ctx.resolveBaseZigType(targetShape)

        when {
            zigType == "[]const u8" -> {
                writer.write("try appendUrlEncoded(alloc, &query_buf, \$L);", varName)
            }
            isEnum -> {
                writer.write("try appendUrlEncoded(alloc, &query_buf, @tagName(\$L));", varName)
            }
            zigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", varName)
                writer.write("try query_buf.appendSlice(alloc, num_str);")
                writer.closeBlock("}")
            }
            zigType == "bool" -> {
                writer.write("try query_buf.appendSlice(alloc, if (\$L) \"true\" else \"false\");", varName)
            }
            else -> {
                writer.write("try appendUrlEncoded(alloc, &query_buf, \$L);", varName)
            }
        }
    }

    private fun writeBodyBuilder(writer: ZigWriter, ctx: OperationContext, bindings: InputBindings) {
        if (bindings.payload != null) {
            // @httpPayload: body is the payload member directly
            val (memberName, memberShape) = bindings.payload
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)
            val zigType = ctx.resolveBaseZigType(targetShape)

            if (zigType == "[]const u8") {
                if (memberShape.isRequired) {
                    writer.write("const body = input.\$L;", fieldName)
                } else {
                    writer.write("const body = input.\$L orelse \"\";", fieldName)
                }
            } else {
                writer.write("const body: ?[]const u8 = null;")
            }
            writer.blankLine()
            return
        }

        // No @httpPayload: serialize body members as JSON
        val hasScalarBodyMembers = bindings.bodyMembers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.isScalarType(ts)
        }

        if (bindings.bodyMembers.isEmpty()) {
            writer.write("const body: ?[]const u8 = null;")
            writer.blankLine()
            return
        }

        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        if (hasScalarBodyMembers) {
            writer.write("var has_prev = false;")
        }
        writer.write("try body_buf.appendSlice(alloc, \"{\");")
        writer.blankLine()

        for ((memberName, memberShape) in bindings.bodyMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            writeJsonFieldSerializer(writer, ctx, memberName, memberShape, targetShape, "input")
        }

        writer.blankLine()
        writer.write("try body_buf.appendSlice(alloc, \"}\");")
        writer.write("const body = try body_buf.toOwnedSlice(alloc);")
        writer.blankLine()
    }

    private fun writeJsonFieldSerializer(
        writer: ZigWriter,
        ctx: OperationContext,
        smithyName: String,
        memberShape: MemberShape,
        targetShape: Shape,
        accessor: String,
    ) {
        val fieldName = NamingUtil.toFieldName(smithyName)

        if (!ctx.isScalarType(targetShape)) return

        val zigType = ctx.resolveBaseZigType(targetShape)
        val isEnum = ctx.isEnumType(targetShape)

        if (memberShape.isRequired) {
            writer.write("if (has_prev) try body_buf.appendSlice(alloc, \",\");")
            writeJsonKeyValue(writer, smithyName, zigType, "$accessor.$fieldName", isEnum)
            writer.write("has_prev = true;")
        } else {
            writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
            writer.write("if (has_prev) try body_buf.appendSlice(alloc, \",\");")
            writeJsonKeyValue(writer, smithyName, zigType, "v", isEnum)
            writer.write("has_prev = true;")
            writer.closeBlock("}")
        }
    }

    private fun writeJsonKeyValue(writer: ZigWriter, jsonKey: String, zigType: String, accessor: String, isEnum: Boolean = false) {
        when {
            isEnum -> {
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\\\"\");", jsonKey)
                writer.write("try body_buf.appendSlice(alloc, @tagName(\$L));", accessor)
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\");")
            }
            zigType == "[]const u8" -> {
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\\\"\");", jsonKey)
                writer.write("try appendJsonEscaped(alloc, &body_buf, \$L);", accessor)
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\");")
            }
            zigType == "bool" -> {
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\");", jsonKey)
                writer.write("try body_buf.appendSlice(alloc, if (\$L) \"true\" else \"false\");", accessor)
            }
            zigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\");", jsonKey)
                writer.write("{")
                writer.write("    const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", accessor)
                writer.write("    try body_buf.appendSlice(alloc, num_str);")
                writer.write("}")
            }
            else -> {}
        }
    }

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        val hasDeserializableBodyFields = bindings.bodyMembers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            val zigType = ctx.resolveBaseZigType(ts)
            zigType in listOf("[]const u8", "i32", "i64", "bool")
        }

        // REST-JSON deserializer also takes status and headers
        writer.openBlock(
            "fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        // Determine if result will actually be mutated
        val payloadUsesBody = bindings.payload != null && run {
            val (_, ms) = bindings.payload!!
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        val bodyUsed = payloadUsesBody || hasDeserializableBodyFields
        val resultMutated = hasDeserializableBodyFields || bindings.responseCode != null ||
            payloadUsesBody || bindings.headers.isNotEmpty()

        if (!resultMutated) {
            writer.write("_ = body;")
            writer.write("_ = status;")
            writer.write("_ = headers;")
            writer.write("const result: \$L = .{ .allocator = alloc };", outputName)
        } else {
            writer.write("var result: \$L = .{ .allocator = alloc };", outputName)

            // @httpResponseCode
            if (bindings.responseCode != null) {
                val (memberName, _) = bindings.responseCode
                val fieldName = NamingUtil.toFieldName(memberName)
                writer.write("result.\$L = @intCast(status);", fieldName)
            } else {
                writer.write("_ = status;")
            }

            if (!bodyUsed) {
                writer.write("_ = body;")
            }

            // @httpPayload
            if (bindings.payload != null) {
                val (memberName, memberShape) = bindings.payload
                val fieldName = NamingUtil.toFieldName(memberName)
                val targetShape = ctx.model.expectShape(memberShape.target)
                val zigType = ctx.resolveBaseZigType(targetShape)

                if (zigType == "[]const u8") {
                    if (memberShape.isRequired) {
                        writer.write("result.\$L = try alloc.dupe(u8, body);", fieldName)
                    } else {
                        writer.openBlock("if (body.len > 0) {")
                        writer.write("result.\$L = try alloc.dupe(u8, body);", fieldName)
                        writer.closeBlock("}")
                    }
                }
            } else {
                // Deserialize body members from JSON
                for ((memberName, memberShape) in bindings.bodyMembers) {
                    val fieldName = NamingUtil.toFieldName(memberName)
                    val targetShape = ctx.model.expectShape(memberShape.target)
                    val zigType = ctx.resolveBaseZigType(targetShape)

                    when (zigType) {
                        "[]const u8" -> {
                            writer.openBlock("if (findJsonValue(body, \"\$L\")) |content| {", memberName)
                            writer.write("result.\$L = try alloc.dupe(u8, content);", fieldName)
                            writer.closeBlock("}")
                        }
                        "i32" -> {
                            writer.openBlock("if (findJsonValue(body, \"\$L\")) |content| {", memberName)
                            writer.write("result.\$L = std.fmt.parseInt(i32, content, 10) catch null;", fieldName)
                            writer.closeBlock("}")
                        }
                        "i64" -> {
                            writer.openBlock("if (findJsonValue(body, \"\$L\")) |content| {", memberName)
                            writer.write("result.\$L = std.fmt.parseInt(i64, content, 10) catch null;", fieldName)
                            writer.closeBlock("}")
                        }
                        "bool" -> {
                            writer.openBlock("if (findJsonValue(body, \"\$L\")) |content| {", memberName)
                            writer.write("result.\$L = std.mem.eql(u8, content, \"true\");", fieldName)
                            writer.closeBlock("}")
                        }
                        else -> {}
                    }
                }
            }

            // @httpHeader - extract from response headers
            if (bindings.headers.isNotEmpty()) {
                writeHeaderDeserialization(writer, ctx, bindings.headers)
            } else {
                writer.write("_ = headers;")
            }
        }

        writer.blankLine()
        writer.write("return result;")
        writer.closeBlock("}")
    }

    private fun writeHeaderDeserialization(
        writer: ZigWriter,
        ctx: OperationContext,
        headerBindings: Map<String, MemberShape>,
    ) {
        for ((memberName, memberShape) in headerBindings) {
            val headerName = memberShape.expectTrait(HttpHeaderTrait::class.java).value.lowercase()
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)
            val zigType = ctx.resolveBaseZigType(targetShape)
            val isEnum = ctx.isEnumType(targetShape)

            writer.openBlock("if (headers.get(\"\$L\")) |value| {", headerName)
            when {
                zigType == "[]const u8" -> {
                    writer.write("result.\$L = try alloc.dupe(u8, value);", fieldName)
                }
                isEnum -> {
                    val typeName = ctx.resolveBaseZigType(targetShape)
                    writer.write("result.\$L = std.meta.stringToEnum(\$L, value);", fieldName, typeName)
                }
                zigType == "bool" -> {
                    writer.write("result.\$L = std.mem.eql(u8, value, \"true\");", fieldName)
                }
                zigType in listOf("i32", "i64", "i16", "i8") -> {
                    writer.write("result.\$L = std.fmt.parseInt(\$L, value, 10) catch null;", fieldName, zigType)
                }
                else -> {
                    writer.write("result.\$L = try alloc.dupe(u8, value);", fieldName)
                }
            }
            writer.closeBlock("}")
        }
    }

    override fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
        // Error parsing is the same as AWS JSON: __type field or x-amzn-ErrorType header
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        // Extract error code from __type, stripping namespace prefix
        writer.openBlock("const error_code = blk: {")
        writer.write("const type_str = findJsonValue(body, \"__type\") orelse break :blk @as([]const u8, \"Unknown\");")
        writer.openBlock("if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {")
        writer.write("break :blk type_str[idx + 1 ..];")
        writer.closeBlock("}")
        writer.write("break :blk type_str;")
        writer.closeBlock("};")

        // Extract error message
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
        writeHelperFunctions(writer)
    }

    private fun writeHelperFunctions(writer: ZigWriter) {
        writeFindJsonValueHelper(writer)
        writer.blankLine()
        writeAppendJsonEscapedHelper(writer)
        writer.blankLine()
        writeAppendUrlEncodedHelper(writer)
        writer.blankLine()
        writeHostParseHelpers(writer)
    }

    private fun writeFindJsonValueHelper(writer: ZigWriter) {
        writer.openBlock("fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {")
        writer.write("var buf: [258]u8 = undefined;")
        writer.write("if (key.len + 2 > buf.len) return null;")
        writer.write("buf[0] = 0x22;")
        writer.write("@memcpy(buf[1..][0..key.len], key);")
        writer.write("buf[key.len + 1] = 0x22;")
        writer.write("const search = buf[0 .. key.len + 2];")
        writer.write("const key_start = std.mem.indexOf(u8, json, search) orelse return null;")
        writer.write("var pos = key_start + search.len;")
        writer.blankLine()

        writer.openBlock("while (pos < json.len) : (pos += 1) {")
        writer.write("if (json[pos] != ' ' and json[pos] != ':') break;")
        writer.closeBlock("}")
        writer.write("if (pos >= json.len) return null;")
        writer.blankLine()

        writer.openBlock("if (json[pos] == 0x22) {")
        writer.write("const start = pos + 1;")
        writer.write("const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;")
        writer.write("return json[start..end];")
        writer.closeBlock("}")
        writer.blankLine()

        writer.write("const start = pos;")
        writer.openBlock("while (pos < json.len) : (pos += 1) {")
        writer.write("if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;")
        writer.closeBlock("}")
        writer.write("return json[start..pos];")

        writer.closeBlock("}")
    }

    private fun writeAppendJsonEscapedHelper(writer: ZigWriter) {
        writer.openBlock("fn appendJsonEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {")
        writer.openBlock("for (value) |c| {")
        writer.openBlock("switch (c) {")
        writer.write("0x22 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x22); },")
        writer.write("0x5C => { try buf.append(alloc, 0x5C); try buf.append(alloc, 0x5C); },")
        writer.write("0x0A => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'n'); },")
        writer.write("0x0D => { try buf.append(alloc, 0x5C); try buf.append(alloc, 'r'); },")
        writer.write("0x09 => { try buf.append(alloc, 0x5C); try buf.append(alloc, 't'); },")
        writer.openBlock("else => {")
        writer.openBlock("if (c < 0x20) {")
        writer.write("const hex = \"0123456789abcdef\";")
        writer.write("try buf.append(alloc, 0x5C);")
        writer.write("try buf.append(alloc, 'u');")
        writer.write("try buf.append(alloc, '0');")
        writer.write("try buf.append(alloc, '0');")
        writer.write("try buf.append(alloc, hex[c >> 4]);")
        writer.write("try buf.append(alloc, hex[c & 0x0F]);")
        writer.dedent()
        writer.openBlock("} else {")
        writer.write("try buf.append(alloc, c);")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.closeBlock("}")
    }

    private fun writeAppendUrlEncodedHelper(writer: ZigWriter) {
        writer.openBlock("fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {")
        writer.openBlock("for (value) |c| {")
        writer.openBlock("switch (c) {")
        writer.write("'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),")
        writer.write("' ' => try buf.append(alloc, '+'),")
        writer.openBlock("else => {")
        writer.write("const hex = \"0123456789ABCDEF\";")
        writer.write("try buf.append(alloc, '%');")
        writer.write("try buf.append(alloc, hex[c >> 4]);")
        writer.write("try buf.append(alloc, hex[c & 0x0F]);")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.closeBlock("}")
    }

    private fun writeHostParseHelpers(writer: ZigWriter) {
        writer.openBlock("fn parseHost(endpoint: []const u8) []const u8 {")
        writer.write("const after_scheme = if (std.mem.indexOf(u8, endpoint, \"://\")) |idx| endpoint[idx + 3 ..] else endpoint;")
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
