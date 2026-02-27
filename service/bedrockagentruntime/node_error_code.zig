pub const NodeErrorCode = enum {
    validation,
    dependency_failed,
    bad_gateway,
    internal_server,

    pub const json_field_names = .{
        .validation = "VALIDATION",
        .dependency_failed = "DEPENDENCY_FAILED",
        .bad_gateway = "BAD_GATEWAY",
        .internal_server = "INTERNAL_SERVER",
    };
};
