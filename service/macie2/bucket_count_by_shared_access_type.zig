/// Provides information about the number of S3 buckets that are or aren't
/// shared with other Amazon Web Services accounts, Amazon CloudFront origin
/// access identities (OAIs), or CloudFront origin access controls (OACs). In
/// this data, an *Amazon Macie organization* is defined as a set of Macie
/// accounts that are centrally managed as a group of related accounts through
/// Organizations or by Macie invitation.
pub const BucketCountBySharedAccessType = struct {
    /// The total number of buckets that are shared with one or more of the
    /// following or any combination of the following: an Amazon CloudFront OAI, a
    /// CloudFront OAC, or an Amazon Web Services account that isn't in the same
    /// Amazon Macie organization.
    external: ?i64 = null,

    /// The total number of buckets that are shared with one or more Amazon Web
    /// Services accounts in the same Amazon Macie organization. These buckets
    /// aren't shared with Amazon CloudFront OAIs or OACs.
    internal: ?i64 = null,

    /// The total number of buckets that aren't shared with other Amazon Web
    /// Services accounts, Amazon CloudFront OAIs, or CloudFront OACs.
    not_shared: ?i64 = null,

    /// The total number of buckets that Amazon Macie wasn't able to evaluate shared
    /// access settings for. For example, the buckets' permissions settings or a
    /// quota prevented Macie from retrieving the requisite data. Macie can't
    /// determine whether the buckets are shared with other Amazon Web Services
    /// accounts, Amazon CloudFront OAIs, or CloudFront OACs.
    unknown: ?i64 = null,

    pub const json_field_names = .{
        .external = "external",
        .internal = "internal",
        .not_shared = "notShared",
        .unknown = "unknown",
    };
};
