pub const SignInOrigin = enum {
    identity_center,
    application,

    pub const json_field_names = .{
        .identity_center = "IDENTITY_CENTER",
        .application = "APPLICATION",
    };
};
