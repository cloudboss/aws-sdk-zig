/// Properties associated with the Item.
pub const Properties = struct {
    /// Estimate of cloud cover.
    eo_cloud_cover: ?f32 = null,

    /// Land cloud cover for Landsat Data Collection.
    landsat_cloud_cover_land: ?f32 = null,

    /// Platform property. Platform refers to the unique name
    /// of the specific platform the instrument is attached to.
    /// For satellites it is the name of
    /// the satellite, eg. landsat-8 (Landsat-8), sentinel-2a.
    platform: ?[]const u8 = null,

    /// The angle from the sensor between nadir (straight down) and the scene
    /// center. Measured in degrees (0-90).
    view_off_nadir: ?f32 = null,

    /// The sun azimuth angle. From the scene center point on the ground, this is
    /// the angle between truth north and the sun.
    /// Measured clockwise in degrees (0-360).
    view_sun_azimuth: ?f32 = null,

    /// The sun elevation angle. The angle from the tangent of the scene center
    /// point to the sun. Measured from the horizon in degrees (-90-90).
    /// Negative values indicate the sun is below the horizon, e.g. sun elevation of
    /// -10° means the data was captured during [nautical
    /// twilight](https://www.timeanddate.com/astronomy/different-types-twilight.html).
    view_sun_elevation: ?f32 = null,

    pub const json_field_names = .{
        .eo_cloud_cover = "EoCloudCover",
        .landsat_cloud_cover_land = "LandsatCloudCoverLand",
        .platform = "Platform",
        .view_off_nadir = "ViewOffNadir",
        .view_sun_azimuth = "ViewSunAzimuth",
        .view_sun_elevation = "ViewSunElevation",
    };
};
