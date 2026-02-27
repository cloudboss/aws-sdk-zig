pub const Severity = enum {
    info,
    warning,
    critical,

    pub const json_field_names = .{
        .info = "INFO",
        .warning = "WARNING",
        .critical = "CRITICAL",
    };
};
