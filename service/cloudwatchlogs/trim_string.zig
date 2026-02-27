/// Use this processor to remove leading and trailing whitespace.
///
/// For more information about this processor including examples, see [
/// trimString](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-trimString) in the *CloudWatch Logs User Guide*.
pub const TrimString = struct {
    /// The array containing the keys of the fields to trim.
    with_keys: []const []const u8,

    pub const json_field_names = .{
        .with_keys = "withKeys",
    };
};
