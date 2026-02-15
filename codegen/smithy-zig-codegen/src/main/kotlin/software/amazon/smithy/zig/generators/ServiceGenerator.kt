package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.knowledge.TopDownIndex
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class ServiceGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
    private val protocol: ProtocolGenerator,
) {
    fun run() {
        val apiVersion = service.version

        // 1. Collect error info (shared across all operations)
        val errorGenerator = ErrorGenerator(context, service, model)
        val errorInfos = errorGenerator.collectErrors()

        // 2. Generate errors.zig
        errorGenerator.run()

        // 3. Generate one file per operation (including resource-bound operations)
        val topDownIndex = TopDownIndex.of(model)
        for (opShape in topDownIndex.getContainedOperations(service)) {
            OperationGenerator(
                context, context.settings(), service, model, opShape, apiVersion, errorInfos, protocol,
            ).run()
        }

        // 4. Generate paginator.zig (if any paginated operations)
        val paginatorGen = PaginatorGenerator(context, service, model)
        paginatorGen.run()

        // 5. Generate waiters.zig (if any waitable operations)
        val waiterGen = WaiterGenerator(context, service, model)
        waiterGen.run()

        // 6. Generate client.zig
        ClientGenerator(context, service, model, paginatorGen, waiterGen).run()

        // 7. Generate root.zig
        RootGenerator(context, service, model, paginatorGen, waiterGen).run()

        // 7. Generate serde.zig for XML protocols
        if (protocol.needsXmlSerde()) {
            SerdeGenerator(context, service, model).run()
        }
    }
}
