/// Information about an enabled security standard in which a security control
/// is enabled.
pub const AssociatedStandard = struct {
    /// The unique identifier of a standard in which a control is enabled. This
    /// field consists of the resource portion of the
    /// Amazon Resource Name (ARN) returned for a standard in the
    /// [DescribeStandards](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_DescribeStandards.html) API response.
    standards_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .standards_id = "StandardsId",
    };
};
