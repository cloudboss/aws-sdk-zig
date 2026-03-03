/// Provides the configuration information for your content sources, such as
/// data sources,
/// FAQs, and content indexed directly via
/// [BatchPutDocument](https://docs.aws.amazon.com/kendra/latest/dg/API_BatchPutDocument.html).
pub const ContentSourceConfiguration = struct {
    /// The identifier of the data sources you want to use for your Amazon Kendra
    /// experience.
    data_source_ids: ?[]const []const u8 = null,

    /// `TRUE` to use documents you indexed directly using the
    /// `BatchPutDocument` API.
    direct_put_content: bool = false,

    /// The identifier of the FAQs that you want to use for your Amazon Kendra
    /// experience.
    faq_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_source_ids = "DataSourceIds",
        .direct_put_content = "DirectPutContent",
        .faq_ids = "FaqIds",
    };
};
