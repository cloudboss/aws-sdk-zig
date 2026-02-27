pub const Ec2InstanceSortBy = enum {
    network_findings,
    critical,
    high,
    all,

    pub const json_field_names = .{
        .network_findings = "NETWORK_FINDINGS",
        .critical = "CRITICAL",
        .high = "HIGH",
        .all = "ALL",
    };
};
