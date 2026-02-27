const DeploymentSummary = @import("deployment_summary.zig").DeploymentSummary;

pub const ListDeploymentsResponse = struct {
    /// The list of deployments that is returned.
    deployments: []const DeploymentSummary,

    /// If there are more items to return, this contains a token
    /// that is passed to a subsequent call to this operation to retrieve the next
    /// set of items.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .deployments = "deployments",
        .next_token = "nextToken",
    };
};
