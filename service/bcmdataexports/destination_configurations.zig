const S3Destination = @import("s3_destination.zig").S3Destination;

/// The destinations used for data exports.
pub const DestinationConfigurations = struct {
    /// An object that describes the destination of the data exports file.
    s3_destination: S3Destination,

    pub const json_field_names = .{
        .s3_destination = "S3Destination",
    };
};
