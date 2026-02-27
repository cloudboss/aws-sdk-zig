pub const RouteSpanGateAttribute = enum {
    emergency,
    key_access,
    permission_required,

    pub const json_field_names = .{
        .emergency = "EMERGENCY",
        .key_access = "KEY_ACCESS",
        .permission_required = "PERMISSION_REQUIRED",
    };
};
