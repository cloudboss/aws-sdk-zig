const PropertyLocation = @import("property_location.zig").PropertyLocation;
const PropertyType = @import("property_type.zig").PropertyType;

/// Defines a property configuration for connection types, default values, and
/// where the property should be used in requests.
pub const ConnectorProperty = struct {
    /// A list of `AllowedValue` objects representing the values allowed for the
    /// property.
    allowed_values: ?[]const []const u8,

    /// The default value for the property.
    default_value: ?[]const u8,

    /// A key name to use when sending this property in API requests, if different
    /// from the display name.
    key_override: ?[]const u8,

    /// The name of the property.
    name: []const u8,

    /// Specifies where this property should be included in REST requests, such as
    /// in headers, query parameters, or request body.
    property_location: ?PropertyLocation,

    /// The data type of this property
    property_type: PropertyType,

    /// Indicates whether the property is required.
    required: bool,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .default_value = "DefaultValue",
        .key_override = "KeyOverride",
        .name = "Name",
        .property_location = "PropertyLocation",
        .property_type = "PropertyType",
        .required = "Required",
    };
};
