const SubstituteStringEntry = @import("substitute_string_entry.zig").SubstituteStringEntry;

/// This processor matches a key’s value against a regular expression and
/// replaces all matches
/// with a replacement string.
///
/// For more information about this processor including examples, see [
/// substituteString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-substituteString) in the *CloudWatch Logs User Guide*.
pub const SubstituteString = struct {
    /// An array of objects, where each object contains the information about one
    /// key to match and
    /// replace.
    entries: []const SubstituteStringEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
