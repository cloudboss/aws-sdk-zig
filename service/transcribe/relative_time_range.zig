/// A time range, in percentage, between two points in your media file.
///
/// You can use `StartPercentage` and `EndPercentage` to search a
/// custom segment. For example, setting `StartPercentage` to 10 and
/// `EndPercentage` to 50 only searches for your specified criteria in the
/// audio contained between the 10 percent mark and the 50 percent mark of your
/// media
/// file.
///
/// You can use also `First` to search from the start of the media file until
/// the time that you specify. Or use `Last` to search from the time that you
/// specify until the end of the media file. For example, setting `First` to 10
/// only searches for your specified criteria in the audio contained in the
/// first 10 percent
/// of the media file.
///
/// If you prefer to use milliseconds instead of percentage, see .
pub const RelativeTimeRange = struct {
    /// The time, in percentage, when Amazon Transcribe stops searching for the
    /// specified
    /// criteria in your media file. If you include `EndPercentage` in your request,
    /// you must also include `StartPercentage`.
    end_percentage: ?i32 = null,

    /// The time, in percentage, from the start of your media file until the
    /// specified value.
    /// Amazon Transcribe searches for your specified criteria in this time segment.
    first: ?i32 = null,

    /// The time, in percentage, from the specified value until the end of your
    /// media file.
    /// Amazon Transcribe searches for your specified criteria in this time segment.
    last: ?i32 = null,

    /// The time, in percentage, when Amazon Transcribe starts searching for the
    /// specified
    /// criteria in your media file. If you include `StartPercentage` in your
    /// request, you must also include `EndPercentage`.
    start_percentage: ?i32 = null,

    pub const json_field_names = .{
        .end_percentage = "EndPercentage",
        .first = "First",
        .last = "Last",
        .start_percentage = "StartPercentage",
    };
};
