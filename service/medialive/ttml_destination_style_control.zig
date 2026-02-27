/// Ttml Destination Style Control
pub const TtmlDestinationStyleControl = enum {
    passthrough,
    use_configured,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .use_configured = "USE_CONFIGURED",
    };
};
