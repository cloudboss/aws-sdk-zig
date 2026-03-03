/// This processor converts a datetime string into a format that you specify.
///
/// For more information about this processor including examples, see [
/// datetimeConverter](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CloudWatch-Logs-Transformation.html#CloudWatch-Logs-Transformation-datetimeConverter) in the *CloudWatch Logs User
/// Guide*.
pub const DateTimeConverter = struct {
    /// The locale of the source field. If you omit this, the default of
    /// `locale.ROOT`
    /// is used.
    locale: ?[]const u8 = null,

    /// A list of patterns to match against the `source` field.
    match_patterns: []const []const u8,

    /// The key to apply the date conversion to.
    source: []const u8,

    /// The time zone of the source field. If you omit this, the default used is the
    /// UTC
    /// zone.
    source_timezone: ?[]const u8 = null,

    /// The JSON field to store the result in.
    target: []const u8,

    /// The datetime format to use for the converted data in the target field.
    ///
    /// If you omit this, the default of ` yyyy-MM-dd'T'HH:mm:ss.SSS'Z` is used.
    target_format: ?[]const u8 = null,

    /// The time zone of the target field. If you omit this, the default used is the
    /// UTC
    /// zone.
    target_timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .locale = "locale",
        .match_patterns = "matchPatterns",
        .source = "source",
        .source_timezone = "sourceTimezone",
        .target = "target",
        .target_format = "targetFormat",
        .target_timezone = "targetTimezone",
    };
};
