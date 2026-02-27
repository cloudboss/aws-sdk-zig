/// Inventory data for installed discovery connectors.
pub const CustomerConnectorInfo = struct {
    /// Number of active discovery connectors.
    active_connectors: i32 = 0,

    /// Number of blacklisted discovery connectors.
    black_listed_connectors: i32 = 0,

    /// Number of healthy discovery connectors.
    healthy_connectors: i32 = 0,

    /// Number of discovery connectors with status SHUTDOWN,
    shutdown_connectors: i32 = 0,

    /// Total number of discovery connectors.
    total_connectors: i32 = 0,

    /// Number of unhealthy discovery connectors.
    unhealthy_connectors: i32 = 0,

    /// Number of unknown discovery connectors.
    unknown_connectors: i32 = 0,

    pub const json_field_names = .{
        .active_connectors = "activeConnectors",
        .black_listed_connectors = "blackListedConnectors",
        .healthy_connectors = "healthyConnectors",
        .shutdown_connectors = "shutdownConnectors",
        .total_connectors = "totalConnectors",
        .unhealthy_connectors = "unhealthyConnectors",
        .unknown_connectors = "unknownConnectors",
    };
};
