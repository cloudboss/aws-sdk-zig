pub const InvitationType = enum {
    invitation,
    organization,

    pub const json_field_names = .{
        .invitation = "INVITATION",
        .organization = "ORGANIZATION",
    };
};
