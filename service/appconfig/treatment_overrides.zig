const aws = @import("aws");

/// Treatment assignment overrides that assign specific entity IDs to
/// treatments, bypassing random assignment.
pub const TreatmentOverrides = union(enum) {
    /// A map of entity IDs to treatment keys. Each entry assigns the specified
    /// entity to the specified treatment, bypassing random assignment.
    @"inline": ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .@"inline" = "Inline",
    };
};
