/// Provides metadata for the Amazon CodeGuru detector associated with a
/// finding. This field pertains to
/// findings that relate to Lambda functions. Amazon Inspector identifies policy
/// violations and
/// vulnerabilities in Lambda function code based on internal detectors
/// developed
/// in collaboration with Amazon CodeGuru. Security Hub CSPM receives those
/// findings.
pub const GeneratorDetails = struct {
    /// The description of the detector used to identify the code vulnerability.
    description: ?[]const u8 = null,

    /// An array of tags used to identify the detector associated with the finding.
    ///
    /// Array Members: Minimum number of 0 items. Maximum number of 10 items.
    labels: ?[]const []const u8 = null,

    /// The name of the detector used to identify the code vulnerability.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .labels = "Labels",
        .name = "Name",
    };
};
