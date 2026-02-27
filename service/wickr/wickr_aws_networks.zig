/// Identifies a Amazon Web Services Wickr network by region and network ID,
/// used for configuring permitted networks for global federation.
pub const WickrAwsNetworks = struct {
    /// The network ID of the Wickr Amazon Web Services network.
    network_id: []const u8,

    /// The Amazon Web Services region identifier where the network is hosted (e.g.,
    /// 'us-east-1').
    region: []const u8,

    pub const json_field_names = .{
        .network_id = "networkId",
        .region = "region",
    };
};
