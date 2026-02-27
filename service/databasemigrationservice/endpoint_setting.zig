const EndpointSettingTypeValue = @import("endpoint_setting_type_value.zig").EndpointSettingTypeValue;

/// Endpoint settings.
pub const EndpointSetting = struct {
    /// The relevance or validity of an endpoint setting for an engine name and its
    /// endpoint
    /// type.
    applicability: ?[]const u8,

    /// The default value of the endpoint setting if no value is specified using
    /// `CreateEndpoint` or `ModifyEndpoint`.
    default_value: ?[]const u8,

    /// Enumerated values to use for this endpoint.
    enum_values: ?[]const []const u8,

    /// The maximum value of an endpoint setting that is of type `int`.
    int_value_max: ?i32,

    /// The minimum value of an endpoint setting that is of type `int`.
    int_value_min: ?i32,

    /// The name that you want to give the endpoint settings.
    name: ?[]const u8,

    /// A value that marks this endpoint setting as sensitive.
    sensitive: ?bool,

    /// The type of endpoint. Valid values are `source` and
    /// `target`.
    type: ?EndpointSettingTypeValue,

    /// The unit of measure for this endpoint setting.
    units: ?[]const u8,

    pub const json_field_names = .{
        .applicability = "Applicability",
        .default_value = "DefaultValue",
        .enum_values = "EnumValues",
        .int_value_max = "IntValueMax",
        .int_value_min = "IntValueMin",
        .name = "Name",
        .sensitive = "Sensitive",
        .type = "Type",
        .units = "Units",
    };
};
