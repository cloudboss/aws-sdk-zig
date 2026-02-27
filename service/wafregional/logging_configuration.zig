const FieldToMatch = @import("field_to_match.zig").FieldToMatch;

/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The Amazon Kinesis Data Firehose, `RedactedFields`
/// information, and the web ACL Amazon Resource Name (ARN).
pub const LoggingConfiguration = struct {
    /// An array of Amazon Kinesis Data Firehose ARNs.
    log_destination_configs: []const []const u8,

    /// The parts of the request that you want redacted from the logs. For
    /// example,
    /// if you redact the cookie field, the cookie field in the firehose will be
    /// `xxx`.
    redacted_fields: ?[]const FieldToMatch,

    /// The Amazon Resource Name (ARN) of the web ACL that you want to associate
    /// with
    /// `LogDestinationConfigs`.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .log_destination_configs = "LogDestinationConfigs",
        .redacted_fields = "RedactedFields",
        .resource_arn = "ResourceArn",
    };
};
