/// This processor converts a string field to uppercase.
///
/// For more information about this processor including examples, see [
/// upperCaseString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-upperCaseString) in the *CloudWatch Logs User Guide*.
pub const UpperCaseString = struct {
    /// The array of containing the keys of the field to convert to uppercase.
    with_keys: []const []const u8,

    pub const json_field_names = .{
        .with_keys = "withKeys",
    };
};
