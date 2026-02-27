const AllowedValue = @import("allowed_value.zig").AllowedValue;
const DataOperation = @import("data_operation.zig").DataOperation;
const PropertyLocation = @import("property_location.zig").PropertyLocation;
const PropertyType = @import("property_type.zig").PropertyType;

/// An object that defines a connection type for a compute environment.
pub const Property = struct {
    /// A list of `AllowedValue` objects representing the values allowed for the
    /// property.
    allowed_values: ?[]const AllowedValue,

    /// Indicates which data operations are applicable to the property.
    data_operation_scopes: ?[]const DataOperation,

    /// The default value for the property.
    default_value: ?[]const u8,

    /// A description of the property.
    description: []const u8,

    /// A key name to use when sending this property in API requests, if different
    /// from the display name.
    key_override: ?[]const u8,

    /// The name of the property.
    name: []const u8,

    /// Specifies where this property should be included in REST requests, such as
    /// in headers, query parameters, or request body.
    property_location: ?PropertyLocation,

    /// Describes the type of property.
    property_types: []const PropertyType = &.{},

    /// Indicates whether the property is required.
    required: bool,

    pub const json_field_names = .{
        .allowed_values = "AllowedValues",
        .data_operation_scopes = "DataOperationScopes",
        .default_value = "DefaultValue",
        .description = "Description",
        .key_override = "KeyOverride",
        .name = "Name",
        .property_location = "PropertyLocation",
        .property_types = "PropertyTypes",
        .required = "Required",
    };
};
