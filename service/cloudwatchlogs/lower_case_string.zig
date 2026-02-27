/// This processor converts a string to lowercase.
///
/// For more information about this processor including examples, see [
/// lowerCaseString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-lowerCaseString) in the *CloudWatch Logs User Guide*.
pub const LowerCaseString = struct {
    /// The array caontaining the keys of the fields to convert to lowercase.
    with_keys: []const []const u8,

    pub const json_field_names = .{
        .with_keys = "withKeys",
    };
};
