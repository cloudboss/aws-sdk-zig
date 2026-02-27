const AccountInfo = @import("account_info.zig").AccountInfo;
const CustomAccountPoolHandler = @import("custom_account_pool_handler.zig").CustomAccountPoolHandler;

/// The source of accounts for the account pool. In the current release, it's
/// either a static list of accounts provided by the customer or a custom Amazon
/// Web Services Lambda handler.
pub const AccountSource = union(enum) {
    /// The static list of accounts within an account pool.
    accounts: ?[]const AccountInfo,
    /// The custom Amazon Web Services Lambda handler within an account pool.
    custom_account_pool_handler: ?CustomAccountPoolHandler,

    pub const json_field_names = .{
        .accounts = "accounts",
        .custom_account_pool_handler = "customAccountPoolHandler",
    };
};
