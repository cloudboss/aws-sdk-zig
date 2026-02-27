const Member = @import("member.zig").Member;

pub const ListMembersResponse = struct {
    /// An array of objects, one for each account that's associated with the
    /// administrator account and matches the criteria specified in the request.
    members: ?[]const Member,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .members = "members",
        .next_token = "nextToken",
    };
};
