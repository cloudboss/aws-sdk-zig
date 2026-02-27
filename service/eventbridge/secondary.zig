/// The secondary Region that processes events when failover is triggered or
/// replication is
/// enabled.
pub const Secondary = struct {
    /// Defines the secondary Region.
    route: []const u8,

    pub const json_field_names = .{
        .route = "Route",
    };
};
