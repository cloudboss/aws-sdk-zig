package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.waiters.AcceptorState
import software.amazon.smithy.waiters.Matcher
import software.amazon.smithy.waiters.WaitableTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigWriter

class WaiterGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    data class WaiterInfo(
        val waiterName: String,
        val operationName: String,
        val moduleName: String,
        val constName: String,
        val moduleFileName: String,
        val inputType: String,
        val outputType: String,
        val minDelay: Int,
        val maxDelay: Int,
        val acceptors: List<AcceptorInfo>,
    )

    data class AcceptorInfo(
        val state: AcceptorState,
        val type: AcceptorType,
        val errorType: String? = null,
        val outputPath: List<String>? = null,
        val expected: String? = null,
        val comparator: String? = null,
    )

    enum class AcceptorType {
        SUCCESS,
        ERROR_TYPE,
        OUTPUT_PATH,
    }

    fun collectWaiters(): List<WaiterInfo> {
        val topDownIndex = TopDownIndex.of(model)
        val waiters = mutableListOf<WaiterInfo>()

        for (opShape in topDownIndex.getContainedOperations(service)) {
            val waitableTrait = opShape.getTrait(WaitableTrait::class.java).orElse(null) ?: continue
            val operationName = opShape.id.name
            val moduleName = NamingUtil.toSnakeCase(operationName)
            val methodName = toCamelCase(moduleName)
            val constName = if (methodName == moduleName) "${moduleName}_" else moduleName
            val moduleFileName = NamingUtil.toZigFileName(operationName)

            for ((waiterName, waiter) in waitableTrait.waiters) {
                val acceptorInfos = waiter.acceptors.mapNotNull { acceptor ->
                    convertAcceptor(acceptor.state, acceptor.matcher)
                }
                if (acceptorInfos.isEmpty()) continue

                waiters.add(
                    WaiterInfo(
                        waiterName = waiterName,
                        operationName = operationName,
                        moduleName = moduleName,
                        constName = constName,
                        moduleFileName = moduleFileName,
                        inputType = "${operationName}Input",
                        outputType = "${operationName}Output",
                        minDelay = waiter.minDelay,
                        maxDelay = waiter.maxDelay,
                        acceptors = acceptorInfos,
                    )
                )
            }
        }
        return waiters.sortedBy { it.waiterName }
    }

    private fun convertAcceptor(state: AcceptorState, matcher: Matcher<*>): AcceptorInfo? {
        return when (matcher) {
            is Matcher.SuccessMember -> AcceptorInfo(
                state = state,
                type = AcceptorType.SUCCESS,
            )
            is Matcher.ErrorTypeMember -> AcceptorInfo(
                state = state,
                type = AcceptorType.ERROR_TYPE,
                errorType = matcher.value,
            )
            is Matcher.OutputMember -> {
                val pathMatcher = matcher.value
                val rawPath = pathMatcher.path
                // Only accept simple dot-separated field paths (e.g. "table.status")
                // Skip complex JMESPath with operators, functions, filters, etc.
                if (!rawPath.matches(Regex("^[a-zA-Z_][a-zA-Z0-9_]*(\\.[a-zA-Z_][a-zA-Z0-9_]*)*$"))) {
                    return null
                }
                val pathSegments = rawPath.split(".").map { NamingUtil.toFieldName(it) }
                AcceptorInfo(
                    state = state,
                    type = AcceptorType.OUTPUT_PATH,
                    outputPath = pathSegments,
                    expected = pathMatcher.expected,
                    comparator = pathMatcher.comparator.toString(),
                )
            }
            else -> null // Skip unsupported matchers (inputOutput, etc.)
        }
    }

    fun run() {
        val waiters = collectWaiters()
        if (waiters.isEmpty()) return

        context.writerDelegator().useFileWriter("waiters.zig") { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            writer.write("const Client = @import(\"client.zig\").Client;")
            writer.blankLine()

            // Import operation modules
            val operationModules = waiters.map { it.moduleName to it }.distinctBy { it.first }
            for ((_, waiter) in operationModules) {
                writer.write(
                    "const \$L = @import(\"\$L\");",
                    waiter.constName, waiter.moduleFileName,
                )
            }
            writer.blankLine()

            var first = true
            for (waiter in waiters) {
                if (!first) writer.blankLine()
                writeWaiterStruct(writer, waiter)
                first = false
            }
        }
    }

    private fun writeWaiterStruct(writer: ZigWriter, waiter: WaiterInfo) {
        val structName = "${waiter.waiterName}Waiter"

        writer.openBlock("pub const \$L = struct {", structName)
        writer.write("client: *Client,")
        writer.write("params: \$L.\$L,", waiter.constName, waiter.inputType)
        writer.openBlock("config: aws.waiter.WaiterConfig = .{")
        writer.write(".min_delay_s = \$L,", waiter.minDelay)
        writer.write(".max_delay_s = \$L,", waiter.maxDelay)
        writer.write(".max_wait_time_s = 300,")
        writer.closeBlock("},")
        writer.blankLine()
        writer.write("const Self = @This();")
        writer.blankLine()

        // wait() method -- polling loop
        writer.openBlock("pub fn wait(self: *Self) aws.waiter.WaiterError!void {")
        writer.write("const start = std.time.timestamp();")
        writer.write("var delay_s: u32 = self.config.min_delay_s;")
        writer.blankLine()
        writer.openBlock("while (true) {")
        writer.write("const state = self.poll();")
        writer.blankLine()
        writer.openBlock("switch (state) {")
        writer.write(".success => return,")
        writer.write(".failure => return error.WaiterFailed,")
        writer.write(".retry => {},")
        writer.closeBlock("}")
        writer.blankLine()
        writer.write("const elapsed: u32 = @intCast(std.time.timestamp() - start);")
        writer.openBlock("if (elapsed >= self.config.max_wait_time_s) {")
        writer.write("return error.WaiterTimedOut;")
        writer.closeBlock("}")
        writer.blankLine()
        writer.write("const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);")
        writer.write("std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);")
        writer.write("delay_s = @min(delay_s * 2, self.config.max_delay_s);")
        writer.closeBlock("}")
        writer.closeBlock("}")
        writer.blankLine()

        // poll() method -- calls operation and checks acceptors
        writePollFunction(writer, waiter)

        writer.closeBlock("};")
    }

    private fun writePollFunction(writer: ZigWriter, waiter: WaiterInfo) {
        val methodName = toCamelCase(waiter.moduleName)

        writer.openBlock("fn poll(self: *Self) aws.waiter.AcceptorState {")

        // Local arena for the operation output -- freed at end of poll
        writer.write("var arena = std.heap.ArenaAllocator.init(self.client.allocator);")
        writer.write("defer arena.deinit();")
        writer.blankLine()

        val hasOutputAcceptors = waiter.acceptors.any { it.type == AcceptorType.OUTPUT_PATH }
        val errorAcceptors = waiter.acceptors.filter { it.type == AcceptorType.ERROR_TYPE }
        val needsDiagnostic = errorAcceptors.isNotEmpty()
        val resultPrefix = if (hasOutputAcceptors) "const output = " else "_ = "
        val errCapture = if (needsDiagnostic) "|err|" else ""

        if (needsDiagnostic) {
            writer.write("var diagnostic: @import(\"errors.zig\").ServiceError = undefined;")
            writer.write(
                "\$Lself.client.\$L(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch \$L {",
                resultPrefix, methodName, errCapture,
            )
        } else {
            writer.write(
                "\$Lself.client.\$L(arena.allocator(), self.params, .{}) catch \$L {",
                resultPrefix, methodName, errCapture,
            )
        }
        writer.indent()

        if (errorAcceptors.isNotEmpty()) {
            writer.openBlock("if (err == error.ServiceError) {")
            writer.write("defer diagnostic.deinit();")
            for (ea in errorAcceptors) {
                writer.openBlock("if (std.mem.eql(u8, diagnostic.code(), \"\$L\")) {", ea.errorType!!)
                writer.write("return .\$L;", ea.state.name.lowercase())
                writer.closeBlock("}")
            }
            writer.closeBlock("}")
        }

        writer.write("return .retry;")
        writer.closeBlock("};")
        writer.blankLine()

        // Success-path acceptors (operation succeeded)
        // First check output path matchers, then success matchers
        val outputAcceptors = waiter.acceptors.filter { it.type == AcceptorType.OUTPUT_PATH }
        for (oa in outputAcceptors) {
            writeOutputPathMatcher(writer, oa)
        }

        val successAcceptors = waiter.acceptors.filter { it.type == AcceptorType.SUCCESS }
        for (sa in successAcceptors) {
            writer.write("return .\$L;", sa.state.name.lowercase())
        }

        // If no success acceptor matched, default to retry
        if (successAcceptors.isEmpty()) {
            writer.write("return .retry;")
        }

        writer.closeBlock("}")
    }

    private fun writeOutputPathMatcher(writer: ZigWriter, acceptor: AcceptorInfo) {
        val path = acceptor.outputPath!!
        val expected = acceptor.expected!!
        val state = acceptor.state.name.lowercase()

        // Build nested optional unwrapping chain
        // e.g., path = ["table", "table_status"] -> output.table.?.table_status
        val accessChain = buildString {
            append("output")
            for (segment in path) {
                append(".\$L")
            }
        }

        // For stringEquals comparator, compare with wireName() for enums
        // We generate the safe optional-unwrapping chain
        // Each level: if (parent.field) |val_N| { ... }
        // Level 0: parent is "output", capture is val_0
        // Level 1: parent is "val_0", capture is val_1
        for ((i, segment) in path.withIndex()) {
            val parent = if (i == 0) "output" else "val_${i - 1}"
            writer.openBlock("if (\$L.\$L) |val_\$L| {", parent, segment, i)
        }
        writeValueComparison(writer, "val_${path.lastIndex}", expected, state)
        for (i in path.indices) {
            writer.closeBlock("}")
        }
    }

    private fun writeValueComparison(writer: ZigWriter, varName: String, expected: String, state: String) {
        // Use wireName() for enums to get the wire-format string for comparison.
        // The expected value comes from the Smithy model and uses wire format.
        writer.openBlock("if (std.mem.eql(u8, \$L.wireName(), \"\$L\")) {", varName, expected)
        writer.write("return .\$L;", state)
        writer.closeBlock("}")
    }

    private fun toCamelCase(snakeCase: String): String {
        return snakeCase.split("_").mapIndexed { index, word ->
            if (index == 0) word
            else word.replaceFirstChar { it.uppercaseChar() }
        }.joinToString("")
    }
}
