const S3Location = @import("s3_location.zig").S3Location;

/// The location of the browser extension.
pub const ResourceLocation = union(enum) {
    /// The Amazon S3 location of the resource. Use this when the resource is stored
    /// in an Amazon S3 bucket.
    s_3: ?S3Location,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
