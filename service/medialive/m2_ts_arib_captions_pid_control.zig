/// M2ts Arib Captions Pid Control
pub const M2tsAribCaptionsPidControl = enum {
    auto,
    use_configured,

    pub const json_field_names = .{
        .auto = "AUTO",
        .use_configured = "USE_CONFIGURED",
    };
};
