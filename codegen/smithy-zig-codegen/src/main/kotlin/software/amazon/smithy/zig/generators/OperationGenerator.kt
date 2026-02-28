package software.amazon.smithy.zig.generators

import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.DocumentationTrait
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.HttpPayloadTrait
import software.amazon.smithy.model.traits.StreamingTrait
import software.amazon.smithy.zig.DefaultValueUtil
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
    companion object {
        val PRESIGNABLE_OPERATIONS = setOf(
            "com.amazonaws.s3#GetObject",
            "com.amazonaws.s3#PutObject",
            "com.amazonaws.s3#DeleteObject",
            "com.amazonaws.s3#HeadObject",
            "com.amazonaws.s3#HeadBucket",
            "com.amazonaws.s3#UploadPart",
            "com.amazonaws.sts#GetCallerIdentity",
        )
    }
    private val operationName = operation.id.name
    private val fileName = NamingUtil.toZigFileName(operationName)
    private val inputShape: StructureShape =
        model.expectShape(operation.inputShape, StructureShape::class.java)
    private val outputShape: StructureShape =
        model.expectShape(operation.outputShape, StructureShape::class.java)

    /**
     * Check if this operation has a streaming output payload:
     * an output member with @httpPayload targeting a @streaming blob.
     */
    private fun hasStreamingOutputPayload(): Boolean {
        for ((_, memberShape) in outputShape.allMembers) {
            if (memberShape.hasTrait(HttpPayloadTrait::class.java)) {
                val target = model.expectShape(memberShape.target)
                if (target is BlobShape && target.hasTrait(StreamingTrait::class.java)) {
                    return true
                }
            }
        }
        return false
    }

    /**
     * Check if this operation has an event stream output:
     * an output member targeting a @streaming union.
     */
    private fun hasEventStreamOutput(): Boolean {
        for ((_, memberShape) in outputShape.allMembers) {
            val target = model.expectShape(memberShape.target)
            if (target is UnionShape && target.hasTrait(StreamingTrait::class.java)) {
                return true
            }
        }
        return false
    }

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
        val isStreaming = hasStreamingOutputPayload()
        val isEventStream = hasEventStreamOutput()

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

            // Import serde module for XML protocols with complex members
            if (protocol.needsXmlSerde() && (hasComplexOutputMembers() || hasComplexInputMembers())) {
                writer.write("const serde = @import(\"serde.zig\");")
            }

            writer.blankLine()

            // smithy.api#Unit is a built-in with no generated file -- emit inline
            if (inputShape.id.toString() == "smithy.api#Unit") {
                writer.write("const \$L = struct {};", "${operationName}Input")
            } else if (isSharedType(inputShape.id)) {
                val inputFileName = NamingUtil.toZigFileName(inputShape.id.name)
                writer.write(
                    "const \$L = @import(\"\$L\").\$L;",
                    "${operationName}Input", inputFileName, inputShape.id.name
                )
            } else {
                writeInputStruct(writer, ctx)
            }
            writer.blankLine()
            if (outputShape.id.toString() == "smithy.api#Unit") {
                writer.write("const \$L = struct {};", "${operationName}Output")
            } else if (isSharedType(outputShape.id)) {
                val outputFileName = NamingUtil.toZigFileName(outputShape.id.name)
                writer.write(
                    "const \$L = @import(\"\$L\").\$L;",
                    "${operationName}Output", outputFileName, outputShape.id.name
                )
            } else {
                writeOutputStruct(writer, ctx, isStreaming)
            }
            writer.blankLine()
            writeOptionsStruct(writer)
            writer.blankLine()

            if (isEventStream) {
                // Event stream operations get a stub until full support is implemented
                writeEventStreamStubExecuteFunction(writer)
            } else if (isStreaming) {
                writeStreamingExecuteFunction(writer)
            } else {
                writeExecuteFunction(writer)
            }

            if (!isEventStream) {
                // Presign function for allowlisted operations
                if (operation.id.toString() in PRESIGNABLE_OPERATIONS) {
                    writer.blankLine()
                    writePresignFunction(writer)
                }

                writer.blankLine()
                protocol.writeSerializeRequest(writer, ctx)
                writer.blankLine()
                if (isStreaming) {
                    protocol.writeDeserializeStreamingResponse(writer, ctx)
                } else {
                    protocol.writeDeserializeResponse(writer, ctx)
                }
                writer.blankLine()
                protocol.writeParseErrorResponse(writer, ctx)
            }
        }
    }

    private fun writeInputStruct(writer: ZigWriter, ctx: OperationContext) {
        val inputName = "${operationName}Input"
        writer.openBlock("pub const \$L = struct {", inputName)

        var firstField = true
        for ((memberName, memberShape) in inputShape.allMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = model.expectShape(memberShape.target)
            // Override streaming blob input types to []const u8 (input streaming deferred)
            val hasMemberDefault = memberShape.hasTrait(software.amazon.smithy.model.traits.DefaultTrait::class.java)
            val zigType = if (ctx.isStreamingBlob(targetShape) && !hasMemberDefault) {
                if (memberShape.isRequired) "[]const u8" else "?[]const u8"
            } else {
                ctx.resolveZigType(memberShape, targetShape)
            }

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            val defaultValue = DefaultValueUtil.resolveDefaultValue(memberShape, model, context.symbolProvider())
            val defaultBaseType = (defaultValue?.typeName ?: zigType).removePrefix("?")
            val outputType = if (hasMemberDefault) {
                "?$defaultBaseType"
            } else {
                defaultValue?.typeName ?: zigType
            }
            val defaultSuffix = if (hasMemberDefault) " = null" else defaultValue?.let { " = ${it.literal}" }
                ?: if (!memberShape.isRequired) " = null" else ""
            writer.write("\$L: \$L\$L,", fieldName, outputType, defaultSuffix)
            firstField = false
        }

        if (isJsonProtocol()) {
            writeJsonFieldNames(writer, inputShape)
        }

        writer.closeBlock("};")
    }

    private fun writeOutputStruct(writer: ZigWriter, ctx: OperationContext, isStreaming: Boolean = false) {
        val outputName = "${operationName}Output"
        writer.openBlock("pub const \$L = struct {", outputName)

        var firstField = true
        for ((memberName, memberShape) in outputShape.allMembers) {
            val fieldName = NamingUtil.toFieldName(memberName)
            val targetShape = model.expectShape(memberShape.target)
            val baseType = ctx.resolveBaseZigType(targetShape)
            val isScalar = ctx.isScalarType(targetShape)
            val isStreamingBlobField = ctx.isStreamingBlob(targetShape)
            val hasMemberDefault = memberShape.hasTrait(software.amazon.smithy.model.traits.DefaultTrait::class.java)

            // Streaming blob fields are not optional -- they always hold the connection
            // They use `= undefined` default since deserializeStreamingResponse sets them immediately
            val isOptional = if (isStreamingBlobField) false
                else !memberShape.isRequired || !isScalar
            val defaultValue = DefaultValueUtil.resolveDefaultValue(memberShape, model, context.symbolProvider())
            val zigType = if (hasMemberDefault) {
                "?$baseType"
            } else if (defaultValue != null) {
                defaultValue.typeName
            } else if (isOptional) {
                "?$baseType"
            } else {
                baseType
            }
            val defaultSuffix = when {
                hasMemberDefault -> " = null"
                defaultValue != null -> " = ${defaultValue.literal}"
                isStreamingBlobField -> " = undefined"
                isOptional -> " = null"
                else -> ""
            }

            val memberDocs = memberShape.getTrait(DocumentationTrait::class.java)
                .map { it.value }
                .orElse(null)

            if (!firstField) {
                writer.blankLine()
            }
            if (memberDocs != null) {
                writer.writeDocs(memberDocs)
            }

            writer.write("\$L: \$L\$L,", fieldName, zigType, defaultSuffix)
            firstField = false
        }

        // Streaming outputs need deinit() for HTTP body cleanup only
        if (isStreaming) {
            writer.blankLine()
            writer.openBlock("pub fn deinit(self: *\$L) void {", outputName)
            for ((memberName, memberShape) in outputShape.allMembers) {
                val targetShape = model.expectShape(memberShape.target)
                if (ctx.isStreamingBlob(targetShape)) {
                    val fieldName = NamingUtil.toFieldName(memberName)
                    writer.write("self.\$L.deinit();", fieldName)
                }
            }
            writer.closeBlock("}")
        }

        if (isJsonProtocol()) {
            writeJsonFieldNames(writer, outputShape)
        }

        writer.closeBlock("};")
    }

    private fun writeOptionsStruct(writer: ZigWriter) {
        writer.openBlock("pub const Options = struct {")
        writer.write("diagnostic: ?*ServiceError = null,")
        writer.closeBlock("};")
    }

    private fun writeEventStreamStubExecuteFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"
        val outputName = "${operationName}Output"

        writer.openBlock(
            "pub fn execute(client: *Client, allocator: std.mem.Allocator, input: \$L, options: Options) !\$L {",
            inputName, outputName,
        )

        writer.write("_ = client;")
        writer.write("_ = allocator;")
        writer.write("_ = input;")
        writer.write("_ = options;")
        writer.write("return error.EventStreamNotSupported;")

        writer.closeBlock("}")
    }

    private fun writeExecuteFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"
        val outputName = "${operationName}Output"

        writer.openBlock(
            "pub fn execute(client: *Client, allocator: std.mem.Allocator, input: \$L, options: Options) !\$L {",
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
        writer.write("d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };")
        writer.closeBlock("}")
        writer.write("return error.ServiceError;")
        writer.closeBlock("}")
        writer.blankLine()

        // Deserialize into caller-provided allocator
        writer.write("const result = try deserializeResponse(response.body, response.status, response.headers, allocator);")
        writer.write("return result;")

        writer.closeBlock("}")
    }

    private fun writeStreamingExecuteFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"
        val outputName = "${operationName}Output"

        writer.openBlock(
            "pub fn execute(client: *Client, allocator: std.mem.Allocator, input: \$L, options: Options) !\$L {",
            inputName, outputName,
        )

        writer.write("var arena = std.heap.ArenaAllocator.init(client.allocator);")
        writer.write("const alloc = arena.allocator();")
        writer.blankLine()

        // Serialize request
        writer.write("var request = try serializeRequest(alloc, input, client.config);")
        writer.blankLine()

        // Sign
        writer.write("const creds = try client.config.credentials.getCredentials(alloc);")
        writer.write("try aws.signing.signRequest(alloc, &request, creds, client.config.region, \"\$L\");", settings.packageName)
        writer.blankLine()

        // Send streaming request
        writer.write("var stream_resp = try client.http_client.sendStreamingRequest(&request);")
        writer.blankLine()

        // Free arena -- request data already sent
        writer.write("arena.deinit();")
        writer.blankLine()

        // Check for errors
        writer.openBlock("if (!stream_resp.isSuccess()) {")
        writer.write("defer stream_resp.deinit();")
        writer.write("const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;")
        writer.write("defer client.allocator.free(error_body);")
        writer.openBlock("if (options.diagnostic) |d| {")
        writer.write("d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };")
        writer.closeBlock("}")
        writer.write("return error.ServiceError;")
        writer.closeBlock("}")
        writer.blankLine()

        // Deserialize into caller-provided allocator
        writer.write("const result = try deserializeStreamingResponse(&stream_resp, allocator);")
        writer.write("return result;")

        writer.closeBlock("}")
    }

    private fun writePresignOptions(writer: ZigWriter) {
        writer.openBlock("pub const PresignOptions = struct {")
        writer.write("expires_seconds: u64 = 3600,")
        writer.closeBlock("};")
    }

    private fun writePresignFunction(writer: ZigWriter) {
        val inputName = "${operationName}Input"

        writePresignOptions(writer)
        writer.blankLine()

        writer.openBlock(
            "pub fn presign(client: *Client, allocator: std.mem.Allocator, input: \$L, options: PresignOptions) ![]const u8 {",
            inputName,
        )

        writer.write("var arena = std.heap.ArenaAllocator.init(client.allocator);")
        writer.write("defer arena.deinit();")
        writer.write("const alloc = arena.allocator();")
        writer.blankLine()

        writer.write("var request = try serializeRequest(alloc, input, client.config);")
        writer.write("defer request.deinit(alloc);")
        writer.blankLine()

        writer.write("const creds = try client.config.credentials.getCredentials(alloc);")
        writer.blankLine()

        writer.openBlock("return aws.signing.presignRequest(")
        writer.write("allocator,")
        writer.write("&request,")
        writer.write("creds,")
        writer.write("client.config.region,")
        writer.write("\"\$L\",", settings.packageName)
        writer.write(".{ .expires_seconds = options.expires_seconds },")
        writer.closeBlock(");")

        writer.closeBlock("}")
    }

    private fun isJsonProtocol(): Boolean {
        return service.hasTrait("aws.protocols#awsJson1_0") ||
            service.hasTrait("aws.protocols#awsJson1_1") ||
            service.hasTrait("aws.protocols#restJson1")
    }

    private fun writeJsonFieldNames(writer: ZigWriter, shape: StructureShape) {
        val members = shape.allMembers
        if (members.isEmpty()) return

        writer.blankLine()
        writer.openBlock("pub const json_field_names = .{")
        for ((memberName, _) in members) {
            val fieldName = NamingUtil.toFieldName(memberName)
            writer.write(".\$L = \"\$L\",", fieldName, memberName)
        }
        writer.closeBlock("};")
    }

    /** Check if output shape has struct, list, or map members that need serde functions. */
    private fun hasComplexOutputMembers(): Boolean {
        return outputShape.allMembers.values.any { memberShape ->
            val target = model.expectShape(memberShape.target)
            target is StructureShape || target is ListShape || target is MapShape
        }
    }

    /** Check if input shape has struct, list, or map members that need serde functions. */
    private fun hasComplexInputMembers(): Boolean {
        return inputShape.allMembers.values.any { memberShape ->
            val target = model.expectShape(memberShape.target)
            target is StructureShape || target is ListShape || target is MapShape
        }
    }

    /**
     * Collect unique named type names referenced by input/output members
     * (enums, structs, unions -- directly or through ListShape/MapShape targets).
     * Recurses through list elements and map values to find nested named types.
     * Excludes the input/output shapes themselves.
     */
    private fun collectSharedTypes(): Set<String> {
        val result = mutableSetOf<String>()

        fun collectFromShape(shape: software.amazon.smithy.model.shapes.Shape) {
            // Skip Smithy prelude shapes -- they have no generated files.
            if (shape.id.namespace == "smithy.api") return
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
                is ListShape -> collectFromShape(model.expectShape(shape.member.target))
                is MapShape -> collectFromShape(model.expectShape(shape.value.target))
            }
        }

        fun collectFromMembers(struct: StructureShape) {
            for ((_, memberShape) in struct.allMembers) {
                collectFromShape(model.expectShape(memberShape.target))
            }
        }

        collectFromMembers(inputShape)
        collectFromMembers(outputShape)

        // Don't import input/output shapes themselves
        result.remove(inputShape.id.name)
        result.remove(outputShape.id.name)
        // Also exclude names matching the generated input/output names to prevent collision
        result.remove("${operationName}Input")
        result.remove("${operationName}Output")
        // Exclude "Options" -- every operation file defines a local Options struct
        result.remove("Options")

        return result
    }

    private fun isSharedType(
        shapeId: software.amazon.smithy.model.shapes.ShapeId
    ): Boolean {
        // Check 1: Is this shape directly referenced as a member type?
        for (shape in model.toSet()) {
            if (shape !is StructureShape || shape.id == shapeId) continue
            for ((_, memberShape) in shape.allMembers) {
                if (memberShape.target == shapeId) return true
                val target = model.getShape(memberShape.target).orElse(null)
                if (target is ListShape && target.member.target == shapeId)
                    return true
                if (target is MapShape && target.value.target == shapeId)
                    return true
            }
        }

        // Check 2: Does the generated name collide with another shape in the model?
        val generatedName = if (shapeId == inputShape.id) "${operationName}Input" else "${operationName}Output"
        if (generatedName != shapeId.name) {
            for (shape in model.toSet()) {
                if (shape.id.name == generatedName && shape.id != shapeId) return true
            }
        }

        return false
    }
}
