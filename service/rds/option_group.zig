const Option = @import("option.zig").Option;

pub const OptionGroup = struct {
    /// Indicates whether this option group can be applied to both VPC and non-VPC
    /// instances. The value `true` indicates the option group can be applied to
    /// both VPC and non-VPC instances.
    allows_vpc_and_non_vpc_instance_memberships: ?bool,

    /// Indicates when the option group was copied.
    copy_timestamp: ?i64,

    /// Indicates the name of the engine that this option group can be applied to.
    engine_name: ?[]const u8,

    /// Indicates the major engine version associated with this option group.
    major_engine_version: ?[]const u8,

    /// Specifies the Amazon Resource Name (ARN) for the option group.
    option_group_arn: ?[]const u8,

    /// Provides a description of the option group.
    option_group_description: ?[]const u8,

    /// Specifies the name of the option group.
    option_group_name: ?[]const u8,

    /// Indicates what options are available in the option group.
    options: ?[]const Option,

    /// Specifies the Amazon Web Services account ID for the option group from which
    /// this option group is copied.
    source_account_id: ?[]const u8,

    /// Specifies the name of the option group from which this option group is
    /// copied.
    source_option_group: ?[]const u8,

    /// If **AllowsVpcAndNonVpcInstanceMemberships** is `false`, this field is
    /// blank. If **AllowsVpcAndNonVpcInstanceMemberships** is `true` and this field
    /// is blank, then this option group can be applied to both VPC and non-VPC
    /// instances. If this field contains a value, then this option group can only
    /// be applied to instances that are in the VPC indicated by this field.
    vpc_id: ?[]const u8,
};
