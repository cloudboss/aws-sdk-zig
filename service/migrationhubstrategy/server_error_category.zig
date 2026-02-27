pub const ServerErrorCategory = enum {
    connectivity_error,
    credential_error,
    permission_error,
    architecture_error,
    other_error,

    pub const json_field_names = .{
        .connectivity_error = "CONNECTIVITY_ERROR",
        .credential_error = "CREDENTIAL_ERROR",
        .permission_error = "PERMISSION_ERROR",
        .architecture_error = "ARCHITECTURE_ERROR",
        .other_error = "OTHER_ERROR",
    };
};
