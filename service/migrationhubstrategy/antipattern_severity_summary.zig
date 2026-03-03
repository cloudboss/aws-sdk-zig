const Severity = @import("severity.zig").Severity;

/// Contains the summary of anti-patterns and their severity.
pub const AntipatternSeveritySummary = struct {
    /// Contains the count of anti-patterns.
    count: ?i32 = null,

    /// Contains the severity of anti-patterns.
    severity: ?Severity = null,

    pub const json_field_names = .{
        .count = "count",
        .severity = "severity",
    };
};
