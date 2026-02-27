pub const ScanResultStatus = enum {
    no_threats_found,
    threats_found,

    pub const json_field_names = .{
        .no_threats_found = "NO_THREATS_FOUND",
        .threats_found = "THREATS_FOUND",
    };
};
