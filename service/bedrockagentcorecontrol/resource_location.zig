const S3Location = @import("s3_location.zig").S3Location;

/// The location of a resource.
pub const ResourceLocation = union(enum) {
    s_3: ?S3Location,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
