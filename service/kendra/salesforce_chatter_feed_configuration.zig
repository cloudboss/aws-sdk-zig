const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const SalesforceChatterFeedIncludeFilterType = @import("salesforce_chatter_feed_include_filter_type.zig").SalesforceChatterFeedIncludeFilterType;

/// The configuration information for syncing a Salesforce chatter feed. The
/// contents of
/// the object comes from the Salesforce FeedItem table.
pub const SalesforceChatterFeedConfiguration = struct {
    /// The name of the column in the Salesforce FeedItem table that contains the
    /// content to
    /// index. Typically this is the `Body` column.
    document_data_field_name: []const u8,

    /// The name of the column in the Salesforce FeedItem table that contains the
    /// title of the
    /// document. This is typically the `Title` column.
    document_title_field_name: ?[]const u8,

    /// Maps fields from a Salesforce chatter feed into Amazon Kendra index
    /// fields.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// Filters the documents in the feed based on status of the user. When you
    /// specify
    /// `ACTIVE_USERS` only documents from users who have an active account are
    /// indexed. When you specify `STANDARD_USER` only documents for Salesforce
    /// standard users are documented. You can specify both.
    include_filter_types: ?[]const SalesforceChatterFeedIncludeFilterType,

    pub const json_field_names = .{
        .document_data_field_name = "DocumentDataFieldName",
        .document_title_field_name = "DocumentTitleFieldName",
        .field_mappings = "FieldMappings",
        .include_filter_types = "IncludeFilterTypes",
    };
};
