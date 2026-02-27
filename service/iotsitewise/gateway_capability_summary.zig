const CapabilitySyncStatus = @import("capability_sync_status.zig").CapabilitySyncStatus;

/// Contains a summary of a gateway capability configuration.
pub const GatewayCapabilitySummary = struct {
    /// The namespace of the capability configuration.
    /// For example, if you configure OPC UA
    /// sources for an MQTT-enabled gateway, your OPC-UA capability configuration
    /// has the namespace
    /// `iotsitewise:opcuacollector:3`.
    capability_namespace: []const u8,

    /// The synchronization status of the gateway capability configuration. The sync
    /// status can be one of the following:
    ///
    /// * `IN_SYNC` - The gateway is running with the latest configuration.
    ///
    /// * `OUT_OF_SYNC` - The gateway hasn't received the latest configuration.
    ///
    /// * `SYNC_FAILED` - The gateway rejected the latest configuration.
    ///
    /// * `UNKNOWN` - The gateway hasn't reported its sync status.
    ///
    /// * `NOT_APPLICABLE` - The gateway doesn't support this capability. This is
    ///   most common when integrating partner data sources, because the data
    ///   integration is handled externally by the partner.
    capability_sync_status: CapabilitySyncStatus,

    pub const json_field_names = .{
        .capability_namespace = "capabilityNamespace",
        .capability_sync_status = "capabilitySyncStatus",
    };
};
