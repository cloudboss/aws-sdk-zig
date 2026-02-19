package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.StringShape
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
            bindings.bodyMembers.isNotEmpty()

        if (!inputUsed) {
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
            targetShape is ListShape -> {
                writeListHeaderPut(writer, ctx, targetShape, headerName, varName)
            }
            else -> {
                writer.write("try request.headers.put(alloc, \"\$L\", \$L);", headerName, varName)
            }
        }
    }

    private fun writeListHeaderPut(writer: ZigWriter, ctx: OperationContext, listShape: ListShape, headerName: String, varName: String) {
        val elementShape = ctx.model.expectShape(listShape.member.target)
        val isElementEnum = elementShape is EnumShape ||
            (elementShape is StringShape && elementShape.hasTrait(EnumTrait::class.java))
        val elementZigType = ctx.resolveBaseZigType(elementShape)

        writer.openBlock("{")
        writer.write("var header_buf: std.ArrayList(u8) = .{};")
        writer.openBlock("for (\$L) |item| {", varName)
        writer.write("if (header_buf.items.len > 0) try header_buf.appendSlice(alloc, \", \");")

        when {
            isElementEnum -> {
                writer.write("try header_buf.appendSlice(alloc, @tagName(item));")
            }
            elementZigType == "[]const u8" -> {
                writer.write("try header_buf.appendSlice(alloc, item);")
            }
            elementZigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{item}) catch \"\";")
                writer.write("try header_buf.appendSlice(alloc, num_str);")
            }
            elementZigType == "bool" -> {
                writer.write("try header_buf.appendSlice(alloc, if (item) \"true\" else \"false\");")
            }
            else -> {
                writer.write("try header_buf.appendSlice(alloc, item);")
            }
        }

        writer.closeBlock("}")
        writer.write("try request.headers.put(alloc, \"\$L\", header_buf.items);", headerName)
        writer.closeBlock("}")
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
                writer.write("try aws.url.appendUrlEncoded(alloc, &query_buf, \$L);", varName)
            }
            isEnum -> {
                writer.write("try aws.url.appendUrlEncoded(alloc, &query_buf, @tagName(\$L));", varName)
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
                writer.write("try aws.url.appendUrlEncoded(alloc, &query_buf, \$L);", varName)
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

            // Blob payloads (including @streaming blobs) are []const u8 in input structs
            if (zigType == "[]const u8" || targetShape is BlobShape) {
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
        if (bindings.bodyMembers.isEmpty()) {
            writer.write("const body: ?[]const u8 = null;")
            writer.blankLine()
            return
        }

        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        writer.write("var has_prev = false;")
        writer.write("try body_buf.appendSlice(alloc, \"{\");")
        writer.blankLine()

        for ((memberName, memberShape) in bindings.bodyMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)

            if (memberShape.isRequired) {
                writer.write("if (has_prev) try body_buf.appendSlice(alloc, \",\");")
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\");", memberName)
                writer.write("try aws.json.writeValue(@TypeOf(input.\$L), input.\$L, alloc, &body_buf);", fieldName, fieldName)
                writer.write("has_prev = true;")
            } else {
                writer.openBlock("if (input.\$L) |v| {", fieldName)
                writer.write("if (has_prev) try body_buf.appendSlice(alloc, \",\");")
                writer.write("try body_buf.appendSlice(alloc, \"\\\"\$L\\\":\");", memberName)
                writer.write("try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);")
                writer.write("has_prev = true;")
                writer.closeBlock("}")
            }
        }

        writer.blankLine()
        writer.write("try body_buf.appendSlice(alloc, \"}\");")
        writer.write("const body = try body_buf.toOwnedSlice(alloc);")
        writer.blankLine()
    }

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        writer.openBlock(
            "fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        val hasBodyMembers = bindings.bodyMembers.isNotEmpty()
        val payloadUsesBody = bindings.payload != null && run {
            val (_, ms) = bindings.payload!!
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        val resultMutated = hasBodyMembers || bindings.responseCode != null ||
            payloadUsesBody || bindings.headers.isNotEmpty()

        val allocUsed = hasBodyMembers || payloadUsesBody || bindings.headers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        if (!allocUsed) {
            writer.write("_ = alloc;")
        }

        if (!resultMutated) {
            writer.write("_ = body;")
            writer.write("_ = status;")
            writer.write("_ = headers;")
            writer.write("const result: \$L = .{};", outputName)
        } else {
            writer.write("var result: \$L = .{};", outputName)

            // Body: @httpPayload, body members from JSON, or unused
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
                } else {
                    writer.write("_ = body;")
                }
            } else if (hasBodyMembers) {
                writer.openBlock("if (body.len > 0) {")
                writer.write("result = try aws.json.parseJsonObject(\$L, body, alloc);", outputName)
                writer.closeBlock("}")
            } else {
                writer.write("_ = body;")
            }

            // @httpResponseCode
            if (bindings.responseCode != null) {
                val (memberName, _) = bindings.responseCode
                val fieldName = NamingUtil.toFieldName(memberName)
                writer.write("result.\$L = @intCast(status);", fieldName)
            } else {
                writer.write("_ = status;")
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

    override fun writeDeserializeStreamingResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        writer.openBlock(
            "fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        // Check if alloc is actually used (only string headers need it)
        val allocUsedInStreaming = bindings.headers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        if (!allocUsedInStreaming) {
            writer.write("_ = alloc;")
        }

        writer.write("var result: \$L = .{};", outputName)

        // Transfer StreamingBody ownership to result for @httpPayload streaming blob
        if (bindings.payload != null) {
            val (memberName, memberShape) = bindings.payload
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)

            if (ctx.isStreamingBlob(targetShape)) {
                writer.write("result.\$L = stream_resp.body;", fieldName)
            }
        }

        // @httpResponseCode
        if (bindings.responseCode != null) {
            val (memberName, _) = bindings.responseCode
            val fieldName = NamingUtil.toFieldName(memberName)
            writer.write("result.\$L = @intCast(stream_resp.status);", fieldName)
        }

        // @httpHeader - extract from response headers
        if (bindings.headers.isNotEmpty()) {
            for ((memberName, memberShape) in bindings.headers) {
                val headerName = memberShape.expectTrait(HttpHeaderTrait::class.java).value.lowercase()
                val fieldName = NamingUtil.toFieldName(memberName)
                val targetShape = ctx.model.expectShape(memberShape.target)
                val zigType = ctx.resolveBaseZigType(targetShape)
                val isEnum = ctx.isEnumType(targetShape)

                writer.openBlock("if (stream_resp.headers.get(\"\$L\")) |value| {", headerName)
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

        // Free headers (values were duped above), but NOT the body
        writer.write("stream_resp.deinitHeaders();")
        writer.blankLine()

        writer.write("return result;")
        writer.closeBlock("}")
    }

    override fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
        // Error parsing is the same as AWS JSON: __type field or x-amzn-ErrorType header
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        // Extract error code from __type, stripping namespace prefix
        writer.openBlock("const error_code = blk: {")
        writer.write("const type_str = aws.json.findJsonValue(body, \"__type\") orelse break :blk @as([]const u8, \"Unknown\");")
        writer.openBlock("if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {")
        writer.write("break :blk type_str[idx + 1 ..];")
        writer.closeBlock("}")
        writer.write("break :blk type_str;")
        writer.closeBlock("};")

        // Extract error message
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
