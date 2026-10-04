const PaymentNetwork = @import("payment_network.zig").PaymentNetwork;

/// The cryptocurrency payment configuration for AI bot monetization. Contains
/// the list of blockchain payment networks where you receive payments.
pub const CryptoConfig = struct {
    /// The blockchain payment networks configured to receive payments. You can
    /// specify 1 to 2 networks. All networks must be in the same environment-either
    /// all production networks (Base, Solana) or all test networks (Base Sepolia,
    /// Solana Devnet).
    payment_networks: []const PaymentNetwork,

    pub const json_field_names = .{
        .payment_networks = "PaymentNetworks",
    };
};
