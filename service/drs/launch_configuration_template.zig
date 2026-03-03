const aws = @import("aws");

const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const Licensing = @import("licensing.zig").Licensing;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;

/// Account level Launch Configuration Template.
pub const LaunchConfigurationTemplate = struct {
    /// ARN of the Launch Configuration Template.
    arn: ?[]const u8 = null,

    /// Copy private IP.
    copy_private_ip: ?bool = null,

    /// Copy tags.
    copy_tags: ?bool = null,

    /// S3 bucket ARN to export Source Network templates.
    export_bucket_arn: ?[]const u8 = null,

    /// ID of the Launch Configuration Template.
    launch_configuration_template_id: ?[]const u8 = null,

    /// Launch disposition.
    launch_disposition: ?LaunchDisposition = null,

    /// DRS will set the 'launch into instance ID' of any source server when
    /// performing a drill, recovery or failback to the previous region or
    /// availability zone, using the instance ID of the source instance.
    launch_into_source_instance: ?bool = null,

    /// Licensing.
    licensing: ?Licensing = null,

    /// Post-launch actions activated.
    post_launch_enabled: ?bool = null,

    /// Tags of the Launch Configuration Template.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Target instance type right-sizing method.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod = null,

    pub const json_field_names = .{
        .arn = "arn",
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .export_bucket_arn = "exportBucketArn",
        .launch_configuration_template_id = "launchConfigurationTemplateID",
        .launch_disposition = "launchDisposition",
        .launch_into_source_instance = "launchIntoSourceInstance",
        .licensing = "licensing",
        .post_launch_enabled = "postLaunchEnabled",
        .tags = "tags",
        .target_instance_type_right_sizing_method = "targetInstanceTypeRightSizingMethod",
    };
};
