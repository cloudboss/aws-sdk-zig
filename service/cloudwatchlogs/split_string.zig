const SplitStringEntry = @import("split_string_entry.zig").SplitStringEntry;

/// Use this processor to split a field into an array of strings using a
/// delimiting
/// character.
///
/// For more information about this processor including examples, see [
/// splitString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-splitString) in the *CloudWatch Logs User Guide*.
pub const SplitString = struct {
    /// An array of `SplitStringEntry` objects, where each object contains the
    /// information about one field to split.
    entries: []const SplitStringEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
