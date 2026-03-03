/// Includes the list of references to legal resources proposed by the proposer
/// to the acceptor. Each `DocumentItem` refers to an individual reference.
pub const DocumentItem = struct {
    /// Category of the document. Document types include:
    ///
    /// * `CustomEula` – A custom EULA provided by you as seller. A URL for a EULA
    ///   stored in an accessible Amazon S3 bucket is required for this document
    ///   type.
    /// * `CustomDsa` – A custom Data Subscription Agreement (DSA) provided by you
    ///   as seller. A URL for a DSA stored in an accessible Amazon S3 bucket is
    ///   required for this document type.
    /// * `StandardEula` – The Standard Contract for AWS Marketplace (SCMP). For
    ///   more information about SCMP, see the AWS Marketplace Seller Guide. You
    ///   don’t provide a URL for this type because it’s managed by AWS Marketplace.
    /// * `StandardDsa` – DSA for AWS Marketplace. For more information about the
    ///   DSA, see the AWS Data Exchange User Guide. You don’t provide a URL for
    ///   this type because it’s managed by AWS Marketplace.
    @"type": ?[]const u8 = null,

    /// A URL to the legal document for buyers to read. Required when `Type` is
    /// `CustomEula`.
    url: ?[]const u8 = null,

    /// Version of standard contracts provided by AWS Marketplace. Required when
    /// Type is `StandardEula` or `StandardDsa`.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .@"type" = "type",
        .url = "url",
        .version = "version",
    };
};
