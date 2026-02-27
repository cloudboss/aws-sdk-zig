const EoCloudCoverInput = @import("eo_cloud_cover_input.zig").EoCloudCoverInput;
const LandsatCloudCoverLandInput = @import("landsat_cloud_cover_land_input.zig").LandsatCloudCoverLandInput;
const PlatformInput = @import("platform_input.zig").PlatformInput;
const ViewOffNadirInput = @import("view_off_nadir_input.zig").ViewOffNadirInput;
const ViewSunAzimuthInput = @import("view_sun_azimuth_input.zig").ViewSunAzimuthInput;
const ViewSunElevationInput = @import("view_sun_elevation_input.zig").ViewSunElevationInput;

/// Represents a single searchable property to search on.
pub const Property = union(enum) {
    /// The structure representing EoCloudCover property filter containing a lower
    /// bound and upper bound.
    eo_cloud_cover: ?EoCloudCoverInput,
    /// The structure representing Land Cloud Cover property filter
    /// for Landsat collection containing a lower bound and upper bound.
    landsat_cloud_cover_land: ?LandsatCloudCoverLandInput,
    /// The structure representing Platform property filter consisting of value and
    /// comparison operator.
    platform: ?PlatformInput,
    /// The structure representing ViewOffNadir property filter containing a lower
    /// bound and upper bound.
    view_off_nadir: ?ViewOffNadirInput,
    /// The structure representing ViewSunAzimuth property filter containing a lower
    /// bound and upper bound.
    view_sun_azimuth: ?ViewSunAzimuthInput,
    /// The structure representing ViewSunElevation property filter containing a
    /// lower bound and upper bound.
    view_sun_elevation: ?ViewSunElevationInput,

    pub const json_field_names = .{
        .eo_cloud_cover = "EoCloudCover",
        .landsat_cloud_cover_land = "LandsatCloudCoverLand",
        .platform = "Platform",
        .view_off_nadir = "ViewOffNadir",
        .view_sun_azimuth = "ViewSunAzimuth",
        .view_sun_elevation = "ViewSunElevation",
    };
};
