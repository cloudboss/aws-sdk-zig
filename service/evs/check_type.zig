pub const CheckType = enum {
    key_reuse,
    key_coverage,
    reachability,
    host_count,

    pub const json_field_names = .{
        .key_reuse = "KEY_REUSE",
        .key_coverage = "KEY_COVERAGE",
        .reachability = "REACHABILITY",
        .host_count = "HOST_COUNT",
    };
};
