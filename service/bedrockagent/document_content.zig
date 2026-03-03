const CustomContent = @import("custom_content.zig").CustomContent;
const ContentDataSourceType = @import("content_data_source_type.zig").ContentDataSourceType;
const S3Content = @import("s3_content.zig").S3Content;

/// Contains information about the content of a document. Choose a
/// `dataSourceType` and include the field that corresponds to it.
pub const DocumentContent = struct {
    /// Contains information about the content to ingest into a knowledge base
    /// connected to a custom data source.
    custom: ?CustomContent = null,

    /// The type of data source that is connected to the knowledge base to which to
    /// ingest this document.
    data_source_type: ContentDataSourceType,

    /// Contains information about the content to ingest into a knowledge base
    /// connected to an Amazon S3 data source
    s_3: ?S3Content = null,

    pub const json_field_names = .{
        .custom = "custom",
        .data_source_type = "dataSourceType",
        .s_3 = "s3",
    };
};
