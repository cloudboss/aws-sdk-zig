const WalletPasswordSourceSummary = @import("wallet_password_source_summary.zig").WalletPasswordSourceSummary;
const AutonomousDatabaseWalletStatus = @import("autonomous_database_wallet_status.zig").AutonomousDatabaseWalletStatus;

/// The wallet details for an Autonomous Database.
pub const AutonomousDatabaseWalletDetails = struct {
    /// The summary of the password source configuration for the Autonomous Database
    /// wallet.
    password_source_summary: ?WalletPasswordSourceSummary = null,

    /// The current status of the Autonomous Database wallet.
    status: ?AutonomousDatabaseWalletStatus = null,

    /// The date and time when the Autonomous Database wallet was last rotated.
    time_rotated: ?i64 = null,

    pub const json_field_names = .{
        .password_source_summary = "passwordSourceSummary",
        .status = "status",
        .time_rotated = "timeRotated",
    };
};
