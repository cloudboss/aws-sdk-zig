const S3Destination = @import("s3_destination.zig").S3Destination;

/// Describes the location of the updated firmware.
pub const Destination = struct {
    /// Describes the location in S3 of the updated firmware.
    s_3_destination: ?S3Destination,

    pub const json_field_names = .{
        .s_3_destination = "s3Destination",
    };
};
