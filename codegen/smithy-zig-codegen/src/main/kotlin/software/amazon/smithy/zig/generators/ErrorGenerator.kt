package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.HttpErrorTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class ErrorGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
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
        writer.openBlock("pub const \$L = struct {", info.structName)
        writer.write("message: []const u8 = \"\",")
        writer.write("request_id: []const u8 = \"\",")
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
