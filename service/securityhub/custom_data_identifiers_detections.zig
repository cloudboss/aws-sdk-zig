const Occurrences = @import("occurrences.zig").Occurrences;

/// The list of detected instances of sensitive data.
pub const CustomDataIdentifiersDetections = struct {
    /// The ARN of the custom identifier that was used to detect the sensitive data.
    arn: ?[]const u8,

    /// The total number of occurrences of sensitive data that were detected.
    count: ?i64,

    /// he name of the custom identifier that detected the sensitive data.
    name: ?[]const u8,

    /// Details about the sensitive data that was detected.
    occurrences: ?Occurrences,

    pub const json_field_names = .{
        .arn = "Arn",
        .count = "Count",
        .name = "Name",
        .occurrences = "Occurrences",
    };
};
