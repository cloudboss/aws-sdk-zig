package software.amazon.smithy.zig.aws.protocols

import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class AwsQueryProtocol : ProtocolGenerator {

    override fun contentType(): String = "application/x-www-form-urlencoded"

    override fun writeSerializeRequest(writer: ZigWriter, ctx: OperationContext) {
        val inputName = "${ctx.operationName}Input"

        writer.openBlock(
            "fn serializeRequest(alloc: std.mem.Allocator, input: \$L, config: *aws.Config) !aws.http.Request {",
            inputName,
        )

        // Discard input if no fields to serialize
        if (ctx.inputShape.allMembers.isEmpty()) {
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

        // Build form body
        writer.write("var body_buf: std.ArrayList(u8) = .{};")
        writer.blankLine()
        writer.write(
            "try body_buf.appendSlice(alloc, \"Action=\$L&Version=\$L\");",
            ctx.operationName, ctx.apiVersion,
        )

        // Serialize input fields
        for ((memberName, memberShape) in ctx.inputShape.allMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            writeFieldSerializer(writer, ctx, memberName, memberShape, targetShape, "input")
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
        ctx: OperationContext,
        smithyName: String,
        memberShape: MemberShape,
        targetShape: Shape,
        accessor: String,
    ) {
        val fieldName = NamingUtil.toSnakeCase(smithyName)

        when {
            targetShape is StructureShape -> {
                if (memberShape.isRequired) {
                    writeStructFieldSerializers(writer, ctx, smithyName, targetShape, "$accessor.$fieldName")
                } else {
                    writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                    writeStructFieldSerializers(writer, ctx, smithyName, targetShape, "v")
                    writer.closeBlock("}")
                }
            }
            targetShape is ListShape -> {
                val listMemberShape = targetShape.member
                val listTargetShape = ctx.model.expectShape(listMemberShape.target)
                val xmlName = listMemberShape.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse("member")

                if (memberShape.isRequired) {
                    writeListSerializer(writer, ctx, smithyName, xmlName, listTargetShape, "$accessor.$fieldName")
                } else {
                    writer.openBlock("if (\$L.\$L) |list| {", accessor, fieldName)
                    writeListSerializer(writer, ctx, smithyName, xmlName, listTargetShape, "list")
                    writer.closeBlock("}")
                }
            }
            else -> {
                // Scalar field
                if (memberShape.isRequired) {
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                        ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                } else {
                    writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                        ctx.scalarFormatExprForOptional(targetShape, "v"))
                    writer.closeBlock("}")
                }
            }
        }
    }

    private fun writeStructFieldSerializers(
        writer: ZigWriter,
        ctx: OperationContext,
        prefix: String,
        structShape: StructureShape,
        accessor: String,
    ) {
        for ((memberName, memberShape) in structShape.allMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            val fieldName = NamingUtil.toSnakeCase(memberName)
            val qualifiedName = "$prefix.$memberName"

            when {
                ctx.isScalarType(targetShape) -> {
                    if (memberShape.isRequired) {
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                    } else {
                        writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExprForOptional(targetShape, "v"))
                        writer.closeBlock("}")
                    }
                }
                else -> {}
            }
        }
    }

    private fun writeListSerializer(
        writer: ZigWriter,
        ctx: OperationContext,
        prefix: String,
        xmlName: String,
        elementShape: Shape,
        accessor: String,
    ) {
        writer.openBlock("for (\$L, 0..) |item, idx| {", accessor)
        writer.write("const n = idx + 1;")

        if (elementShape is StructureShape) {
            for ((memberName, memberShape) in elementShape.allMembers) {
                val targetShape = ctx.model.expectShape(memberShape.target)
                val fieldName = NamingUtil.toSnakeCase(memberName)

                if (ctx.isScalarType(targetShape)) {
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
                            ctx.scalarFormatExpr(targetShape, fieldName, "item"))
                    } else {
                        writer.openBlock("if (item.\$L) |v| {", fieldName)
                        writer.write("try appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExprForOptional(targetShape, "v"))
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

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"

        // Check if any members are deserializable scalar types
        val hasDeserializableFields = ctx.outputShape.allMembers.values.any { memberShape ->
            val targetShape = ctx.model.expectShape(memberShape.target)
            val zigType = ctx.resolveBaseZigType(targetShape)
            zigType in listOf("[]const u8", "i32", "i64", "bool")
        }

        writer.openBlock(
            "fn deserializeResponse(body: []const u8, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )

        if (!hasDeserializableFields) {
            writer.write("_ = body;")
            writer.write("const result: \$L = .{ .allocator = alloc };", outputName)
        } else {
            writer.write("var result: \$L = .{ .allocator = alloc };", outputName)

            for ((memberName, memberShape) in ctx.outputShape.allMembers) {
                val fieldName = NamingUtil.toSnakeCase(memberName)
                val targetShape = ctx.model.expectShape(memberShape.target)
                val xmlName = memberShape.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse(memberName)
                val zigType = ctx.resolveBaseZigType(targetShape)

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
                    }
                }
            }
        }

        writer.blankLine()
        writer.write("return result;")
        writer.closeBlock("}")
    }

    override fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
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
}
