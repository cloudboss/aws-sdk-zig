const DataValue = @import("data_value.zig").DataValue;

/// An object that filters items returned by a property request.
pub const PropertyFilter = struct {
    /// The operator associated with this property filter.
    operator: ?[]const u8 = null,

    /// The property name associated with this property filter.
    property_name: ?[]const u8 = null,

    /// The value associated with this property filter.
    value: ?DataValue = null,

    pub const json_field_names = .{
        .operator = "operator",
        .property_name = "propertyName",
        .value = "value",
    };
};
