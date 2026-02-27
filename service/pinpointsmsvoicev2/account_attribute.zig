const AccountAttributeName = @import("account_attribute_name.zig").AccountAttributeName;

/// Displays the attributes associated with a single Amazon Web Services
/// account.
pub const AccountAttribute = struct {
    /// The name of the account attribute.
    name: AccountAttributeName,

    /// The value associated with the account attribute name.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
