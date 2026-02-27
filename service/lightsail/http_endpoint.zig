pub const HttpEndpoint = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "disabled",
        .enabled = "enabled",
    };
};
