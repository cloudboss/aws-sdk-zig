const DocumentAttributeBoostingLevel = @import("document_attribute_boosting_level.zig").DocumentAttributeBoostingLevel;

/// Provides information on boosting `DATE` type document attributes.
///
/// For more information on how boosting document attributes work in Amazon Q
/// Business, see [Boosting using document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/metadata-boosting.html).
pub const DateAttributeBoostingConfiguration = struct {
    /// Specifies the duration, in seconds, of a boost applies to a `DATE` type
    /// document attribute.
    boosting_duration_in_seconds: ?i64 = null,

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
        .boosting_duration_in_seconds = "boostingDurationInSeconds",
        .boosting_level = "boostingLevel",
    };
};
