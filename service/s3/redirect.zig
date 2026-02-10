const Protocol = @import("protocol.zig").Protocol;

/// Specifies how requests are redirected. In the event of an error, you can
/// specify a different error
/// code to return.
pub const Redirect = struct {
    /// The host name to use in the redirect request.
    host_name: ?[]const u8,

    /// The HTTP redirect code to use on the response. Not required if one of the
    /// siblings is
    /// present.
    http_redirect_code: ?[]const u8,

    /// Protocol to use when redirecting requests. The default is the protocol that
    /// is used in the original
    /// request.
    protocol: ?Protocol,

    /// The object key prefix to use in the redirect request. For example, to
    /// redirect requests for all
    /// pages with prefix `docs/` (objects in the `docs/` folder) to
    /// `documents/`, you can set a condition block with `KeyPrefixEquals` set to
    /// `docs/` and in the Redirect set `ReplaceKeyPrefixWith` to
    /// `/documents`. Not required if one of the siblings is present. Can be present
    /// only if
    /// `ReplaceKeyWith` is not provided.
    ///
    /// **Important:**
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    replace_key_prefix_with: ?[]const u8,

    /// The specific object key to use in the redirect request. For example,
    /// redirect request to
    /// `error.html`. Not required if one of the siblings is present. Can be present
    /// only if
    /// `ReplaceKeyPrefixWith` is not provided.
    ///
    /// **Important:**
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    replace_key_with: ?[]const u8,
};
