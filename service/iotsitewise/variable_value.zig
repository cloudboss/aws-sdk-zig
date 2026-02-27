const AssetModelPropertyPathSegment = @import("asset_model_property_path_segment.zig").AssetModelPropertyPathSegment;

/// Identifies a property value used in an expression.
pub const VariableValue = struct {
    /// The ID of the hierarchy to query for the property ID. You can use the
    /// hierarchy's name
    /// instead of the hierarchy's ID. If the hierarchy has an external ID, you can
    /// specify
    /// `externalId:` followed by the external ID. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    ///
    /// You use a hierarchy ID instead of a model ID because you can have several
    /// hierarchies
    /// using the same model and therefore the same `propertyId`. For example, you
    /// might
    /// have separately grouped assets that come from the same asset model. For more
    /// information, see
    /// [Asset
    /// hierarchies](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/asset-hierarchies.html) in the *IoT SiteWise User Guide*.
    hierarchy_id: ?[]const u8,

    /// The ID of the property to use as the variable. You can use the property
    /// `name`
    /// if it's from the same asset model. If the property has an external ID, you
    /// can specify
    /// `externalId:` followed by the external ID. For more information, see [Using
    /// external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-ids) in the *IoT SiteWise User Guide*.
    property_id: ?[]const u8,

    /// The path of the property.
    property_path: ?[]const AssetModelPropertyPathSegment,

    pub const json_field_names = .{
        .hierarchy_id = "hierarchyId",
        .property_id = "propertyId",
        .property_path = "propertyPath",
    };
};
