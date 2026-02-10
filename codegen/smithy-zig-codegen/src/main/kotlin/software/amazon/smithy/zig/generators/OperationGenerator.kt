package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.zig.NamingUtil
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.protocols.OperationContext
import software.amazon.smithy.zig.protocols.ProtocolGenerator

class OperationGenerator(
    private val context: ZigContext,
    private val settings: ZigSettings,
    private val service: ServiceShape,
    private val model: Model,
    private val operation: OperationShape,
    private val apiVersion: String,
    private val errorInfos: List<ErrorGenerator.ErrorInfo>,
    private val protocol: ProtocolGenerator,
) {
    private val operationName = operation.id.name
    private val fileName = NamingUtil.toZigFileName(operationName)
    private val inputShape: StructureShape =
        model.expectShape(operation.inputShape, StructureShape::class.java)
    private val outputShape: StructureShape =
        model.expectShape(operation.outputShape, StructureShape::class.java)

    private fun buildOperationContext(): OperationContext {
        return OperationContext(
            operation = operation,
            inputShape = inputShape,
            outputShape = outputShape,
            model = model,
            service = service,
            apiVersion = apiVersion,
            errorInfos = errorInfos,
            settings = settings,
            symbolProvider = context.symbolProvider(),
        )
    }

    fun run() {
        val ctx = buildOperationContext()

        context.writerDelegator().useFileWriter(fileName) { writer ->
            writer.importContainer.addImport("std", "std")
            writer.importContainer.addImport("aws", "aws")

            // Intra-service imports written after standard imports
            writer.write("const Client = @import(\"client.zig\").Client;")
            writer.write("const ServiceError = @import(\"errors.zig\").ServiceError;")

            // Import shared types referenced by input/output members
            val sharedTypes = collectSharedTypes()
            for (typeName in sharedTypes) {
                val fileName = NamingUtil.toZigFileName(typeName)
                writer.write("const \$L = @import(\"\$L\").\$L;", typeName, fileName, typeName)
            }

            writer.blankLine()

            writeInputStruct(writer, ctx)
            writer.blankLine()
            writeOutputStruct(writer, ctx)
            writer.blankLine()
            writeOptionsStruct(writer)
            writer.blankLine()
            writeExecuteFunction(writer)
            writer.blankLine()
            protocol.writeSerializeRequest(writer, ctx)
            writer.blankLine()
            protocol.writeDeserializeResponse(writer, ctx)
            writer.blankLine()
            protocol.writeParseErrorResponse(writer, ctx)
        }
    }

    private fun writeInputStruct(writer: ZigWriter, ctx: OperationContext) {
        val docs = operation.getTrait(DocumentationTrait::class.java)
            .map { it.value }
            .orElse(null)
        if (docs != null) {
            writer.writeDocs(docs)
        }

        val inputName = "${operationName}Input"
        writer.openBlock("pub const \$L = struct {", inputName)

        var firstField = true
        for ((memberName, memberShape) in inputShape.allMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val zigType = ctx.resolveZigType(memberShape, targetShape)

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            val defaultValue = if (!memberShape.isRequired) " = null" else ""
            writer.write("\$L: \$L\$L,", fieldName, zigType, defaultValue)
            firstField = false
        }

        writer.closeBlock("};")
    }

    private fun writeOutputStruct(writer: ZigWriter, ctx: OperationContext) {
        val outputName = "${operationName}Output"
        writer.openBlock("pub const \$L = struct {", outputName)

        var firstField = true
        for ((memberName, memberShape) in outputShape.allMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val baseType = ctx.resolveBaseZigType(targetShape)
            val isScalar = ctx.isScalarType(targetShape)

            // For output structs, make non-scalar required members optional since
            // the deserializer may not populate them
            val isOptional = !memberShape.isRequired || !isScalar
            val zigType = if (isOptional) "?$baseType" else baseType
            val defaultValue = if (isOptional) " = null" else ""

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            writer.write("\$L: \$L\$L,", fieldName, zigType, defaultValue)
            firstField = false
        }

        writer.blankLine()
        writer.write("allocator: std.mem.Allocator,")
        writer.blankLine()
        writer.openBlock("pub fn deinit(self: *const \$L) void {", outputName)

        val hasStringFields = outputShape.allMembers.values.any { memberShape ->
            val targetShape = model.expectShape(memberShape.target)
            ctx.resolveBaseZigType(targetShape) == "[]const u8"
        }

        if (!hasStringFields) {
            writer.write("_ = self;")
        } else {
            for ((memberName, memberShape) in outputShape.allMembers) {
                val fieldName = NamingUtil.toFieldName(memberName)
                val targetShape = model.expectShape(memberShape.target)
                val zigType = ctx.resolveBaseZigType(targetShape)

                if (zigType == "[]const u8") {
                    if (memberShape.isRequired) {
                        writer.write("self.allocator.free(self.\$L);", fieldName)
                    } else {
                        writer.openBlock("if (self.\$L) |v| {", fieldName)
                        writer.write("self.allocator.free(v);")
                        writer.closeBlock("}")
                    }
                }
            }
        }

        writer.closeBlock("}")
        writer.closeBlock("};")
    }

    private fun writeOptionsStruct(writer: ZigWriter) {
        writer.openBlock("pub const Options = struct {")
        writer.write("diagnostic: ?*ServiceError = null,")
        writer.closeBlock("};")
    }

    private fun writeExecuteFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"
        val outputName = "${operationName}Output"

        writer.openBlock(
            "pub fn execute(client: *Client, input: \$L, options: Options) !\$L {",
            inputName, outputName,
        )

        writer.write("var arena = std.heap.ArenaAllocator.init(client.allocator);")
        writer.write("defer arena.deinit();")
        writer.write("const alloc = arena.allocator();")
        writer.blankLine()

        // Serialize request
        writer.write("var request = try serializeRequest(alloc, input, client.config);")
        writer.write("defer request.deinit(alloc);")
        writer.blankLine()

        // Sign
        writer.write("const creds = try client.config.credentials.getCredentials(alloc);")
        writer.write("try aws.signing.signRequest(alloc, &request, creds, client.config.region, \"\$L\");", settings.packageName)
        writer.blankLine()

        // Send
        writer.write("var response = try client.http_client.sendRequest(&request);")
        writer.write("defer response.deinit();")
        writer.blankLine()

        // Check for errors
        writer.openBlock("if (!response.isSuccess()) {")
        writer.openBlock("if (options.diagnostic) |d| {")
        writer.write("d.* = parseErrorResponse(response.body, response.status);")
        writer.closeBlock("}")
        writer.write("return error.ServiceError;")
        writer.closeBlock("}")
        writer.blankLine()

        // Deserialize
        writer.write("return try deserializeResponse(response.body, response.status, client.allocator);")

        writer.closeBlock("}")
    }

    /**
     * Collect unique named type names referenced by input/output members
     * (enums, structs, unions -- directly or through ListShape targets).
     * Excludes the input/output shapes themselves.
     */
    private fun collectSharedTypes(): Set<String> {
        val result = mutableSetOf<String>()

        fun addIfNamed(shape: software.amazon.smithy.model.shapes.Shape) {
            when (shape) {
                is StructureShape -> result.add(shape.id.name)
                is EnumShape -> result.add(shape.id.name)
                is IntEnumShape -> result.add(shape.id.name)
                is UnionShape -> result.add(shape.id.name)
                is StringShape -> {
                    if (shape.hasTrait(EnumTrait::class.java)) {
                        result.add(shape.id.name)
                    }
                }
            }
        }

        fun collectFromMembers(struct: StructureShape) {
            for ((_, memberShape) in struct.allMembers) {
                val targetShape = model.expectShape(memberShape.target)
                addIfNamed(targetShape)
                if (targetShape is ListShape) {
                    addIfNamed(model.expectShape(targetShape.member.target))
                }
            }
        }

        collectFromMembers(inputShape)
        collectFromMembers(outputShape)

        // Don't import input/output shapes themselves
        result.remove(inputShape.id.name)
        result.remove(outputShape.id.name)

        return result
    }
}
