const CoinbaseCdpSecret = @import("coinbase_cdp_secret.zig").CoinbaseCdpSecret;

/// Specifies the service-managed Coinbase CDP secrets to rotate.
pub const CoinbaseCdpRotationTargets = struct {
    /// The secrets to rotate. Specify at least one value. Each secret that you
    /// specify is rotated independently.
    ///
    /// * `API_KEY` - The API key that the payment connector uses to call Coinbase
    ///   CDP. Rotate it as routine maintenance, or if you suspect that it is
    ///   compromised.
    /// * `WALLET_SECRET` - The wallet secret that signs transactions. Rotate it
    ///   only if it is lost or compromised. Coinbase CDP allows one wallet secret
    ///   per project, so it is replaced in place and signing can be briefly
    ///   interrupted.
    secrets: []const CoinbaseCdpSecret,

    pub const json_field_names = .{
        .secrets = "secrets",
    };
};
