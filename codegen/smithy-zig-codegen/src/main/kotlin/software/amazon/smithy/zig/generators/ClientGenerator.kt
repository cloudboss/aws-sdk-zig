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
    private val paginatorGen: PaginatorGenerator? = null,
    private val waiterGen: WaiterGenerator? = null,
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
        val shapeId: String,
    )

    fun run() {
        val operations = collectOperations()
        val paginatedOps = paginatorGen?.collectPaginatedOperations() ?: emptyList()
        val waiterInfos = waiterGen?.collectWaiters() ?: emptyList()

        context.writerDelegator().useFileWriter("client.zig") { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            // Import each operation module
            for (op in operations) {
                writer.write(
                    "const \$L = @import(\"\$L\");",
                    op.constName, op.moduleFileName,
                )
            }
            writer.write("const CallOptions = @import(\"call_options.zig\").CallOptions;")

            // Import paginator module if paginated ops exist
            if (paginatedOps.isNotEmpty()) {
                writer.write("const paginator = @import(\"paginator.zig\");")
            }

            // Import waiters module if waitable ops exist
            if (waiterInfos.isNotEmpty()) {
                writer.write("const waiters = @import(\"waiters.zig\");")
            }

            writer.blankLine()

            writeClientStruct(writer, operations, paginatedOps, waiterInfos)
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
                    shapeId = opShape.id.toString(),
                )
            }
            .sortedBy { it.moduleName }
    }

    private fun writeClientStruct(
        writer: ZigWriter,
        operations: List<OperationInfo>,
        paginatedOps: List<PaginatorGenerator.PaginationInfo>,
        waiterInfos: List<WaiterGenerator.WaiterInfo>,
    ) {
        writer.openBlock("pub const Client = struct {")
        writer.write("allocator: std.mem.Allocator,")
        writer.write("config: *aws.Config,")
        writer.write("http_client: aws.http.HttpClient,")
        writer.blankLine()

        writer.write("const Self = @This();")
        writer.write("pub const sdk_id = \"\$L\";", context.settings().sdkId)
        writer.blankLine()

        // init
        writer.openBlock("pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {")
        writer.openBlock("return .{")
        writer.write(".allocator = allocator,")
        writer.write(".config = config,")
        writer.write(".http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),")
        writer.closeBlock("};")
        writer.closeBlock("}")
        writer.blankLine()

        // initWithOptions
        writer.openBlock("pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {")
        writer.openBlock("return .{")
        writer.write(".allocator = allocator,")
        writer.write(".config = config,")
        writer.write(".http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),")
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
                "pub fn \$L(self: *Self, allocator: std.mem.Allocator, input: \$L.\$L, options: CallOptions) !\$L.\$L {",
                op.methodName,
                op.constName, op.inputType,
                op.constName, op.outputType,
            )
            writer.write("return \$L.execute(self, allocator, input, options);", op.constName)
            writer.closeBlock("}")
        }

        // Paginator convenience methods
        for (pagOp in paginatedOps) {
            writer.blankLine()
            val paginatorMethodName = "${toCamelCase(pagOp.moduleName)}Paginator"
            writer.openBlock(
                "pub fn \$L(self: *Self, params: \$L.\$L) paginator.\$LPaginator {",
                paginatorMethodName,
                pagOp.constName, pagOp.inputType,
                pagOp.operationName,
            )
            writer.openBlock("return .{")
            writer.write(".client = self,")
            writer.write(".params = params,")
            writer.closeBlock("};")
            writer.closeBlock("}")
        }

        // Presign convenience methods
        val presignableOps = operations.filter {
            it.shapeId in OperationGenerator.PRESIGNABLE_OPERATIONS
        }
        for (op in presignableOps) {
            writer.blankLine()
            val presignMethodName = "presign${op.operationName}"
            writer.openBlock(
                "pub fn \$L(self: *Self, allocator: std.mem.Allocator, input: \$L.\$L, options: \$L.PresignOptions) ![]const u8 {",
                presignMethodName,
                op.constName, op.inputType,
                op.constName,
            )
            writer.write("return \$L.presign(self, allocator, input, options);", op.constName)
            writer.closeBlock("}")
        }

        // Waiter convenience methods
        for (waiter in waiterInfos) {
            writer.blankLine()
            val waitMethodName = "waitUntil${waiter.waiterName}"
            writer.openBlock(
                "pub fn \$L(self: *Self, params: \$L.\$L) aws.waiter.WaiterError!void {",
                waitMethodName,
                waiter.constName, waiter.inputType,
            )
            writer.write(
                "var w = waiters.\$LWaiter{ .client = self, .params = params };",
                waiter.waiterName,
            )
            writer.write("return w.wait();")
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
