const SettingName = @import("setting_name.zig").SettingName;
const SettingType = @import("setting_type.zig").SettingType;

/// The current account setting for a resource.
pub const Setting = struct {
    /// The Amazon ECS resource name.
    name: ?SettingName,

    /// The ARN of the principal. It can be a user, role, or the root user. If this
    /// field is
    /// omitted, the authenticated user is assumed.
    principal_arn: ?[]const u8,

    /// Indicates whether Amazon Web Services manages the account setting, or if the
    /// user manages
    /// it.
    ///
    /// `aws_managed` account settings are read-only, as Amazon Web Services manages
    /// such
    /// on the customer's behalf. Currently, the `guardDutyActivate` account setting
    /// is the only one Amazon
    /// Web Services manages.
    type: ?SettingType,

    /// Determines whether the account setting is on or off for the specified
    /// resource.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .principal_arn = "principalArn",
        .type = "type",
        .value = "value",
    };
};
