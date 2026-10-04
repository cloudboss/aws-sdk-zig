const CryptoConfig = @import("crypto_config.zig").CryptoConfig;
const CurrencyMode = @import("currency_mode.zig").CurrencyMode;

/// The monetization configuration for a web ACL or rule group. Specifies the
/// cryptocurrency payment networks and currency mode for AI bot monetization.
/// You must provide this configuration when any rule in the web ACL or rule
/// group uses the `Monetize` action.
pub const MonetizationConfig = struct {
    /// The cryptocurrency payment configuration, including the blockchain networks
    /// and wallet addresses where you receive payments.
    crypto_config: ?CryptoConfig = null,

    /// Specifies whether the configuration uses real or test currency. Set to
    /// `REAL` to settle payments in USDC on production blockchain networks (Base,
    /// Solana). Set to `TEST` to settle on testnet networks (Base Sepolia, Solana
    /// Devnet) with tokens that have no monetary value. If not specified, defaults
    /// to `REAL`.
    currency_mode: ?CurrencyMode = null,

    pub const json_field_names = .{
        .crypto_config = "CryptoConfig",
        .currency_mode = "CurrencyMode",
    };
};
