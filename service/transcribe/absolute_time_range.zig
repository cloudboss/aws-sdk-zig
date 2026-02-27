/// A time range, in milliseconds, between two points in your media file.
///
/// You can use `StartTime` and `EndTime` to search a custom
/// segment. For example, setting `StartTime` to 10000 and `EndTime`
/// to 50000 only searches for your specified criteria in the audio contained
/// between the
/// 10,000 millisecond mark and the 50,000 millisecond mark of your media file.
/// You must use
/// `StartTime` and `EndTime` as a set; that is, if you include
/// one, you must include both.
///
/// You can use also `First` to search from the start of the audio until the
/// time that you specify, or `Last` to search from the time that you specify
/// until the end of the audio. For example, setting `First` to 50000 only
/// searches for your specified criteria in the audio contained between the
/// start of the
/// media file to the 50,000 millisecond mark. You can use `First` and
/// `Last` independently of each other.
///
/// If you prefer to use percentage instead of milliseconds, see .
pub const AbsoluteTimeRange = struct {
    /// The time, in milliseconds, when Amazon Transcribe stops searching for the
    /// specified
    /// criteria in your audio. If you include `EndTime` in your request, you must
    /// also include `StartTime`.
    end_time: ?i64,

    /// The time, in milliseconds, from the start of your media file until the
    /// specified value.
    /// Amazon Transcribe searches for your specified criteria in this time segment.
    first: ?i64,

    /// The time, in milliseconds, from the specified value until the end of your
    /// media file.
    /// Amazon Transcribe searches for your specified criteria in this time segment.
    last: ?i64,

    /// The time, in milliseconds, when Amazon Transcribe starts searching for the
    /// specified
    /// criteria in your audio. If you include `StartTime` in your request, you must
    /// also include `EndTime`.
    start_time: ?i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .first = "First",
        .last = "Last",
        .start_time = "StartTime",
    };
};
