package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class OperationGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
    private val operation: OperationShape,
    private val apiVersion: String,
    private val errorInfos: List<ErrorGenerator.ErrorInfo>,
) {
    private val operationName = operation.id.name
    private val fileName = NamingUtil.toZigFileName(operationName)
    private val inputShape: StructureShape =
        model.expectShape(operation.inputShape, StructureShape::class.java)
    private val outputShape: StructureShape =
        model.expectShape(operation.outputShape, StructureShape::class.java)

    fun run() {
        context.writerDelegator().useFileWriter(fileName) { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            // Intra-service imports written after standard imports
            writer.write("const Client = @import(\"client.zig\").Client;")
            writer.write("const ServiceError = @import(\"errors.zig\").ServiceError;")
            writer.blankLine()

            writeInputStruct(writer)
            writer.blankLine()
            writeOutputStruct(writer)
            writer.blankLine()
            writeOptionsStruct(writer)
            writer.blankLine()
            writeExecuteFunction(writer)
            writer.blankLine()
            writeSerializeRequest(writer)
            writer.blankLine()
            writeDeserializeResponse(writer)
            writer.blankLine()
            writeParseErrorResponse(writer)
        }
    }

    private fun writeInputStruct(writer: ZigWriter) {
        val docs = operation.getTrait(DocumentationTrait::class.java)
            .map { it.value }
            .orElse(null)
        if (docs != null) {
            writer.writeDocs(docs)
        }

        val inputName = "${operationName}Input"
        writer.openBlock("pub const \$L = struct {", inputName)

        var firstField = true
        for ((memberName, memberShape) in inputShape.allMembers) {
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val zigType = resolveZigType(memberShape, targetShape)

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            val defaultValue = if (!memberShape.isRequired) " = null" else ""
            writer.write("\$L: \$L\$L,", fieldName, zigType, defaultValue)
            firstField = false
        }

        writer.closeBlock("};")
    }

    private fun writeOutputStruct(writer: ZigWriter) {
        val outputName = "${operationName}Output"
        writer.openBlock("pub const \$L = struct {", outputName)

        var firstField = true
        for ((memberName, memberShape) in outputShape.allMembers) {
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val zigType = resolveZigType(memberShape, targetShape)

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            val defaultValue = if (!memberShape.isRequired) " = null" else ""
            writer.write("\$L: \$L\$L,", fieldName, zigType, defaultValue)
            firstField = false
        }

        writer.blankLine()
        writer.write("allocator: std.mem.Allocator,")
        writer.blankLine()
        writer.openBlock("pub fn deinit(self: *const \$L) void {", outputName)

        for ((memberName, memberShape) in outputShape.allMembers) {
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val zigType = resolveBaseZigType(targetShape)

            if (zigType == "[]const u8") {
                if (memberShape.isRequired) {
                    writer.write("self.allocator.free(self.\$L);", fieldName)
                } else {
                    writer.openBlock("if (self.\$L) |v| {", fieldName)
                    writer.write("self.allocator.free(v);")
                    writer.closeBlock("}")
                }
            }
        }

        writer.closeBlock("}")
        writer.closeBlock("};")
    }

    private fun writeOptionsStruct(writer: ZigWriter) {
        writer.openBlock("pub const Options = struct {")
        writer.write("diagnostic: ?*ServiceError = null,")
        writer.closeBlock("};")
    }

    private fun writeExecuteFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"
        val outputName = "${operationName}Output"

        writer.openBlock(
            "pub fn execute(client: *Client, input: \$L, options: Options) !\$L {",
            inputName, outputName,
        )

        writer.write("var arena = std.heap.ArenaAllocator.init(client.allocator);")
        writer.write("defer arena.deinit();")
        writer.write("const alloc = arena.allocator();")
        writer.blankLine()

        // Serialize request
        writer.write("var request = try serializeRequest(alloc, input, client.config);")
        writer.write("defer request.deinit(alloc);")
        writer.blankLine()

        // Sign
        writer.write("var creds = try client.config.credentials.getCredentials(alloc);")
        writer.write("try aws.signing.signRequest(alloc, &request, creds, client.config.region, \"sts\");")
        writer.blankLine()

        // Send
        writer.write("var response = try client.http_client.sendRequest(&request);")
        writer.write("defer response.deinit();")
        writer.blankLine()

        // Check for errors
        writer.openBlock("if (!response.isSuccess()) {")
        writer.openBlock("if (options.diagnostic) |d| {")
        writer.write("d.* = parseErrorResponse(response.body, response.status);")
        writer.closeBlock("}")
        writer.write("return error.ServiceError;")
        writer.closeBlock("}")
        writer.blankLine()

        // Deserialize
        writer.write("return try deserializeResponse(response.body, client.allocator);")

        writer.closeBlock("}")
    }

    private fun writeSerializeRequest(writer: ZigWriter) {
        val inputName = "${operationName}Input"

        writer.openBlock(
            "fn serializeRequest(alloc: std.mem.Allocator, input: \$L, config: *aws.Config) !aws.http.Request {",
            inputName,
        )

        // Build endpoint
        writer.write("const endpoint = try config.getEndpoint(\"sts\", alloc);")
        writer.blankLine()

        // Parse host from endpoint
        writer.write("const host = parseHost(endpoint);")
        writer.write("const tls = !std.mem.startsWith(u8, endpoint, \"http://\");")
        writer.write("const port = parsePort(endpoint);")
        writer.blankLine()

        // Build form body
        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        writer.blankLine()
        writer.write(
            "try body_buf.appendSlice(alloc, \"Action=\$L&Version=\$L\");",
            operationName, apiVersion,
        )

        // Serialize input fields
        for ((memberName, memberShape) in inputShape.allMembers) {
            val targetShape = model.expectShape(memberShape.target)
            writeFieldSerializer(writer, memberName, memberShape, targetShape, "input")
        }

        writer.blankLine()
        writer.write("const body = try body_buf.toOwnedSlice(alloc);")
        writer.blankLine()

        // Build request
        writer.write("var request = aws.http.Request.init(host);")
        writer.write("request.method = .POST;")
        writer.write("request.path = \"/\";")
        writer.write("request.tls = tls;")
        writer.write("request.port = port;")
        writer.write("request.body = body;")
        writer.write("try request.headers.put(alloc, \"Content-Type\", \"application/x-www-form-urlencoded\");")
        writer.blankLine()

        writer.write("return request;")
        writer.closeBlock("}")
    }

    private fun writeFieldSerializer(
        writer: ZigWriter,
        smithyName: String,
        memberShape: MemberShape,
        targetShape: Shape,
        accessor: String,
    ) {
        val fieldName = NamingUtil.toSnakeCase(smithyName)

        when {
            targetShape is StructureShape -> {
                if (memberShape.isRequired) {
                    writeStructFieldSerializers(writer, smithyName, targetShape, "$accessor.$fieldName")
                } else {
                    writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                    writeStructFieldSerializers(writer, smithyName, targetShape, "v")
                    writer.closeBlock("}")
                }
            }
            targetShape is ListShape -> {
                val listMemberShape = targetShape.member
                val listTargetShape = model.expectShape(listMemberShape.target)
                val xmlName = listMemberShape.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse("member")

                if (memberShape.isRequired) {
                    writeListSerializer(writer, smithyName, xmlName, listTargetShape, "$accessor.$fieldName")
                } else {
                    writer.openBlock("if (\$L.\$L) |list| {", accessor, fieldName)
                    writeListSerializer(writer, smithyName, xmlName, listTargetShape, "list")
                    writer.closeBlock("}")
                }
            }
            else -> {
                // Scalar field
                if (memberShape.isRequired) {
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                        scalarFormatExpr(targetShape, fieldName, accessor))
                } else {
                    writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                        scalarFormatExprForOptional(targetShape, "v"))
                    writer.closeBlock("}")
                }
            }
        }
    }

    private fun writeStructFieldSerializers(
        writer: ZigWriter,
        prefix: String,
        structShape: StructureShape,
        accessor: String,
    ) {
        for ((memberName, memberShape) in structShape.allMembers) {
            val targetShape = model.expectShape(memberShape.target)
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val qualifiedName = "$prefix.$memberName"

            when {
                isScalarType(targetShape) -> {
                    if (memberShape.isRequired) {
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            scalarFormatExpr(targetShape, fieldName, accessor))
                    } else {
                        writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            scalarFormatExprForOptional(targetShape, "v"))
                        writer.closeBlock("}")
                    }
                }
                else -> {}
            }
        }
    }

    private fun writeListSerializer(
        writer: ZigWriter,
        prefix: String,
        xmlName: String,
        elementShape: Shape,
        accessor: String,
    ) {
        writer.openBlock("for (\$L, 0..) |item, idx| {", accessor)
        writer.write("const n = idx + 1;")

        if (elementShape is StructureShape) {
            for ((memberName, memberShape) in elementShape.allMembers) {
                val targetShape = model.expectShape(memberShape.target)
                val fieldName = NamingUtil.toSnakeCase(memberName)

                if (isScalarType(targetShape)) {
                    // Use a block scope to avoid variable name conflicts across struct fields
                    writer.openBlock("{")
                    writer.write("var prefix_buf: [256]u8 = undefined;")
                    writer.write(
                        "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.\$L.{d}.\$L=\", .{n}) catch continue;",
                        prefix, xmlName, memberName,
                    )
                    writer.write("try body_buf.appendSlice(alloc, field_prefix);")
                    if (memberShape.isRequired) {
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            scalarFormatExpr(targetShape, fieldName, "item"))
                    } else {
                        writer.openBlock("if (item.\$L) |v| {", fieldName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            scalarFormatExprForOptional(targetShape, "v"))
                        writer.closeBlock("}")
                    }
                    writer.closeBlock("}")
                }
            }
        } else {
            writer.write("var prefix_buf: [256]u8 = undefined;")
            writer.write(
                "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.\$L.{d}=\", .{n}) catch continue;",
                prefix, xmlName,
            )
            writer.write("try body_buf.appendSlice(alloc, field_prefix);")
            writer.write("try appendUrlEncoded(alloc, &body_buf, item);")
        }

        writer.closeBlock("}")
    }

    private fun writeDeserializeResponse(writer: ZigWriter) {
        val outputName = "${operationName}Output"

        writer.openBlock(
            "fn deserializeResponse(body: []const u8, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        writer.write("var result: \$L = .{ .allocator = alloc };", outputName)

        for ((memberName, memberShape) in outputShape.allMembers) {
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val xmlName = memberShape.getTrait(XmlNameTrait::class.java)
                .map { it.value }
                .orElse(memberName)
            val zigType = resolveBaseZigType(targetShape)

            when (zigType) {
                "[]const u8" -> {
                    writer.openBlock(
                        "if (findElement(body, \"\$L\")) |content| {",
                        xmlName,
                    )
                    writer.write("result.\$L = try alloc.dupe(u8, content);", fieldName)
                    writer.closeBlock("}")
                }
                "i32" -> {
                    writer.openBlock(
                        "if (findElement(body, \"\$L\")) |content| {",
                        xmlName,
                    )
                    writer.write(
                        "result.\$L = std.fmt.parseInt(i32, content, 10) catch null;",
                        fieldName,
                    )
                    writer.closeBlock("}")
                }
                "i64" -> {
                    writer.openBlock(
                        "if (findElement(body, \"\$L\")) |content| {",
                        xmlName,
                    )
                    writer.write(
                        "result.\$L = std.fmt.parseInt(i64, content, 10) catch null;",
                        fieldName,
                    )
                    writer.closeBlock("}")
                }
                "bool" -> {
                    writer.openBlock(
                        "if (findElement(body, \"\$L\")) |content| {",
                        xmlName,
                    )
                    writer.write(
                        "result.\$L = std.mem.eql(u8, content, \"true\");",
                        fieldName,
                    )
                    writer.closeBlock("}")
                }
                else -> {
                    // Nested struct types -- skip for now.
                    // Full deserialization of nested types can be added incrementally.
                }
            }
        }

        writer.blankLine()
        writer.write("return result;")
        writer.closeBlock("}")
    }

    private fun writeParseErrorResponse(writer: ZigWriter) {
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16) ServiceError {")

        writer.write("const error_code = findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = findElement(body, \"RequestId\") orelse \"\";")
        writer.blankLine()

        // Match error codes to ServiceError variants
        for (info in errorInfos) {
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
        writeFindElementHelper(writer)
        writer.blankLine()
        writeUrlEncodeHelper(writer)
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

    private fun writeUrlEncodeHelper(writer: ZigWriter) {
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

    private fun resolveZigType(memberShape: MemberShape, targetShape: Shape): String {
        val baseType = resolveBaseZigType(targetShape)
        return if (memberShape.isRequired) baseType else "?$baseType"
    }

    private fun resolveBaseZigType(shape: Shape): String {
        return context.symbolProvider().toSymbol(shape).name
    }

    private fun isScalarType(shape: Shape): Boolean {
        val typeName = resolveBaseZigType(shape)
        return typeName in listOf("[]const u8", "bool", "i8", "i16", "i32", "i64", "f32", "f64", "i128", "f128")
    }

    private fun scalarFormatExpr(shape: Shape, fieldName: String, accessor: String): String {
        val typeName = resolveBaseZigType(shape)
        return when (typeName) {
            "[]const u8" -> "$accessor.$fieldName"
            "bool" -> "if ($accessor.$fieldName) \"true\" else \"false\""
            "i32", "i64", "i16", "i8" ->
                "std.fmt.allocPrint(alloc, \"{d}\", .{$accessor.$fieldName}) catch \"\""
            else -> "$accessor.$fieldName"
        }
    }

    private fun scalarFormatExprForOptional(shape: Shape, varName: String): String {
        val typeName = resolveBaseZigType(shape)
        return when (typeName) {
            "[]const u8" -> varName
            "bool" -> "if ($varName) \"true\" else \"false\""
            "i32", "i64", "i16", "i8" ->
                "std.fmt.allocPrint(alloc, \"{d}\", .{$varName}) catch \"\""
            else -> varName
        }
    }
}
