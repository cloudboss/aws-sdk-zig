const Occurrences = @import("occurrences.zig").Occurrences;

/// The list of detected instances of sensitive data.
pub const SensitiveDataDetections = struct {
    /// The total number of occurrences of sensitive data that were detected.
    count: ?i64,

    /// Details about the sensitive data that was detected.
    occurrences: ?Occurrences,

    /// The type of sensitive data that was detected. For example, the type might
    /// indicate that the data is an email address.
    type: ?[]const u8,

    pub const json_field_names = .{
        .count = "Count",
        .occurrences = "Occurrences",
        .type = "Type",
    };
};
