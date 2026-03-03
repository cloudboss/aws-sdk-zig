const LayerAvailability = @import("layer_availability.zig").LayerAvailability;

/// An object that represents an Amazon ECR image layer.
pub const Layer = struct {
    /// The availability status of the image layer.
    layer_availability: ?LayerAvailability = null,

    /// The `sha256` digest of the image layer.
    layer_digest: ?[]const u8 = null,

    /// The size, in bytes, of the image layer.
    layer_size: ?i64 = null,

    /// The media type of the layer, such as
    /// `application/vnd.docker.image.rootfs.diff.tar.gzip` or
    /// `application/vnd.oci.image.layer.v1.tar+gzip`.
    media_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .layer_availability = "layerAvailability",
        .layer_digest = "layerDigest",
        .layer_size = "layerSize",
        .media_type = "mediaType",
    };
};
