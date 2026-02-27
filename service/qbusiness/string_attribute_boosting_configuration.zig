const aws = @import("aws");

const StringAttributeValueBoostingLevel = @import("string_attribute_value_boosting_level.zig").StringAttributeValueBoostingLevel;
const DocumentAttributeBoostingLevel = @import("document_attribute_boosting_level.zig").DocumentAttributeBoostingLevel;

/// Provides information on boosting `STRING` type document attributes.
///
/// For `STRING` and `STRING_LIST` type document attributes to be used for
/// boosting on the console and the API, they must be enabled for search using
/// the
/// [DocumentAttributeConfiguration](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeConfiguration.html) object of the [UpdateIndex](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_UpdateIndex.html) API. If you haven't enabled searching on these attributes, you can't boost attributes of these data types on either the console or the API.
///
/// For more information on how boosting document attributes work in Amazon Q
/// Business, see [Boosting using document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/metadata-boosting.html).
pub const StringAttributeBoostingConfiguration = struct {
    /// Specifies specific values of a `STRING` type document attribute being
    /// boosted. When using `NativeIndexConfiguration` version 2, you can specify up
    /// to five values in order of priority.
    attribute_value_boosting: ?[]const aws.map.MapEntry(StringAttributeValueBoostingLevel),

    /// Specifies the priority tier ranking of boosting applied to document
    /// attributes. For version 2, this parameter indicates the relative ranking
    /// between boosted fields (ONE being highest priority, TWO being second
    /// highest, etc.) and determines the order in which attributes influence
    /// document ranking in search results. For version 1, this parameter specifies
    /// the boosting intensity. For version 2, boosting intensity (VERY HIGH, HIGH,
    /// MEDIUM, LOW, NONE) are not supported. Note that in version 2, you are not
    /// allowed to boost on only one field and make this value TWO.
    boosting_level: DocumentAttributeBoostingLevel,

    pub const json_field_names = .{
        .attribute_value_boosting = "attributeValueBoosting",
        .boosting_level = "boostingLevel",
    };
};
