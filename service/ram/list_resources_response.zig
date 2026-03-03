const Resource = @import("resource.zig").Resource;

pub const ListResourcesResponse = struct {
    /// If present, this value indicates that more output is available than
    /// is included in the current response. Use this value in the `NextToken`
    /// request parameter in a subsequent call to the operation to get the next part
    /// of the
    /// output. You should repeat this until the `NextToken` response element comes
    /// back as `null`. This indicates that this is the last page of results.
    next_token: ?[]const u8 = null,

    /// An array of objects that contain information about the resources.
    resources: ?[]const Resource = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .resources = "resources",
    };
};
