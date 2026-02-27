pub const ScanResult = enum {
    clean,
    infected,

    pub const json_field_names = .{
        .clean = "CLEAN",
        .infected = "INFECTED",
    };
};
