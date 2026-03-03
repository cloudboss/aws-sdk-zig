const AccountAttributeValue = @import("account_attribute_value.zig").AccountAttributeValue;

/// Describes an account attribute.
pub const AccountAttribute = struct {
    /// The name of the account attribute.
    attribute_name: ?[]const u8 = null,

    /// The values for the account attribute.
    attribute_values: ?[]const AccountAttributeValue = null,
};
