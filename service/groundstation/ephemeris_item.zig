const EphemerisType = @import("ephemeris_type.zig").EphemerisType;
const S3Object = @import("s3_object.zig").S3Object;
const EphemerisStatus = @import("ephemeris_status.zig").EphemerisStatus;

/// Ephemeris item.
pub const EphemerisItem = struct {
    /// The time the ephemeris was uploaded in UTC.
    creation_time: ?i64 = null,

    /// Whether or not the ephemeris is enabled.
    enabled: ?bool = null,

    /// The AWS Ground Station ephemeris ID.
    ephemeris_id: ?[]const u8 = null,

    /// The type of ephemeris.
    ephemeris_type: ?EphemerisType = null,

    /// A name that you can use to identify the ephemeris.
    name: ?[]const u8 = null,

    /// A priority score that determines which ephemeris to use when multiple
    /// ephemerides overlap.
    ///
    /// Higher numbers take precedence. The default is 1. Must be 1 or greater.
    priority: ?i32 = null,

    /// Source Amazon S3 object used for the ephemeris.
    source_s3_object: ?S3Object = null,

    /// The status of the ephemeris.
    status: ?EphemerisStatus = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .enabled = "enabled",
        .ephemeris_id = "ephemerisId",
        .ephemeris_type = "ephemerisType",
        .name = "name",
        .priority = "priority",
        .source_s3_object = "sourceS3Object",
        .status = "status",
    };
};
