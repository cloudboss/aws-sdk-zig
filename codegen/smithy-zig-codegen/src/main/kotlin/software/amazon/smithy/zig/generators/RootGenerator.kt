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

        // Collect operation I/O type re-exports for root.zig.
        // For each operation, export {OpName}Input and {OpName}Output,
        // unless the input/output is smithy.api#Unit (empty struct).
        data class IoTypeExport(val typeName: String, val fileName: String)
        val ioTypes = mutableListOf<IoTypeExport>()
        for (opShape in topDownIndex.getContainedOperations(service)) {
            val operationName = opShape.id.name
            val moduleFileName = NamingUtil.toSnakeCase(operationName)
            if (opShape.inputShape.toString() != "smithy.api#Unit") {
                ioTypes.add(IoTypeExport("${operationName}Input", moduleFileName))
            }
            if (opShape.outputShape.toString() != "smithy.api#Unit") {
                ioTypes.add(IoTypeExport("${operationName}Output", moduleFileName))
            }
        }
        // Filter out I/O types that collide with standalone type names.
        // Some shapes are both operation I/O AND referenced as member types,
        // so they appear in standaloneTypes already.
        val standaloneTypeNames = standaloneTypes.map { it.second }.toSet()
        val filteredIoTypes = ioTypes
            .filter { it.typeName !in standaloneTypeNames }
            .sortedBy { it.typeName }

        // Generate call_options.zig
        context.writerDelegator().useFileWriter("call_options.zig") { writer ->
            writer.write("const errors = @import(\"errors.zig\");")
            writer.blankLine()
            writer.openBlock("pub const CallOptions = struct {")
            writer.write("diagnostic: ?*errors.ServiceError = null,")
            writer.closeBlock("};")
        }

        // Generate types.zig -- standalone types only
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
            writer.write("pub const CallOptions = @import(\"call_options.zig\").CallOptions;")
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

            for (ioType in filteredIoTypes) {
                writer.write(
                    "pub const \$L = @import(\"\$L.zig\").\$L;",
                    ioType.typeName, ioType.fileName, ioType.typeName,
                )
            }
        }
    }
}
