/// The error information.
pub const ErrorDocument = struct {
    /// The object key name to use when a 4XX class error occurs.
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    key: []const u8,
};
