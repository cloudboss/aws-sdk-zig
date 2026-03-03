/// Information about a cache behavior for the distribution.
pub const AwsCloudFrontDistributionCacheBehavior = struct {
    /// The protocol that viewers can use to access the files in an origin. You can
    /// specify the
    /// following options:
    ///
    /// * `allow-all` - Viewers can use HTTP or HTTPS.
    ///
    /// * `redirect-to-https` - CloudFront responds to HTTP requests with an HTTP
    /// status code of 301 (Moved Permanently) and the HTTPS URL. The viewer then
    /// uses the
    /// new URL to resubmit.
    ///
    /// * `https-only` - CloudFront responds to HTTP request with an HTTP status
    /// code of 403 (Forbidden).
    viewer_protocol_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .viewer_protocol_policy = "ViewerProtocolPolicy",
    };
};
