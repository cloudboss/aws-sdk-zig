pub const AggregationFindingType = enum {
    network_reachability,
    package_vulnerability,
    code_vulnerability,

    pub const json_field_names = .{
        .network_reachability = "NETWORK_REACHABILITY",
        .package_vulnerability = "PACKAGE_VULNERABILITY",
        .code_vulnerability = "CODE_VULNERABILITY",
    };
};
