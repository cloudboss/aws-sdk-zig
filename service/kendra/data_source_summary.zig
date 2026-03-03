const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;
const DataSourceType = @import("data_source_type.zig").DataSourceType;

/// Summary information for a Amazon Kendra data source.
pub const DataSourceSummary = struct {
    /// The Unix timestamp when the data source connector was created.
    created_at: ?i64 = null,

    /// The identifier for the data source.
    id: ?[]const u8 = null,

    /// The code for a language. This shows a supported language for all documents
    /// in the data source. English is supported by default.
    /// For more information on supported languages, including their codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// The name of the data source.
    name: ?[]const u8 = null,

    /// The status of the data source. When the status is `ACTIVE` the data source
    /// is
    /// ready to use.
    status: ?DataSourceStatus = null,

    /// The type of the data source.
    @"type": ?DataSourceType = null,

    /// The Unix timestamp when the data source connector was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .id = "Id",
        .language_code = "LanguageCode",
        .name = "Name",
        .status = "Status",
        .@"type" = "Type",
        .updated_at = "UpdatedAt",
    };
};
