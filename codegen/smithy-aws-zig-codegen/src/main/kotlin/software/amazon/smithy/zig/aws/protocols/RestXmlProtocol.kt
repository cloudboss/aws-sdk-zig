package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.shapes.BlobShape
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
import software.amazon.smithy.model.traits.StreamingTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class RestXmlProtocol : ProtocolGenerator {

    override fun contentType(): String = "application/xml"

    override fun needsXmlSerde(): Boolean = true

    private data class InputBindings(
        val labels: Map<String, MemberShape>,
        val queryParams: Map<String, MemberShape>,
        val headers: Map<String, MemberShape>,
        val payload: Pair<String, MemberShape>?,
        val bodyMembers: Map<String, MemberShape>,
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
        val headers: Map<String, MemberShape>,
        val responseCode: Pair<String, MemberShape>?,
        val payload: Pair<String, MemberShape>?,
        val bodyMembers: Map<String, MemberShape>,
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
            writer.write("const path = \"\$L\";", pathPattern)
            return
        }

        writer.write("var path_buf: std.ArrayList(u8) = .{};")

        val parts = mutableListOf<Any>()
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

        val hasScalarBodyMembers = bindings.bodyMembers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.isScalarType(ts)
        }

        if (bindings.bodyMembers.isEmpty() || !hasScalarBodyMembers) {
            writer.write("const body: ?[]const u8 = null;")
            writer.blankLine()
            return
        }

        // XML body serialization
        val rootElementName = ctx.inputShape.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse(ctx.inputShape.id.name)

        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        writer.write("try body_buf.appendSlice(alloc, \"<\$L>\");", rootElementName)

        for ((memberName, memberShape) in bindings.bodyMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            if (!ctx.isScalarType(targetShape)) continue

            val xmlName = xmlElementName(memberName, memberShape)
            val fieldName = NamingUtil.toFieldName(memberName)
            val zigType = ctx.resolveBaseZigType(targetShape)

            if (memberShape.isRequired) {
                writeXmlElement(writer, xmlName, zigType, "input.$fieldName")
            } else {
                writer.openBlock("if (input.\$L) |v| {", fieldName)
                writeXmlElement(writer, xmlName, zigType, "v")
                writer.closeBlock("}")
            }
        }

        writer.write("try body_buf.appendSlice(alloc, \"</\$L>\");", rootElementName)
        writer.write("const body = try body_buf.toOwnedSlice(alloc);")
        writer.blankLine()
    }

    private fun xmlElementName(memberName: String, memberShape: MemberShape): String {
        return memberShape.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse(memberName)
    }

    private fun writeXmlElement(writer: ZigWriter, xmlName: String, zigType: String, accessor: String) {
        when (zigType) {
            "[]const u8" -> {
                writer.write("try body_buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.write("try appendXmlEscaped(alloc, &body_buf, \$L);", accessor)
                writer.write("try body_buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            "bool" -> {
                writer.write("try body_buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.write("try body_buf.appendSlice(alloc, if (\$L) \"true\" else \"false\");", accessor)
                writer.write("try body_buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            "i32", "i64", "i16", "i8" -> {
                writer.write("try body_buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", accessor)
                writer.write("try body_buf.appendSlice(alloc, num_str);")
                writer.closeBlock("}")
                writer.write("try body_buf.appendSlice(alloc, \"</\$L>\");", xmlName)
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
                // Deserialize body members from XML using findElement
                for ((memberName, memberShape) in bindings.bodyMembers) {
                    val fieldName = NamingUtil.toFieldName(memberName)
                    val targetShape = ctx.model.expectShape(memberShape.target)
                    val xmlName = xmlElementName(memberName, memberShape)
                    val zigType = ctx.resolveBaseZigType(targetShape)

                    when (zigType) {
                        "[]const u8" -> {
                            writer.openBlock("if (findElement(body, \"\$L\")) |content| {", xmlName)
                            writer.write("result.\$L = try alloc.dupe(u8, content);", fieldName)
                            writer.closeBlock("}")
                        }
                        "i32" -> {
                            writer.openBlock("if (findElement(body, \"\$L\")) |content| {", xmlName)
                            writer.write("result.\$L = std.fmt.parseInt(i32, content, 10) catch null;", fieldName)
                            writer.closeBlock("}")
                        }
                        "i64" -> {
                            writer.openBlock("if (findElement(body, \"\$L\")) |content| {", xmlName)
                            writer.write("result.\$L = std.fmt.parseInt(i64, content, 10) catch null;", fieldName)
                            writer.closeBlock("}")
                        }
                        "bool" -> {
                            writer.openBlock("if (findElement(body, \"\$L\")) |content| {", xmlName)
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

    override fun writeDeserializeStreamingResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        writer.openBlock(
            "fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        writer.write("var result: \$L = .{ .allocator = alloc };", outputName)

        // Transfer StreamingBody ownership to result for @httpPayload streaming blob
        if (bindings.payload != null) {
            val (memberName, memberShape) = bindings.payload
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)

            if (ctx.isStreamingBlob(targetShape)) {
                writer.write("result.\$L = stream_resp.body;", fieldName)
            }
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
        // REST-XML error format: <Error><Code>...</Code><Message>...</Message><RequestId>...</RequestId></Error>
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        writer.write("const error_code = findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = findElement(body, \"RequestId\") orelse \"\";")
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

    private fun writeHelperFunctions(writer: ZigWriter) {
        writeFindElementHelper(writer)
        writer.blankLine()
        writeAppendXmlEscapedHelper(writer)
        writer.blankLine()
        writeAppendUrlEncodedHelper(writer)
        writer.blankLine()
        writeHostParseHelpers(writer)
    }

    private fun writeFindElementHelper(writer: ZigWriter) {
        writer.openBlock("fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {")
        writer.write("var buf: [256]u8 = undefined;")
        writer.blankLine()
        writer.write("const open_tag = std.fmt.bufPrint(&buf, \"<{s}>\", .{tag_name}) catch return null;")
        writer.write("const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;")
        writer.write("const content_start = start + open_tag.len;")
        writer.blankLine()
        writer.write("var close_buf: [256]u8 = undefined;")
        writer.write("const close_tag = std.fmt.bufPrint(&close_buf, \"</{s}>\", .{tag_name}) catch return null;")
        writer.write("const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;")
        writer.blankLine()
        writer.write("return xml[content_start..end];")
        writer.closeBlock("}")
    }

    private fun writeAppendXmlEscapedHelper(writer: ZigWriter) {
        writer.openBlock("fn appendXmlEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {")
        writer.openBlock("for (value) |c| {")
        writer.openBlock("switch (c) {")
        writer.write("'&' => try buf.appendSlice(alloc, \"&amp;\"),")
        writer.write("'<' => try buf.appendSlice(alloc, \"&lt;\"),")
        writer.write("'>' => try buf.appendSlice(alloc, \"&gt;\"),")
        writer.write("else => try buf.append(alloc, c),")
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
