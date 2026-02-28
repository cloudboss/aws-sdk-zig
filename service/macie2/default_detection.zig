const Occurrences = @import("occurrences.zig").Occurrences;

/// Provides information about a type of sensitive data that was detected by a
/// managed data identifier and produced a sensitive data finding.
pub const DefaultDetection = struct {
    /// The total number of occurrences of the type of sensitive data that was
    /// detected.
    count: ?i64,

    /// The location of 1-15 occurrences of the sensitive data that was detected. A
    /// finding includes location data for a maximum of 15 occurrences of sensitive
    /// data.
    occurrences: ?Occurrences,

    /// The type of sensitive data that was detected. For example, AWS_CREDENTIALS,
    /// PHONE_NUMBER, or ADDRESS.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .count = "count",
        .occurrences = "occurrences",
        .@"type" = "type",
    };
};
