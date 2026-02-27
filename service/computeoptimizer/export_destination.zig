const S3Destination = @import("s3_destination.zig").S3Destination;

/// Describes the destination of the recommendations export and metadata files.
pub const ExportDestination = struct {
    /// An object that describes the destination Amazon Simple Storage Service
    /// (Amazon S3)
    /// bucket name and object keys of a recommendations export file, and its
    /// associated
    /// metadata file.
    s_3: ?S3Destination,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
