const Comparator = @import("comparator.zig").Comparator;

/// Defines a property predicate.
pub const PropertyPredicate = struct {
    /// The comparator used to compare this property to others.
    comparator: ?Comparator,

    /// The key of the property.
    key: ?[]const u8,

    /// The value of the property.
    value: ?[]const u8,

    pub const json_field_names = .{
        .comparator = "Comparator",
        .key = "Key",
        .value = "Value",
    };
};
