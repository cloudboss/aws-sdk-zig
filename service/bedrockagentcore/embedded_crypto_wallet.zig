const LinkedAccount = @import("linked_account.zig").LinkedAccount;
const CryptoWalletNetwork = @import("crypto_wallet_network.zig").CryptoWalletNetwork;

/// Embedded Crypto wallet instrument details
pub const EmbeddedCryptoWallet = struct {
    /// List of linkedAccounts linked to this wallet.
    /// Each linkedAccount represents a way the end user can authenticate to this
    /// wallet.
    /// Can be empty when adding a new linkedAccount to an existing wallet.
    linked_accounts: []const LinkedAccount,

    /// The blockchain network for this embedded crypto wallet.
    /// Supported networks: ETHEREUM, SOLANA
    network: CryptoWalletNetwork,

    /// URL for the end user to complete a provider-specific action (e.g., wallet
    /// linking, onboarding).
    /// Returned by the payment connector during instrument creation.
    redirect_url: ?[]const u8 = null,

    /// The wallet address on the specified blockchain network.
    wallet_address: ?[]const u8 = null,

    pub const json_field_names = .{
        .linked_accounts = "linkedAccounts",
        .network = "network",
        .redirect_url = "redirectUrl",
        .wallet_address = "walletAddress",
    };
};
