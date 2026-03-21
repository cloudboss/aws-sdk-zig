package software.amazon.smithy.zig.protocols

import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.StreamingTrait
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.generators.ErrorGenerator

data class OperationContext(
    val operation: OperationShape,
    val inputShape: StructureShape,
    val outputShape: StructureShape,
    val model: Model,
    val service: ServiceShape,
    val apiVersion: String,
    val errorInfos: List<ErrorGenerator.ErrorInfo>,
    val settings: ZigSettings,
    val symbolProvider: SymbolProvider,
) {
    val operationName: String get() = operation.id.name

    fun resolveZigType(memberShape: MemberShape, targetShape: Shape): String {
        val baseType = resolveBaseZigType(targetShape)
        return if (memberShape.isRequired) baseType else "?$baseType"
    }

    fun resolveBaseZigType(shape: Shape): String {
        return symbolProvider.toSymbol(shape).name
    }

    fun isEnumType(shape: Shape): Boolean {
        return shape is EnumShape || shape is IntEnumShape ||
            (shape is StringShape && shape.hasTrait(EnumTrait::class.java))
    }

    fun isStreamingBlob(shape: Shape): Boolean {
        return shape is BlobShape && shape.hasTrait(StreamingTrait::class.java)
    }

    fun isScalarType(shape: Shape): Boolean {
        if (isEnumType(shape)) return true
        val typeName = resolveBaseZigType(shape)
        return typeName in listOf("[]const u8", "bool", "i8", "i16", "i32", "i64", "f32", "f64", "i128", "f128")
    }

    fun scalarFormatExpr(shape: Shape, fieldName: String, accessor: String): String {
        if (isEnumType(shape)) return "$accessor.$fieldName.wireName()"
        val typeName = resolveBaseZigType(shape)
        return when (typeName) {
            "[]const u8" -> "$accessor.$fieldName"
            "bool" -> "if ($accessor.$fieldName) \"true\" else \"false\""
            "i8", "i16", "i32", "i64", "i128" ->
                "std.fmt.allocPrint(allocator, \"{d}\", .{$accessor.$fieldName}) catch \"\""
            "f32", "f64", "f128" ->
                "std.fmt.allocPrint(allocator, \"{d}\", .{$accessor.$fieldName}) catch \"\""
            else -> "$accessor.$fieldName"
        }
    }

    fun scalarFormatExprForOptional(shape: Shape, varName: String): String {
        if (isEnumType(shape)) return "$varName.wireName()"
        val typeName = resolveBaseZigType(shape)
        return when (typeName) {
            "[]const u8" -> varName
            "bool" -> "if ($varName) \"true\" else \"false\""
            "i8", "i16", "i32", "i64", "i128" ->
                "std.fmt.allocPrint(allocator, \"{d}\", .{$varName}) catch \"\""
            "f32", "f64", "f128" ->
                "std.fmt.allocPrint(allocator, \"{d}\", .{$varName}) catch \"\""
            else -> varName
        }
    }
}
