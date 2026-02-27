/// Summary of the information about a CloudFront origin access identity.
pub const CloudFrontOriginAccessIdentitySummary = struct {
    /// The comment for this origin access identity, as originally specified when
    /// created.
    comment: []const u8,

    /// The ID for the origin access identity. For example: `E74FTE3AJFJ256A`.
    id: []const u8,

    /// The Amazon S3 canonical user ID for the origin access identity, which you
    /// use when giving the origin access identity read permission to an object in
    /// Amazon S3.
    s3_canonical_user_id: []const u8,
};
