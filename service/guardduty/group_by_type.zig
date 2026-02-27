pub const GroupByType = enum {
    account,
    date,
    finding_type,
    resource,
    severity,

    pub const json_field_names = .{
        .account = "ACCOUNT",
        .date = "DATE",
        .finding_type = "FINDING_TYPE",
        .resource = "RESOURCE",
        .severity = "SEVERITY",
    };
};
