/// Settings configured for Quick Setup.
pub const ServiceSettings = struct {
    /// The IAM role used to enable Explorer.
    explorer_enabling_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .explorer_enabling_role_arn = "ExplorerEnablingRoleArn",
    };
};
