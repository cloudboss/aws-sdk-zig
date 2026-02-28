const PropertyDataType = @import("property_data_type.zig").PropertyDataType;
const AssetModelPropertyPathSegment = @import("asset_model_property_path_segment.zig").AssetModelPropertyPathSegment;
const PropertyType = @import("property_type.zig").PropertyType;

/// Contains information about an asset model property.
pub const AssetModelProperty = struct {
    /// The data type of the asset model property.
    ///
    /// If you specify `STRUCT`, you must also specify `dataTypeSpec` to
    /// identify the type of the structure for this property.
    data_type: PropertyDataType,

    /// The data type of the structure for this property. This parameter exists on
    /// properties that
    /// have the `STRUCT` data type.
    data_type_spec: ?[]const u8,

    /// The external ID (if any) provided in the
    /// [CreateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_CreateAssetModel.html) or [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html)
    /// operation. You can assign an external ID by specifying
    /// this value as part of a call to
    /// [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html). However, you can't change the external ID if one is already assigned. For more information, see [Using external IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID of the asset model property.
    ///
    /// * If you are callling
    ///   [UpdateAssetModel](https://docs.aws.amazon.com/iot-sitewise/latest/APIReference/API_UpdateAssetModel.html) to create a
    /// *new* property: You can specify its ID here, if desired.
    /// IoT SiteWise automatically generates a unique ID for you, so this parameter
    /// is never required.
    /// However, if you prefer to supply your own ID instead, you can specify it
    /// here in UUID format.
    /// If you specify your own ID, it must be globally unique.
    ///
    /// * If you are calling UpdateAssetModel to modify an *existing*
    /// property: This can be either the actual ID in UUID format, or else
    /// `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    id: ?[]const u8,

    /// The name of the asset model property.
    name: []const u8,

    /// The structured path to the property from the root of the asset model.
    path: ?[]const AssetModelPropertyPathSegment,

    /// The property type (see `PropertyType`).
    @"type": PropertyType,

    /// The unit of the asset model property, such as `Newtons` or
    /// `RPM`.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .external_id = "externalId",
        .id = "id",
        .name = "name",
        .path = "path",
        .@"type" = "type",
        .unit = "unit",
    };
};
