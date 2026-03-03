const ImageStaticFile = @import("image_static_file.zig").ImageStaticFile;
const SpatialStaticFile = @import("spatial_static_file.zig").SpatialStaticFile;

/// The static file.
pub const StaticFile = struct {
    /// The image static file.
    image_static_file: ?ImageStaticFile = null,

    /// The spacial static file.
    spatial_static_file: ?SpatialStaticFile = null,

    pub const json_field_names = .{
        .image_static_file = "ImageStaticFile",
        .spatial_static_file = "SpatialStaticFile",
    };
};
