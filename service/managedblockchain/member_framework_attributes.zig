const MemberFabricAttributes = @import("member_fabric_attributes.zig").MemberFabricAttributes;

/// Attributes relevant to a member for the blockchain framework that the
/// Managed Blockchain network uses.
pub const MemberFrameworkAttributes = struct {
    /// Attributes of Hyperledger Fabric relevant to a member on a Managed
    /// Blockchain network that uses Hyperledger Fabric.
    fabric: ?MemberFabricAttributes,

    pub const json_field_names = .{
        .fabric = "Fabric",
    };
};
