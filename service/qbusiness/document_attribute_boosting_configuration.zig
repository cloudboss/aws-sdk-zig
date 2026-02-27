const DateAttributeBoostingConfiguration = @import("date_attribute_boosting_configuration.zig").DateAttributeBoostingConfiguration;
const NumberAttributeBoostingConfiguration = @import("number_attribute_boosting_configuration.zig").NumberAttributeBoostingConfiguration;
const StringAttributeBoostingConfiguration = @import("string_attribute_boosting_configuration.zig").StringAttributeBoostingConfiguration;
const StringListAttributeBoostingConfiguration = @import("string_list_attribute_boosting_configuration.zig").StringListAttributeBoostingConfiguration;

/// Provides information on boosting supported Amazon Q Business document
/// attribute types. When an end user chat query matches document attributes
/// that have been boosted, Amazon Q Business prioritizes generating responses
/// from content that matches the boosted document attributes.
///
/// In version 2, boosting uses numeric values (ONE, TWO) to indicate priority
/// tiers that establish clear hierarchical relationships between boosted
/// attributes. This allows for more precise control over how different
/// attributes influence search results.
///
/// For `STRING` and `STRING_LIST` type document attributes to be used for
/// boosting on the console and the API, they must be enabled for search using
/// the
/// [DocumentAttributeConfiguration](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_DocumentAttributeConfiguration.html) object of the [UpdateIndex](https://docs.aws.amazon.com/amazonq/latest/api-reference/API_UpdateIndex.html) API. If you haven't enabled searching on these attributes, you can't boost attributes of these data types on either the console or the API.
///
/// For more information on how boosting document attributes work in Amazon Q
/// Business, see [Boosting using document
/// attributes](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/metadata-boosting.html).
pub const DocumentAttributeBoostingConfiguration = union(enum) {
    /// Provides information on boosting `DATE` type document attributes.
    ///
    /// Version 2 assigns priority tiers to `DATE` attributes, establishing clear
    /// hierarchical relationships with other boosted attributes.
    date_configuration: ?DateAttributeBoostingConfiguration,
    /// Provides information on boosting `NUMBER` type document attributes.
    ///
    /// `NUMBER` attributes are not supported when using `NativeIndexConfiguration`
    /// version 2, which focuses on `DATE` attributes for recency and `STRING`
    /// attributes for source prioritization.
    number_configuration: ?NumberAttributeBoostingConfiguration,
    /// Provides information on boosting `STRING` type document attributes.
    ///
    /// Version 2 assigns priority tiers to `STRING` attributes, establishing clear
    /// hierarchical relationships with other boosted attributes.
    string_configuration: ?StringAttributeBoostingConfiguration,
    /// Provides information on boosting `STRING_LIST` type document attributes.
    ///
    /// `STRING_LIST` attributes are not supported when using
    /// `NativeIndexConfiguration` version 2, which focuses on `DATE` attributes for
    /// recency and `STRING` attributes for source prioritization.
    string_list_configuration: ?StringListAttributeBoostingConfiguration,

    pub const json_field_names = .{
        .date_configuration = "dateConfiguration",
        .number_configuration = "numberConfiguration",
        .string_configuration = "stringConfiguration",
        .string_list_configuration = "stringListConfiguration",
    };
};
