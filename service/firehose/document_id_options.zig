const DefaultDocumentIdFormat = @import("default_document_id_format.zig").DefaultDocumentIdFormat;

/// Indicates the method for setting up document ID. The supported methods are
/// Firehose generated document ID and OpenSearch Service generated document ID.
pub const DocumentIdOptions = struct {
    /// When the `FIREHOSE_DEFAULT` option is chosen, Firehose generates
    /// a unique document ID for each record based on a unique internal identifier.
    /// The generated
    /// document ID is stable across multiple delivery attempts, which helps prevent
    /// the same
    /// record from being indexed multiple times with different document IDs.
    ///
    /// When the `NO_DOCUMENT_ID` option is chosen, Firehose does not
    /// include any document IDs in the requests it sends to the Amazon OpenSearch
    /// Service. This
    /// causes the Amazon OpenSearch Service domain to generate document IDs. In
    /// case of multiple
    /// delivery attempts, this may cause the same record to be indexed more than
    /// once with
    /// different document IDs. This option enables write-heavy operations, such as
    /// the ingestion
    /// of logs and observability data, to consume less resources in the Amazon
    /// OpenSearch Service
    /// domain, resulting in improved performance.
    default_document_id_format: DefaultDocumentIdFormat,

    pub const json_field_names = .{
        .default_document_id_format = "DefaultDocumentIdFormat",
    };
};
