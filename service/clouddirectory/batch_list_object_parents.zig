const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Lists parent objects that are associated with a given object in pagination
/// fashion.
pub const BatchListObjectParents = struct {
    /// The maximum number of items to be retrieved in a single call. This is an
    /// approximate
    /// number.
    max_results: ?i32 = null,

    /// The pagination token.
    next_token: ?[]const u8 = null,

    object_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
