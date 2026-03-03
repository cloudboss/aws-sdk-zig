/// Identifies an Amazon EC2 launch template to use for a specific account.
pub const LaunchTemplateConfiguration = struct {
    /// The account ID that this configuration applies to.
    account_id: ?[]const u8 = null,

    /// Identifies the Amazon EC2 launch template to use.
    launch_template_id: []const u8,

    /// Set the specified Amazon EC2 launch template as the default launch template
    /// for the
    /// specified account.
    set_default_version: bool = false,

    pub const json_field_names = .{
        .account_id = "accountId",
        .launch_template_id = "launchTemplateId",
        .set_default_version = "setDefaultVersion",
    };
};
