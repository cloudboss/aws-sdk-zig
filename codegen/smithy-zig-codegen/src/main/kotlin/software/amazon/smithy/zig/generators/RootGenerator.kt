package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.neighbor.Walker
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.zig.DirectedZigCodegen
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

        // Collect standalone type shapes for types.zig.
        // Use Walker to get only shapes in this service's closure.
        val walker = Walker(model)
        val serviceShapes = walker.walkShapes(service)
        val operationIoSkipSet = DirectedZigCodegen.getOperationIoShapeIds(context)
        val operationNames = topDownIndex.getContainedOperations(service)
            .map { NamingUtil.toSnakeCase(it.id.name) }
            .toSet()

        val standaloneTypes = serviceShapes
            .filter { shape ->
                shape.id.namespace != "smithy.api" &&
                !shape.hasTrait(ErrorTrait::class.java) &&
                (shape is StructureShape || shape is UnionShape ||
                 shape is EnumShape || shape is IntEnumShape ||
                 (shape is StringShape && shape.hasTrait(EnumTrait::class.java))) &&
                (shape !is StructureShape || shape.id !in operationIoSkipSet)
            }
            .map { shape ->
                val typeName = shape.id.name
                val fileName = NamingUtil.toSnakeCase(typeName)
                Pair(fileName, typeName)
            }
            .filter { (fileName, _) -> fileName !in operationNames }
            .distinctBy { it.second }
            .sortedBy { it.first }

        // Generate types.zig
        if (standaloneTypes.isNotEmpty()) {
            context.writerDelegator().useFileWriter("types.zig") { writer ->
                for ((fileName, typeName) in standaloneTypes) {
                    writer.write(
                        "pub const \$L = @import(\"\$L.zig\").\$L;",
                        typeName, fileName, typeName,
                    )
                }
            }
        }

        // Generate root.zig
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

            if (standaloneTypes.isNotEmpty()) {
                writer.write("pub const types = @import(\"types.zig\");")
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
