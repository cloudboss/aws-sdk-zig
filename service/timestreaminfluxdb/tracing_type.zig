pub const TracingType = enum {
    log,
    jaeger,
    disabled,

    pub const json_field_names = .{
        .log = "LOG",
        .jaeger = "JAEGER",
        .disabled = "DISABLED",
    };
};
