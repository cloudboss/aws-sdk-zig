const ObjectReference = @import("object_reference.zig").ObjectReference;

/// Retrieves all available parent paths for any object type such as node, leaf
/// node, policy node, and index node objects inside a BatchRead operation. For
/// more information, see ListObjectParentPaths and BatchReadRequest$Operations.
pub const BatchListObjectParentPaths = struct {
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
