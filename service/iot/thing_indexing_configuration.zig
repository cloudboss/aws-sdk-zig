const Field = @import("field.zig").Field;
const DeviceDefenderIndexingMode = @import("device_defender_indexing_mode.zig").DeviceDefenderIndexingMode;
const IndexingFilter = @import("indexing_filter.zig").IndexingFilter;
const NamedShadowIndexingMode = @import("named_shadow_indexing_mode.zig").NamedShadowIndexingMode;
const ThingConnectivityIndexingMode = @import("thing_connectivity_indexing_mode.zig").ThingConnectivityIndexingMode;
const ThingIndexingMode = @import("thing_indexing_mode.zig").ThingIndexingMode;

/// The thing indexing configuration. For more information, see [Managing
/// Thing
/// Indexing](https://docs.aws.amazon.com/iot/latest/developerguide/managing-index.html).
pub const ThingIndexingConfiguration = struct {
    /// Contains custom field names and their data type.
    custom_fields: ?[]const Field,

    /// Device Defender indexing mode. Valid values are:
    ///
    /// * VIOLATIONS – Your thing index contains Device Defender violations. To
    ///   enable Device
    /// Defender indexing, *deviceDefenderIndexingMode* must not be set to
    /// OFF.
    ///
    /// * OFF - Device Defender indexing is disabled.
    ///
    /// For more information about Device Defender violations, see [Device Defender
    /// Detect.](https://docs.aws.amazon.com/iot/latest/developerguide/device-defender-detect.html)
    device_defender_indexing_mode: ?DeviceDefenderIndexingMode,

    /// Provides additional selections for named shadows and geolocation data.
    ///
    /// To add named shadows to your fleet indexing configuration, set
    /// `namedShadowIndexingMode` to
    /// be ON and specify your shadow names in `namedShadowNames` filter.
    ///
    /// To add geolocation data to your fleet indexing configuration:
    ///
    /// * If you store geolocation data in a class/unnamed shadow, set
    /// `thingIndexingMode` to be `REGISTRY_AND_SHADOW` and specify your
    /// geolocation data in `geoLocations` filter.
    ///
    /// * If you store geolocation data in a named shadow, set
    ///   `namedShadowIndexingMode`
    /// to be `ON`, add the shadow name in `namedShadowNames` filter, and
    /// specify your geolocation data in `geoLocations` filter. For more
    /// information, see
    /// [Managing fleet
    /// indexing](https://docs.aws.amazon.com/iot/latest/developerguide/managing-fleet-index.html).
    filter: ?IndexingFilter,

    /// Contains fields that are indexed and whose types are already known by the
    /// Fleet Indexing
    /// service. This is an optional field. For more information, see [Managed
    /// fields](https://docs.aws.amazon.com/iot/latest/developerguide/managing-fleet-index.html#managed-field) in the *Amazon Web Services IoT Core Developer Guide*.
    ///
    /// You can't modify managed fields by updating fleet indexing configuration.
    managed_fields: ?[]const Field,

    /// Named shadow indexing mode. Valid values are:
    ///
    /// * ON – Your thing index contains named shadow. To enable thing
    /// named shadow indexing, *namedShadowIndexingMode* must not be set to
    /// OFF.
    ///
    /// * OFF - Named shadow indexing is disabled.
    ///
    /// For more information about Shadows, see [IoT Device Shadow
    /// service.](https://docs.aws.amazon.com/iot/latest/developerguide/iot-device-shadows.html)
    named_shadow_indexing_mode: ?NamedShadowIndexingMode,

    /// Thing connectivity indexing mode. Valid values are:
    ///
    /// * STATUS – Your thing index contains connectivity status. To enable thing
    /// connectivity indexing, *thingIndexMode* must not be set to
    /// OFF.
    ///
    /// * OFF - Thing connectivity status indexing is disabled.
    thing_connectivity_indexing_mode: ?ThingConnectivityIndexingMode,

    /// Thing indexing mode. Valid values are:
    ///
    /// * REGISTRY – Your thing index contains registry data only.
    ///
    /// * REGISTRY_AND_SHADOW - Your thing index contains registry and shadow data.
    ///
    /// * OFF - Thing indexing is disabled.
    thing_indexing_mode: ThingIndexingMode,

    pub const json_field_names = .{
        .custom_fields = "customFields",
        .device_defender_indexing_mode = "deviceDefenderIndexingMode",
        .filter = "filter",
        .managed_fields = "managedFields",
        .named_shadow_indexing_mode = "namedShadowIndexingMode",
        .thing_connectivity_indexing_mode = "thingConnectivityIndexingMode",
        .thing_indexing_mode = "thingIndexingMode",
    };
};
