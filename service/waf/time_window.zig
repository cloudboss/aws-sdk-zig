/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// In a GetSampledRequests request, the `StartTime` and `EndTime` objects
/// specify the time range
/// for which you want AWS WAF to return a sample of web requests.
///
/// You must specify the times in Coordinated Universal Time (UTC) format. UTC
/// format includes the special
/// designator, `Z`. For example, `"2016-09-27T14:50Z"`.
///
/// In a GetSampledRequests response, the `StartTime` and `EndTime` objects
/// specify the time range
/// for which AWS WAF actually returned a sample of web requests. AWS WAF gets
/// the specified number of requests from among the first
/// 5,000 requests that your AWS resource receives during the specified time
/// period. If your resource receives more than 5,000
/// requests during that period, AWS WAF stops sampling after the 5,000th
/// request. In that case, `EndTime`
/// is the time that AWS WAF received the 5,000th request.
pub const TimeWindow = struct {
    /// The end of the time range from which you want `GetSampledRequests` to return
    /// a sample of the
    /// requests that your AWS resource received. You must specify the date and time
    /// in Coordinated Universal Time (UTC) format.
    /// UTC format includes the special designator, `Z`. For example,
    /// `"2016-09-27T14:50Z"`.
    /// You can specify any time range in the previous three hours.
    end_time: i64,

    /// The beginning of the time range from which you want `GetSampledRequests` to
    /// return a sample of the
    /// requests that your AWS resource received. You must specify the date and time
    /// in Coordinated Universal Time (UTC) format.
    /// UTC format includes the special designator, `Z`. For example,
    /// `"2016-09-27T14:50Z"`.
    /// You can specify any time range in the previous three hours.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
