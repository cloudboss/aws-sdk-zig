/// This configuration determines which HTTP requests are sent to the staging
/// distribution. If the HTTP request contains a header and value that matches
/// what you specify here, the request is sent to the staging distribution.
/// Otherwise the request is sent to the primary distribution.
pub const ContinuousDeploymentSingleHeaderConfig = struct {
    /// The request header name that you want CloudFront to send to your staging
    /// distribution. The header must contain the prefix `aws-cf-cd-`.
    header: []const u8,

    /// The request header value.
    value: []const u8,
};
