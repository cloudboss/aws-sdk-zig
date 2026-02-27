pub const ScanType = enum {
    network,
    package,
    code,

    pub const json_field_names = .{
        .network = "NETWORK",
        .package = "PACKAGE",
        .code = "CODE",
    };
};
