pub const RDSEstimatedMonthlyVolumeIOPsCostVariation = enum {
    none,
    low,
    medium,
    high,

    pub const json_field_names = .{
        .none = "NONE",
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
    };
};
