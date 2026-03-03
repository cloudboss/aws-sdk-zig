/// A complex type that is an entry in an
/// [CidrCollection](https://docs.aws.amazon.com/Route53/latest/APIReference/API_CidrCollection.html)
/// array.
pub const CollectionSummary = struct {
    /// The ARN of the collection summary. Can be used to reference the collection
    /// in IAM
    /// policy or cross-account.
    arn: ?[]const u8 = null,

    /// Unique ID for the CIDR collection.
    id: ?[]const u8 = null,

    /// The name of a CIDR collection.
    name: ?[]const u8 = null,

    /// A sequential counter that Route 53 sets to 1 when you create a CIDR
    /// collection and increments by 1 each time you update settings for the CIDR
    /// collection.
    version: ?i64 = null,
};
