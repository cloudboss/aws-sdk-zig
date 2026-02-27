const Occurrences = @import("occurrences.zig").Occurrences;

/// Provides information about a custom data identifier that produced a
/// sensitive data finding, and the sensitive data that it detected for the
/// finding.
pub const CustomDetection = struct {
    /// The unique identifier for the custom data identifier.
    arn: ?[]const u8,

    /// The total number of occurrences of the sensitive data that the custom data
    /// identifier detected.
    count: ?i64,

    /// The name of the custom data identifier.
    name: ?[]const u8,

    /// The location of 1-15 occurrences of the sensitive data that the custom data
    /// identifier detected. A finding includes location data for a maximum of 15
    /// occurrences of sensitive data.
    occurrences: ?Occurrences,

    pub const json_field_names = .{
        .arn = "arn",
        .count = "count",
        .name = "name",
        .occurrences = "occurrences",
    };
};
