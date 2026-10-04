const S3Object = @import("s3_object.zig").S3Object;

/// The code configuration specifying the location of the deployment artifact.
pub const CodeConfig = struct {
    /// The Amazon S3 location of the deployment artifact.
    s_3_object: S3Object,

    pub const json_field_names = .{
        .s_3_object = "s3Object",
    };
};
