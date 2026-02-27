const DataIdentifierSeverity = @import("data_identifier_severity.zig").DataIdentifierSeverity;

/// Specifies a severity level for findings that a custom data identifier
/// produces. A severity level determines which severity is assigned to the
/// findings, based on the number of occurrences of text that match the custom
/// data identifier's detection criteria.
pub const SeverityLevel = struct {
    /// The minimum number of occurrences of text that must match the custom data
    /// identifier's detection criteria in order to produce a finding with the
    /// specified severity (severity).
    occurrences_threshold: i64,

    /// The severity to assign to a finding: if the number of occurrences is greater
    /// than or equal to the specified threshold (occurrencesThreshold); and, if
    /// applicable, the number of occurrences is less than the threshold for the
    /// next consecutive severity level for the custom data identifier, moving from
    /// LOW to HIGH.
    severity: DataIdentifierSeverity,

    pub const json_field_names = .{
        .occurrences_threshold = "occurrencesThreshold",
        .severity = "severity",
    };
};
