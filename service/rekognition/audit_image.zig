const BoundingBox = @import("bounding_box.zig").BoundingBox;
const S3Object = @import("s3_object.zig").S3Object;

/// An image that is picked from the Face Liveness video and returned for audit
/// trail
/// purposes, returned as Base64-encoded bytes.
pub const AuditImage = struct {
    bounding_box: ?BoundingBox,

    /// The Base64-encoded bytes representing an image selected from the Face
    /// Liveness video and
    /// returned for audit purposes.
    bytes: ?[]const u8,

    s3_object: ?S3Object,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .bytes = "Bytes",
        .s3_object = "S3Object",
    };
};
