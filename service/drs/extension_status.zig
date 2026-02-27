pub const ExtensionStatus = enum {
    extended,
    extension_error,
    not_extended,

    pub const json_field_names = .{
        .extended = "EXTENDED",
        .extension_error = "EXTENSION_ERROR",
        .not_extended = "NOT_EXTENDED",
    };
};
