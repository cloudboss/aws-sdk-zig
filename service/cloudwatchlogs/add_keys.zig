const AddKeyEntry = @import("add_key_entry.zig").AddKeyEntry;

/// This processor adds new key-value pairs to the log event.
///
/// For more information about this processor including examples, see [
/// addKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-addKeys) in the *CloudWatch Logs User Guide*.
pub const AddKeys = struct {
    /// An array of objects, where each object contains the information about one
    /// key to add to
    /// the log event.
    entries: []const AddKeyEntry,

    pub const json_field_names = .{
        .entries = "entries",
    };
};
