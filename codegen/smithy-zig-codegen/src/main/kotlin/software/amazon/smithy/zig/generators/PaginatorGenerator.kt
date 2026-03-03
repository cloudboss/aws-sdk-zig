package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.PaginatedIndex
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class PaginatorGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    data class PaginationInfo(
        val operationName: String,
        val inputType: String,
        val outputType: String,
        val moduleFileName: String,
        val moduleName: String,
        val constName: String,
        val inputTokenField: String,
        val outputTokenField: String,
        val isMapToken: Boolean,
        val tokenZigType: String,
        /** For map tokens, the name of the map value type if it needs importing (e.g. "AttributeValue"). */
        val mapValueTypeName: String? = null,
    )

    fun collectPaginatedOperations(): List<PaginationInfo> {
        val paginatedIndex = PaginatedIndex.of(model)
        val topDownIndex = TopDownIndex.of(model)

        return topDownIndex.getContainedOperations(service)
            .mapNotNull { opShape ->
                val paginationInfo = paginatedIndex.getPaginationInfo(service, opShape)
                if (!paginationInfo.isPresent) return@mapNotNull null

                val pagination = paginationInfo.get()
                val operationName = opShape.id.name
                val inputToken = pagination.inputTokenMember.memberName
                val outputToken = pagination.outputTokenMemberPath.last().memberName

                val outputTokenMember = pagination.outputTokenMemberPath.last()
                val outputTokenTarget = model.expectShape(outputTokenMember.target)
                val isMapToken = outputTokenTarget is MapShape

                val inputTokenField = NamingUtil.toFieldName(inputToken)
                val outputTokenField = NamingUtil.toFieldName(outputToken)

                val moduleName = NamingUtil.toSnakeCase(operationName)
                val methodName = toCamelCase(moduleName)
                val constName = if (methodName == moduleName) "${moduleName}_" else moduleName

                val tokenZigType: String
                val mapValueTypeName: String?
                if (isMapToken) {
                    // For map tokens, use the resolved Zig type from the symbol provider
                    tokenZigType = context.symbolProvider().toSymbol(outputTokenTarget).name
                    // Extract the map value type name for import if it's a named type
                    val mapValueShape = model.expectShape((outputTokenTarget as MapShape).value.target)
                    mapValueTypeName = when (mapValueShape) {
                        is StructureShape, is UnionShape -> mapValueShape.id.name
                        else -> null
                    }
                } else {
                    tokenZigType = "[]const u8"
                    mapValueTypeName = null
                }

                PaginationInfo(
                    operationName = operationName,
                    inputType = "${operationName}Input",
                    outputType = "${operationName}Output",
                    moduleFileName = NamingUtil.toZigFileName(operationName),
                    moduleName = moduleName,
                    constName = constName,
                    inputTokenField = inputTokenField,
                    outputTokenField = outputTokenField,
                    isMapToken = isMapToken,
                    tokenZigType = tokenZigType,
                    mapValueTypeName = mapValueTypeName,
                )
            }
            .sortedBy { it.moduleName }
    }

    fun run() {
        val paginatedOps = collectPaginatedOperations()
        if (paginatedOps.isEmpty()) return

        context.writerDelegator().useFileWriter("paginator.zig") { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            writer.write("const CallOptions = @import(\"call_options.zig\").CallOptions;")
            writer.write("const Client = @import(\"client.zig\").Client;")
            writer.blankLine()

            // Import operation modules
            for (op in paginatedOps) {
                writer.write(
                    "const \$L = @import(\"\$L\");",
                    op.constName, op.moduleFileName,
                )
            }

            // Import named types used in map token types
            val namedTypeImports = paginatedOps
                .mapNotNull { it.mapValueTypeName }
                .toSet()
                .sorted()
            for (typeName in namedTypeImports) {
                val typeFileName = NamingUtil.toZigFileName(typeName)
                writer.write(
                    "const \$L = @import(\"\$L\").\$L;",
                    typeName, typeFileName, typeName,
                )
            }

            writer.blankLine()

            var first = true
            for (op in paginatedOps) {
                if (!first) {
                    writer.blankLine()
                }
                writePaginatorStruct(writer, op)
                first = false
            }
        }
    }

    private fun writePaginatorStruct(writer: ZigWriter, op: PaginationInfo) {
        val structName = "${op.operationName}Paginator"

        writer.openBlock("pub const \$L = struct {", structName)
        writer.write("client: *Client,")
        writer.write("params: \$L.\$L,", op.constName, op.inputType)
        if (op.isMapToken) {
            writer.write("next_token: ?\$L = null,", op.tokenZigType)
        } else {
            writer.write("next_token: ?[]const u8 = null,")
        }
        writer.write("done: bool = false,")
        writer.write("allocator: std.mem.Allocator,")
        writer.blankLine()

        writer.write("const Self = @This();")
        writer.blankLine()

        // next() method
        writer.openBlock(
            "pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !\$L.\$L {",
            op.constName, op.outputType,
        )

        writer.openBlock("if (self.done) {")
        writer.write("return error.EndOfPagination;")
        writer.closeBlock("}")
        writer.blankLine()

        // Set the input token
        writer.write("self.params.\$L = self.next_token;", op.inputTokenField)
        writer.blankLine()

        // Execute with caller-provided allocator
        writer.write("const output = try \$L.execute(self.client, allocator, self.params, options);", op.constName)
        writer.blankLine()

        // Extract next token
        if (op.isMapToken) {
            // Map token points into caller's allocator -- caller must not free between pages
            writer.openBlock("if (output.\$L) |token| {", op.outputTokenField)
            writer.openBlock("if (token.len > 0) {")
            writer.write("self.next_token = token;")
            writer.dedent()
            writer.openBlock("} else {")
            writer.write("self.next_token = null;")
            writer.write("self.done = true;")
            writer.closeBlock("}")
            writer.dedent()
            writer.openBlock("} else {")
            writer.write("self.next_token = null;")
            writer.write("self.done = true;")
            writer.closeBlock("}")
        } else {
            writer.openBlock("if (output.\$L) |token| {", op.outputTokenField)
            // Free old duped token before duping the new one
            writer.openBlock("if (self.next_token) |old| {")
            writer.write("self.allocator.free(old);")
            writer.closeBlock("}")
            writer.write("self.next_token = self.allocator.dupe(u8, token) catch null;")
            writer.dedent()
            writer.openBlock("} else {")
            writer.openBlock("if (self.next_token) |old| {")
            writer.write("self.allocator.free(old);")
            writer.closeBlock("}")
            writer.write("self.next_token = null;")
            writer.write("self.done = true;")
            writer.closeBlock("}")
        }
        writer.blankLine()

        writer.write("return output;")
        writer.closeBlock("}")
        writer.blankLine()

        // deinit() -- only needed for string tokens (duped into self.allocator)
        if (!op.isMapToken) {
            writer.openBlock("pub fn deinit(self: *Self) void {")
            writer.openBlock("if (self.next_token) |token| {")
            writer.write("self.allocator.free(token);")
            writer.closeBlock("}")
            writer.closeBlock("}")
        }

        writer.closeBlock("};")
    }

    private fun toCamelCase(snakeCase: String): String {
        return snakeCase.split("_").mapIndexed { index, word ->
            if (index == 0) word
            else word.replaceFirstChar { it.uppercaseChar() }
        }.joinToString("")
    }
}
