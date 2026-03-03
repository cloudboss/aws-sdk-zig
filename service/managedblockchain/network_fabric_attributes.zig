const Edition = @import("edition.zig").Edition;

/// Attributes of Hyperledger Fabric for a network.
pub const NetworkFabricAttributes = struct {
    /// The edition of Amazon Managed Blockchain that Hyperledger Fabric uses. For
    /// more information, see [Amazon Managed Blockchain
    /// Pricing](http://aws.amazon.com/managed-blockchain/pricing/).
    edition: ?Edition = null,

    /// The endpoint of the ordering service for the network.
    ordering_service_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .edition = "Edition",
        .ordering_service_endpoint = "OrderingServiceEndpoint",
    };
};
