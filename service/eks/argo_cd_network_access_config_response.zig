/// The response object containing network access configuration for the Argo CD
/// capability's managed API server endpoint. If VPC endpoint IDs are present,
/// public access is blocked and the Argo CD server is only accessible through
/// the specified VPC endpoints.
pub const ArgoCdNetworkAccessConfigResponse = struct {
    /// The list of VPC endpoint IDs associated with the managed Argo CD API server
    /// endpoint. Each VPC endpoint provides private connectivity from a specific
    /// VPC to the Argo CD server.
    vpce_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .vpce_ids = "vpceIds",
    };
};
