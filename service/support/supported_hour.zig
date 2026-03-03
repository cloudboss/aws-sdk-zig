/// Time range object with `startTime` and `endTime` range in RFC 3339 format.
/// `'HH:mm:ss.SSS'`.
pub const SupportedHour = struct {
    /// End Time. RFC 3339 format `'HH:mm:ss.SSS'`.
    end_time: ?[]const u8 = null,

    /// Start Time. RFC 3339 format `'HH:mm:ss.SSS'`.
    start_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
