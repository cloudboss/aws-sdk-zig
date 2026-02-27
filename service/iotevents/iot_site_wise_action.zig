const AssetPropertyValue = @import("asset_property_value.zig").AssetPropertyValue;

/// Sends information about the detector model instance and the event that
/// triggered the
/// action to a specified asset property in AWS IoT SiteWise.
///
/// You must use expressions for all parameters in `IotSiteWiseAction`. The
/// expressions accept literals, operators, functions, references, and
/// substitutions
/// templates.
///
/// **Examples**
///
/// * For literal values, the expressions must contain single quotes. For
///   example, the value
/// for the `propertyAlias` parameter can be
/// `'/company/windfarm/3/turbine/7/temperature'`.
///
/// * For references, you must specify either variables or input values. For
///   example, the
/// value for the `assetId` parameter can be
/// `$input.TurbineInput.assetId1`.
///
/// * For a substitution template, you must use `${}`, and the template must be
/// in single quotes. A substitution template can also contain a combination of
/// literals,
/// operators, functions, references, and substitution templates.
///
/// In the following example, the value for the `propertyAlias` parameter uses
/// a substitution template.
///
/// `'company/windfarm/${$input.TemperatureInput.sensorData.windfarmID}/turbine/
/// ${$input.TemperatureInput.sensorData.turbineID}/temperature'`
///
/// You must specify either `propertyAlias` or both `assetId` and
/// `propertyId` to identify the target asset property in AWS IoT SiteWise.
///
/// For more information,
/// see
/// [Expressions](https://docs.aws.amazon.com/iotevents/latest/developerguide/iotevents-expressions.html)
/// in the *AWS IoT Events Developer Guide*.
pub const IotSiteWiseAction = struct {
    /// The ID of the asset that has the specified property.
    asset_id: ?[]const u8,

    /// A unique identifier for this entry. You can use the entry ID to track which
    /// data entry
    /// causes an error in case of failure. The default is a new unique identifier.
    entry_id: ?[]const u8,

    /// The alias of the asset property.
    property_alias: ?[]const u8,

    /// The ID of the asset property.
    property_id: ?[]const u8,

    /// The value to send to the asset property. This value contains timestamp,
    /// quality, and value
    /// (TQV) information.
    property_value: ?AssetPropertyValue,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .entry_id = "entryId",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .property_value = "propertyValue",
    };
};
