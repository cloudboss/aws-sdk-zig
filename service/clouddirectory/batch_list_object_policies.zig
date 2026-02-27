const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Returns policies attached to an object in pagination fashion inside a
/// BatchRead operation. For more information, see ListObjectPolicies and
/// BatchReadRequest$Operations.
pub const BatchListObjectPolicies = struct {
    /// The maximum number of results to retrieve.
    max_results: ?i32,

    /// The pagination token.
    next_token: ?[]const u8,

    /// The reference that identifies the object whose attributes will be listed.
    object_reference: ObjectReference,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .object_reference = "ObjectReference",
    };
};
