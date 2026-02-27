const Principal = @import("principal.zig").Principal;
const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;
const ContentType = @import("content_type.zig").ContentType;
const HierarchicalPrincipal = @import("hierarchical_principal.zig").HierarchicalPrincipal;
const S3Path = @import("s3_path.zig").S3Path;

/// A document in an index.
pub const Document = struct {
    /// The identifier of the access control configuration that you want to apply to
    /// the
    /// document.
    access_control_configuration_id: ?[]const u8,

    /// Information on principals (users and/or groups) and which documents they
    /// should have
    /// access to. This is useful for user context filtering, where search results
    /// are filtered
    /// based on the user or their group access to documents.
    access_control_list: ?[]const Principal,

    /// Custom attributes to apply to the document. Use the custom attributes to
    /// provide
    /// additional information for searching, to provide facets for refining
    /// searches, and to
    /// provide additional information in the query response.
    ///
    /// For example, 'DataSourceId' and 'DataSourceSyncJobId' are custom attributes
    /// that
    /// provide information on the synchronization of documents running on a data
    /// source. Note,
    /// 'DataSourceSyncJobId' could be an optional custom attribute as Amazon Kendra
    /// will use the ID of
    /// a running sync job.
    attributes: ?[]const DocumentAttribute,

    /// The contents of the document.
    ///
    /// Documents passed to the `Blob` parameter must be base64 encoded. Your code
    /// might not need to encode the document file bytes if you're using an Amazon
    /// Web Services
    /// SDK to call Amazon Kendra APIs. If you are calling the Amazon Kendra
    /// endpoint
    /// directly using REST, you must base64 encode the contents before sending.
    blob: ?[]const u8,

    /// The file type of the document in the `Blob` field.
    ///
    /// If you want to index snippets or subsets of HTML documents instead of the
    /// entirety of
    /// the HTML documents, you must add the `HTML` start and closing tags
    /// (`content`) around the content.
    content_type: ?ContentType,

    /// The list of
    /// [principal](https://docs.aws.amazon.com/kendra/latest/dg/API_Principal.html)
    /// lists that define the hierarchy for which documents users should
    /// have access to.
    hierarchical_access_control_list: ?[]const HierarchicalPrincipal,

    /// A identifier of the document in the index.
    ///
    /// Note, each document ID must be unique per index. You cannot create a data
    /// source to
    /// index your documents with their unique IDs and then use the
    /// `BatchPutDocument` API to index the same documents, or vice versa. You
    /// can delete a data source and then use the `BatchPutDocument` API to index
    /// the
    /// same documents, or vice versa.
    id: []const u8,

    s3_path: ?S3Path,

    /// The title of the document.
    title: ?[]const u8,

    pub const json_field_names = .{
        .access_control_configuration_id = "AccessControlConfigurationId",
        .access_control_list = "AccessControlList",
        .attributes = "Attributes",
        .blob = "Blob",
        .content_type = "ContentType",
        .hierarchical_access_control_list = "HierarchicalAccessControlList",
        .id = "Id",
        .s3_path = "S3Path",
        .title = "Title",
    };
};
