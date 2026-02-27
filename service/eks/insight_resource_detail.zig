const InsightStatus = @import("insight_status.zig").InsightStatus;

/// Returns information about the resource being evaluated.
pub const InsightResourceDetail = struct {
    /// The Amazon Resource Name (ARN) if applicable.
    arn: ?[]const u8,

    /// An object containing more detail on the status of the insight resource.
    insight_status: ?InsightStatus,

    /// The Kubernetes resource URI if applicable.
    kubernetes_resource_uri: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .insight_status = "insightStatus",
        .kubernetes_resource_uri = "kubernetesResourceUri",
    };
};
