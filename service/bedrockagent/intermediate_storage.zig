const S3Location = @import("s3_location.zig").S3Location;

/// A location for storing content from data sources temporarily as it is
/// processed by custom components in the ingestion pipeline.
pub const IntermediateStorage = struct {
    /// An S3 bucket path.
    s_3_location: S3Location,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};
