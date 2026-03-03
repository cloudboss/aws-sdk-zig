/// The Amazon Web Services Region that events are routed to when failover is
/// triggered or event replication is enabled.
pub const AwsEventsEndpointRoutingConfigFailoverConfigSecondaryDetails = struct {
    /// Defines the secondary Region.
    route: ?[]const u8 = null,

    pub const json_field_names = .{
        .route = "Route",
    };
};
