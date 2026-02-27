const DocumentAttributeBoostingLevel = @import("document_attribute_boosting_level.zig").DocumentAttributeBoostingLevel;
const NumberAttributeBoostingType = @import("number_attribute_boosting_type.zig").NumberAttributeBoostingType;

/// Provides information on boosting `NUMBER` type document attributes.
///
/// In the current boosting implementation, boosting focuses primarily on `DATE`
/// attributes for recency and `STRING` attributes for source prioritization.
/// `NUMBER` attributes can serve as additional boosting factors when needed,
/// but are not supported when using `NativeIndexConfiguration` version 2.
///
/// For more information on how boosting document attributes work in Amazon Q
/// Business, see [Boosting using document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/metadata-boosting.html).
pub const NumberAttributeBoostingConfiguration = struct {
    /// Specifies the priority of boosted document attributes in relation to other
    /// boosted attributes. This parameter determines how strongly the attribute
    /// influences document ranking in search results. `NUMBER` attributes can serve
    /// as additional boosting factors when needed, but are not supported when using
    /// `NativeIndexConfiguration` version 2.
    boosting_level: DocumentAttributeBoostingLevel,

    /// Specifies whether higher or lower numeric values should be prioritized when
    /// boosting. Valid values are ASCENDING (higher numbers are more important) and
    /// DESCENDING (lower numbers are more important).
    boosting_type: ?NumberAttributeBoostingType,

    pub const json_field_names = .{
        .boosting_level = "boostingLevel",
        .boosting_type = "boostingType",
    };
};
