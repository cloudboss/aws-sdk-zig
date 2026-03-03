const MobileDeviceAccessRuleEffect = @import("mobile_device_access_rule_effect.zig").MobileDeviceAccessRuleEffect;

/// The override object.
pub const MobileDeviceAccessOverride = struct {
    /// The date the override was first created.
    date_created: ?i64 = null,

    /// The date the override was last modified.
    date_modified: ?i64 = null,

    /// A description of the override.
    description: ?[]const u8 = null,

    /// The device to which the override applies.
    device_id: ?[]const u8 = null,

    /// The effect of the override, `ALLOW` or `DENY`.
    effect: ?MobileDeviceAccessRuleEffect = null,

    /// The WorkMail user to which the access override applies.
    user_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .description = "Description",
        .device_id = "DeviceId",
        .effect = "Effect",
        .user_id = "UserId",
    };
};
