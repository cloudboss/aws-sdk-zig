/// The `AmpConfiguration` structure defines the Amazon Managed Service for
/// Prometheus instance a scraper should send metrics to.
pub const AmpConfiguration = struct {
    /// ARN of the Amazon Managed Service for Prometheus workspace.
    workspace_arn: []const u8,

    pub const json_field_names = .{
        .workspace_arn = "workspaceArn",
    };
};
