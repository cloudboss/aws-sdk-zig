package software.amazon.smithy.zig.aws

import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Assertions.assertTrue
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.io.TempDir
import software.amazon.smithy.build.FileManifest
import software.amazon.smithy.codegen.core.WriterDelegator
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.EnumShape
import software.amazon.smithy.model.shapes.ListShape
import software.amazon.smithy.model.shapes.OperationShape
import software.amazon.smithy.model.shapes.ServiceShape
import software.amazon.smithy.model.shapes.ShapeId
import software.amazon.smithy.model.shapes.StructureShape
import software.amazon.smithy.model.traits.EnumDefinition
import software.amazon.smithy.model.traits.ErrorTrait
import software.amazon.smithy.model.traits.XmlFlattenedTrait
import software.amazon.smithy.model.traits.XmlNameTrait
import software.amazon.smithy.zig.ZigContext
import software.amazon.smithy.zig.ZigSettings
import software.amazon.smithy.zig.ZigSymbolVisitor
import software.amazon.smithy.zig.ZigWriter
import software.amazon.smithy.zig.aws.protocols.AwsQueryProtocol
import software.amazon.smithy.zig.generators.ServiceGenerator
import java.nio.file.Path

class SerdeGeneratorTest {

    @TempDir
    lateinit var tempDir: Path

    private fun buildTestModel(): Model {
        return Model.assembler()
            // Tag struct (nested)
            .addShape(
                StructureShape.builder()
                    .id("test#Tag")
                    .addMember("Key", ShapeId.from("smithy.api#String"))
                    .addMember("Value", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // StatusType enum
            .addShape(
                EnumShape.builder()
                    .id("test#StatusType")
                    .addMember("Active", "Active")
                    .addMember("Inactive", "Inactive")
                    .build()
            )
            // Tag list
            .addShape(
                ListShape.builder()
                    .id("test#TagList")
                    .member(ShapeId.from("test#Tag"))
                    .build()
            )
            // Marker struct (empty -- no members at all)
            .addShape(
                StructureShape.builder()
                    .id("test#Marker")
                    .build()
            )
            // Settings struct (only scalar fields -- no alloc needed)
            .addShape(
                StructureShape.builder()
                    .id("test#Settings")
                    .addMember("MaxItems", ShapeId.from("smithy.api#Integer"))
                    .addMember("Enabled", ShapeId.from("smithy.api#Boolean"))
                    .build()
            )
            // User struct (has nested struct + list + enum)
            .addShape(
                StructureShape.builder()
                    .id("test#User")
                    .addMember("UserName", ShapeId.from("smithy.api#String"))
                    .addMember("UserId", ShapeId.from("smithy.api#String"))
                    .addMember("Arn", ShapeId.from("smithy.api#String"))
                    .addMember("CreateDate", ShapeId.from("smithy.api#Long"))
                    .addMember("IsTruncated", ShapeId.from("smithy.api#Boolean"))
                    .addMember("Status", ShapeId.from("test#StatusType"))
                    .addMember("Tags", ShapeId.from("test#TagList"))
                    .addMember("Settings", ShapeId.from("test#Settings"))
                    .addMember("Marker", ShapeId.from("test#Marker"))
                    .build()
            )
            // Error shape
            .addShape(
                StructureShape.builder()
                    .id("test#NoSuchEntityException")
                    .addTrait(ErrorTrait("client"))
                    .addMember("message", ShapeId.from("smithy.api#String"))
                    .build()
            )
            // GetUser operation
            .addShape(
                StructureShape.builder()
                    .id("test#GetUserInput")
                    .addMember("UserName", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetUserOutput")
                    .addMember("User", ShapeId.from("test#User"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#GetUser")
                    .input(ShapeId.from("test#GetUserInput"))
                    .output(ShapeId.from("test#GetUserOutput"))
                    .addError(ShapeId.from("test#NoSuchEntityException"))
                    .build()
            )
            // ListUsers operation (returns list of structs)
            .addShape(
                StructureShape.builder()
                    .id("test#ListUsersInput")
                    .build()
            )
            .addShape(
                ListShape.builder()
                    .id("test#UserList")
                    .member(ShapeId.from("test#User"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#ListUsersOutput")
                    .addMember("Users", ShapeId.from("test#UserList"))
                    .addMember("IsTruncated", ShapeId.from("smithy.api#Boolean"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#ListUsers")
                    .input(ShapeId.from("test#ListUsersInput"))
                    .output(ShapeId.from("test#ListUsersOutput"))
                    .build()
            )
            // UpdateUser operation (complex input with nested struct + list)
            .addShape(
                StructureShape.builder()
                    .id("test#UpdateUserInput")
                    .addMember("User", ShapeId.from("test#User"))
                    .addMember("Tags", ShapeId.from("test#TagList"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#UpdateUserOutput")
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#UpdateUser")
                    .input(ShapeId.from("test#UpdateUserInput"))
                    .output(ShapeId.from("test#UpdateUserOutput"))
                    .build()
            )
            // Service
            .addShape(
                ServiceShape.builder()
                    .id("test#IAM")
                    .version("2010-05-08")
                    .addOperation(ShapeId.from("test#GetUser"))
                    .addOperation(ShapeId.from("test#ListUsers"))
                    .addOperation(ShapeId.from("test#UpdateUser"))
                    .build()
            )
            .assemble()
            .unwrap()
    }

    private fun createContext(model: Model): ZigContext {
        val settings = ZigSettings(
            ShapeId.from("test#IAM"),
            "iam",
            ".",
        )
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val service = model.expectShape(settings.service, ServiceShape::class.java)

        return ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )
    }

    private fun generateFiles(): Map<String, String> {
        val model = buildTestModel()
        val context = createContext(model)
        val service = model.expectShape(
            ShapeId.from("test#IAM"),
            ServiceShape::class.java,
        )

        ServiceGenerator(context, service, model, AwsQueryProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }
        return files
    }

    // ---- File generation ----

    @Test
    fun serdeZigIsGenerated() {
        val files = generateFiles()
        assertTrue(files.containsKey("serde.zig"), "serde.zig should be generated for XML protocols")
    }

    @Test
    fun serdeZigImportsAws() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(serde.contains("const aws = @import(\"aws\");"), "Should import aws")
        assertTrue(serde.contains("const std = @import(\"std\");"), "Should import std")
    }

    @Test
    fun serdeZigImportsTypeFiles() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("const User = @import(\"user.zig\").User;"),
            "Should import User type",
        )
        assertTrue(
            serde.contains("const Tag = @import(\"tag.zig\").Tag;"),
            "Should import Tag type",
        )
    }

    // ---- Struct deserializer ----

    @Test
    fun deserializeUserFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn deserializeUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !User {"),
            "Should generate deserializeUser function",
        )
    }

    @Test
    fun deserializeTagFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {"),
            "Should generate deserializeTag function",
        )
    }

    @Test
    fun userDeserializerHandlesStringField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("\"UserName\""),
            "Should match on XML element name UserName",
        )
        assertTrue(
            serde.contains("result.user_name = try alloc.dupe(u8, try reader.readElementText());"),
            "Should deserialize string with alloc.dupe",
        )
    }

    @Test
    fun userDeserializerHandlesLongField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("\"CreateDate\""),
            "Should match on XML element name CreateDate",
        )
        assertTrue(
            serde.contains("result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;"),
            "Should deserialize long with parseInt",
        )
    }

    @Test
    fun userDeserializerHandlesBoolField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("result.is_truncated = std.mem.eql(u8, try reader.readElementText(), \"true\");"),
            "Should deserialize boolean",
        )
    }

    @Test
    fun userDeserializerHandlesEnumField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("result.status = std.meta.stringToEnum(StatusType, try reader.readElementText());"),
            "Should deserialize enum with stringToEnum",
        )
    }

    @Test
    fun userDeserializerHandlesNestedList() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("result.tags = try deserializeTagList(reader, alloc, \"member\");"),
            "Should call list deserializer for tags",
        )
    }

    @Test
    fun userDeserializerHandlesNestedStruct() {
        // The User struct has Tags member which contains Tag structs
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("deserializeTag(reader, alloc)"),
            "Tag list deserializer should call deserializeTag",
        )
    }

    @Test
    fun userDeserializerSkipsUnknownElements() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("try reader.skipElement();"),
            "Should skip unknown elements",
        )
    }

    @Test
    fun userDeserializerUsesWhileLoop() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("while (try reader.next()) |event|"),
            "Should use while loop to iterate events",
        )
    }

    @Test
    fun userDeserializerBreaksOnElementEnd() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains(".element_end => break,"),
            "Should break on element_end",
        )
    }

    // ---- List deserializer ----

    @Test
    fun tagListDeserializerFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn deserializeTagList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {"),
            "Should generate deserializeTagList function",
        )
    }

    @Test
    fun tagListDeserializerUsesArrayList() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("var list: std.ArrayList(Tag) = .{};"),
            "Should use ArrayList for accumulation",
        )
    }

    @Test
    fun tagListDeserializerCallsToOwnedSlice() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("return list.toOwnedSlice(alloc);"),
            "Should convert to owned slice",
        )
    }

    @Test
    fun userListDeserializerFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn deserializeUserList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const User {"),
            "Should generate deserializeUserList function",
        )
    }

    // ---- I/O shapes excluded ----

    @Test
    fun ioShapesNotInSerde() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertFalse(
            serde.contains("deserializeGetUserOutput"),
            "Operation I/O shapes should not be in serde.zig",
        )
        assertFalse(
            serde.contains("deserializeListUsersOutput"),
            "Operation I/O shapes should not be in serde.zig",
        )
        assertFalse(
            serde.contains("deserializeGetUserInput"),
            "Operation input shapes should not be in serde.zig",
        )
    }

    // ---- Empty struct handling ----

    @Test
    fun emptyStructUsesConstResult() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        val fnStart = serde.indexOf("pub fn deserializeMarker(")
        assertTrue(fnStart >= 0, "Should generate deserializeMarker")
        val fnBody = serde.substring(fnStart, serde.indexOf("}\n", fnStart + 100) + 1)
        assertTrue(
            fnBody.contains("const result:"),
            "Empty struct should use const result",
        )
        assertFalse(
            fnBody.contains("var result"),
            "Empty struct should NOT use var result",
        )
        assertTrue(
            fnBody.contains("|_|"),
            "Empty struct should use |_| for unused element capture",
        )
    }

    // ---- Unused alloc suppression ----

    @Test
    fun scalarOnlyStructSuppressesUnusedAlloc() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Settings has only integer + boolean fields -- alloc is unused
        assertTrue(
            serde.contains("pub fn deserializeSettings("),
            "Should generate deserializeSettings",
        )
        // Find the deserializeSettings function body and check for _ = alloc
        val fnStart = serde.indexOf("pub fn deserializeSettings(")
        val fnBody = serde.substring(fnStart, serde.indexOf("}\n", fnStart + 200) + 1)
        assertTrue(
            fnBody.contains("_ = alloc;"),
            "Scalar-only struct deserializer should suppress unused alloc",
        )
    }

    @Test
    fun stringStructDoesNotSuppressAlloc() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Tag has string fields -- alloc IS used
        val fnStart = serde.indexOf("pub fn deserializeTag(")
        val fnBody = serde.substring(fnStart, serde.indexOf("}\n", fnStart + 100) + 1)
        assertFalse(
            fnBody.contains("_ = alloc;"),
            "String-containing struct deserializer should NOT suppress alloc",
        )
    }

    // ---- Enum import ----

    @Test
    fun serdeImportsEnumType() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("const StatusType = @import(\"status_type.zig\").StatusType;"),
            "Should import StatusType enum",
        )
    }

    // ---- @xmlName trait ----

    // ---- Struct serializer ----

    @Test
    fun serializeTagFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn serializeTag(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {"),
            "Should generate serializeTag function",
        )
    }

    @Test
    fun serializeUserFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn serializeUser(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: User) !void {"),
            "Should generate serializeUser function",
        )
    }

    @Test
    fun tagSerializerHandlesStringField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Tag.Key is optional, so serializer wraps in if/else with |v|
        assertTrue(
            serde.contains("appendXmlEscaped(alloc, buf, v)"),
            "String fields should use appendXmlEscaped",
        )
    }

    @Test
    fun userSerializerHandlesEnumField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Status is optional, so unwrapped as v
        assertTrue(
            serde.contains("@tagName(v)"),
            "Enum fields should use @tagName",
        )
    }

    @Test
    fun userSerializerHandlesListField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Tags is optional, so unwrapped as v
        assertTrue(
            serde.contains("serializeTagList(alloc, buf, v, \"member\")"),
            "List fields should call list serializer",
        )
    }

    @Test
    fun userSerializerHandlesBoolField() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // IsTruncated is optional, so unwrapped as v
        assertTrue(
            serde.contains("if (v) \"true\" else \"false\""),
            "Bool fields should use if/else true/false",
        )
    }

    @Test
    fun userSerializerHandlesNestedStruct() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        // Settings is optional, so unwrapped as v
        assertTrue(
            serde.contains("serializeSettings(alloc, buf, v)"),
            "Nested struct fields should call struct serializer",
        )
    }

    // ---- List serializer ----

    @Test
    fun serializeTagListFunction() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn serializeTagList(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {"),
            "Should generate serializeTagList function",
        )
    }

    @Test
    fun tagListSerializerCallsSerializeTag() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        val fnStart = serde.indexOf("pub fn serializeTagList(")
        assertTrue(fnStart >= 0)
        val fnBody = serde.substring(fnStart, serde.indexOf("\n}\n", fnStart) + 1)
        assertTrue(
            fnBody.contains("try serializeTag(alloc, buf, item)"),
            "List serializer should call element serializer for struct elements",
        )
    }

    // ---- Empty struct serializer ----

    @Test
    fun emptyStructSerializerSuppressesParams() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        val fnStart = serde.indexOf("pub fn serializeMarker(")
        assertTrue(fnStart >= 0, "Should generate serializeMarker")
        val fnBody = serde.substring(fnStart, serde.indexOf("\n}\n", fnStart) + 1)
        assertTrue(fnBody.contains("_ = alloc;"), "Empty struct serializer should suppress alloc")
        assertTrue(fnBody.contains("_ = buf;"), "Empty struct serializer should suppress buf")
        assertTrue(fnBody.contains("_ = value;"), "Empty struct serializer should suppress value")
    }

    // ---- appendXmlEscaped helper ----

    @Test
    fun appendXmlEscapedHelperGenerated() {
        val files = generateFiles()
        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("fn appendXmlEscaped(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {"),
            "Should generate appendXmlEscaped helper",
        )
    }

    // ---- @xmlFlattened handling ----

    @Test
    fun xmlFlattenedListSerializerNoWrapper() {
        // Build a model with a @xmlFlattened list member
        val model = Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#Item")
                    .addMember("Name", ShapeId.from("smithy.api#String"))
                    .build()
            )
            .addShape(
                ListShape.builder()
                    .id("test#ItemList")
                    .member(ShapeId.from("test#Item"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#Container")
                    .addMember(
                        "Items",
                        ShapeId.from("test#ItemList"),
                        { it.addTrait(XmlFlattenedTrait()) },
                    )
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutItemsInput")
                    .addMember("Container", ShapeId.from("test#Container"))
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#PutItemsOutput")
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#PutItems")
                    .input(ShapeId.from("test#PutItemsInput"))
                    .output(ShapeId.from("test#PutItemsOutput"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2024-01-01")
                    .addOperation(ShapeId.from("test#PutItems"))
                    .build()
            )
            .assemble()
            .unwrap()

        val settings = ZigSettings(
            ShapeId.from("test#TestService"),
            "testservice",
            ".",
        )
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val service = model.expectShape(settings.service, ServiceShape::class.java)
        val context = ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )

        ServiceGenerator(context, service, model, AwsQueryProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }

        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("pub fn serializeContainer("),
            "Should generate serializeContainer",
        )

        // Flattened list should NOT have wrapper element, and Items is optional -> v
        assertTrue(
            serde.contains("serializeItemList(alloc, buf, v, \"Items\")"),
            "Flattened list should use member name as item tag directly",
        )
    }

    // ---- @xmlName trait ----

    @Test
    fun xmlNameTraitOverridesElementName() {
        // Build a model where a member has @xmlName
        val model = Model.assembler()
            .addShape(
                StructureShape.builder()
                    .id("test#Item")
                    .addMember(
                        "DisplayName",
                        ShapeId.from("smithy.api#String"),
                        { it.addTrait(XmlNameTrait("display-name")) },
                    )
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemInput")
                    .build()
            )
            .addShape(
                StructureShape.builder()
                    .id("test#GetItemOutput")
                    .addMember("Item", ShapeId.from("test#Item"))
                    .build()
            )
            .addShape(
                OperationShape.builder()
                    .id("test#GetItem")
                    .input(ShapeId.from("test#GetItemInput"))
                    .output(ShapeId.from("test#GetItemOutput"))
                    .build()
            )
            .addShape(
                ServiceShape.builder()
                    .id("test#TestService")
                    .version("2024-01-01")
                    .addOperation(ShapeId.from("test#GetItem"))
                    .build()
            )
            .assemble()
            .unwrap()

        val settings = ZigSettings(
            ShapeId.from("test#TestService"),
            "testservice",
            ".",
        )
        val symbolProvider = ZigSymbolVisitor(model, settings.packageName)
        val fileManifest = FileManifest.create(tempDir)
        val delegator = WriterDelegator(fileManifest, symbolProvider, ZigWriter.factory())
        val service = model.expectShape(settings.service, ServiceShape::class.java)
        val context = ZigContext(
            model = model,
            settings = settings,
            symbolProvider = symbolProvider,
            fileManifest = fileManifest,
            writerDelegator = delegator,
            integrations = listOf(),
            service = service,
        )

        ServiceGenerator(context, service, model, AwsQueryProtocol()).run()
        context.writerDelegator().flushWriters()

        val files = mutableMapOf<String, String>()
        for (file in context.fileManifest().files) {
            files[file.fileName.toString()] = file.toFile().readText()
        }

        val serde = files["serde.zig"]!!
        assertTrue(
            serde.contains("\"display-name\""),
            "Should use @xmlName trait value instead of member name",
        )
        assertFalse(
            serde.contains("\"DisplayName\""),
            "Should NOT use original member name when @xmlName is present",
        )
    }
}
