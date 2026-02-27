const ObjectReference = @import("object_reference.zig").ObjectReference;
const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

/// Retrieves attributes within a facet that are associated with an object
/// inside an BatchRead operation. For more information, see GetObjectAttributes
/// and BatchReadRequest$Operations.
pub const BatchGetObjectAttributes = struct {
    /// List of attribute names whose values will be retrieved.
    attribute_names: []const []const u8,

    /// Reference that identifies the object whose attributes will be retrieved.
    object_reference: ObjectReference,

    /// Identifier for the facet whose attributes will be retrieved. See SchemaFacet
    /// for details.
    schema_facet: SchemaFacet,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .object_reference = "ObjectReference",
        .schema_facet = "SchemaFacet",
    };
};
