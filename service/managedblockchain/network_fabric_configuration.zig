const Edition = @import("edition.zig").Edition;

/// Hyperledger Fabric configuration properties for the network.
pub const NetworkFabricConfiguration = struct {
    /// The edition of Amazon Managed Blockchain that the network uses. For more
    /// information, see [Amazon Managed Blockchain
    /// Pricing](http://aws.amazon.com/managed-blockchain/pricing/).
    edition: Edition,

    pub const json_field_names = .{
        .edition = "Edition",
    };
};
