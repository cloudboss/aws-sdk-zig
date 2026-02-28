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
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.aws.traits.protocols.Ec2QueryNameTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

open class AwsQueryProtocol : ProtocolGenerator {

    override fun contentType(): String = "application/x-www-form-urlencoded"

    override fun needsXmlSerde(): Boolean = true

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
            // EC2 Query protocol uses ec2QueryName trait for the wire name.
            // When absent, fall back to xmlName (capitalized) which carries the
            // correct wire name for members like Description -> GroupDescription.
            // Final fallback is the Smithy member name itself.
            val queryName = memberShape.getTrait(Ec2QueryNameTrait::class.java)
                .map { it.value }
                .orElseGet {
                    memberShape.getTrait(XmlNameTrait::class.java)
                        .map { it.value.replaceFirstChar { c -> c.uppercaseChar() } }
                        .orElse(memberName)
                }
            writeFieldSerializer(writer, ctx, queryName, memberShape, targetShape, "input")
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

    private fun hasSerializableFields(ctx: OperationContext, shape: Shape): Boolean {
        return when (shape) {
            is StructureShape -> shape.allMembers.values.any { ms ->
                val ts = ctx.model.expectShape(ms.target)
                ctx.isScalarType(ts) || ts is StructureShape || ts is ListShape
            }
            is ListShape -> {
                val elementShape = ctx.model.expectShape(shape.member.target)
                if (elementShape is StructureShape) hasSerializableFields(ctx, elementShape)
                else ctx.isScalarType(elementShape)
            }
            is MapShape -> true
            else -> ctx.isScalarType(shape)
        }
    }

    private fun writeFieldSerializer(
        writer: ZigWriter,
        ctx: OperationContext,
        smithyName: String,
        memberShape: MemberShape,
        targetShape: Shape,
        accessor: String,
    ) {
        val fieldName = NamingUtil.toFieldName(memberShape.memberName)

        when {
            targetShape is StructureShape -> {
                if (!hasSerializableFields(ctx, targetShape)) return
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
                if (!hasSerializableFields(ctx, listTargetShape)) return
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
            targetShape is MapShape -> {
                val mapValueShape = ctx.model.expectShape(targetShape.value.target)
                // Handle struct/union-valued maps
                if (mapValueShape is UnionShape) {
                    // TODO: union-valued map serialization requires discriminator logic
                    if (!memberShape.isRequired) {
                        // Optional: no code needed, field is null by default
                    } else {
                        writer.write("_ = \$L.\$L;", accessor, fieldName)
                    }
                    return
                }

                // Struct-valued maps: serialize with flattened field structure
                if (memberShape.isRequired) {
                    writeStructMapQuerySerializer(writer, ctx, smithyName, mapValueShape as StructureShape, "$accessor.$fieldName")
                } else {
                    writer.openBlock("if (\$L.\$L) |entries| {", accessor, fieldName)
                    writeStructMapQuerySerializer(writer, ctx, smithyName, mapValueShape as StructureShape, "entries")
                    writer.closeBlock("}")
                }
                return
            }
            else -> {
                // Scalar field
                if (memberShape.isRequired) {
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                        ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                } else {
                    writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                    writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", smithyName)
                    writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
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
        depth: Int = 0,
    ) {
        for ((memberName, memberShape) in structShape.allMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            val fieldName = NamingUtil.toFieldName(memberName)
            val qualifiedName = "$prefix.$memberName"

            when {
                ctx.isScalarType(targetShape) -> {
                    if (memberShape.isRequired) {
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                    } else {
                        val captureVar = if (depth == 0) "sv" else "sv${depth + 1}"
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, captureVar)
                        writer.write("try body_buf.appendSlice(alloc, \"&\$L=\");", qualifiedName)
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExprForOptional(targetShape, captureVar))
                        writer.closeBlock("}")
                    }
                }
                targetShape is StructureShape -> {
                    if (!hasSerializableFields(ctx, targetShape)) continue
                    val captureVar = if (depth == 0) "sv" else "sv${depth + 1}"
                    if (memberShape.isRequired) {
                        writeStructFieldSerializers(writer, ctx, qualifiedName, targetShape,
                            "$accessor.$fieldName", depth + 1)
                    } else {
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, captureVar)
                        writeStructFieldSerializers(writer, ctx, qualifiedName, targetShape,
                            captureVar, depth + 1)
                        writer.closeBlock("}")
                    }
                }
                targetShape is ListShape -> {
                    val listMemberShape = targetShape.member
                    val listTargetShape = ctx.model.expectShape(listMemberShape.target)
                    if (!hasSerializableFields(ctx, listTargetShape)) continue
                    val xmlName = listMemberShape.getTrait(XmlNameTrait::class.java)
                        .map { it.value }
                        .orElse("member")
                    val listVar = "list_d$depth"
                    if (memberShape.isRequired) {
                        writeListSerializer(writer, ctx, qualifiedName, xmlName, listTargetShape,
                            "$accessor.$fieldName", depth)
                    } else {
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, listVar)
                        writeListSerializer(writer, ctx, qualifiedName, xmlName, listTargetShape,
                            listVar, depth)
                        writer.closeBlock("}")
                    }
                }
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
        depth: Int = 0,
    ) {
        if (elementShape is StructureShape) {
            if (!hasSerializableFields(ctx, elementShape)) return

            writer.openBlock("for (\$L, 0..) |item, idx| {", accessor)
            writer.write("const n = idx + 1;")

            val innerPrefix = "$prefix.$xmlName.{d}"
            writeStructFieldSerializersInList(writer, ctx, innerPrefix, elementShape, "item", listOf("n"), depth + 1)

            writer.closeBlock("}")
        } else {
            writer.openBlock("for (\$L, 0..) |item, idx| {", accessor)
            writer.write("const n = idx + 1;")
            writer.write("var prefix_buf: [256]u8 = undefined;")
            writer.write(
                "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.\$L.{d}=\", .{n}) catch continue;",
                prefix, xmlName,
            )
            writer.write("try body_buf.appendSlice(alloc, field_prefix);")
            writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, item);")
            writer.closeBlock("}")
        }
    }

    private fun writeStructFieldSerializersInList(
        writer: ZigWriter,
        ctx: OperationContext,
        prefixTemplate: String,
        structShape: StructureShape,
        accessor: String,
        indexVars: List<String>,
        depth: Int,
    ) {
        for ((memberName, memberShape) in structShape.allMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            val fieldName = NamingUtil.toFieldName(memberName)
            val qualifiedPrefix = "$prefixTemplate.$memberName"

            when {
                ctx.isScalarType(targetShape) -> {
                    val captureVar = "fv_$depth"
                    writer.openBlock("{")
                    writer.write("var prefix_buf: [256]u8 = undefined;")
                    val formatArgs = indexVars.joinToString(", ")
                    writer.write(
                        "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L=\", .{\$L}) catch continue;",
                        qualifiedPrefix, formatArgs,
                    )
                    writer.write("try body_buf.appendSlice(alloc, field_prefix);")
                    if (memberShape.isRequired) {
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                    } else {
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, captureVar)
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExprForOptional(targetShape, captureVar))
                        writer.closeBlock("}")
                    }
                    writer.closeBlock("}")
                }
                targetShape is StructureShape -> {
                    if (!hasSerializableFields(ctx, targetShape)) continue
                    val captureVar = "sv_$depth"
                    if (memberShape.isRequired) {
                        writeStructFieldSerializersInList(writer, ctx, qualifiedPrefix, targetShape,
                            "$accessor.$fieldName", indexVars, depth + 1)
                    } else {
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, captureVar)
                        writeStructFieldSerializersInList(writer, ctx, qualifiedPrefix, targetShape,
                            captureVar, indexVars, depth + 1)
                        writer.closeBlock("}")
                    }
                }
                targetShape is ListShape -> {
                    val listMember = targetShape.member
                    val listElement = ctx.model.expectShape(listMember.target)
                    if (!hasSerializableFields(ctx, listElement)) continue
                    val xmlName = listMember.getTrait(XmlNameTrait::class.java)
                        .map { it.value }
                        .orElse("member")
                    val innerPrefix = "$qualifiedPrefix.$xmlName.{d}"
                    val innerVar = "item_$depth"
                    val innerIdx = "idx_$depth"
                    val innerN = "n_$depth"
                    val listVar = "lst_$depth"

                    if (!memberShape.isRequired) {
                        writer.openBlock("if (\$L.\$L) |\$L| {", accessor, fieldName, listVar)
                    }
                    val listAccessor = if (memberShape.isRequired) "$accessor.$fieldName" else listVar
                    writer.openBlock("for (\$L, 0..) |\$L, \$L| {", listAccessor, innerVar, innerIdx)
                    writer.write("const \$L = \$L + 1;", innerN, innerIdx)

                    val newIndexVars = indexVars + innerN
                    if (listElement is StructureShape) {
                        writeStructFieldSerializersInList(writer, ctx, innerPrefix, listElement,
                            innerVar, newIndexVars, depth + 1)
                    } else {
                        writer.openBlock("{")
                        writer.write("var prefix_buf: [256]u8 = undefined;")
                        val formatArgs = newIndexVars.joinToString(", ")
                        writer.write(
                            "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L=\", .{\$L}) catch continue;",
                            innerPrefix, formatArgs,
                        )
                        writer.write("try body_buf.appendSlice(alloc, field_prefix);")
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);", innerVar)
                        writer.closeBlock("}")
                    }

                    writer.closeBlock("}") // for
                    if (!memberShape.isRequired) {
                        writer.closeBlock("}") // if
                    }
                }
            }
        }
    }

    private fun writeMapQuerySerializer(
        writer: ZigWriter,
        ctx: OperationContext,
        prefix: String,
        mapShape: MapShape,
        keyTag: String,
        valueTag: String,
        accessor: String,
    ) {
        // Maps are serialized as: prefix.entry.1.key=K&prefix.entry.1.value=V
        val valueShape = ctx.model.expectShape(mapShape.value.target)
        val valueZigType = ctx.resolveBaseZigType(valueShape)
        val isValueEnum = ctx.isEnumType(valueShape)

        writer.openBlock("for (\$L, 0..) |entry, idx| {", accessor)
        writer.write("const n = idx + 1;")
        writer.openBlock("{")
        writer.write("var prefix_buf: [256]u8 = undefined;")
        writer.write(
            "const key_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.entry.{d}.\$L=\", .{n}) catch continue;",
            prefix, keyTag,
        )
        writer.write("try body_buf.appendSlice(alloc, key_prefix);")
        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, entry.key);")
        writer.closeBlock("}")

        writer.openBlock("{")
        writer.write("var prefix_buf: [256]u8 = undefined;")
        writer.write(
            "const val_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.entry.{d}.\$L=\", .{n}) catch continue;",
            prefix, valueTag,
        )
        writer.write("try body_buf.appendSlice(alloc, val_prefix);")

        when {
            isValueEnum -> {
                writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(entry.value));")
            }
            valueZigType == "[]const u8" -> {
                writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, entry.value);")
            }
            valueZigType in listOf("i32", "i64", "i16", "i8") -> {
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{entry.value}) catch \"\";")
                writer.write("try body_buf.appendSlice(alloc, num_str);")
            }
            valueZigType == "bool" -> {
                writer.write("try body_buf.appendSlice(alloc, if (entry.value) \"true\" else \"false\");")
            }
            else -> {
                writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, entry.value);")
            }
        }

        writer.closeBlock("}")
        writer.closeBlock("}") // for
    }

    private fun writeStructMapQuerySerializer(
        writer: ZigWriter,
        ctx: OperationContext,
        prefix: String,
        structShape: StructureShape,
        accessor: String,
    ) {
        // Maps with struct values are serialized as:
        // prefix.entry.1.key=K&prefix.entry.1.StructField1=V1&prefix.entry.1.StructField2=V2
        writer.openBlock("for (\$L, 0..) |entry, idx| {", accessor)
        writer.write("const n = idx + 1;")
        
        // Serialize the key
        writer.openBlock("{")
        writer.write("var prefix_buf: [256]u8 = undefined;")
        writer.write(
            "const key_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L.entry.{d}.key=\", .{n}) catch continue;",
            prefix,
        )
        writer.write("try body_buf.appendSlice(alloc, key_prefix);")
        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, entry.key);")
        writer.closeBlock("}")
        
        // Serialize struct fields within the map entry
        val entryPrefix = "$prefix.entry.{d}"
        writeStructMapEntryFields(writer, ctx, entryPrefix, structShape, "entry.value")
        
        writer.closeBlock("}") // for
    }
    
    private fun writeStructMapEntryFields(
        writer: ZigWriter,
        ctx: OperationContext,
        prefixTemplate: String,
        structShape: StructureShape,
        accessor: String,
    ) {
        for ((memberName, memberShape) in structShape.allMembers) {
            val targetShape = ctx.model.expectShape(memberShape.target)
            val fieldName = NamingUtil.toFieldName(memberName)
            val qualifiedName = "$prefixTemplate.$memberName"
            
            when {
                ctx.isScalarType(targetShape) -> {
                    if (memberShape.isRequired) {
                        writer.openBlock("{")
                        writer.write("var prefix_buf: [256]u8 = undefined;")
                        writer.write(
                            "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L=\", .{}) catch continue;",
                            qualifiedName,
                        )
                        writer.write("try body_buf.appendSlice(alloc, field_prefix);")
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExpr(targetShape, fieldName, accessor))
                        writer.closeBlock("}")
                    } else {
                        writer.openBlock("if (\$L.\$L) |v| {", accessor, fieldName)
                        writer.openBlock("{")
                        writer.write("var prefix_buf: [256]u8 = undefined;")
                        writer.write(
                            "const field_prefix = std.fmt.bufPrint(&prefix_buf, \"&\$L=\", .{}) catch continue;",
                            qualifiedName,
                        )
                        writer.write("try body_buf.appendSlice(alloc, field_prefix);")
                        writer.write("try aws.url.appendUrlEncoded(alloc, &body_buf, \$L);",
                            ctx.scalarFormatExprForOptional(targetShape, "v"))
                        writer.closeBlock("}")
                        writer.closeBlock("}")
                    }
                }
            }
        }
    }

    override fun writeDeserializeResponse(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${ctx.operationName}Output"
        val hasMembers = ctx.outputShape.allMembers.isNotEmpty()
        val resultMutated = ctx.outputShape.allMembers.values.any { ms ->
            memberWritesToResult(ctx.model.expectShape(ms.target))
        }

        writer.openBlock(
            "fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !\$L {",
            outputName,
        )
        writer.write("_ = status;")
        writer.write("_ = headers;")

        if (!hasMembers || !resultMutated) {
            writer.write("_ = body;")
            writer.write("_ = alloc;")
            writer.write("const result: \$L = .{};", outputName)
        } else {
            val allocUsed = ctx.outputShape.allMembers.values.any { ms ->
                val target = ctx.model.expectShape(ms.target)
                (target is StringShape && !ctx.isEnumType(target)) ||
                    target is BlobShape || target is StructureShape || target is ListShape ||
                    target is MapShape
            }
            if (!allocUsed) {
                writer.write("_ = alloc;")
            }
            writer.write("var reader = aws.xml.Reader.init(body);")
            writer.blankLine()

            // Navigate to wrapper element
            writeSkipToResultWrapper(writer, ctx)
            writer.blankLine()

            writer.write("var result: \$L = .{};", outputName)
            writeXmlMemberParsing(writer, ctx, ctx.outputShape.allMembers)
        }

        writer.blankLine()
        writer.write("return result;")
        writer.closeBlock("}")
    }

    /** Check if deserializing this shape type will assign to result (vs skipElement). */
    protected fun memberWritesToResult(targetShape: Shape): Boolean {
        return targetShape is StructureShape || targetShape is ListShape ||
            targetShape is MapShape ||
            targetShape is StringShape || targetShape is BooleanShape ||
            targetShape is IntegerShape || targetShape is ShortShape ||
            targetShape is LongShape || targetShape is FloatShape ||
            targetShape is DoubleShape || targetShape is EnumShape ||
            targetShape is IntEnumShape || targetShape is TimestampShape ||
            targetShape is BlobShape
    }

    protected open fun writeSkipToResultWrapper(writer: ZigWriter, ctx: OperationContext) {
        val resultName = "${ctx.operationName}Result"
        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.openBlock(".element_start => |e| {")
        writer.write("if (std.mem.eql(u8, e.local, \"\$L\")) break;", resultName)
        writer.closeBlock("},")
        writer.write("else => {},")
        writer.closeBlock("}")
        writer.closeBlock("}")
    }

    protected fun writeXmlMemberParsing(
        writer: ZigWriter,
        ctx: OperationContext,
        members: Map<String, MemberShape>,
    ) {
        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.openBlock(".element_start => |e| {")

        var first = true
        for ((memberName, memberShape) in members) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = ctx.model.expectShape(memberShape.target)
            val xmlName = memberShape.getTrait(XmlNameTrait::class.java)
                .map { it.value }
                .orElse(memberName)

            val prefix = if (first) "if" else "} else if"
            first = false

            writer.write("\$L (std.mem.eql(u8, e.local, \"\$L\")) {", prefix, xmlName)
            writer.indent()
            writeXmlMemberDeserializer(writer, ctx, fieldName, targetShape)
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
    }

    protected fun writeXmlMemberDeserializer(
        writer: ZigWriter,
        ctx: OperationContext,
        fieldName: String,
        targetShape: Shape,
    ) {
        when (targetShape) {
            is StructureShape -> {
                writer.write(
                    "result.\$L = try serde.deserialize\$L(&reader, alloc);",
                    fieldName, targetShape.id.name,
                )
            }
            is ListShape -> {
                val listFnName = "deserialize${targetShape.id.name}"
                val itemTag = targetShape.member.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse("member")
                writer.write(
                    "result.\$L = try serde.\$L(&reader, alloc, \"\$L\");",
                    fieldName, listFnName, itemTag,
                )
            }
            is MapShape -> {
                val mapFnName = "deserialize${targetShape.id.name}"
                writer.write(
                    "result.\$L = try serde.\$L(&reader, alloc, \"entry\");",
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
                        "result.\$L = try alloc.dupe(u8, try reader.readElementText());",
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
                    "result.\$L = try alloc.dupe(u8, try reader.readElementText());",
                    fieldName,
                )
            }
            else -> {
                writer.write("try reader.skipElement();")
            }
        }
    }

    override open fun writeParseErrorResponse(writer: ZigWriter, ctx: OperationContext) {
        writer.openBlock("fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {")

        writer.write("const error_code = aws.xml.findElement(body, \"Code\") orelse \"Unknown\";")
        writer.write("const error_message = aws.xml.findElement(body, \"Message\") orelse \"\";")
        writer.write("const request_id = aws.xml.findElement(body, \"RequestId\") orelse \"\";")
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
