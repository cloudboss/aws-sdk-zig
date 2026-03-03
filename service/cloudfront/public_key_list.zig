const PublicKeySummary = @import("public_key_summary.zig").PublicKeySummary;

/// A list of public keys that you can use with [signed URLs and signed
/// cookies](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/PrivateContent.html), or with [field-level encryption](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/field-level-encryption.html).
pub const PublicKeyList = struct {
    /// A list of public keys.
    items: ?[]const PublicKeySummary = null,

    /// The maximum number of public keys you want in the response.
    max_items: i32,

    /// If there are more elements to be listed, this element is present and
    /// contains the value that you can use for the `Marker` request parameter to
    /// continue listing your public keys where you left off.
    next_marker: ?[]const u8 = null,

    /// The number of public keys in the list.
    quantity: i32,
};
