const MobileDeviceAccessRuleEffect = @import("mobile_device_access_rule_effect.zig").MobileDeviceAccessRuleEffect;

/// A rule that controls access to mobile devices for an WorkMail group.
pub const MobileDeviceAccessRule = struct {
    /// The date and time at which an access rule was created.
    date_created: ?i64,

    /// The date and time at which an access rule was modified.
    date_modified: ?i64,

    /// The description of a mobile access rule.
    description: ?[]const u8,

    /// Device models that a rule will match.
    device_models: ?[]const []const u8,

    /// Device operating systems that a rule will match.
    device_operating_systems: ?[]const []const u8,

    /// Device types that a rule will match.
    device_types: ?[]const []const u8,

    /// Device user agents that a rule will match.
    device_user_agents: ?[]const []const u8,

    /// The effect of the rule when it matches. Allowed values are `ALLOW` or
    /// `DENY`.
    effect: ?MobileDeviceAccessRuleEffect,

    /// The ID assigned to a mobile access rule.
    mobile_device_access_rule_id: ?[]const u8,

    /// The name of a mobile access rule.
    name: ?[]const u8,

    /// Device models that a rule **will not** match. All other device models will
    /// match.
    not_device_models: ?[]const []const u8,

    /// Device operating systems that a rule **will not** match. All other device
    /// types will match.
    not_device_operating_systems: ?[]const []const u8,

    /// Device types that a rule **will not** match. All other device types will
    /// match.
    not_device_types: ?[]const []const u8,

    /// Device user agents that a rule **will not** match. All other device user
    /// agents will match.
    not_device_user_agents: ?[]const []const u8,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .description = "Description",
        .device_models = "DeviceModels",
        .device_operating_systems = "DeviceOperatingSystems",
        .device_types = "DeviceTypes",
        .device_user_agents = "DeviceUserAgents",
        .effect = "Effect",
        .mobile_device_access_rule_id = "MobileDeviceAccessRuleId",
        .name = "Name",
        .not_device_models = "NotDeviceModels",
        .not_device_operating_systems = "NotDeviceOperatingSystems",
        .not_device_types = "NotDeviceTypes",
        .not_device_user_agents = "NotDeviceUserAgents",
    };
};
