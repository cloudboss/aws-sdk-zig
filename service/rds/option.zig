const DBSecurityGroupMembership = @import("db_security_group_membership.zig").DBSecurityGroupMembership;
const OptionSetting = @import("option_setting.zig").OptionSetting;
const VpcSecurityGroupMembership = @import("vpc_security_group_membership.zig").VpcSecurityGroupMembership;

/// The details of an option.
pub const Option = struct {
    /// If the option requires access to a port, then this DB security group allows
    /// access to the port.
    db_security_group_memberships: ?[]const DBSecurityGroupMembership,

    /// The description of the option.
    option_description: ?[]const u8,

    /// The name of the option.
    option_name: ?[]const u8,

    /// The option settings for this option.
    option_settings: ?[]const OptionSetting,

    /// The version of the option.
    option_version: ?[]const u8,

    /// Indicates whether this option is permanent.
    permanent: ?bool,

    /// Indicates whether this option is persistent.
    persistent: ?bool,

    /// If required, the port configured for this option to use.
    port: ?i32,

    /// If the option requires access to a port, then this VPC security group allows
    /// access to the port.
    vpc_security_group_memberships: ?[]const VpcSecurityGroupMembership,
};
