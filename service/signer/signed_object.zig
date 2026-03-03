const S3SignedObject = @import("s3_signed_object.zig").S3SignedObject;

/// Points to an `S3SignedObject` object that contains information about your
/// signed code image.
pub const SignedObject = struct {
    /// The `S3SignedObject`.
    s_3: ?S3SignedObject = null,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
