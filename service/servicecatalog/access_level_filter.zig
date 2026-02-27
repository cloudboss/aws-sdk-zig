const AccessLevelFilterKey = @import("access_level_filter_key.zig").AccessLevelFilterKey;

/// The access level to use to filter results.
pub const AccessLevelFilter = struct {
    /// The access level.
    ///
    /// * `Account` - Filter results based on the account.
    ///
    /// * `Role` - Filter results based on the federated role of the specified user.
    ///
    /// * `User` - Filter results based on the specified user.
    key: ?AccessLevelFilterKey,

    /// The user to which the access level applies. The only supported value is
    /// `self`.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
