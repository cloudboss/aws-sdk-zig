const S3Object = @import("s3_object.zig").S3Object;

/// Description of ephemeris.
pub const EphemerisDescription = struct {
    /// Supplied ephemeris data.
    ephemeris_data: ?[]const u8,

    /// Source Amazon S3 object used for the ephemeris.
    source_s3_object: ?S3Object,

    pub const json_field_names = .{
        .ephemeris_data = "ephemerisData",
        .source_s3_object = "sourceS3Object",
    };
};
