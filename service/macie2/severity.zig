const SeverityDescription = @import("severity_description.zig").SeverityDescription;

/// Provides the numerical and qualitative representations of a finding's
/// severity.
pub const Severity = struct {
    /// The qualitative representation of the finding's severity, ranging from Low
    /// (least severe) to High (most severe).
    description: ?SeverityDescription,

    /// The numerical representation of the finding's severity, ranging from 1
    /// (least severe) to 3 (most severe).
    score: ?i64,

    pub const json_field_names = .{
        .description = "description",
        .score = "score",
    };
};
