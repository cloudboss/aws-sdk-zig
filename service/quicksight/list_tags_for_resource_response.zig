const Tag = @import("tag.zig").Tag;

pub const ListTagsForResourceResponse = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: i32 = 0,

    /// Contains a map of the key-value pairs for the resource tag or tags assigned
    /// to the
    /// resource.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
        .tags = "Tags",
    };
};
