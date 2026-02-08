package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.zig.ZigContext

class ServiceGenerator(
    private val context: ZigContext,
    private val service: ServiceShape,
    private val model: Model,
) {
    fun run() {
        val apiVersion = service.version

        // 1. Collect error info (shared across all operations)
        val errorGenerator = ErrorGenerator(context, service, model)
        val errorInfos = errorGenerator.collectErrors()

        // 2. Generate errors.zig
        errorGenerator.run()

        // 3. Generate one file per operation
        for (operationId in service.allOperations) {
            val opShape = model.expectShape(operationId, OperationShape::class.java)
            OperationGenerator(
                context, context.settings(), service, model, opShape, apiVersion, errorInfos,
            ).run()
        }

        // 4. Generate client.zig
        ClientGenerator(context, service, model).run()

        // 5. Generate root.zig
        RootGenerator(context, service, model).run()
    }
}
