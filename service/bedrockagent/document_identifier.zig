const CustomDocumentIdentifier = @import("custom_document_identifier.zig").CustomDocumentIdentifier;
const ContentDataSourceType = @import("content_data_source_type.zig").ContentDataSourceType;
const S3Location = @import("s3_location.zig").S3Location;

/// Contains information that identifies the document.
pub const DocumentIdentifier = struct {
    /// Contains information that identifies the document in a custom data source.
    custom: ?CustomDocumentIdentifier,

    /// The type of data source connected to the knowledge base that contains the
    /// document.
    data_source_type: ContentDataSourceType,

    /// Contains information that identifies the document in an S3 data source.
    s_3: ?S3Location,

    pub const json_field_names = .{
        .custom = "custom",
        .data_source_type = "dataSourceType",
        .s_3 = "s3",
    };
};
