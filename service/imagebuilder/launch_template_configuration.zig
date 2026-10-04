/// Identifies an Amazon EC2 launch template to use for a specific account.
pub const LaunchTemplateConfiguration = struct {
    /// The account ID that this configuration applies to.
    account_id: ?[]const u8 = null,

    /// Identifies the Amazon EC2 launch template to use.
    launch_template_id: []const u8,

    /// Specifies whether to make the new launch template version that Image Builder
    /// creates
    /// the default version of the launch template. If you don't set a value,
    /// Image Builder treats it as `true`.
    set_default_version: bool = false,

    pub const json_field_names = .{
        .account_id = "accountId",
        .launch_template_id = "launchTemplateId",
        .set_default_version = "setDefaultVersion",
    };
};
