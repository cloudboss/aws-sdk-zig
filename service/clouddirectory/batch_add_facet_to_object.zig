const AttributeKeyAndValue = @import("attribute_key_and_value.zig").AttributeKeyAndValue;
const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

/// Represents the output of a batch add facet to object operation.
pub const BatchAddFacetToObject = struct {
    /// The attributes to set on the object.
    object_attribute_list: []const AttributeKeyAndValue,

    /// A reference to the object being mutated.
    object_reference: ObjectReference,

    /// Represents the facet being added to the object.
    schema_facet: SchemaFacet,

    pub const json_field_names = .{
        .object_attribute_list = "ObjectAttributeList",
        .object_reference = "ObjectReference",
        .schema_facet = "SchemaFacet",
    };
};
