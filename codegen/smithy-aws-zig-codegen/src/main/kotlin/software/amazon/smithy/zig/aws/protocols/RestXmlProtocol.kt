package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.BooleanShape
import software.amazon.smithy.model.shapes.DoubleShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.FloatShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.IntegerShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.LongShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.ShortShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.TimestampShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.HttpHeaderTrait
import software.amazon.smithy.model.traits.HttpLabelTrait
import software.amazon.smithy.model.traits.HttpPayloadTrait
import software.amazon.smithy.model.traits.HttpQueryTrait
import software.amazon.smithy.model.traits.HttpResponseCodeTrait
import software.amazon.smithy.model.traits.HttpTrait
import software.amazon.smithy.model.traits.StreamingTrait
import software.amazon.smithy.model.traits.XmlFlattenedTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.model.traits.XmlNamespaceTrait
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
            "fn serializeRequest(allocator: std.mem.Allocator, input: \$L, config: *aws.Config) !aws.http.Request {",
            inputName,
        )

        // Check if input is used at all
        val inputUsed = bindings.labels.isNotEmpty() || bindings.queryParams.isNotEmpty() ||
            bindings.headers.isNotEmpty() || bindings.payload != null ||
            bindings.bodyMembers.any { (_, ms) ->
                val ts = ctx.model.expectShape(ms.target)
                ctx.isScalarType(ts) || ts is StructureShape || ts is ListShape || ts is MapShape
            }

        if (!inputUsed) {
            writer.write("_ = input;")
        }

        // Build endpoint
        writer.write(
            "const endpoint = try config.getEndpointForService(\"\$L\", \"\$L\", allocator);",
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

        writer.write("try request.headers.put(allocator, \"Content-Type\", \"\$L\");", contentType())

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
                writer.write("try request.headers.put(allocator, \"\$L\", \$L);", headerName, varName)
            }
            isEnum -> {
                writer.write("try request.headers.put(allocator, \"\$L\", @tagName(\$L));", headerName, varName)
            }
            zigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(allocator, \"{d}\", .{\$L}) catch \"\";", varName)
                writer.write("try request.headers.put(allocator, \"\$L\", num_str);", headerName)
                writer.closeBlock("}")
            }
            zigType == "bool" -> {
                writer.write("try request.headers.put(allocator, \"\$L\", if (\$L) \"true\" else \"false\");", headerName, varName)
            }
            targetShape is ListShape -> {
                writeListHeaderPut(writer, ctx, targetShape, headerName, varName)
            }
            else -> {
                writer.write("try request.headers.put(allocator, \"\$L\", \$L);", headerName, varName)
            }
        }
    }

    private fun writeListHeaderPut(writer: ZigWriter, ctx: OperationContext, listShape: ListShape, headerName: String, varName: String) {
        val elementShape = ctx.model.expectShape(listShape.member.target)
        val isElementEnum = elementShape is EnumShape ||
            (elementShape is software.amazon.smithy.model.shapes.StringShape && elementShape.hasTrait(EnumTrait::class.java))
        val elementZigType = ctx.resolveBaseZigType(elementShape)

        writer.openBlock("{")
        writer.write("var header_buf: std.ArrayList(u8) = .{};")
        writer.openBlock("for (\$L) |item| {", varName)
        writer.write("if (header_buf.items.len > 0) try header_buf.appendSlice(allocator, \", \");")

        when {
            isElementEnum -> {
                writer.write("try header_buf.appendSlice(allocator, @tagName(item));")
            }
            elementZigType == "[]const u8" -> {
                writer.write("try header_buf.appendSlice(allocator, item);")
            }
            elementZigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.write("const num_str = std.fmt.allocPrint(allocator, \"{d}\", .{item}) catch \"\";")
                writer.write("try header_buf.appendSlice(allocator, num_str);")
            }
            elementZigType == "bool" -> {
                writer.write("try header_buf.appendSlice(allocator, if (item) \"true\" else \"false\");")
            }
            else -> {
                writer.write("try header_buf.appendSlice(allocator, item);")
            }
        }

        writer.closeBlock("}")
        writer.write("try request.headers.put(allocator, \"\$L\", header_buf.items);", headerName)
        writer.closeBlock("}")
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
                    writer.write("try path_buf.appendSlice(allocator, \"\$L\");", part)
                }
                is Pair<*, *> -> {
                    val memberName = part.first as String
                    val fieldName = NamingUtil.toFieldName(memberName)
                    writer.write("try path_buf.appendSlice(allocator, input.\$L);", fieldName)
                }
            }
        }

        writer.write("const path = try path_buf.toOwnedSlice(allocator);")
    }

    private fun writeQueryBuilder(writer: ZigWriter, ctx: OperationContext, bindings: InputBindings, staticQuery: String? = null) {
        if (bindings.queryParams.isEmpty() && staticQuery == null) return

        writer.write("var query_buf: std.ArrayList(u8) = .{};")
        writer.write("var query_has_prev = false;")

        if (staticQuery != null) {
            writer.write("try query_buf.appendSlice(allocator, \"\$L\");", staticQuery)
            writer.write("query_has_prev = true;")
        }

        for ((memberName, memberShape) in bindings.queryParams) {
            val queryKey = memberShape.expectTrait(HttpQueryTrait::class.java).value
            val fieldName = NamingUtil.toFieldName(memberName)

            if (memberShape.isRequired) {
                writer.write("if (query_has_prev) try query_buf.appendSlice(allocator, \"&\");")
                writer.write("try query_buf.appendSlice(allocator, \"\$L=\");", queryKey)
                writeQueryValueAppend(writer, ctx, memberShape, "input.$fieldName")
                writer.write("query_has_prev = true;")
            } else {
                writer.openBlock("if (input.\$L) |v| {", fieldName)
                writer.write("if (query_has_prev) try query_buf.appendSlice(allocator, \"&\");")
                writer.write("try query_buf.appendSlice(allocator, \"\$L=\");", queryKey)
                writeQueryValueAppend(writer, ctx, memberShape, "v")
                writer.write("query_has_prev = true;")
                writer.closeBlock("}")
            }
        }

        writer.write("const query = try query_buf.toOwnedSlice(allocator);")
        writer.blankLine()
    }

    private fun writeQueryValueAppend(writer: ZigWriter, ctx: OperationContext, memberShape: MemberShape, varName: String) {
        val targetShape = ctx.model.expectShape(memberShape.target)
        val isEnum = targetShape is EnumShape ||
            (targetShape is software.amazon.smithy.model.shapes.StringShape && targetShape.hasTrait(EnumTrait::class.java))
        val zigType = ctx.resolveBaseZigType(targetShape)

        when {
            zigType == "[]const u8" -> {
                writer.write("try aws.url.appendUrlEncoded(allocator, &query_buf, \$L);", varName)
            }
            isEnum -> {
                writer.write("try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(\$L));", varName)
            }
            zigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(allocator, \"{d}\", .{\$L}) catch \"\";", varName)
                writer.write("try query_buf.appendSlice(allocator, num_str);")
                writer.closeBlock("}")
            }
            zigType == "bool" -> {
                writer.write("try query_buf.appendSlice(allocator, if (\$L) \"true\" else \"false\");", varName)
            }
            else -> {
                writer.write("try aws.url.appendUrlEncoded(allocator, &query_buf, \$L);", varName)
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
            } else if (targetShape is StructureShape) {
                // Struct payload -- serialize via serde
                val rootName = targetShape.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse(targetShape.id.name)
                val ns = targetShape.getTrait(XmlNamespaceTrait::class.java)
                    .or { ctx.service.getTrait(XmlNamespaceTrait::class.java) }
                    .orElse(null)

                if (memberShape.isRequired) {
                    writer.write("var body_buf: std.ArrayList(u8) = .{};")
                    writeXmlRootOpen(writer, rootName, ns)
                    writer.write("try serde.serialize\$L(allocator, &body_buf, input.\$L);", targetShape.id.name, fieldName)
                    writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", rootName)
                    writer.write("const body = try body_buf.toOwnedSlice(allocator);")
                } else {
                    writer.openBlock("const body: ?[]const u8 = blk: {")
                    writer.openBlock("if (input.\$L) |payload| {", fieldName)
                    writer.write("var body_buf: std.ArrayList(u8) = .{};")
                    writeXmlRootOpen(writer, rootName, ns)
                    writer.write("try serde.serialize\$L(allocator, &body_buf, payload);", targetShape.id.name)
                    writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", rootName)
                    writer.write("break :blk try body_buf.toOwnedSlice(allocator);")
                    writer.closeBlock("}")
                    writer.write("break :blk null;")
                    writer.closeBlock("};")
                }
            } else {
                writer.write("const body: ?[]const u8 = null;")
            }
            writer.blankLine()
            return
        }

        val hasSerializableBodyMembers = bindings.bodyMembers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.isScalarType(ts) || ts is StructureShape || ts is ListShape || ts is MapShape
        }

        if (bindings.bodyMembers.isEmpty() || !hasSerializableBodyMembers) {
            writer.write("const body: ?[]const u8 = null;")
            writer.blankLine()
            return
        }

        // XML body serialization
        val rootElementName = ctx.inputShape.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse(ctx.inputShape.id.name)

        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", rootElementName)

        for ((memberName, memberShape) in bindings.bodyMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            val xmlName = xmlElementName(memberName, memberShape)
            val fieldName = NamingUtil.toFieldName(memberName)

            when {
                ctx.isScalarType(targetShape) -> {
                    val zigType = ctx.resolveBaseZigType(targetShape)
                    if (memberShape.isRequired) {
                        writeXmlElement(writer, xmlName, zigType, "input.$fieldName")
                    } else {
                        writer.openBlock("if (input.\$L) |v| {", fieldName)
                        writeXmlElement(writer, xmlName, zigType, "v")
                        writer.closeBlock("}")
                    }
                }
                targetShape is StructureShape -> {
                    if (memberShape.isRequired) {
                        writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                        writer.write("try serde.serialize\$L(allocator, &body_buf, input.\$L);", targetShape.id.name, fieldName)
                        writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                    } else {
                        writer.openBlock("if (input.\$L) |v| {", fieldName)
                        writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                        writer.write("try serde.serialize\$L(allocator, &body_buf, v);", targetShape.id.name)
                        writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                        writer.closeBlock("}")
                    }
                }
                targetShape is ListShape -> {
                    val listFnName = "serialize${targetShape.id.name}"
                    val isFlattened = memberShape.hasTrait(XmlFlattenedTrait::class.java)

                    if (memberShape.isRequired) {
                        if (isFlattened) {
                            writer.write("try serde.\$L(allocator, &body_buf, input.\$L, \"\$L\");", listFnName, fieldName, xmlName)
                        } else {
                            val itemTag = targetShape.member.getTrait(XmlNameTrait::class.java)
                                .map { it.value }.orElse("member")
                            writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                            writer.write("try serde.\$L(allocator, &body_buf, input.\$L, \"\$L\");", listFnName, fieldName, itemTag)
                            writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                        }
                    } else {
                        writer.openBlock("if (input.\$L) |v| {", fieldName)
                        if (isFlattened) {
                            writer.write("try serde.\$L(allocator, &body_buf, v, \"\$L\");", listFnName, xmlName)
                        } else {
                            val itemTag = targetShape.member.getTrait(XmlNameTrait::class.java)
                                .map { it.value }.orElse("member")
                            writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                            writer.write("try serde.\$L(allocator, &body_buf, v, \"\$L\");", listFnName, itemTag)
                            writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                        }
                        writer.closeBlock("}")
                    }
                }
                targetShape is MapShape -> {
                    val mapFnName = "serialize${targetShape.id.name}"
                    val entryTag = "entry"

                    if (memberShape.isRequired) {
                        writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                        writer.write("try serde.\$L(allocator, &body_buf, input.\$L, \"\$L\");", mapFnName, fieldName, entryTag)
                        writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                    } else {
                        writer.openBlock("if (input.\$L) |v| {", fieldName)
                        writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                        writer.write("try serde.\$L(allocator, &body_buf, v, \"\$L\");", mapFnName, entryTag)
                        writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
                        writer.closeBlock("}")
                    }
                }
            }
        }

        writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", rootElementName)
        writer.write("const body = try body_buf.toOwnedSlice(allocator);")
        writer.blankLine()
    }

    private fun writeXmlRootOpen(writer: ZigWriter, rootName: String, ns: XmlNamespaceTrait?) {
        if (ns != null) {
            writer.write(
                "try body_buf.appendSlice(allocator, \"<\$L xmlns=\" ++ &[_]u8{0x22} ++ \"\$L\" ++ &[_]u8{0x22} ++ \">\");",
                rootName, ns.uri,
            )
        } else {
            writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", rootName)
        }
    }

    private fun xmlElementName(memberName: String, memberShape: MemberShape): String {
        return memberShape.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse(memberName)
    }

    private fun writeXmlElement(writer: ZigWriter, xmlName: String, zigType: String, accessor: String) {
        when (zigType) {
            "[]const u8" -> {
                writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                writer.write("try aws.xml.appendXmlEscaped(allocator, &body_buf, \$L);", accessor)
                writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
            }
            "bool" -> {
                writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                writer.write("try body_buf.appendSlice(allocator, if (\$L) \"true\" else \"false\");", accessor)
                writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
            }
            "i32", "i64", "i16", "i8" -> {
                writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(allocator, \"{d}\", .{\$L}) catch \"\";", accessor)
                writer.write("try body_buf.appendSlice(allocator, num_str);")
                writer.closeBlock("}")
                writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
            }
            else -> {
                // Enum types and other named types -- serialize as their tag name
                writer.write("try body_buf.appendSlice(allocator, \"<\$L>\");", xmlName)
                writer.write("try body_buf.appendSlice(allocator, @tagName(\$L));", accessor)
                writer.write("try body_buf.appendSlice(allocator, \"</\$L>\");", xmlName)
            }
        }
    }

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        writer.openBlock(
            "fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !\$L {",
            outputName,
        )

        // Determine if result will actually be mutated
        val payloadUsesBody = bindings.payload != null && run {
            val (_, ms) = bindings.payload!!
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        val hasBodyMembers = bindings.bodyMembers.isNotEmpty()
        val bodyUsed = payloadUsesBody || hasBodyMembers
        val resultMutated = hasBodyMembers || bindings.responseCode != null ||
            payloadUsesBody || bindings.headers.isNotEmpty()

        val bodyNeedsAlloc = bindings.bodyMembers.values.any { ms ->
            val target = ctx.model.expectShape(ms.target)
            (target is StringShape && !ctx.isEnumType(target)) ||
                target is BlobShape || target is StructureShape || target is ListShape ||
                target is MapShape
        }
        val headersNeedAlloc = bindings.headers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        val allocUsed = bodyNeedsAlloc || payloadUsesBody || headersNeedAlloc
        if (!allocUsed) {
            writer.write("_ = allocator;")
        }

        if (!resultMutated) {
            writer.write("_ = body;")
            writer.write("_ = status;")
            writer.write("_ = headers;")
            writer.write("const result: \$L = .{};", outputName)
        } else {
            writer.write("var result: \$L = .{};", outputName)

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
                        writer.write("result.\$L = try allocator.dupe(u8, body);", fieldName)
                    } else {
                        writer.openBlock("if (body.len > 0) {")
                        writer.write("result.\$L = try allocator.dupe(u8, body);", fieldName)
                        writer.closeBlock("}")
                    }
                }
            } else if (hasBodyMembers) {
                // Deserialize body members from XML using xml.Reader
                writer.write("var reader = aws.xml.Reader.init(body);")
                writer.blankLine()

                // Skip root element
                writer.openBlock("while (try reader.next()) |event| {")
                writer.openBlock("switch (event) {")
                writer.write(".element_start => break,")
                writer.write("else => {},")
                writer.closeBlock("}")
                writer.closeBlock("}")
                writer.blankLine()

                // Parse body members
                writeXmlMemberParsing(writer, ctx, bindings.bodyMembers)
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

    private fun writeXmlMemberParsing(
        writer: ZigWriter,
        ctx: OperationContext,
        members: Map<String, MemberShape>,
    ) {
        // Collect flattened list members that need ArrayList accumulation
        val flattenedLists = mutableListOf<Triple<String, String, ListShape>>() // (fieldName, xmlName, listShape)
        for ((memberName, memberShape) in members) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            if (targetShape is ListShape && memberShape.hasTrait(XmlFlattenedTrait::class.java)) {
                val fieldName = NamingUtil.toFieldName(memberName)
                val xmlName = xmlElementName(memberName, memberShape)
                flattenedLists.add(Triple(fieldName, xmlName, targetShape))
            }
        }

        // Declare ArrayLists for flattened list members before the loop
        for ((fieldName, _, listShape) in flattenedLists) {
            val elementShape = ctx.model.expectShape(listShape.member.target)
            val elementType = resolveZigElementType(ctx, elementShape)
            writer.write("var \${L}_list: std.ArrayList(\$L) = .{};", fieldName, elementType)
        }

        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.openBlock(".element_start => |e| {")

        var first = true
        for ((memberName, memberShape) in members) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)
            val xmlName = xmlElementName(memberName, memberShape)

            val prefix = if (first) "if" else "} else if"
            first = false

            writer.write("\$L (std.mem.eql(u8, e.local, \"\$L\")) {", prefix, xmlName)
            writer.indent()
            writeXmlMemberDeserializer(writer, ctx, fieldName, targetShape, memberShape)
            writer.dedent()
        }

        if (!first) {
            writer.write("} else {")
            writer.indent()
            writer.write("try reader.skipElement();")
            writer.dedent()
            writer.write("}")
        } else {
            writer.write("try reader.skipElement();")
        }

        writer.closeBlock("},")
        writer.write(".element_end => break,")
        writer.write("else => {},")
        writer.closeBlock("}")
        writer.closeBlock("}")

        // Assign accumulated flattened lists to result fields
        for ((fieldName, _, _) in flattenedLists) {
            writer.write(
                "result.\$L = if (\${L}_list.items.len > 0) try \${L}_list.toOwnedSlice(allocator) else null;",
                fieldName, fieldName, fieldName,
            )
        }
    }

    private fun resolveZigElementType(ctx: OperationContext, elementShape: Shape): String {
        return when (elementShape) {
            is StructureShape -> elementShape.id.name
            is EnumShape, is IntEnumShape -> elementShape.id.name
            is StringShape -> {
                if (ctx.isEnumType(elementShape)) elementShape.id.name
                else "[]const u8"
            }
            is BooleanShape -> "bool"
            is IntegerShape, is ShortShape -> "i32"
            is LongShape -> "i64"
            is FloatShape -> "f32"
            is DoubleShape -> "f64"
            else -> "[]const u8"
        }
    }

    private fun writeXmlMemberDeserializer(
        writer: ZigWriter,
        ctx: OperationContext,
        fieldName: String,
        targetShape: Shape,
        memberShape: MemberShape,
    ) {
        when (targetShape) {
            is StructureShape -> {
                writer.write(
                    "result.\$L = try serde.deserialize\$L(allocator, &reader);",
                    fieldName, targetShape.id.name,
                )
            }
            is ListShape -> {
                val isFlattened = memberShape.hasTrait(XmlFlattenedTrait::class.java)
                if (isFlattened) {
                    // Each XML element is a single item -- append to the ArrayList
                    val elementShape = ctx.model.expectShape(targetShape.member.target)
                    writeFlattenedItemDeserializer(writer, ctx, fieldName, elementShape)
                } else {
                    val listFnName = "deserialize${targetShape.id.name}"
                    val itemTag = targetShape.member.getTrait(XmlNameTrait::class.java)
                        .map { it.value }
                        .orElse("member")
                    writer.write(
                        "result.\$L = try serde.\$L(allocator, &reader, \"\$L\");",
                        fieldName, listFnName, itemTag,
                    )
                }
            }
            is MapShape -> {
                val mapFnName = "deserialize${targetShape.id.name}"
                writer.write(
                    "result.\$L = try serde.\$L(allocator, &reader, \"entry\");",
                    fieldName, mapFnName,
                )
            }
            is EnumShape, is IntEnumShape -> {
                writer.write(
                    "result.\$L = std.meta.stringToEnum(\$L, try reader.readElementText());",
                    fieldName, targetShape.id.name,
                )
            }
            is StringShape -> {
                if (ctx.isEnumType(targetShape)) {
                    writer.write(
                        "result.\$L = std.meta.stringToEnum(\$L, try reader.readElementText());",
                        fieldName, targetShape.id.name,
                    )
                } else {
                    writer.write(
                        "result.\$L = try allocator.dupe(u8, try reader.readElementText());",
                        fieldName,
                    )
                }
            }
            is BooleanShape -> {
                writer.write(
                    "result.\$L = std.mem.eql(u8, try reader.readElementText(), \"true\");",
                    fieldName,
                )
            }
            is IntegerShape, is ShortShape -> {
                writer.write(
                    "result.\$L = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;",
                    fieldName,
                )
            }
            is LongShape -> {
                writer.write(
                    "result.\$L = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;",
                    fieldName,
                )
            }
            is FloatShape -> {
                writer.write(
                    "result.\$L = std.fmt.parseFloat(f32, try reader.readElementText()) catch null;",
                    fieldName,
                )
            }
            is DoubleShape -> {
                writer.write(
                    "result.\$L = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;",
                    fieldName,
                )
            }
            is TimestampShape -> {
                writer.write(
                    "result.\$L = aws.date.parseIso8601(try reader.readElementText()) catch null;",
                    fieldName,
                )
            }
            is BlobShape -> {
                writer.write(
                    "result.\$L = try allocator.dupe(u8, try reader.readElementText());",
                    fieldName,
                )
            }
            else -> {
                writer.write("try reader.skipElement();")
            }
        }
    }

    private fun writeFlattenedItemDeserializer(
        writer: ZigWriter,
        ctx: OperationContext,
        fieldName: String,
        elementShape: Shape,
    ) {
        when (elementShape) {
            is StructureShape -> {
                writer.write(
                    "try \${L}_list.append(allocator, try serde.deserialize\$L(allocator, &reader));",
                    fieldName, elementShape.id.name,
                )
            }
            is EnumShape, is IntEnumShape -> {
                writer.write(
                    "try \${L}_list.append(allocator, std.meta.stringToEnum(\$L, try reader.readElementText()) orelse continue);",
                    fieldName, elementShape.id.name,
                )
            }
            is StringShape -> {
                if (ctx.isEnumType(elementShape)) {
                    writer.write(
                        "try \${L}_list.append(allocator, std.meta.stringToEnum(\$L, try reader.readElementText()) orelse continue);",
                        fieldName, elementShape.id.name,
                    )
                } else {
                    writer.write(
                        "try \${L}_list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));",
                        fieldName,
                    )
                }
            }
            is BooleanShape -> {
                writer.write(
                    "try \${L}_list.append(allocator, std.mem.eql(u8, try reader.readElementText(), \"true\"));",
                    fieldName,
                )
            }
            is IntegerShape, is ShortShape -> {
                writer.write(
                    "try \${L}_list.append(allocator, std.fmt.parseInt(i32, try reader.readElementText(), 10) catch continue);",
                    fieldName,
                )
            }
            is LongShape -> {
                writer.write(
                    "try \${L}_list.append(allocator, std.fmt.parseInt(i64, try reader.readElementText(), 10) catch continue);",
                    fieldName,
                )
            }
            else -> {
                writer.write("try reader.skipElement();")
            }
        }
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
                    writer.write("result.\$L = try allocator.dupe(u8, value);", fieldName)
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
                    writer.write("result.\$L = try allocator.dupe(u8, value);", fieldName)
                }
            }
            writer.closeBlock("}")
        }
    }

    override fun writeDeserializeStreamingResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val bindings = resolveOutputBindings(ctx)

        writer.openBlock(
            "fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !\$L {",
            outputName,
        )

        // Check if allocator is actually used (only string headers need it)
        val allocUsedInStreaming = bindings.headers.values.any { ms ->
            val ts = ctx.model.expectShape(ms.target)
            ctx.resolveBaseZigType(ts) == "[]const u8"
        }
        if (!allocUsedInStreaming) {
            writer.write("_ = allocator;")
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
                        writer.write("result.\$L = try allocator.dupe(u8, value);", fieldName)
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
                        writer.write("result.\$L = try allocator.dupe(u8, value);", fieldName)
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
        writer.openBlock("fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {")

        writer.write("const error_code = aws.xml.findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = aws.xml.findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = aws.xml.findElement(body, \"RequestId\") orelse \"\";")
        writer.write("var arena = std.heap.ArenaAllocator.init(allocator);")
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
