const DimensionValueSource = @import("dimension_value_source.zig").DimensionValueSource;

/// Contains the dimension configuration to use when you publish email sending
/// events to
/// Amazon CloudWatch.
///
/// For information about publishing email sending events to Amazon CloudWatch,
/// see the [Amazon SES
/// Developer
/// Guide](https://docs.aws.amazon.com/ses/latest/dg/monitor-sending-activity.html).
pub const CloudWatchDimensionConfiguration = struct {
    /// The default value of the dimension that is published to Amazon CloudWatch if
    /// you do not provide
    /// the value of the dimension when you send an email. The default value must
    /// meet the
    /// following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_),
    ///   dashes
    /// (-), at signs (@), or periods (.).
    ///
    /// * Contain 256 characters or fewer.
    default_dimension_value: []const u8,

    /// The name of an Amazon CloudWatch dimension associated with an email sending
    /// metric. The name
    /// must meet the following requirements:
    ///
    /// * Contain only ASCII letters (a-z, A-Z), numbers (0-9), underscores (_),
    ///   dashes
    /// (-), or colons (:).
    ///
    /// * Contain 256 characters or fewer.
    dimension_name: []const u8,

    /// The place where Amazon SES finds the value of a dimension to publish to
    /// Amazon CloudWatch. To use
    /// the message tags that you specify using an `X-SES-MESSAGE-TAGS` header or a
    /// parameter to the `SendEmail`/`SendRawEmail` API, specify
    /// `messageTag`. To use your own email headers, specify
    /// `emailHeader`. To put a custom tag on any link included in your email,
    /// specify `linkTag`.
    dimension_value_source: DimensionValueSource,
};
