const aws = @import("aws");

const Severity = @import("severity.zig").Severity;

/// A structure that contains the result of an automated audit analysis,
/// including the auditor name, description of findings, additional data, and
/// severity level.
pub const AuditorResult = struct {
    /// The name of the auditor algorithm that generated this result.
    auditor: ?[]const u8,

    /// This is a string-to-string map. It contains additional data about the result
    /// of an automated audit analysis.
    data: ?[]const aws.map.StringMapEntry,

    /// A detailed description of the audit finding, explaining what was observed
    /// and potential implications.
    description: ?[]const u8,

    /// The severity level of this audit finding, indicating the importance and
    /// potential impact of the issue.
    severity: ?Severity,

    pub const json_field_names = .{
        .auditor = "Auditor",
        .data = "Data",
        .description = "Description",
        .severity = "Severity",
    };
};
