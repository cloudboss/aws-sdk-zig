const AwsEc2LaunchTemplateDataDetails = @import("aws_ec_2_launch_template_data_details.zig").AwsEc2LaunchTemplateDataDetails;

/// Specifies the properties for creating an Amazon Elastic Compute Cloud
/// (Amazon EC2) launch template.
pub const AwsEc2LaunchTemplateDetails = struct {
    /// The default version of the launch template.
    default_version_number: ?i64 = null,

    /// An ID for the launch template.
    id: ?[]const u8 = null,

    /// The latest version of the launch template.
    latest_version_number: ?i64 = null,

    /// The information to include in the launch template.
    launch_template_data: ?AwsEc2LaunchTemplateDataDetails = null,

    /// A name for the launch template.
    launch_template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_version_number = "DefaultVersionNumber",
        .id = "Id",
        .latest_version_number = "LatestVersionNumber",
        .launch_template_data = "LaunchTemplateData",
        .launch_template_name = "LaunchTemplateName",
    };
};
