const DocumentAttributeBoostingLevel = @import("document_attribute_boosting_level.zig").DocumentAttributeBoostingLevel;

/// Provides information on boosting `STRING_LIST` type document attributes.
///
/// In the current boosting implementation, boosting focuses primarily on `DATE`
/// attributes for recency and `STRING` attributes for source prioritization.
/// `STRING_LIST` attributes can serve as additional boosting factors when
/// needed, but are not supported when using `NativeIndexConfiguration` version
/// 2.
///
/// For `STRING` and `STRING_LIST` type document attributes to be used for
/// boosting on the console and the API, they must be enabled for search using
/// the
/// [DocumentAttributeConfiguration](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeConfiguration.html) object of the [UpdateIndex](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_UpdateIndex.html) API. If you haven't enabled searching on these attributes, you can't boost attributes of these data types on either the console or the API.
///
/// For more information on how boosting document attributes work in Amazon Q
/// Business, see [Boosting using document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/metadata-boosting.html).
pub const StringListAttributeBoostingConfiguration = struct {
    /// Specifies the priority of boosted document attributes in relation to other
    /// boosted attributes. This parameter determines how strongly the attribute
    /// influences document ranking in search results. `STRING_LIST` attributes can
    /// serve as additional boosting factors when needed, but are not supported when
    /// using `NativeIndexConfiguration` version 2.
    boosting_level: DocumentAttributeBoostingLevel,

    pub const json_field_names = .{
        .boosting_level = "boostingLevel",
    };
};
