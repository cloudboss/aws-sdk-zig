const PrimaryAttributeValue = @import("primary_attribute_value.zig").PrimaryAttributeValue;

/// A primary attribute access control configuration item.
pub const PrimaryAttributeAccessControlConfigurationItem = struct {
    /// The item's primary attribute values.
    primary_attribute_values: ?[]const PrimaryAttributeValue = null,

    pub const json_field_names = .{
        .primary_attribute_values = "PrimaryAttributeValues",
    };
};
