const S3Location = @import("s3_location.zig").S3Location;

/// Information about the location of a custom plugin.
pub const CustomPluginLocation = struct {
    /// The S3 bucket Amazon Resource Name (ARN), file key, and object version of
    /// the plugin file stored in Amazon S3.
    s_3_location: S3Location,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
