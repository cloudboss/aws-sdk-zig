package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class ClientGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    data class OperationInfo(
        val operationName: String,
        val methodName: String,
        val moduleFileName: String,
        val moduleName: String,
        val constName: String,
        val inputType: String,
        val outputType: String,
        val docs: String?,
    )

    fun run() {
        val operations = collectOperations()

        context.writerDelegator().useFileWriter("client.zig") { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            // Import each operation module
            writer.blankLine()
            for (op in operations) {
                writer.write(
                    "const \$L = @import(\"\$L\");",
                    op.constName, op.moduleFileName,
                )
            }
            writer.blankLine()

            writeClientStruct(writer, operations)
        }
    }

    private fun collectOperations(): List<OperationInfo> {
        val topDownIndex = TopDownIndex.of(model)
        return topDownIndex.getContainedOperations(service)
            .map { opShape ->
                val operationName = opShape.id.name
                val methodName = NamingUtil.toSnakeCase(operationName)
                    .let { toCamelCase(it) }
                val moduleFileName = NamingUtil.toZigFileName(operationName)
                val moduleName = NamingUtil.toSnakeCase(operationName)

                val docs = opShape.getTrait(DocumentationTrait::class.java)
                    .map { it.value }
                    .orElse(null)

                // Avoid name collision between import const and method name
                val constName = if (methodName == moduleName) "${moduleName}_" else moduleName

                OperationInfo(
                    operationName = operationName,
                    methodName = methodName,
                    moduleFileName = moduleFileName,
                    moduleName = moduleName,
                    constName = constName,
                    inputType = "${operationName}Input",
                    outputType = "${operationName}Output",
                    docs = docs,
                )
            }
            .sortedBy { it.moduleName }
    }

    private fun writeClientStruct(writer: ZigWriter, operations: List<OperationInfo>) {
        writer.openBlock("pub const Client = struct {")
        writer.write("allocator: std.mem.Allocator,")
        writer.write("config: *aws.Config,")
        writer.write("http_client: aws.http.HttpClient,")
        writer.blankLine()

        writer.write("const Self = @This();")
        writer.blankLine()

        // init
        writer.openBlock("pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {")
        writer.openBlock("return .{")
        writer.write(".allocator = allocator,")
        writer.write(".config = config,")
        writer.write(".http_client = aws.http.HttpClient.init(allocator),")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.blankLine()

        // deinit
        writer.openBlock("pub fn deinit(self: *Self) void {")
        writer.write("self.http_client.deinit();")
        writer.closeBlock("}")

        // Operation methods
        for (op in operations) {
            writer.blankLine()
            if (op.docs != null) {
                writer.writeDocs(op.docs)
            }
            writer.openBlock(
                "pub fn \$L(self: *Self, input: \$L.\$L, options: \$L.Options) !\$L.\$L {",
                op.methodName,
                op.constName, op.inputType,
                op.constName,
                op.constName, op.outputType,
            )
            writer.write("return \$L.execute(self, input, options);", op.constName)
            writer.closeBlock("}")
        }

        writer.closeBlock("};")
    }

    /** Convert snake_case to camelCase */
    private fun toCamelCase(snakeCase: String): String {
        return snakeCase.split("_").mapIndexed { index, word ->
            if (index == 0) word
            else word.replaceFirstChar { it.uppercaseChar() }
        }.joinToString("")
    }
}
