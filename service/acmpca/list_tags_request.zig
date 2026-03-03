pub const ListTagsRequest = struct {
    /// The Amazon Resource Name (ARN) that was returned when you called the
    /// [CreateCertificateAuthority](https://docs.aws.amazon.com/privateca/latest/APIReference/API_CreateCertificateAuthority.html) action. This must be of the form:
    ///
    /// `arn:aws:acm-pca:*region*:*account*:certificate-authority/*12345678-1234-1234-1234-123456789012* `
    certificate_authority_arn: []const u8,

    /// Use this parameter when paginating results to specify the maximum number of
    /// items to return in the response. If additional items exist beyond the number
    /// you specify, the **NextToken** element is sent in the response. Use this
    /// **NextToken** value in a subsequent request to retrieve additional items.
    max_results: ?i32 = null,

    /// Use this parameter when paginating results in a subsequent request after you
    /// receive a response with truncated results. Set it to the value of
    /// **NextToken** from the response you just received.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_authority_arn = "CertificateAuthorityArn",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};
