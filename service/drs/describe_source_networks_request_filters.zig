/// A set of filters by which to return Source Networks.
pub const DescribeSourceNetworksRequestFilters = struct {
    /// Filter Source Networks by account ID containing the protected VPCs.
    origin_account_id: ?[]const u8 = null,

    /// Filter Source Networks by the region containing the protected VPCs.
    origin_region: ?[]const u8 = null,

    /// An array of Source Network IDs that should be returned. An empty array means
    /// all Source Networks.
    source_network_i_ds: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .origin_account_id = "originAccountID",
        .origin_region = "originRegion",
        .source_network_i_ds = "sourceNetworkIDs",
    };
};
