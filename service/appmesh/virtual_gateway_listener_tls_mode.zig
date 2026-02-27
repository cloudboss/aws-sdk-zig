pub const VirtualGatewayListenerTlsMode = enum {
    strict,
    permissive,
    disabled,

    pub const json_field_names = .{
        .strict = "STRICT",
        .permissive = "PERMISSIVE",
        .disabled = "DISABLED",
    };
};
