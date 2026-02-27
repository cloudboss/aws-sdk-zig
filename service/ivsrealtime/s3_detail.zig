/// Complex data type that defines S3Detail objects.
pub const S3Detail = struct {
    /// The S3 bucket prefix under which the recording is stored.
    recording_prefix: []const u8,

    pub const json_field_names = .{
        .recording_prefix = "recordingPrefix",
    };
};
