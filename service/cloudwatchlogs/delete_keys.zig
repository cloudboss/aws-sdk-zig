/// This processor deletes entries from a log event. These entries are key-value
/// pairs.
///
/// For more information about this processor including examples, see [
/// deleteKeys](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-deleteKeys) in the *CloudWatch Logs User Guide*.
pub const DeleteKeys = struct {
    /// The list of keys to delete.
    with_keys: []const []const u8,

    pub const json_field_names = .{
        .with_keys = "withKeys",
    };
};
