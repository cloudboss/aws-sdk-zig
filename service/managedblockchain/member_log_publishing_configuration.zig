const MemberFabricLogPublishingConfiguration = @import("member_fabric_log_publishing_configuration.zig").MemberFabricLogPublishingConfiguration;

/// Configuration properties for logging events associated with a member of a
/// Managed Blockchain network.
pub const MemberLogPublishingConfiguration = struct {
    /// Configuration properties for logging events associated with a member of a
    /// Managed Blockchain network using the Hyperledger Fabric framework.
    fabric: ?MemberFabricLogPublishingConfiguration = null,

    pub const json_field_names = .{
        .fabric = "Fabric",
    };
};
