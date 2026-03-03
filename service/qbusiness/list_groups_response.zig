const GroupSummary = @import("group_summary.zig").GroupSummary;

pub const ListGroupsResponse = struct {
    /// Summary information for list of groups that are mapped to users.
    items: ?[]const GroupSummary = null,

    /// If the response is truncated, Amazon Q Business returns this token that you
    /// can use in the subsequent request to retrieve the next set of groups that
    /// are mapped to users.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};
