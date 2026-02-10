/// Container for the `Suffix` element.
pub const IndexDocument = struct {
    /// A suffix that is appended to a request that is for a directory on the
    /// website endpoint. (For
    /// example, if the suffix is `index.html` and you make a request to
    /// `samplebucket/images/`, the data that is returned will be for the object
    /// with the key name
    /// `images/index.html`.) The suffix must not be empty and must not include a
    /// slash
    /// character.
    ///
    /// **Important:**
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    suffix: []const u8,
};
