package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.BlobShape
import software.amazon.smithy.model.shapes.BooleanShape
import software.amazon.smithy.model.shapes.DoubleShape
import software.amazon.smithy.model.shapes.FloatShape
import software.amazon.smithy.model.shapes.IntegerShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.LongShape
import software.amazon.smithy.model.shapes.MemberShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.ShortShape
import software.amazon.smithy.model.shapes.StringShape
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.shapes.TimestampShape

class ZigSymbolVisitorTest {
    private val model = Model.assembler()
        .addShape(StringShape.builder().id("test#MyString").build())
        .addShape(IntegerShape.builder().id("test#MyInt").build())
        .addShape(BooleanShape.builder().id("test#MyBool").build())
        .addShape(LongShape.builder().id("test#MyLong").build())
        .addShape(ShortShape.builder().id("test#MyShort").build())
        .addShape(FloatShape.builder().id("test#MyFloat").build())
        .addShape(DoubleShape.builder().id("test#MyDouble").build())
        .addShape(BlobShape.builder().id("test#MyBlob").build())
        .addShape(TimestampShape.builder().id("test#MyTimestamp").build())
        .addShape(
            StructureShape.builder()
                .id("test#MyStruct")
                .addMember("name", ShapeId.from("test#MyString"))
                .build()
        )
        .addShape(
            ListShape.builder()
                .id("test#MyList")
                .member(
                    MemberShape.builder()
                        .id("test#MyList\$member")
                        .target("test#MyString")
                        .build()
                )
                .build()
        )
        .assemble()
        .unwrap()

    private val visitor = ZigSymbolVisitor(model, "test")

    @Test
    fun stringType() {
        val shape = model.expectShape(ShapeId.from("test#MyString"))
        assertEquals("[]const u8", visitor.toSymbol(shape).name)
    }

    @Test
    fun integerType() {
        val shape = model.expectShape(ShapeId.from("test#MyInt"))
        assertEquals("i32", visitor.toSymbol(shape).name)
    }

    @Test
    fun booleanType() {
        val shape = model.expectShape(ShapeId.from("test#MyBool"))
        assertEquals("bool", visitor.toSymbol(shape).name)
    }

    @Test
    fun longType() {
        val shape = model.expectShape(ShapeId.from("test#MyLong"))
        assertEquals("i64", visitor.toSymbol(shape).name)
    }

    @Test
    fun shortType() {
        val shape = model.expectShape(ShapeId.from("test#MyShort"))
        assertEquals("i16", visitor.toSymbol(shape).name)
    }

    @Test
    fun floatType() {
        val shape = model.expectShape(ShapeId.from("test#MyFloat"))
        assertEquals("f32", visitor.toSymbol(shape).name)
    }

    @Test
    fun doubleType() {
        val shape = model.expectShape(ShapeId.from("test#MyDouble"))
        assertEquals("f64", visitor.toSymbol(shape).name)
    }

    @Test
    fun blobType() {
        val shape = model.expectShape(ShapeId.from("test#MyBlob"))
        assertEquals("[]const u8", visitor.toSymbol(shape).name)
    }

    @Test
    fun timestampType() {
        val shape = model.expectShape(ShapeId.from("test#MyTimestamp"))
        assertEquals("i64", visitor.toSymbol(shape).name)
    }

    @Test
    fun structureType() {
        val shape = model.expectShape(ShapeId.from("test#MyStruct"))
        val symbol = visitor.toSymbol(shape)
        assertEquals("MyStruct", symbol.name)
        assertEquals("my_struct.zig", symbol.definitionFile)
    }

    @Test
    fun listType() {
        val shape = model.expectShape(ShapeId.from("test#MyList"))
        assertEquals("[]const []const u8", visitor.toSymbol(shape).name)
    }

    @Test
    fun memberName() {
        val shape = model.expectShape(ShapeId.from("test#MyStruct\$name")) as MemberShape
        assertEquals("name", visitor.toMemberName(shape))
    }
}
