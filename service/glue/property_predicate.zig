const Comparator = @import("comparator.zig").Comparator;

/// Defines a property predicate.
pub const PropertyPredicate = struct {
    /// The comparator used to compare this property to others.
    comparator: ?Comparator = null,

    /// The key of the property.
    key: ?[]const u8 = null,

    /// The value of the property.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparator = "Comparator",
        .key = "Key",
        .value = "Value",
    };
};
