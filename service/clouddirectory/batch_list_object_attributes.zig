const SchemaFacet = @import("schema_facet.zig").SchemaFacet;
const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Represents the output of a ListObjectAttributes operation.
pub const BatchListObjectAttributes = struct {
    /// Used to filter the list of object attributes that are associated with a
    /// certain
    /// facet.
    facet_filter: ?SchemaFacet = null,

    /// The maximum number of items to be retrieved in a single call. This is an
    /// approximate
    /// number.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    /// Reference of the object whose attributes need to be listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .facet_filter = "FacetFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
