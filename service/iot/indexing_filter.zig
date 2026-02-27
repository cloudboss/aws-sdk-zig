const GeoLocationTarget = @import("geo_location_target.zig").GeoLocationTarget;

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
/// `namedShadowIndexingMode` to be `ON`, add the shadow name in
/// `namedShadowNames` filter, and specify your geolocation data in
/// `geoLocations` filter. For more information, see [Managing fleet
/// indexing](https://docs.aws.amazon.com/iot/latest/developerguide/managing-fleet-index.html).
pub const IndexingFilter = struct {
    /// The list of geolocation targets that you select to index. The default
    /// maximum number of
    /// geolocation targets for indexing is `1`. To increase the limit, see [Amazon
    /// Web Services IoT Device
    /// Management
    /// Quotas](https://docs.aws.amazon.com/general/latest/gr/iot_device_management.html#fleet-indexing-limits) in the *Amazon Web Services General Reference*.
    geo_locations: ?[]const GeoLocationTarget,

    /// The shadow names that you select to index. The default maximum number of
    /// shadow names for indexing is 10. To increase
    /// the limit, see [Amazon Web Services IoT Device Management
    /// Quotas](https://docs.aws.amazon.com/general/latest/gr/iot_device_management.html#fleet-indexing-limits) in the *Amazon Web Services General Reference*.
    named_shadow_names: ?[]const []const u8,

    pub const json_field_names = .{
        .geo_locations = "geoLocations",
        .named_shadow_names = "namedShadowNames",
    };
};
