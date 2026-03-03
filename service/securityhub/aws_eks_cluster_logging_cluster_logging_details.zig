/// Details for a cluster logging configuration.
pub const AwsEksClusterLoggingClusterLoggingDetails = struct {
    /// Whether the logging types that are listed in `Types` are enabled.
    enabled: ?bool = null,

    /// A list of logging types. Valid values are as follows:
    ///
    /// * `api`
    ///
    /// * `audit`
    ///
    /// * `authenticator`
    ///
    /// * `controllerManager`
    ///
    /// * `scheduler`
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .types = "Types",
    };
};
