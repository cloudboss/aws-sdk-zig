pub const SigningProfileStatus = enum {
    active,
    canceled,
    revoked,

    pub const json_field_names = .{
        .active = "Active",
        .canceled = "Canceled",
        .revoked = "Revoked",
    };
};
