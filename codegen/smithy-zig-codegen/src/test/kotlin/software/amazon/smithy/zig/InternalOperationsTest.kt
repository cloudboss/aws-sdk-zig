package software.amazon.smithy.zig

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertFalse
import org.junit.jupiter.api.Test
import software.amazon.smithy.model.Model
import software.amazon.smithy.model.shapes.ShapeId

class InternalOperationsTest {
    @Test
    fun excludesInternalOperationsAndRetainsPublicOperations() {
        val model = Model.assembler()
            .addUnparsedModel(
                "internal.smithy",
                """
                ${'$'}version: "2.0"
                namespace test

                @internal
                operation InternalTrait {}

                @documentation("<p>This is for internal use. Amplify uses this action.</p>")
                operation InternalDocumentation {}

                @documentation("This API is experimental and for internal AWS use only.")
                operation InternalAws {}

                @documentation("This API is not yet available to external customers.")
                operation Unavailable {}

                @documentation("The type field is reserved for internal use only.")
                operation PublicField {}

                @documentation("The service reserves some IP addresses for internal use.")
                operation PublicAddresses {}

                @documentation("Customers can access databases and internal APIs.")
                operation PublicNetwork {}

                service TestService {
                    version: "1"
                    operations: [InternalTrait, InternalDocumentation, PublicField]
                    resources: [TestResource]
                }

                resource TestResource {
                    operations: [InternalAws, Unavailable, PublicAddresses, PublicNetwork]
                }
                """.trimIndent(),
            )
            .assemble()
            .unwrap()

        val filtered = removeInternalOperations(model)
        assertEquals(
            setOf("test#PublicField", "test#PublicAddresses", "test#PublicNetwork"),
            filtered.operationShapes.map { it.id.toString() }.toSet(),
        )
        assertEquals(
            listOf(ShapeId.from("test#PublicField")),
            filtered.expectShape(ShapeId.from("test#TestService")).asServiceShape().get()
                .operations.toList(),
        )
        assertEquals(
            setOf(ShapeId.from("test#PublicAddresses"), ShapeId.from("test#PublicNetwork")),
            filtered.expectShape(ShapeId.from("test#TestResource")).asResourceShape().get()
                .operations,
        )
        assertFalse(Model.assembler().addModel(filtered).assemble().isBroken)
    }
}
