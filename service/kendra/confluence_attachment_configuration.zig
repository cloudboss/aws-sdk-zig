const ConfluenceAttachmentToIndexFieldMapping = @import("confluence_attachment_to_index_field_mapping.zig").ConfluenceAttachmentToIndexFieldMapping;

/// Configuration of attachment settings for the Confluence data source.
/// Attachment
/// settings are optional, if you don't specify settings attachments, Amazon
/// Kendra
/// won't index them.
pub const ConfluenceAttachmentConfiguration = struct {
    /// Maps attributes or field names of Confluence attachments to Amazon Kendra
    /// index
    /// field names. To create custom fields, use the `UpdateIndex` API before you
    /// map to Confluence fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Confluence data source field names must exist in your Confluence custom
    /// metadata.
    ///
    /// If you specify the `AttachentFieldMappings` parameter, you must specify at
    /// least one field mapping.
    attachment_field_mappings: ?[]const ConfluenceAttachmentToIndexFieldMapping = null,

    /// `TRUE` to index attachments of pages and blogs in Confluence.
    crawl_attachments: bool = false,

    pub const json_field_names = .{
        .attachment_field_mappings = "AttachmentFieldMappings",
        .crawl_attachments = "CrawlAttachments",
    };
};
