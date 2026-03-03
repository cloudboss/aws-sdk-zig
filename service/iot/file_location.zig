const S3Location = @import("s3_location.zig").S3Location;
const Stream = @import("stream.zig").Stream;

/// The location of the OTA update.
pub const FileLocation = struct {
    /// The location of the updated firmware in S3.
    s_3_location: ?S3Location = null,

    /// The stream that contains the OTA update.
    stream: ?Stream = null,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
        .stream = "stream",
    };
};
