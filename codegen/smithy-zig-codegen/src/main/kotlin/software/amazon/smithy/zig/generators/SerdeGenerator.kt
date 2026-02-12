package software.amazon.smithy.zig.generators

import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
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
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.ShortShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.TimestampShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

/**
 * Generates serde.zig for XML-based protocols (AWS Query, EC2 Query, REST-XML).
 *
 * Produces per-type `deserialize{TypeName}` functions that use the runtime
 * `aws.xml.Reader` to parse XML responses into typed Zig structs.
 */
class SerdeGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    private val symbolProvider: SymbolProvider = context.symbolProvider()
    private val topDownIndex = TopDownIndex.of(model)

    /** Struct shapes that need deserialize functions. */
    private val deserializableStructs: Set<StructureShape> by lazy { collectDeserializableShapes() }

    /** List shapes whose elements need list deserializer helpers. */
    private val deserializableLists: Set<ListShape> by lazy { collectDeserializableLists() }

    /** I/O shape IDs that are exclusively I/O (not also member types). */
    private val exclusiveIoShapeIds: Set<ShapeId> by lazy { collectExclusiveIoShapeIds() }

    fun run() {
        val structs = deserializableStructs.sortedBy { it.id.name }
        val lists = deserializableLists.sortedBy { it.id.name }

        if (structs.isEmpty() && lists.isEmpty()) return

        context.writerDelegator().useFileWriter("serde.zig") { writer ->
            // Imports
            writer.write("const aws = @import(\"aws\");")
            writer.write("const std = @import(\"std\");")
            writer.blankLine()

            // Import all referenced types
            val importedTypes = collectImportedTypes(structs, lists)
            for (typeName in importedTypes.sorted()) {
                val fileName = NamingUtil.toZigFileName(typeName)
                writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
            }
            if (importedTypes.isNotEmpty()) {
                writer.blankLine()
            }

            // Generate list deserializers first (structs may reference them)
            for (listShape in lists) {
                writeListDeserializer(writer, listShape)
                writer.blankLine()
            }

            // Generate struct deserializers
            for (structShape in structs) {
                writeStructDeserializer(writer, structShape)
                writer.blankLine()
            }
        }
    }

    // ---- Shape collection ----

    private fun collectDeserializableShapes(): Set<StructureShape> {
        val result = mutableSetOf<StructureShape>()
        val visited = mutableSetOf<ShapeId>()
        val excludeIds = exclusiveIoShapeIds

        for (op in topDownIndex.getContainedOperations(service)) {
            val outputShape = model.expectShape(op.outputShape, StructureShape::class.java)
            for ((_, member) in outputShape.allMembers) {
                collectNestedStructs(member, result, visited, excludeIds)
            }
        }
        return result
    }

    private fun collectNestedStructs(
        member: MemberShape,
        result: MutableSet<StructureShape>,
        visited: MutableSet<ShapeId>,
        excludeIds: Set<ShapeId>,
    ) {
        val targetId = member.target
        if (targetId in visited) return
        visited.add(targetId)

        val target = model.expectShape(targetId)
        when (target) {
            is StructureShape -> {
                if (targetId !in excludeIds) {
                    result.add(target)
                }
                for ((_, m) in target.allMembers) {
                    collectNestedStructs(m, result, visited, excludeIds)
                }
            }
            is ListShape -> {
                val listTarget = model.expectShape(target.member.target)
                if (listTarget is StructureShape) {
                    if (listTarget.id !in excludeIds) {
                        result.add(listTarget)
                    }
                    if (listTarget.id !in visited) {
                        visited.add(listTarget.id)
                        for ((_, m) in listTarget.allMembers) {
                            collectNestedStructs(m, result, visited, excludeIds)
                        }
                    }
                }
            }
            is MapShape -> {
                // Maps are []const u8 placeholder -- skip
            }
        }
    }

    private fun collectDeserializableLists(): Set<ListShape> {
        val result = mutableSetOf<ListShape>()
        val visited = mutableSetOf<ShapeId>()

        for (op in topDownIndex.getContainedOperations(service)) {
            val outputShape = model.expectShape(op.outputShape, StructureShape::class.java)
            collectNestedLists(outputShape, result, visited)
        }

        // Also collect lists from nested structs
        for (structShape in deserializableStructs) {
            collectNestedLists(structShape, result, visited)
        }
        return result
    }

    private fun collectNestedLists(
        structShape: StructureShape,
        result: MutableSet<ListShape>,
        visited: MutableSet<ShapeId>,
    ) {
        for ((_, member) in structShape.allMembers) {
            val target = model.expectShape(member.target)
            if (target is ListShape && target.id !in visited) {
                visited.add(target.id)
                val elementShape = model.expectShape(target.member.target)
                // Generate list helpers for all deserializable element types
                if (elementShape is StructureShape || elementShape is StringShape ||
                    elementShape is EnumShape || elementShape is IntEnumShape ||
                    elementShape is IntegerShape || elementShape is LongShape ||
                    elementShape is ShortShape || elementShape is FloatShape ||
                    elementShape is DoubleShape || elementShape is BooleanShape ||
                    elementShape is TimestampShape || elementShape is BlobShape
                ) {
                    result.add(target)
                }
                // Recurse into struct elements
                if (elementShape is StructureShape) {
                    collectNestedLists(elementShape, result, visited)
                }
            }
        }
    }

    /**
     * Collects I/O shape IDs that are *exclusively* operation I/O -- not referenced
     * as member targets by any other struct in the service. Shapes that serve as both
     * I/O and member types (e.g., EC2 Volume) must be included in serde.zig.
     */
    private fun collectExclusiveIoShapeIds(): Set<ShapeId> {
        val allIoIds = mutableSetOf<ShapeId>()
        for (op in topDownIndex.getContainedOperations(service)) {
            allIoIds.add(op.inputShape)
            allIoIds.add(op.outputShape)
        }

        // Find I/O shapes that are also member targets of other structs
        val referencedAsMembers = mutableSetOf<ShapeId>()
        for (shape in model.getShapesWithTrait(software.amazon.smithy.model.traits.MixinTrait::class.java).plus(
            model.structureShapes
        )) {
            for ((_, member) in shape.allMembers) {
                val targetId = member.target
                if (targetId in allIoIds) {
                    referencedAsMembers.add(targetId)
                }
                // Also check through lists
                val target = model.expectShape(targetId)
                if (target is ListShape) {
                    val elemId = target.member.target
                    if (elemId in allIoIds) {
                        referencedAsMembers.add(elemId)
                    }
                }
            }
        }

        return allIoIds - referencedAsMembers
    }

    // ---- Import collection ----

    private fun collectImportedTypes(
        structs: List<StructureShape>,
        lists: List<ListShape>,
    ): Set<String> {
        val types = mutableSetOf<String>()

        // All struct types that are deserialized
        for (s in structs) {
            types.add(s.id.name)
        }

        // Enum types referenced by struct members
        for (s in structs) {
            for ((_, member) in s.allMembers) {
                val target = model.expectShape(member.target)
                if (isEnumType(target)) {
                    types.add(target.id.name)
                }
                // Also check list element types
                if (target is ListShape) {
                    val elem = model.expectShape(target.member.target)
                    if (isEnumType(elem)) {
                        types.add(elem.id.name)
                    }
                }
            }
        }

        // List element types
        for (l in lists) {
            val elem = model.expectShape(l.member.target)
            if (elem is StructureShape) {
                types.add(elem.id.name)
            } else if (isEnumType(elem)) {
                types.add(elem.id.name)
            }
        }

        return types
    }

    // ---- Code generation ----

    private fun memberNeedsAlloc(targetShape: Shape): Boolean {
        return when (targetShape) {
            is StringShape -> !isEnumType(targetShape)
            is BlobShape -> true
            is StructureShape -> true
            is ListShape -> true
            is MapShape -> true
            else -> false
        }
    }

    private fun structNeedsAlloc(shape: StructureShape): Boolean {
        return shape.allMembers.values.any { member ->
            memberNeedsAlloc(model.expectShape(member.target))
        }
    }

    private fun writeStructDeserializer(writer: ZigWriter, shape: StructureShape) {
        val typeName = shape.id.name
        val fnName = "deserialize$typeName"
        val needsAlloc = structNeedsAlloc(shape)
        val hasMembers = shape.allMembers.isNotEmpty()

        writer.openBlock(
            "pub fn \$L(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !\$L {",
            fnName, typeName,
        )
        if (!needsAlloc) {
            writer.write("_ = alloc;")
        }
        if (hasMembers) {
            writer.write("var result: \$L = undefined;", typeName)
            // Initialize optional fields to null (required fields stay undefined until parsed)
            for ((memberName, memberShape) in shape.allMembers) {
                if (!memberShape.isRequired) {
                    val fieldName = NamingUtil.toFieldName(memberName)
                    writer.write("result.\$L = null;", fieldName)
                }
            }
        } else {
            writer.write("const result: \$L = .{};", typeName)
        }

        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")

        // .element_start branch -- use |_| if no members need the element name
        if (hasMembers) {
            writer.openBlock(".element_start => |e| {")
        } else {
            writer.openBlock(".element_start => |_| {")
        }

        var first = true
        for ((memberName, memberShape) in shape.allMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val xmlName = memberShape.getTrait(XmlNameTrait::class.java)
                .map { it.value }
                .orElse(memberName)

            val prefix = if (first) "if" else "} else if"
            first = false

            writer.write("\$L (std.mem.eql(u8, e.local, \"\$L\")) {", prefix, xmlName)
            writer.indent()
            writeMemberDeserializer(writer, fieldName, memberShape, targetShape)
            writer.dedent()
        }

        if (!first) {
            // Close the last if/else-if and add the else for skipElement
            writer.write("} else {")
            writer.indent()
            writer.write("try reader.skipElement();")
            writer.dedent()
            writer.write("}")
        } else {
            // No members -- just skip
            writer.write("try reader.skipElement();")
        }

        writer.closeBlock("},") // .element_start
        writer.write(".element_end => break,")
        writer.write("else => {},")
        writer.closeBlock("}") // switch
        writer.closeBlock("}") // while

        writer.write("return result;")
        writer.closeBlock("}") // fn
    }

    private fun writeMemberDeserializer(
        writer: ZigWriter,
        fieldName: String,
        memberShape: MemberShape,
        targetShape: Shape,
    ) {
        when (targetShape) {
            is StringShape -> {
                if (isEnumType(targetShape)) {
                    val enumName = targetShape.id.name
                    writer.write(
                        "result.\$L = std.meta.stringToEnum(\$L, try reader.readElementText());",
                        fieldName, enumName,
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
                if (memberShape.isRequired) {
                    writer.write(
                        "result.\$L = try std.fmt.parseInt(i32, try reader.readElementText(), 10);",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;",
                        fieldName,
                    )
                }
            }
            is LongShape -> {
                if (memberShape.isRequired) {
                    writer.write(
                        "result.\$L = try std.fmt.parseInt(i64, try reader.readElementText(), 10);",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;",
                        fieldName,
                    )
                }
            }
            is FloatShape -> {
                if (memberShape.isRequired) {
                    writer.write(
                        "result.\$L = try std.fmt.parseFloat(f32, try reader.readElementText());",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = std.fmt.parseFloat(f32, try reader.readElementText()) catch null;",
                        fieldName,
                    )
                }
            }
            is DoubleShape -> {
                if (memberShape.isRequired) {
                    writer.write(
                        "result.\$L = try std.fmt.parseFloat(f64, try reader.readElementText());",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;",
                        fieldName,
                    )
                }
            }
            is EnumShape, is IntEnumShape -> {
                val enumName = targetShape.id.name
                writer.write(
                    "result.\$L = std.meta.stringToEnum(\$L, try reader.readElementText());",
                    fieldName, enumName,
                )
            }
            is TimestampShape -> {
                if (memberShape.isRequired) {
                    writer.write(
                        "result.\$L = try aws.imds.parseIso8601(try reader.readElementText());",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = aws.imds.parseIso8601(try reader.readElementText()) catch null;",
                        fieldName,
                    )
                }
            }
            is BlobShape -> {
                writer.write(
                    "result.\$L = try alloc.dupe(u8, try reader.readElementText());",
                    fieldName,
                )
            }
            is StructureShape -> {
                val typeName = targetShape.id.name
                writer.write(
                    "result.\$L = try deserialize\$L(reader, alloc);",
                    fieldName, typeName,
                )
            }
            is ListShape -> {
                val listFnName = listDeserializerName(targetShape)
                val itemTag = getListItemTag(targetShape)
                writer.write(
                    "result.\$L = try \$L(reader, alloc, \"\$L\");",
                    fieldName, listFnName, itemTag,
                )
            }
            is MapShape -> {
                // Maps are []const u8 placeholder -- read raw text
                writer.write(
                    "result.\$L = try alloc.dupe(u8, try reader.readElementText());",
                    fieldName,
                )
            }
            else -> {
                // Unknown type -- skip
                writer.write("try reader.skipElement();")
            }
        }
    }

    private fun writeListDeserializer(writer: ZigWriter, listShape: ListShape) {
        val elementShape = model.expectShape(listShape.member.target)
        val fnName = listDeserializerName(listShape)
        val elementTypeName = symbolProvider.toSymbol(elementShape).name

        val returnType = "[]const $elementTypeName"

        writer.openBlock(
            "pub fn \$L(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) !\$L {",
            fnName, returnType,
        )

        writer.write("var list: std.ArrayList(\$L) = .{};", elementTypeName)
        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.openBlock(".element_start => |e| {")
        writer.openBlock("if (std.mem.eql(u8, e.local, item_tag)) {")

        when (elementShape) {
            is StructureShape -> {
                val typeName = elementShape.id.name
                writer.write("try list.append(alloc, try deserialize\$L(reader, alloc));", typeName)
            }
            is StringShape -> {
                if (isEnumType(elementShape)) {
                    val enumName = elementShape.id.name
                    writer.write(
                        "if (std.meta.stringToEnum(\$L, try reader.readElementText())) |v| try list.append(alloc, v);",
                        enumName,
                    )
                } else {
                    writer.write("try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));")
                }
            }
            is EnumShape, is IntEnumShape -> {
                val enumName = elementShape.id.name
                writer.write(
                    "if (std.meta.stringToEnum(\$L, try reader.readElementText())) |v| try list.append(alloc, v);",
                    enumName,
                )
            }
            is IntegerShape, is ShortShape -> {
                writer.write("if (std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null) |v| try list.append(alloc, v);")
            }
            is LongShape -> {
                writer.write("if (std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null) |v| try list.append(alloc, v);")
            }
            is TimestampShape -> {
                writer.write("if (aws.imds.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(alloc, v);")
            }
            is FloatShape -> {
                writer.write("if (std.fmt.parseFloat(f32, try reader.readElementText()) catch null) |v| try list.append(alloc, v);")
            }
            is DoubleShape -> {
                writer.write("if (std.fmt.parseFloat(f64, try reader.readElementText()) catch null) |v| try list.append(alloc, v);")
            }
            is BooleanShape -> {
                writer.write("try list.append(alloc, std.mem.eql(u8, try reader.readElementText(), \"true\"));")
            }
            is BlobShape -> {
                writer.write("try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));")
            }
            else -> {
                writer.write("try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));")
            }
        }

        writer.closeBlock("} else {") // if eql
        writer.write("    try reader.skipElement();")
        writer.write("}")
        writer.closeBlock("},") // .element_start
        writer.write(".element_end => break,")
        writer.write("else => {},")
        writer.closeBlock("}") // switch
        writer.closeBlock("}") // while

        writer.write("return list.toOwnedSlice(alloc);")
        writer.closeBlock("}") // fn
    }

    // ---- Helpers ----

    private fun listDeserializerName(listShape: ListShape): String {
        return "deserialize${listShape.id.name}"
    }

    private fun getListItemTag(listShape: ListShape): String {
        return listShape.member.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse("member")
    }

    private fun isEnumType(shape: Shape): Boolean {
        return shape is EnumShape || shape is IntEnumShape ||
            (shape is StringShape && shape.hasTrait(EnumTrait::class.java))
    }
}
