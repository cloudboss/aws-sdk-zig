pub const AuthorizationStatus = enum {
    authorized,
    not_authorized,

    pub const json_field_names = .{
        .authorized = "AUTHORIZED",
        .not_authorized = "NOT_AUTHORIZED",
    };
};
