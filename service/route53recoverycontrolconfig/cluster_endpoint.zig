/// A cluster endpoint. Specify an endpoint when you want to set or retrieve a
/// routing control state in the cluster.
pub const ClusterEndpoint = struct {
    /// A cluster endpoint. Specify an endpoint and Amazon Web Services Region when
    /// you want to set or retrieve a routing control state in the cluster.
    ///
    /// To get or update the routing control state, see the Amazon Route 53
    /// Application Recovery Controller Routing Control Actions.
    endpoint: ?[]const u8,

    /// The Amazon Web Services Region for a cluster endpoint.
    region: ?[]const u8,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
        .region = "Region",
    };
};
