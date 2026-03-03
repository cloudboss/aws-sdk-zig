const S3DestinationSettings = @import("s3_destination_settings.zig").S3DestinationSettings;

/// Settings associated with the destination. Will vary based on the type of
/// destination
pub const DestinationSettings = struct {
    /// Settings associated with S3 destination
    s3_settings: ?S3DestinationSettings = null,

    pub const json_field_names = .{
        .s3_settings = "S3Settings",
    };
};
