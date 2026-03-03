/// A complex
/// type that
/// identifies a CIDR collection.
pub const CidrCollection = struct {
    /// The ARN of the collection. Can be used to reference the collection in IAM
    /// policy or in
    /// another Amazon Web Services account.
    arn: ?[]const u8 = null,

    /// The unique ID of the CIDR collection.
    id: ?[]const u8 = null,

    /// The name of a CIDR collection.
    name: ?[]const u8 = null,

    /// A sequential counter that Route 53 sets to 1 when you create a CIDR
    /// collection and increments by 1 each time you update settings for the CIDR
    /// collection.
    version: ?i64 = null,
};
