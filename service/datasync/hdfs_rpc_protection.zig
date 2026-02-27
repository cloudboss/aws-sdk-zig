pub const HdfsRpcProtection = enum {
    disabled,
    authentication,
    integrity,
    privacy,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .authentication = "AUTHENTICATION",
        .integrity = "INTEGRITY",
        .privacy = "PRIVACY",
    };
};
