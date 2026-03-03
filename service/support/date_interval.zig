/// Date and time (UTC) format in RFC 3339 : 'yyyy-MM-dd'T'HH:mm:ss.SSSZZ'.
pub const DateInterval = struct {
    /// End Date Time (UTC). RFC 3339 format : 'yyyy-MM-dd'T'HH:mm:ss.SSSZZ'.
    end_date_time: ?[]const u8 = null,

    /// A JSON object containing start and date time (UTC). Date and time format is
    /// RFC 3339 : 'yyyy-MM-dd'T'HH:mm:ss.SSSZZ'.
    start_date_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date_time = "endDateTime",
        .start_date_time = "startDateTime",
    };
};
