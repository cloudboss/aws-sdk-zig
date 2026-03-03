/// A comprehensive distribution of security findings by severity level for
/// Amazon Web Services resources.
pub const ResourceSeverityBreakdown = struct {
    /// The number of findings with a severity level of critical.
    critical: ?i32 = null,

    /// The number of findings with a severity level of fatal.
    fatal: ?i32 = null,

    /// The number of findings with a severity level of high.
    high: ?i32 = null,

    /// The number of findings that provide security-related information.
    informational: ?i32 = null,

    /// The number of findings with a severity level of low.
    low: ?i32 = null,

    /// The number of findings with a severity level of medium.
    medium: ?i32 = null,

    /// The number of findings not in any of the severity categories.
    other: ?i32 = null,

    /// The number of findings with a severity level cannot be determined.
    unknown: ?i32 = null,

    pub const json_field_names = .{
        .critical = "Critical",
        .fatal = "Fatal",
        .high = "High",
        .informational = "Informational",
        .low = "Low",
        .medium = "Medium",
        .other = "Other",
        .unknown = "Unknown",
    };
};
