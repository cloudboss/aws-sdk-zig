const WalletPasswordSource = @import("wallet_password_source.zig").WalletPasswordSource;
const WalletPasswordSourceConfiguration = @import("wallet_password_source_configuration.zig").WalletPasswordSourceConfiguration;

/// A summary of the password source configuration for an Autonomous Database
/// wallet.
pub const WalletPasswordSourceSummary = struct {
    /// The source of the password for the Autonomous Database wallet.
    password_source: ?WalletPasswordSource = null,

    /// The configuration of the password source for the Autonomous Database wallet.
    password_source_configuration: ?WalletPasswordSourceConfiguration = null,

    pub const json_field_names = .{
        .password_source = "passwordSource",
        .password_source_configuration = "passwordSourceConfiguration",
    };
};
