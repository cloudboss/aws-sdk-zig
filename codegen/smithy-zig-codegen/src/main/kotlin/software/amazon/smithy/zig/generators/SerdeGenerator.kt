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
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.shapes.TimestampShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.XmlFlattenedTrait
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

    /** Map shapes that need map deserializer helpers. */
    private val deserializableMaps: Set<MapShape> by lazy { collectDeserializableMaps() }

    /** Struct shapes that need serialize functions (from input shapes). */
    private val serializableStructs: Set<StructureShape> by lazy { collectSerializableShapes() }

    /** List shapes that need list serializer helpers (from input shapes). */
    private val serializableLists: Set<ListShape> by lazy { collectSerializableLists() }

    /** Map shapes that need map serializer helpers (from input shapes). */
    private val serializableMaps: Set<MapShape> by lazy { collectSerializableMaps() }

    fun run() {
        val deserStructs = deserializableStructs.sortedBy { it.id.name }
        val deserLists = deserializableLists.sortedBy { it.id.name }
        val deserMaps = deserializableMaps.sortedBy { it.id.name }
        val serStructs = serializableStructs.sortedBy { it.id.name }
        val serLists = serializableLists.sortedBy { it.id.name }
        val serMaps = serializableMaps.sortedBy { it.id.name }

        if (deserStructs.isEmpty() && deserLists.isEmpty() && deserMaps.isEmpty() &&
            serStructs.isEmpty() && serLists.isEmpty() && serMaps.isEmpty()
        ) return

        context.writerDelegator().useFileWriter("serde.zig") { writer ->
            // Imports
            writer.write("const aws = @import(\"aws\");")
            writer.write("const std = @import(\"std\");")
            writer.blankLine()

            // Import all referenced types (from both deser and ser)
            val allStructs = (deserStructs + serStructs).distinctBy { it.id.name }.sortedBy { it.id.name }
            val allLists = (deserLists + serLists).distinctBy { it.id.name }.sortedBy { it.id.name }
            val allMaps = (deserMaps + serMaps).distinctBy { it.id.name }.sortedBy { it.id.name }
            val importedTypes = collectImportedTypes(allStructs, allLists, allMaps)
            for (typeName in importedTypes.sorted()) {
                val fileName = NamingUtil.toZigFileName(typeName)
                writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
            }
            if (importedTypes.isNotEmpty()) {
                writer.blankLine()
            }

            // Generate list deserializers first (structs may reference them)
            for (listShape in deserLists) {
                writeListDeserializer(writer, listShape)
                writer.blankLine()
            }

            // Generate map deserializers
            for (mapShape in deserMaps) {
                writeMapDeserializer(writer, mapShape)
                writer.blankLine()
            }

            // Generate struct deserializers
            for (structShape in deserStructs) {
                writeStructDeserializer(writer, structShape)
                writer.blankLine()
            }

            // Generate list serializers
            for (listShape in serLists) {
                writeListSerializer(writer, listShape)
                writer.blankLine()
            }

            // Generate map serializers
            for (mapShape in serMaps) {
                writeMapSerializer(writer, mapShape)
                writer.blankLine()
            }

            // Generate struct serializers
            for (structShape in serStructs) {
                writeStructSerializer(writer, structShape)
                writer.blankLine()
            }

            // appendXmlEscaped is now provided by the aws.xml runtime module
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
                val valueTarget = model.expectShape(target.value.target)
                if (valueTarget is StructureShape) {
                    if (valueTarget.id !in excludeIds) {
                        result.add(valueTarget)
                    }
                    if (valueTarget.id !in visited) {
                        visited.add(valueTarget.id)
                        for ((_, m) in valueTarget.allMembers) {
                            collectNestedStructs(m, result, visited, excludeIds)
                        }
                    }
                }
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
                if (elementShape is StructureShape || elementShape is UnionShape ||
                    elementShape is StringShape ||
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

    private fun collectDeserializableMaps(): Set<MapShape> {
        val result = mutableSetOf<MapShape>()
        val visited = mutableSetOf<ShapeId>()

        for (op in topDownIndex.getContainedOperations(service)) {
            val outputShape = model.expectShape(op.outputShape, StructureShape::class.java)
            collectNestedMaps(outputShape, result, visited)
        }

        // Also collect maps from nested deserialized structs
        for (structShape in deserializableStructs) {
            collectNestedMaps(structShape, result, visited)
        }
        return result
    }

    private fun collectNestedMaps(
        structShape: StructureShape,
        result: MutableSet<MapShape>,
        visited: MutableSet<ShapeId>,
    ) {
        for ((_, member) in structShape.allMembers) {
            val target = model.expectShape(member.target)
            if (target is MapShape && target.id !in visited) {
                visited.add(target.id)
                result.add(target)
                // Recurse into struct values
                val valueShape = model.expectShape(target.value.target)
                if (valueShape is StructureShape) {
                    collectNestedMaps(valueShape, result, visited)
                }
            }
        }
    }

    private fun collectSerializableShapes(): Set<StructureShape> {
        val result = mutableSetOf<StructureShape>()
        val visited = mutableSetOf<ShapeId>()
        val excludeIds = exclusiveIoShapeIds

        for (op in topDownIndex.getContainedOperations(service)) {
            val inputShape = model.expectShape(op.inputShape, StructureShape::class.java)
            for ((_, member) in inputShape.allMembers) {
                collectNestedStructs(member, result, visited, excludeIds)
            }
        }
        return result
    }

    private fun collectSerializableLists(): Set<ListShape> {
        val result = mutableSetOf<ListShape>()
        val visited = mutableSetOf<ShapeId>()

        for (op in topDownIndex.getContainedOperations(service)) {
            val inputShape = model.expectShape(op.inputShape, StructureShape::class.java)
            collectNestedLists(inputShape, result, visited)
        }

        // Also collect lists from nested serializable structs
        for (structShape in serializableStructs) {
            collectNestedLists(structShape, result, visited)
        }
        return result
    }

    private fun collectSerializableMaps(): Set<MapShape> {
        val result = mutableSetOf<MapShape>()
        val visited = mutableSetOf<ShapeId>()

        for (op in topDownIndex.getContainedOperations(service)) {
            val inputShape = model.expectShape(op.inputShape, StructureShape::class.java)
            collectNestedMaps(inputShape, result, visited)
        }

        // Also collect maps from nested serializable structs
        for (structShape in serializableStructs) {
            collectNestedMaps(structShape, result, visited)
        }
        return result
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
                if (target is MapShape) {
                    val valueId = target.value.target
                    if (valueId in allIoIds) {
                        referencedAsMembers.add(valueId)
                    }
                }
            }
        }

        // Also exclude I/O shapes whose generated name collides with another shape
        val allShapeNames = model.toSet().map { it.id.name }.toSet()
        val nameCollisionIds = mutableSetOf<ShapeId>()
        for (op in topDownIndex.getContainedOperations(service)) {
            val opName = op.id.name
            val inputName = model.expectShape(op.inputShape).id.name
            val outputName = model.expectShape(op.outputShape).id.name
            if ("${opName}Input" != inputName && "${opName}Input" in allShapeNames) {
                nameCollisionIds.add(op.inputShape)
            }
            if ("${opName}Output" != outputName && "${opName}Output" in allShapeNames) {
                nameCollisionIds.add(op.outputShape)
            }
        }

        return allIoIds - referencedAsMembers - nameCollisionIds
    }

    // ---- Import collection ----

    private fun collectImportedTypes(
        structs: List<StructureShape>,
        lists: List<ListShape>,
        maps: List<MapShape> = emptyList(),
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
                // Also check map value types
                if (target is MapShape) {
                    val valueShape = model.expectShape(target.value.target)
                    if (valueShape is StructureShape) {
                        types.add(valueShape.id.name)
                    } else if (isEnumType(valueShape)) {
                        types.add(valueShape.id.name)
                    }
                }
            }
        }

        // List element types
        for (l in lists) {
            val elem = model.expectShape(l.member.target)
            if (elem is StructureShape) {
                types.add(elem.id.name)
            } else if (elem is UnionShape) {
                types.add(elem.id.name)
            } else if (isEnumType(elem)) {
                types.add(elem.id.name)
            }
        }

        // Map value types
        for (m in maps) {
            val valueShape = model.expectShape(m.value.target)
            if (valueShape is StructureShape) {
                types.add(valueShape.id.name)
            } else if (isEnumType(valueShape)) {
                types.add(valueShape.id.name)
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

    /**
     * Returns the number of variants in an enum-like shape, or 0 if not an enum.
     * Used to decide whether to emit @setEvalBranchQuota.
     */
    private fun enumVariantCount(shape: Shape): Int {
        return when (shape) {
            is EnumShape -> shape.enumValues.size
            is IntEnumShape -> shape.enumValues.size
            is StringShape -> if (shape.hasTrait(EnumTrait::class.java))
                shape.getTrait(EnumTrait::class.java).get().values.size
            else 0
            else -> 0
        }
    }

    /**
     * Computes the total stringToEnum branch cost for a struct's members.
     * Each enum field costs (variant count) branches during comptime evaluation.
     */
    private fun totalEnumBranchCost(shape: StructureShape): Int {
        return shape.allMembers.values.sumOf { member ->
            val target = model.expectShape(member.target)
            when {
                isEnumType(target) -> enumVariantCount(target)
                // List members whose element type is an enum also cost branches
                target is ListShape -> {
                    val elem = model.expectShape(target.member.target)
                    if (isEnumType(elem)) enumVariantCount(elem) else 0
                }
                else -> 0
            }
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

        // Zig's default comptime branch quota is 1000. Large enums (e.g. EC2 InstanceType
        // with 1170+ variants) exceed this in std.meta.stringToEnum's inline for loop.
        // Emit @setEvalBranchQuota when the total enum branch cost across all members
        // would exceed the default limit.
        val branchCost = totalEnumBranchCost(shape)
        if (branchCost > 500) {
            // Round up to the next power of ten above the cost, minimum 2000.
            val quota = maxOf(2000, (branchCost / 1000 + 1) * 1000)
            writer.write("@setEvalBranchQuota(\$L);", quota)
        }

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
                        "result.\$L = try aws.date.parseIso8601(try reader.readElementText());",
                        fieldName,
                    )
                } else {
                    writer.write(
                        "result.\$L = aws.date.parseIso8601(try reader.readElementText()) catch null;",
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
                val mapFnName = "deserialize${targetShape.id.name}"
                val entryTag = getMapEntryTag(targetShape)
                writer.write(
                    "result.\$L = try \$L(reader, alloc, \"\$L\");",
                    fieldName, mapFnName, entryTag,
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
                writer.write("if (aws.date.parseIso8601(try reader.readElementText()) catch null) |v| try list.append(alloc, v);")
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

    private fun getMapEntryTag(mapShape: MapShape): String {
        // Default entry wrapper tag for AWS maps
        return "entry"
    }

    private fun getMapKeyTag(mapShape: MapShape): String {
        return mapShape.key.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse("key")
    }

    private fun getMapValueTag(mapShape: MapShape): String {
        return mapShape.value.getTrait(XmlNameTrait::class.java)
            .map { it.value }
            .orElse("value")
    }

    private fun writeMapDeserializer(writer: ZigWriter, mapShape: MapShape) {
        val valueShape = model.expectShape(mapShape.value.target)
        val fnName = "deserialize${mapShape.id.name}"
        val valueSymbol = symbolProvider.toSymbol(mapShape)
        val returnType = valueSymbol.name
        val keyTag = getMapKeyTag(mapShape)
        val valueTag = getMapValueTag(mapShape)

        writer.openBlock(
            "pub fn \$L(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime entry_tag: []const u8) !\$L {",
            fnName, returnType,
        )

        // Determine value Zig type for the MapEntry
        val valueZigType = symbolProvider.toSymbol(valueShape).name
        val entryType = if (valueZigType == "[]const u8") {
            "aws.map.StringMapEntry"
        } else {
            "aws.map.MapEntry($valueZigType)"
        }

        writer.write("var list: std.ArrayList(\$L) = .{};", entryType)
        writer.openBlock("while (try reader.next()) |event| {")
        writer.openBlock("switch (event) {")
        writer.openBlock(".element_start => |e| {")
        writer.openBlock("if (std.mem.eql(u8, e.local, entry_tag)) {")

        // Parse key and value from child elements
        writer.write("var entry_key: []const u8 = \"\";")
        writer.write("var entry_value: \$L = undefined;", valueZigType)
        writer.openBlock("while (try reader.next()) |inner| {")
        writer.openBlock("switch (inner) {")
        writer.openBlock(".element_start => |ie| {")

        // Key parsing
        writer.openBlock("if (std.mem.eql(u8, ie.local, \"\$L\")) {", keyTag)
        writer.write("entry_key = try alloc.dupe(u8, try reader.readElementText());")
        writer.dedent()
        writer.openBlock("} else if (std.mem.eql(u8, ie.local, \"\$L\")) {", valueTag)

        // Value parsing depends on value type
        writeMapValueDeserializer(writer, valueShape)

        writer.dedent()
        writer.openBlock("} else {")
        writer.write("try reader.skipElement();")
        writer.closeBlock("}")
        writer.closeBlock("},") // .element_start
        writer.write(".element_end => break,")
        writer.write("else => {},")
        writer.closeBlock("}") // switch
        writer.closeBlock("}") // while

        writer.write("try list.append(alloc, .{ .key = entry_key, .value = entry_value });")

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

    private fun writeMapValueDeserializer(writer: ZigWriter, valueShape: Shape) {
        when (valueShape) {
            is StringShape -> {
                if (isEnumType(valueShape)) {
                    writer.write(
                        "if (std.meta.stringToEnum(\$L, try reader.readElementText())) |v| { entry_value = v; }",
                        valueShape.id.name,
                    )
                } else {
                    writer.write("entry_value = try alloc.dupe(u8, try reader.readElementText());")
                }
            }
            is BooleanShape -> {
                writer.write("entry_value = std.mem.eql(u8, try reader.readElementText(), \"true\");")
            }
            is IntegerShape, is ShortShape -> {
                writer.write("entry_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch 0;")
            }
            is LongShape -> {
                writer.write("entry_value = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch 0;")
            }
            is FloatShape -> {
                writer.write("entry_value = std.fmt.parseFloat(f32, try reader.readElementText()) catch 0;")
            }
            is DoubleShape -> {
                writer.write("entry_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch 0;")
            }
            is StructureShape -> {
                writer.write("entry_value = try deserialize\$L(reader, alloc);", valueShape.id.name)
            }
            is EnumShape, is IntEnumShape -> {
                writer.write(
                    "if (std.meta.stringToEnum(\$L, try reader.readElementText())) |v| { entry_value = v; }",
                    valueShape.id.name,
                )
            }
            else -> {
                writer.write("entry_value = try alloc.dupe(u8, try reader.readElementText());")
            }
        }
    }

    private fun writeMapSerializer(writer: ZigWriter, mapShape: MapShape) {
        val valueShape = model.expectShape(mapShape.value.target)
        val fnName = "serialize${mapShape.id.name}"
        val valueZigType = symbolProvider.toSymbol(valueShape).name
        val entryType = if (valueZigType == "[]const u8") {
            "aws.map.StringMapEntry"
        } else {
            "aws.map.MapEntry($valueZigType)"
        }
        val keyTag = getMapKeyTag(mapShape)
        val valueTag = getMapValueTag(mapShape)

        writer.openBlock(
            "pub fn \$L(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), entries: []const \$L, comptime entry_tag: []const u8) !void {",
            fnName, entryType,
        )

        writer.openBlock("for (entries) |entry| {")
        writer.write("try buf.appendSlice(alloc, \"<\");")
        writer.write("try buf.appendSlice(alloc, entry_tag);")
        writer.write("try buf.appendSlice(alloc, \">\");")

        // Serialize key
        writer.write("try buf.appendSlice(alloc, \"<\$L>\");", keyTag)
        writer.write("try aws.xml.appendXmlEscaped(alloc, buf, entry.key);")
        writer.write("try buf.appendSlice(alloc, \"</\$L>\");", keyTag)

        // Serialize value
        writeMapValueSerializer(writer, valueShape, valueTag)

        writer.write("try buf.appendSlice(alloc, \"</\");")
        writer.write("try buf.appendSlice(alloc, entry_tag);")
        writer.write("try buf.appendSlice(alloc, \">\");")
        writer.closeBlock("}") // for

        writer.closeBlock("}") // fn
    }

    private fun writeMapValueSerializer(writer: ZigWriter, valueShape: Shape, valueTag: String) {
        when (valueShape) {
            is StringShape -> {
                if (isEnumType(valueShape)) {
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                    writer.write("try buf.appendSlice(alloc, @tagName(entry.value));")
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
                } else {
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                    writer.write("try aws.xml.appendXmlEscaped(alloc, buf, entry.value);")
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
                }
            }
            is BooleanShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                writer.write("try buf.appendSlice(alloc, if (entry.value) \"true\" else \"false\");")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
            }
            is IntegerShape, is ShortShape, is LongShape, is FloatShape, is DoubleShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{entry.value}) catch \"\";")
                writer.write("try buf.appendSlice(alloc, num_str);")
                writer.closeBlock("}")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
            }
            is EnumShape, is IntEnumShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                writer.write("try buf.appendSlice(alloc, @tagName(entry.value));")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
            }
            is StructureShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                writer.write("try serialize\$L(alloc, buf, entry.value);", valueShape.id.name)
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
            }
            else -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", valueTag)
                writer.write("try aws.xml.appendXmlEscaped(alloc, buf, entry.value);")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", valueTag)
            }
        }
    }

    // ---- Serialization code generation ----

    private fun isSerializableType(shape: Shape): Boolean {
        return shape is StringShape || shape is BooleanShape ||
            shape is IntegerShape || shape is ShortShape || shape is LongShape ||
            shape is FloatShape || shape is DoubleShape ||
            shape is EnumShape || shape is IntEnumShape ||
            shape is TimestampShape || shape is StructureShape || shape is ListShape ||
            shape is MapShape
    }

    private fun writeStructSerializer(writer: ZigWriter, shape: StructureShape) {
        val typeName = shape.id.name
        val fnName = "serialize$typeName"

        writer.openBlock(
            "pub fn \$L(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: \$L) !void {",
            fnName, typeName,
        )

        val serializableMembers = shape.allMembers.filter { (_, memberShape) ->
            isSerializableType(model.expectShape(memberShape.target))
        }

        if (serializableMembers.isEmpty()) {
            writer.write("_ = alloc;")
            writer.write("_ = buf;")
            writer.write("_ = value;")
        } else {
            for ((memberName, memberShape) in serializableMembers) {
                val fieldName = NamingUtil.toFieldName(memberName)
                val targetShape = model.expectShape(memberShape.target)
                val xmlName = memberShape.getTrait(XmlNameTrait::class.java)
                    .map { it.value }
                    .orElse(memberName)

                if (memberShape.isRequired) {
                    writeMemberSerializer(writer, xmlName, "value.$fieldName", memberShape, targetShape)
                } else {
                    writer.openBlock("if (value.\$L) |v| {", fieldName)
                    writeMemberSerializer(writer, xmlName, "v", memberShape, targetShape)
                    writer.closeBlock("}")
                }
            }
        }

        writer.closeBlock("}") // fn
    }

    private fun writeMemberSerializer(
        writer: ZigWriter,
        xmlName: String,
        accessor: String,
        memberShape: MemberShape,
        targetShape: Shape,
    ) {
        when (targetShape) {
            is StringShape -> {
                if (isEnumType(targetShape)) {
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                    writer.write("try buf.appendSlice(alloc, @tagName(\$L));", accessor)
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
                } else {
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                    writer.write("try aws.xml.appendXmlEscaped(alloc, buf, \$L);", accessor)
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
                }
            }
            is BooleanShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.write("try buf.appendSlice(alloc, if (\$L) \"true\" else \"false\");", accessor)
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            is IntegerShape, is ShortShape, is LongShape, is FloatShape, is DoubleShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", accessor)
                writer.write("try buf.appendSlice(alloc, num_str);")
                writer.closeBlock("}")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            is EnumShape, is IntEnumShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.write("try buf.appendSlice(alloc, @tagName(\$L));", accessor)
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            is TimestampShape -> {
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.openBlock("{")
                writer.write("const ts_str = std.fmt.allocPrint(alloc, \"{d}\", .{\$L}) catch \"\";", accessor)
                writer.write("try buf.appendSlice(alloc, ts_str);")
                writer.closeBlock("}")
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            is StructureShape -> {
                val nestedTypeName = targetShape.id.name
                writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                writer.write("try serialize\$L(alloc, buf, \$L);", nestedTypeName, accessor)
                writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
            }
            is ListShape -> {
                val listFnName = "serialize${targetShape.id.name}"
                if (memberShape.hasTrait(XmlFlattenedTrait::class.java)) {
                    // Flattened: no wrapper element, item tag from member's xmlName
                    writer.write("try \$L(alloc, buf, \$L, \"\$L\");", listFnName, accessor, xmlName)
                } else {
                    // Non-flattened: wrapper element + item tag from list member
                    val itemTag = getListItemTag(targetShape)
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                    writer.write("try \$L(alloc, buf, \$L, \"\$L\");", listFnName, accessor, itemTag)
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
                }
            }
            is MapShape -> {
                val mapFnName = "serialize${targetShape.id.name}"
                val entryTag = getMapEntryTag(targetShape)
                if (memberShape.hasTrait(XmlFlattenedTrait::class.java)) {
                    writer.write("try \$L(alloc, buf, \$L, \"\$L\");", mapFnName, accessor, xmlName)
                } else {
                    writer.write("try buf.appendSlice(alloc, \"<\$L>\");", xmlName)
                    writer.write("try \$L(alloc, buf, \$L, \"\$L\");", mapFnName, accessor, entryTag)
                    writer.write("try buf.appendSlice(alloc, \"</\$L>\");", xmlName)
                }
            }
            else -> {}
        }
    }

    private fun writeListSerializer(writer: ZigWriter, listShape: ListShape) {
        val elementShape = model.expectShape(listShape.member.target)
        val fnName = "serialize${listShape.id.name}"
        val elementTypeName = symbolProvider.toSymbol(elementShape).name
        val paramType = "[]const $elementTypeName"

        writer.openBlock(
            "pub fn \$L(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: \$L, comptime item_tag: []const u8) !void {",
            fnName, paramType,
        )

        writer.openBlock("for (value) |item| {")
        writer.write("try buf.appendSlice(alloc, \"<\");")
        writer.write("try buf.appendSlice(alloc, item_tag);")
        writer.write("try buf.appendSlice(alloc, \">\");")

        when (elementShape) {
            is StructureShape -> {
                val typeName = elementShape.id.name
                writer.write("try serialize\$L(alloc, buf, item);", typeName)
            }
            is StringShape -> {
                if (isEnumType(elementShape)) {
                    writer.write("try buf.appendSlice(alloc, @tagName(item));")
                } else {
                    writer.write("try aws.xml.appendXmlEscaped(alloc, buf, item);")
                }
            }
            is EnumShape, is IntEnumShape -> {
                writer.write("try buf.appendSlice(alloc, @tagName(item));")
            }
            is BooleanShape -> {
                writer.write("try buf.appendSlice(alloc, if (item) \"true\" else \"false\");")
            }
            is IntegerShape, is ShortShape, is LongShape, is FloatShape, is DoubleShape -> {
                writer.openBlock("{")
                writer.write("const num_str = std.fmt.allocPrint(alloc, \"{d}\", .{item}) catch \"\";")
                writer.write("try buf.appendSlice(alloc, num_str);")
                writer.closeBlock("}")
            }
            else -> {
                writer.write("try aws.xml.appendXmlEscaped(alloc, buf, item);")
            }
        }

        writer.write("try buf.appendSlice(alloc, \"</\");")
        writer.write("try buf.appendSlice(alloc, item_tag);")
        writer.write("try buf.appendSlice(alloc, \">\");")
        writer.closeBlock("}") // for

        writer.closeBlock("}") // fn
    }

}
