package software.amazon.smithy.zig

import software.amazon.smithy.codegen.core.Symbol
import software.amazon.smithy.codegen.core.SymbolProvider
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.BigDecimalShape
import software.amazon.smithy.model.shapes.BigIntegerShape
import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.BooleanShape
import software.amazon.smithy.model.shapes.ByteShape
import software.amazon.smithy.model.shapes.DocumentShape
import software.amazon.smithy.model.shapes.DoubleShape
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.FloatShape
import software.amazon.smithy.model.shapes.IntEnumShape
import software.amazon.smithy.model.shapes.IntegerShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.LongShape
import software.amazon.smithy.model.shapes.MapShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ResourceShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.Shape
import software.amazon.smithy.model.shapes.ShapeVisitor
import software.amazon.smithy.model.shapes.ShortShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.TimestampShape
import software.amazon.smithy.model.shapes.UnionShape
import software.amazon.smithy.model.traits.EnumTrait
import software.amazon.smithy.model.traits.StreamingTrait

class ZigSymbolVisitor(private val model: Model, private val packageName: String) :
    SymbolProvider, ShapeVisitor<Symbol> {

    override fun toSymbol(shape: Shape): Symbol {
        return shape.accept(this)
    }

    override fun toMemberName(shape: MemberShape): String {
        return NamingUtil.toSnakeCase(shape.memberName)
    }

    override fun blobShape(shape: BlobShape): Symbol {
        if (shape.hasTrait(StreamingTrait::class.java)) {
            return simpleSymbol("aws.http.StreamingBody")
        }
        return simpleSymbol("[]const u8")
    }

    override fun booleanShape(shape: BooleanShape): Symbol = simpleSymbol("bool")

    override fun byteShape(shape: ByteShape): Symbol = simpleSymbol("i8")

    override fun shortShape(shape: ShortShape): Symbol = simpleSymbol("i16")

    override fun integerShape(shape: IntegerShape): Symbol = simpleSymbol("i32")

    override fun longShape(shape: LongShape): Symbol = simpleSymbol("i64")

    override fun floatShape(shape: FloatShape): Symbol = simpleSymbol("f32")

    override fun doubleShape(shape: DoubleShape): Symbol = simpleSymbol("f64")

    override fun bigIntegerShape(shape: BigIntegerShape): Symbol = simpleSymbol("i128")

    override fun bigDecimalShape(shape: BigDecimalShape): Symbol = simpleSymbol("f128")

    override fun stringShape(shape: StringShape): Symbol {
        // Legacy string enums with @enum trait
        if (shape.hasTrait(EnumTrait::class.java)) {
            return namedShape(shape)
        }
        return simpleSymbol("[]const u8")
    }

    override fun enumShape(shape: EnumShape): Symbol = namedShape(shape)

    override fun intEnumShape(shape: IntEnumShape): Symbol = namedShape(shape)

    override fun timestampShape(shape: TimestampShape): Symbol = simpleSymbol("i64")

    override fun documentShape(shape: DocumentShape): Symbol = simpleSymbol("[]const u8")

    override fun listShape(shape: ListShape): Symbol {
        val targetSymbol = toSymbol(model.expectShape(shape.member.target))
        return simpleSymbol("[]const ${targetSymbol.name}")
    }

    override fun mapShape(shape: MapShape): Symbol {
        val valueTarget = model.expectShape(shape.value.target)
        val valueSymbol = toSymbol(valueTarget)
        val valueTypeName = valueSymbol.name

        return if (valueTypeName == "[]const u8") {
            simpleSymbol("[]const aws.map.StringMapEntry")
        } else {
            simpleSymbol("[]const aws.map.MapEntry($valueTypeName)")
        }
    }

    override fun structureShape(shape: StructureShape): Symbol = namedShape(shape)

    override fun unionShape(shape: UnionShape): Symbol = namedShape(shape)

    override fun memberShape(shape: MemberShape): Symbol {
        val target = model.expectShape(shape.target)
        val targetSymbol = toSymbol(target)
        return if (shape.isRequired) {
            targetSymbol
        } else {
            simpleSymbol("?${targetSymbol.name}")
        }
    }

    override fun operationShape(shape: OperationShape): Symbol = namedShape(shape)

    override fun resourceShape(shape: ResourceShape): Symbol = namedShape(shape)

    override fun serviceShape(shape: ServiceShape): Symbol = namedShape(shape)

    private fun simpleSymbol(name: String): Symbol {
        return Symbol.builder()
            .name(name)
            .build()
    }

    private fun namedShape(shape: Shape): Symbol {
        val name = shape.id.name
        return Symbol.builder()
            .name(name)
            .namespace(packageName, "/")
            .definitionFile(NamingUtil.toZigFileName(name))
            .build()
    }
}
