const S3Object = @import("s3_object.zig").S3Object;
const TLEData = @import("tle_data.zig").TLEData;

/// Two-line element set (TLE) ephemeris.
///
/// For more detail about providing Two-line element sets to AWS Ground Station,
/// see the [TLE
/// section](https://docs.aws.amazon.com/ground-station/latest/ug/providing-tle-ephemeris-data.html) of the AWS Ground Station user guide.
pub const TLEEphemeris = struct {
    /// The Amazon S3 object that contains the ephemeris data.
    s_3_object: ?S3Object = null,

    /// TLE data that you provide directly instead of using an Amazon S3 object.
    tle_data: ?[]const TLEData = null,

    pub const json_field_names = .{
        .s_3_object = "s3Object",
        .tle_data = "tleData",
    };
};
