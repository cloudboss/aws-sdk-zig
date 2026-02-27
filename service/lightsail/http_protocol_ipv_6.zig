pub const HttpProtocolIpv6 = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "disabled",
        .enabled = "enabled",
    };
};
