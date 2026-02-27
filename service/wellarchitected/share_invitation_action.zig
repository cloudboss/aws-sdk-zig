/// Share invitation action taken by contributor.
pub const ShareInvitationAction = enum {
    accept,
    reject,

    pub const json_field_names = .{
        .accept = "ACCEPT",
        .reject = "REJECT",
    };
};
