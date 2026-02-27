pub const AppUnitErrorCategory = enum {
    credential_error,
    connectivity_error,
    permission_error,
    unsupported_error,
    other_error,

    pub const json_field_names = .{
        .credential_error = "CREDENTIAL_ERROR",
        .connectivity_error = "CONNECTIVITY_ERROR",
        .permission_error = "PERMISSION_ERROR",
        .unsupported_error = "UNSUPPORTED_ERROR",
        .other_error = "OTHER_ERROR",
    };
};
