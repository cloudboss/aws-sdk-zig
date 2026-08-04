package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DefaultTrait
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.HttpErrorTrait
import software.amazon.smithy.zig.DefaultValueUtil
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class ErrorGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    companion object {
        private val RESERVED_FIELDS = setOf("message", "request_id")
    }

    data class ErrorInfo(
        val shape: StructureShape,
        val smithyName: String,
        val variantName: String,
        val structName: String,
        val httpStatus: Int,
    )

    fun run() {
        val errorInfos = collectErrors()

        context.writerDelegator().useFileWriter("errors.zig") { writer ->
            writer.importContainer.addImport("std", "std")

            if (isAwsJsonProtocol()) {
                if (errorInfos.any { hasMapMember(it.shape) }) {
                    writer.importContainer.addImport("aws", "aws")
                }

                val referencedTypes = collectReferencedNamedTypes(errorInfos)
                for (typeName in referencedTypes) {
                    val fileName = NamingUtil.toZigFileName(typeName)
                    writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
                }
                if (referencedTypes.isNotEmpty()) {
                    writer.blankLine()
                }
            }

            writeServiceErrorUnion(writer, errorInfos)
            writer.blankLine()

            for (info in errorInfos) {
                writeErrorStruct(writer, info)
                writer.blankLine()
            }

            writeUnknownServiceError(writer)
        }
    }

    fun collectErrors(): List<ErrorInfo> {
        val errorShapeIds = mutableSetOf<ShapeId>()
        val topDownIndex = TopDownIndex.of(model)
        for (opShape in topDownIndex.getContainedOperations(service)) {
            for (errorId in opShape.errors) {
                errorShapeIds.add(errorId)
            }
        }

        return errorShapeIds
            .map { id ->
                val shape = model.expectShape(id, StructureShape::class.java)
                val smithyName = shape.id.name
                val errorTrait = shape.expectTrait(ErrorTrait::class.java)
                val httpStatus = shape.getTrait(HttpErrorTrait::class.java)
                    .map { it.code }
                    .orElse(if (errorTrait.value == "client") 400 else 500)

                ErrorInfo(
                    shape = shape,
                    smithyName = smithyName,
                    variantName = NamingUtil.toSnakeCase(smithyName),
                    structName = smithyName,
                    httpStatus = httpStatus,
                )
            }
            .sortedBy { it.variantName }
    }

    private fun writeServiceErrorUnion(writer: ZigWriter, errors: List<ErrorInfo>) {
        writer.openBlock("pub const ServiceError = struct {")
        writer.write("arena: ?std.heap.ArenaAllocator = null,")
        writer.write("kind: Kind,")
        writer.blankLine()

        writer.openBlock("pub const Kind = union(enum) {")
        for (info in errors) {
            writer.write("\$L: \$L,", info.variantName, info.structName)
        }
        writer.write("unknown: UnknownServiceError,")
        writer.blankLine()

        writer.openBlock("pub fn code(self: Kind) []const u8 {")
        writer.openBlock("return switch (self) {")
        for (info in errors) {
            writer.write(".\$L => \"\$L\",", info.variantName, info.smithyName)
        }
        writer.write(".unknown => |e| e.code,")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn message(self: Kind) []const u8 {")
        writer.openBlock("return switch (self) {")
        for (info in errors) {
            writer.write(".\$L => |e| e.message,", info.variantName)
        }
        writer.write(".unknown => |e| e.message,")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn httpStatus(self: Kind) u16 {")
        writer.openBlock("return switch (self) {")
        for (info in errors) {
            writer.write(".\$L => \$L,", info.variantName, info.httpStatus)
        }
        writer.write(".unknown => |e| e.http_status,")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn requestId(self: Kind) []const u8 {")
        writer.openBlock("return switch (self) {")
        for (info in errors) {
            writer.write(".\$L => |e| e.request_id,", info.variantName)
        }
        writer.write(".unknown => |e| e.request_id,")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.closeBlock("};")
        writer.blankLine()

        writer.openBlock("pub fn deinit(self: *ServiceError) void {")
        writer.write("if (self.arena) |*a| a.deinit();")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn code(self: ServiceError) []const u8 {")
        writer.write("return self.kind.code();")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn message(self: ServiceError) []const u8 {")
        writer.write("return self.kind.message();")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn httpStatus(self: ServiceError) u16 {")
        writer.write("return self.kind.httpStatus();")
        writer.closeBlock("}")
        writer.blankLine()

        writer.openBlock("pub fn requestId(self: ServiceError) []const u8 {")
        writer.write("return self.kind.requestId();")
        writer.closeBlock("}")
        writer.closeBlock("};")
    }

    private fun writeErrorStruct(writer: ZigWriter, info: ErrorInfo) {
        if (isAwsJsonProtocol()) {
            val docs = info.shape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)
            writer.writeDocs(docs)
        }

        writer.openBlock("pub const \$L = struct {", info.structName)
        writer.write("message: []const u8 = \"\",")
        writer.write("request_id: []const u8 = \"\",")

        if (isAwsJsonProtocol()) {
            for ((memberName, memberShape) in info.shape.allMembers) {
                val fieldName = NamingUtil.toFieldName(memberName)
                if (fieldName in RESERVED_FIELDS) continue

                val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                writer.blankLine()
                writer.writeDocs(memberDocs)

                val targetShape = model.expectShape(memberShape.target)
                val baseType = context.symbolProvider().toSymbol(targetShape).name
                val hasMemberDefault = memberShape.hasTrait(DefaultTrait::class.java)
                val defaultValue = DefaultValueUtil.resolveDefaultValue(
                    memberShape,
                    model,
                    context.symbolProvider(),
                )
                val isOptional = !memberShape.isRequired || !isScalarType(targetShape)
                val zigType = when {
                    hasMemberDefault -> "?$baseType"
                    defaultValue != null -> defaultValue.typeName
                    isOptional -> "?$baseType"
                    else -> baseType
                }
                val defaultSuffix = when {
                    hasMemberDefault -> " = null"
                    defaultValue != null -> " = ${defaultValue.literal}"
                    isOptional -> " = null"
                    else -> ""
                }

                writer.write("\$L: \$L\$L,", fieldName, zigType, defaultSuffix)
            }

            writeJsonFieldNames(writer, info.shape)
        }

        writer.closeBlock("};")
    }

    private fun isAwsJsonProtocol(): Boolean {
        return service.hasTrait("aws.protocols#awsJson1_0") ||
            service.hasTrait("aws.protocols#awsJson1_1")
    }

    private fun isScalarType(shape: Shape): Boolean {
        if (shape is EnumShape || shape is IntEnumShape ||
            (shape is StringShape && shape.hasTrait(EnumTrait::class.java))
        ) {
            return true
        }

        return context.symbolProvider().toSymbol(shape).name in setOf(
            "[]const u8", "bool", "i8", "i16", "i32", "i64",
            "f32", "f64", "i128", "f128",
        )
    }

    private fun hasMapMember(shape: StructureShape): Boolean {
        fun containsMap(target: Shape, visited: MutableSet<ShapeId>): Boolean {
            if (!visited.add(target.id)) return false
            return when (target) {
                is MapShape -> true
                is ListShape -> containsMap(model.expectShape(target.member.target), visited)
                else -> false
            }
        }

        return shape.allMembers.values
            .filterNot { NamingUtil.toFieldName(it.memberName) in RESERVED_FIELDS }
            .any { containsMap(model.expectShape(it.target), mutableSetOf()) }
    }

    private fun collectReferencedNamedTypes(errors: List<ErrorInfo>): Set<String> {
        val result = sortedSetOf<String>()

        fun collectFromShape(target: Shape) {
            if (target.id.namespace == "smithy.api") return
            when (target) {
                is StructureShape -> {
                    if (!target.hasTrait(ErrorTrait::class.java)) result.add(target.id.name)
                }
                is EnumShape -> result.add(target.id.name)
                is IntEnumShape -> result.add(target.id.name)
                is UnionShape -> result.add(target.id.name)
                is ListShape -> collectFromShape(model.expectShape(target.member.target))
                is MapShape -> collectFromShape(model.expectShape(target.value.target))
                is StringShape -> {
                    if (target.hasTrait(EnumTrait::class.java)) result.add(target.id.name)
                }
            }
        }

        for (info in errors) {
            for ((memberName, memberShape) in info.shape.allMembers) {
                if (NamingUtil.toFieldName(memberName) in RESERVED_FIELDS) continue
                collectFromShape(model.expectShape(memberShape.target))
            }
        }

        return result
    }

    private fun writeJsonFieldNames(writer: ZigWriter, shape: StructureShape) {
        if (shape.allMembers.isEmpty()) return

        val mappings = linkedMapOf<String, String>()
        for ((memberName, _) in shape.allMembers) {
            mappings.putIfAbsent(NamingUtil.toFieldName(memberName), memberName)
        }
        if (mappings.isEmpty()) return

        writer.blankLine()
        writer.openBlock("pub const json_field_names = .{")
        for ((fieldName, memberName) in mappings) {
            writer.write(".\$L = \"\$L\",", fieldName, memberName)
        }
        writer.closeBlock("};")
    }

    private fun writeUnknownServiceError(writer: ZigWriter) {
        writer.openBlock("pub const UnknownServiceError = struct {")
        writer.write("code: []const u8 = \"\",")
        writer.write("message: []const u8 = \"\",")
        writer.write("request_id: []const u8 = \"\",")
        writer.write("http_status: u16 = 0,")
        writer.closeBlock("};")
    }
}
