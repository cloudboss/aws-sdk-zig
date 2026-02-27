/// Configuration information specifying which hub contents have accessible
/// deployment options.
pub const InferenceHubAccessConfig = struct {
    /// The ARN of the hub content for which deployment access is allowed.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_content_arn = "HubContentArn",
    };
};
