const S3Object = @import("s3_object.zig").S3Object;

/// Ephemeris data in Orbit Ephemeris Message (OEM) format.
///
/// AWS Ground Station processes OEM ephemerides according to the [CCSDS
/// standard](https://ccsds.org/Pubs/502x0b3e1.pdf) with some extra
/// restrictions. OEM files should be in KVN format. For more detail about the
/// OEM format that AWS Ground Station supports, see [OEM ephemeris
/// format](https://docs.aws.amazon.com/ground-station/latest/ug/providing-oem-ephemeris-data.html#oem-ephemeris-format) in the AWS Ground Station user guide.
pub const OEMEphemeris = struct {
    /// OEM data that you provide directly instead of using an Amazon S3 object.
    oem_data: ?[]const u8 = null,

    /// The Amazon S3 object that contains the ephemeris data.
    s_3_object: ?S3Object = null,

    pub const json_field_names = .{
        .oem_data = "oemData",
        .s_3_object = "s3Object",
    };
};
