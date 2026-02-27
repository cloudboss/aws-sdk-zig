const OptionSetting = @import("option_setting.zig").OptionSetting;

/// A list of all available options for an option group.
pub const OptionConfiguration = struct {
    /// A list of DB security groups used for this option.
    db_security_group_memberships: ?[]const []const u8,

    /// The configuration of options to include in a group.
    option_name: []const u8,

    /// The option settings to include in an option group.
    option_settings: ?[]const OptionSetting,

    /// The version for the option.
    option_version: ?[]const u8,

    /// The optional port for the option.
    port: ?i32,

    /// A list of VPC security group names used for this option.
    vpc_security_group_memberships: ?[]const []const u8,
};
