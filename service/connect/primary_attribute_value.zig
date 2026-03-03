const AccessType = @import("access_type.zig").AccessType;

/// A primary attribute value.
pub const PrimaryAttributeValue = struct {
    /// The value's access type.
    access_type: ?AccessType = null,

    /// The value's attribute name.
    attribute_name: ?[]const u8 = null,

    /// The value's values.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .access_type = "AccessType",
        .attribute_name = "AttributeName",
        .values = "Values",
    };
};
