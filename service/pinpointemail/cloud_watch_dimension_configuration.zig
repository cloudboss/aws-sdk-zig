const DimensionValueSource = @import("dimension_value_source.zig").DimensionValueSource;

/// An object that defines the dimension configuration to use when you send
/// Amazon Pinpoint email
/// events to Amazon CloudWatch.
pub const CloudWatchDimensionConfiguration = struct {
    /// The default value of the dimension that is published to Amazon CloudWatch if
    /// you don't provide the
    /// value of the dimension when you send an email. This value has to meet the
    /// following
    /// criteria:
    ///
    /// * It can only contain ASCII letters (a-z, A-Z), numbers (0-9), underscores
    ///   (_),
    /// or dashes (-).
    ///
    /// * It can contain no more than 256 characters.
    default_dimension_value: []const u8,

    /// The name of an Amazon CloudWatch dimension associated with an email sending
    /// metric. The name has to
    /// meet the following criteria:
    ///
    /// * It can only contain ASCII letters (a-z, A-Z), numbers (0-9), underscores
    ///   (_),
    /// or dashes (-).
    ///
    /// * It can contain no more than 256 characters.
    dimension_name: []const u8,

    /// The location where Amazon Pinpoint finds the value of a dimension to publish
    /// to Amazon CloudWatch. If you
    /// want Amazon Pinpoint to use the message tags that you specify using an
    /// X-SES-MESSAGE-TAGS header
    /// or a parameter to the SendEmail/SendRawEmail API, choose `messageTag`. If
    /// you
    /// want Amazon Pinpoint to use your own email headers, choose `emailHeader`. If
    /// you want
    /// Amazon Pinpoint to use link tags, choose `linkTags`.
    dimension_value_source: DimensionValueSource,

    pub const json_field_names = .{
        .default_dimension_value = "DefaultDimensionValue",
        .dimension_name = "DimensionName",
        .dimension_value_source = "DimensionValueSource",
    };
};
