/// Attributes of Hyperledger Fabric for a member in a Managed Blockchain
/// network using the Hyperledger Fabric framework.
pub const MemberFabricAttributes = struct {
    /// The user name for the initial administrator user for the member.
    admin_username: ?[]const u8 = null,

    /// The endpoint used to access the member's certificate authority.
    ca_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .admin_username = "AdminUsername",
        .ca_endpoint = "CaEndpoint",
    };
};
