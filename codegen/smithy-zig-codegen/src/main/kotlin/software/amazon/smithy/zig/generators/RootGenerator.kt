package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext

class RootGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    fun run() {
        val operations = service.allOperations
            .map { opId ->
                val opShape = model.expectShape(opId, OperationShape::class.java)
                val name = opShape.id.name
                NamingUtil.toSnakeCase(name)
            }
            .sorted()

        context.writerDelegator().useFileWriter("root.zig") { writer ->
            writer.write("pub const Client = @import(\"client.zig\").Client;")
            writer.write("pub const errors = @import(\"errors.zig\");")
            writer.write("pub const ServiceError = errors.ServiceError;")
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
