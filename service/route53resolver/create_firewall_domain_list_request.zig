const Tag = @import("tag.zig").Tag;

pub const CreateFirewallDomainListRequest = struct {
    /// A unique string that identifies the request and that allows you to retry
    /// failed requests
    /// without the risk of running the operation twice. `CreatorRequestId` can be
    /// any unique string, for example, a date/time stamp.
    creator_request_id: []const u8,

    /// A name that lets you identify the domain list to manage and use it.
    name: []const u8,

    /// A list of the tag keys and values that you want to associate with the domain
    /// list.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .creator_request_id = "CreatorRequestId",
        .name = "Name",
        .tags = "Tags",
    };
};
