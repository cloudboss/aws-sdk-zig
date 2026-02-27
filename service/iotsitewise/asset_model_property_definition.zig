const PropertyDataType = @import("property_data_type.zig").PropertyDataType;
const PropertyType = @import("property_type.zig").PropertyType;

/// Contains an asset model property definition. This property definition is
/// applied to all
/// assets created from the asset model.
pub const AssetModelPropertyDefinition = struct {
    /// The data type of the property definition.
    ///
    /// If you specify `STRUCT`, you must also specify `dataTypeSpec` to
    /// identify the type of the structure for this property.
    data_type: PropertyDataType,

    /// The data type of the structure for this property. This parameter is required
    /// on properties
    /// that have the `STRUCT` data type.
    ///
    /// The options for this parameter depend on the type of the composite model in
    /// which you
    /// define this property. Use `AWS/ALARM_STATE` for alarm state in alarm
    /// composite
    /// models.
    data_type_spec: ?[]const u8,

    /// An external ID to assign to the property definition. The external ID must be
    /// unique among
    /// property definitions within this asset model. For more information, see
    /// [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID to assign to the asset model property, if desired. IoT SiteWise
    /// automatically generates a unique ID for you, so this parameter is never
    /// required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    id: ?[]const u8,

    /// The name of the property definition.
    name: []const u8,

    /// The property definition type (see `PropertyType`). You can only specify one
    /// type in a property definition.
    type: PropertyType,

    /// The unit of the property definition, such as `Newtons` or
    /// `RPM`.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .type = "type",
        .unit = "unit",
    };
};
