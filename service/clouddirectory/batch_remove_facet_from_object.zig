const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

/// A batch operation to remove a facet from an object.
pub const BatchRemoveFacetFromObject = struct {
    /// A reference to the object whose facet will be removed.
    object_reference: ObjectReference,

    /// The facet to remove from the object.
    schema_facet: SchemaFacet,

    pub const json_field_names = .{
        .object_reference = "ObjectReference",
        .schema_facet = "SchemaFacet",
    };
};
