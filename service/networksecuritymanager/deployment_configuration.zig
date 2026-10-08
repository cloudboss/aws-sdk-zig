/// Configuration settings that control a deployment's behavior.
pub const DeploymentConfiguration = struct {
    /// Specifies whether aggregate synchronization status details for the resources
    /// covered by this deployment are visible across accounts. Default: `false`.
    enable_cross_account_visibility: bool = false,

    pub const json_field_names = .{
        .enable_cross_account_visibility = "enableCrossAccountVisibility",
    };
};
