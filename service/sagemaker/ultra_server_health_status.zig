pub const UltraServerHealthStatus = enum {
    ok,
    impaired,
    insufficient_data,

    pub const json_field_names = .{
        .ok = "OK",
        .impaired = "IMPAIRED",
        .insufficient_data = "INSUFFICIENT_DATA",
    };
};
