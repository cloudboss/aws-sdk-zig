const S3ContentBaseLocationUpdate = @import("s3_content_base_location_update.zig").S3ContentBaseLocationUpdate;

/// Updates to the configuration information required to deploy an Amazon Data
/// Analytics Studio notebook as an application with durable state.
pub const DeployAsApplicationConfigurationUpdate = struct {
    /// Updates to the location that holds the data required to specify an Amazon
    /// Data Analytics application.
    s3_content_location_update: ?S3ContentBaseLocationUpdate,

    pub const json_field_names = .{
        .s3_content_location_update = "S3ContentLocationUpdate",
    };
};
