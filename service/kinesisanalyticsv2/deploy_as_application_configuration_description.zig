const S3ContentBaseLocationDescription = @import("s3_content_base_location_description.zig").S3ContentBaseLocationDescription;

/// The configuration information required to deploy an Amazon Data Analytics
/// Studio notebook as an application with durable state.
pub const DeployAsApplicationConfigurationDescription = struct {
    /// The location that holds the data required to specify an Amazon Data
    /// Analytics application.
    s3_content_location_description: S3ContentBaseLocationDescription,

    pub const json_field_names = .{
        .s3_content_location_description = "S3ContentLocationDescription",
    };
};
