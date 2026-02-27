const S3LocationDescription = @import("s3_location_description.zig").S3LocationDescription;

/// Information about the location of a custom plugin.
pub const CustomPluginLocationDescription = struct {
    /// The S3 bucket Amazon Resource Name (ARN), file key, and object version of
    /// the plugin file stored in Amazon S3.
    s_3_location: ?S3LocationDescription,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
