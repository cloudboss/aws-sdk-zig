/// In a GetSampledRequests request, the `StartTime` and
/// `EndTime` objects specify the time range for which you want WAF to
/// return a sample of web requests.
///
/// You must specify the times in Coordinated Universal Time (UTC) format. UTC
/// format
/// includes the special designator, `Z`. For example,
/// `"2016-09-27T14:50Z"`. You can specify any time range in the previous three
/// hours.
///
/// In a GetSampledRequests response, the `StartTime` and
/// `EndTime` objects specify the time range for which WAF actually returned a
/// sample of web requests. WAF gets the specified number of requests from among
/// the first
/// 5,000 requests that your Amazon Web Services resource receives during the
/// specified time period. If your
/// resource receives more than 5,000 requests during that period, WAF stops
/// sampling after
/// the 5,000th request. In that case, `EndTime` is the time that WAF received
/// the
/// 5,000th request.
pub const TimeWindow = struct {
    /// The end of the time range from which you want `GetSampledRequests` to return
    /// a sample of the requests that your Amazon Web Services resource received.
    /// You must specify the times in
    /// Coordinated Universal Time (UTC) format. UTC format includes the special
    /// designator,
    /// `Z`. For example, `"2016-09-27T14:50Z"`. You can specify any time
    /// range in the previous three hours.
    end_time: i64,

    /// The beginning of the time range from which you want `GetSampledRequests` to
    /// return a sample of the requests that your Amazon Web Services resource
    /// received. You must specify the
    /// times in Coordinated Universal Time (UTC) format. UTC format includes the
    /// special
    /// designator, `Z`. For example, `"2016-09-27T14:50Z"`. You can specify
    /// any time range in the previous three hours.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
