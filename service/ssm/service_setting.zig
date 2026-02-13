/// The service setting data structure.
///
/// `ServiceSetting` is an account-level setting for an Amazon Web Services
/// service. This setting
/// defines how a user interacts with or uses a service or a feature of a
/// service. For example, if an
/// Amazon Web Services service charges money to the account based on feature or
/// service usage, then the Amazon Web Services
/// service team might create a default setting of "false". This means the user
/// can't use this
/// feature unless they change the setting to "true" and intentionally opt in
/// for a paid
/// feature.
///
/// Services map a `SettingId` object to a setting value. Amazon Web Services
/// services teams define
/// the default value for a `SettingId`. You can't create a new `SettingId`,
/// but you can overwrite the default value if you have the
/// `ssm:UpdateServiceSetting`
/// permission for the setting. Use the UpdateServiceSetting API operation to
/// change the default setting. Or, use the ResetServiceSetting to change the
/// value
/// back to the original value defined by the Amazon Web Services service team.
pub const ServiceSetting = struct {
    /// The ARN of the service setting.
    arn: ?[]const u8,

    /// The last time the service setting was modified.
    last_modified_date: ?i64,

    /// The ARN of the last modified user. This field is populated only if the
    /// setting value was
    /// overwritten.
    last_modified_user: ?[]const u8,

    /// The ID of the service setting.
    setting_id: ?[]const u8,

    /// The value of the service setting.
    setting_value: ?[]const u8,

    /// The status of the service setting. The value can be Default, Customized or
    /// PendingUpdate.
    ///
    /// * Default: The current setting uses a default value provisioned by the
    ///   Amazon Web Services service
    /// team.
    ///
    /// * Customized: The current setting use a custom value specified by the
    ///   customer.
    ///
    /// * PendingUpdate: The current setting uses a default or custom value, but a
    ///   setting change
    /// request is pending approval.
    status: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .last_modified_date = "LastModifiedDate",
        .last_modified_user = "LastModifiedUser",
        .setting_id = "SettingId",
        .setting_value = "SettingValue",
        .status = "Status",
    };
};
