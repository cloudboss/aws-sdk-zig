const MemberFabricConfiguration = @import("member_fabric_configuration.zig").MemberFabricConfiguration;

/// Configuration properties relevant to a member for the blockchain framework
/// that the Managed Blockchain network uses.
pub const MemberFrameworkConfiguration = struct {
    /// Attributes of Hyperledger Fabric for a member on a Managed Blockchain
    /// network that uses Hyperledger Fabric.
    fabric: ?MemberFabricConfiguration = null,

    pub const json_field_names = .{
        .fabric = "Fabric",
    };
};
