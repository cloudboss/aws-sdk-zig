const Invitation = @import("invitation.zig").Invitation;

pub const ListInvitationsResponse = struct {
    /// An array of objects, one for each invitation that was received by the
    /// account.
    invitations: ?[]const Invitation,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .invitations = "invitations",
        .next_token = "nextToken",
    };
};
