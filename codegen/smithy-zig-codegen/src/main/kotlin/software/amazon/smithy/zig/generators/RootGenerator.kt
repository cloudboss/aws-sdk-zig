package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext

class RootGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
    private val paginatorGen: PaginatorGenerator? = null,
    private val waiterGen: WaiterGenerator? = null,
) {
    fun run() {
        val topDownIndex = TopDownIndex.of(model)
        val operations = topDownIndex.getContainedOperations(service)
            .map { opShape ->
                val name = opShape.id.name
                NamingUtil.toSnakeCase(name)
            }
            .sorted()

        val hasPaginatedOps = paginatorGen?.collectPaginatedOperations()?.isNotEmpty() ?: false
        val hasWaiters = waiterGen?.collectWaiters()?.isNotEmpty() ?: false

        context.writerDelegator().useFileWriter("root.zig") { writer ->
            writer.write("pub const Client = @import(\"client.zig\").Client;")
            writer.write("pub const errors = @import(\"errors.zig\");")
            writer.write("pub const ServiceError = errors.ServiceError;")

            if (hasPaginatedOps) {
                writer.write("pub const paginator = @import(\"paginator.zig\");")
            }

            if (hasWaiters) {
                writer.write("pub const waiters = @import(\"waiters.zig\");")
            }

            writer.blankLine()

            for (opName in operations) {
                writer.write(
                    "pub const \$L = @import(\"\$L.zig\");",
                    opName, opName,
                )
            }
        }
    }
}
