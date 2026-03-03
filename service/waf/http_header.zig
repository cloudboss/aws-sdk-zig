/// This is **AWS WAF Classic** documentation. For
/// more information, see [AWS
/// WAF
/// Classic](https://docs.aws.amazon.com/waf/latest/developerguide/classic-waf-chapter.html) in the developer guide.
///
/// **For the latest version of AWS
/// WAF**, use the AWS WAFV2 API and see the [AWS WAF Developer
/// Guide](https://docs.aws.amazon.com/waf/latest/developerguide/waf-chapter.html). With the latest version, AWS WAF has a single set of endpoints for regional and global use.
///
/// The response from a GetSampledRequests request includes an `HTTPHeader`
/// complex type that
/// appears as `Headers` in the response syntax. `HTTPHeader` contains the names
/// and values of
/// all of the headers that appear in one of the web requests that were returned
/// by `GetSampledRequests`.
pub const HTTPHeader = struct {
    /// The name of one of the headers in the sampled web request.
    name: ?[]const u8 = null,

    /// The value of one of the headers in the sampled web request.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
