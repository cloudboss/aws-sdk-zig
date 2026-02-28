const PropertyDataType = @import("property_data_type.zig").PropertyDataType;
const InterfaceSummary = @import("interface_summary.zig").InterfaceSummary;
const AssetModelPropertyPathSegment = @import("asset_model_property_path_segment.zig").AssetModelPropertyPathSegment;
const PropertyType = @import("property_type.zig").PropertyType;

/// Contains a summary of a property associated with a model. This includes
/// information about
/// which interfaces the property belongs to, if any.
pub const AssetModelPropertySummary = struct {
    /// The ID of the composite model that contains the asset model property.
    asset_model_composite_model_id: ?[]const u8,

    /// The data type of the property.
    data_type: PropertyDataType,

    /// The data type of the structure for this property. This parameter exists on
    /// properties that
    /// have the `STRUCT` data type.
    data_type_spec: ?[]const u8,

    /// The external ID of the property. For more information, see [Using external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    external_id: ?[]const u8,

    /// The ID of the property.
    id: ?[]const u8,

    /// A list of interface summaries that describe which interfaces this property
    /// belongs to,
    /// including the interface asset model ID and the corresponding property ID in
    /// the
    /// interface.
    interface_summaries: ?[]const InterfaceSummary,

    /// The name of the property.
    name: []const u8,

    /// The structured path to the property from the root of the asset model.
    path: ?[]const AssetModelPropertyPathSegment,

    @"type": PropertyType,

    /// The unit (such as `Newtons` or `RPM`) of the property.
    unit: ?[]const u8,

    pub const json_field_names = .{
        .asset_model_composite_model_id = "assetModelCompositeModelId",
        .data_type = "dataType",
        .data_type_spec = "dataTypeSpec",
        .external_id = "externalId",
        .id = "id",
        .interface_summaries = "interfaceSummaries",
        .name = "name",
        .path = "path",
        .@"type" = "type",
        .unit = "unit",
    };
};
