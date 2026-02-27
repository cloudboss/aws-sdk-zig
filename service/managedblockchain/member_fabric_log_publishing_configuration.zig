const LogConfigurations = @import("log_configurations.zig").LogConfigurations;

/// Configuration properties for logging events associated with a member of a
/// Managed Blockchain network using the Hyperledger Fabric framework.
pub const MemberFabricLogPublishingConfiguration = struct {
    /// Configuration properties for logging events associated with a member's
    /// Certificate Authority (CA). CA logs help you determine when a member in your
    /// account joins the network, or when new peers register with a member CA.
    ca_logs: ?LogConfigurations,

    pub const json_field_names = .{
        .ca_logs = "CaLogs",
    };
};
