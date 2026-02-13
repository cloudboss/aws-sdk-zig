pub const AssociationComplianceSeverity = enum {
    critical,
    high,
    medium,
    low,
    unspecified,

    pub const json_field_names = .{
        .critical = "Critical",
        .high = "High",
        .medium = "Medium",
        .low = "Low",
        .unspecified = "Unspecified",
    };
};
