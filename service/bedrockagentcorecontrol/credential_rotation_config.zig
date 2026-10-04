const CoinbaseCdpRotationTargets = @import("coinbase_cdp_rotation_targets.zig").CoinbaseCdpRotationTargets;

/// Specifies the service-managed credentials to rotate. Provide the member that
/// matches the payment connector's `type`.
pub const CredentialRotationConfig = union(enum) {
    /// The credentials to rotate for a Coinbase CDP payment connector.
    coinbase_cdp: ?CoinbaseCdpRotationTargets,

    pub const json_field_names = .{
        .coinbase_cdp = "coinbaseCDP",
    };
};
