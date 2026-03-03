const aws = @import("aws");

/// The standard that you want to enable.
pub const StandardsSubscriptionRequest = struct {
    /// The ARN of the standard that you want to enable. To view the list of
    /// available standards
    /// and their ARNs, use the `DescribeStandards` operation.
    standards_arn: []const u8,

    /// A key-value pair of input for the standard.
    standards_input: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .standards_arn = "StandardsArn",
        .standards_input = "StandardsInput",
    };
};
