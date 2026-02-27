/// Configuration for network access to the Argo CD capability's managed API
/// server endpoint. When VPC endpoint IDs are specified, public access is
/// blocked and the Argo CD server is only accessible through the specified VPC
/// endpoints.
pub const ArgoCdNetworkAccessConfigRequest = struct {
    /// A list of VPC endpoint IDs to associate with the managed Argo CD API server
    /// endpoint. Each VPC endpoint provides private connectivity from a specific
    /// VPC to the Argo CD server. You can specify multiple VPC endpoint IDs to
    /// enable access from multiple VPCs.
    vpce_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .vpce_ids = "vpceIds",
    };
};
