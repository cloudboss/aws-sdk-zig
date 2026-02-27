pub const DryRunResults = struct {
    /// Specifies the deployment mechanism through which the update shall be applied
    /// on the domain.
    /// Possible responses are
    /// `Blue/Green` (The update will require a blue/green deployment.)
    /// `DynamicUpdate` (The update can be applied in-place without a Blue/Green
    /// deployment required.)
    /// `Undetermined` (The domain is undergoing an update which needs to complete
    /// before the deployment type can be predicted.)
    /// `None` (The configuration change matches the current configuration and will
    /// not result in any update.)
    deployment_type: ?[]const u8,

    /// Contains an optional message associated with the DryRunResults.
    message: ?[]const u8,

    pub const json_field_names = .{
        .deployment_type = "DeploymentType",
        .message = "Message",
    };
};
