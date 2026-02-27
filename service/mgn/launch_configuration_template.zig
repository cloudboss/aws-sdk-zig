const aws = @import("aws");

const BootMode = @import("boot_mode.zig").BootMode;
const LaunchTemplateDiskConf = @import("launch_template_disk_conf.zig").LaunchTemplateDiskConf;
const LaunchDisposition = @import("launch_disposition.zig").LaunchDisposition;
const Licensing = @import("licensing.zig").Licensing;
const PostLaunchActions = @import("post_launch_actions.zig").PostLaunchActions;
const TargetInstanceTypeRightSizingMethod = @import("target_instance_type_right_sizing_method.zig").TargetInstanceTypeRightSizingMethod;

pub const LaunchConfigurationTemplate = struct {
    /// ARN of the Launch Configuration Template.
    arn: ?[]const u8,

    /// Associate public Ip address.
    associate_public_ip_address: ?bool,

    /// Launch configuration template boot mode.
    boot_mode: ?BootMode,

    /// Copy private Ip.
    copy_private_ip: ?bool,

    /// Copy tags.
    copy_tags: ?bool,

    /// EC2 launch template ID.
    ec_2_launch_template_id: ?[]const u8,

    /// Enable map auto tagging.
    enable_map_auto_tagging: ?bool,

    /// Enable parameters encryption.
    enable_parameters_encryption: ?bool,

    /// Large volume config.
    large_volume_conf: ?LaunchTemplateDiskConf,

    /// ID of the Launch Configuration Template.
    launch_configuration_template_id: []const u8,

    /// Launch disposition.
    launch_disposition: ?LaunchDisposition,

    licensing: ?Licensing,

    /// Launch configuration template map auto tagging MPE ID.
    map_auto_tagging_mpe_id: ?[]const u8,

    /// Parameters encryption key.
    parameters_encryption_key: ?[]const u8,

    /// Post Launch Actions of the Launch Configuration Template.
    post_launch_actions: ?PostLaunchActions,

    /// Small volume config.
    small_volume_conf: ?LaunchTemplateDiskConf,

    /// Small volume maximum size.
    small_volume_max_size: i64 = 0,

    /// Tags of the Launch Configuration Template.
    tags: ?[]const aws.map.StringMapEntry,

    /// Target instance type right-sizing method.
    target_instance_type_right_sizing_method: ?TargetInstanceTypeRightSizingMethod,

    pub const json_field_names = .{
        .arn = "arn",
        .associate_public_ip_address = "associatePublicIpAddress",
        .boot_mode = "bootMode",
        .copy_private_ip = "copyPrivateIp",
        .copy_tags = "copyTags",
        .ec_2_launch_template_id = "ec2LaunchTemplateID",
        .enable_map_auto_tagging = "enableMapAutoTagging",
        .enable_parameters_encryption = "enableParametersEncryption",
        .large_volume_conf = "largeVolumeConf",
        .launch_configuration_template_id = "launchConfigurationTemplateID",
        .launch_disposition = "launchDisposition",
        .licensing = "licensing",
        .map_auto_tagging_mpe_id = "mapAutoTaggingMpeID",
        .parameters_encryption_key = "parametersEncryptionKey",
        .post_launch_actions = "postLaunchActions",
        .small_volume_conf = "smallVolumeConf",
        .small_volume_max_size = "smallVolumeMaxSize",
        .tags = "tags",
        .target_instance_type_right_sizing_method = "targetInstanceTypeRightSizingMethod",
    };
};
