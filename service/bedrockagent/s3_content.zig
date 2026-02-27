const S3Location = @import("s3_location.zig").S3Location;

/// Contains information about the content to ingest into a knowledge base
/// connected to an Amazon S3 data source.
pub const S3Content = struct {
    /// The S3 location of the file containing the content to ingest.
    s_3_location: S3Location,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
