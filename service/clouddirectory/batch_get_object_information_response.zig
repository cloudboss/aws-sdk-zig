const SchemaFacet = @import("schema_facet.zig").SchemaFacet;

/// Represents the output of a GetObjectInformation response operation.
pub const BatchGetObjectInformationResponse = struct {
    /// The `ObjectIdentifier` of the specified object.
    object_identifier: ?[]const u8 = null,

    /// The facets attached to the specified object.
    schema_facets: ?[]const SchemaFacet = null,

    pub const json_field_names = .{
        .object_identifier = "ObjectIdentifier",
        .schema_facets = "SchemaFacets",
    };
};
