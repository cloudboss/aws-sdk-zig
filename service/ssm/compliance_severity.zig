pub const ComplianceSeverity = enum {
    critical,
    high,
    medium,
    low,
    informational,
    unspecified,

    pub const json_field_names = .{
        .critical = "Critical",
        .high = "High",
        .medium = "Medium",
        .low = "Low",
        .informational = "Informational",
        .unspecified = "Unspecified",
    };
};
