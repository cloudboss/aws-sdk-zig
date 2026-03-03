const CostCategoryValues = @import("cost_category_values.zig").CostCategoryValues;
const DimensionValues = @import("dimension_values.zig").DimensionValues;
const TagValues = @import("tag_values.zig").TagValues;

/// Use `Expression` to filter in various Cost Explorer APIs.
///
/// Not all `Expression` types are supported in each API. Refer to the
/// documentation for each specific API to see what is supported.
///
/// There are two patterns:
///
/// * Simple dimension values.
///
/// * There are three types of simple dimension values:
/// `CostCategories`, `Tags`, and
/// `Dimensions`.
///
/// * Specify the `CostCategories` field to define a
/// filter that acts on Cost Categories.
///
/// * Specify the `Tags` field to define a filter that
/// acts on Cost Allocation Tags.
///
/// * Specify the `Dimensions` field to define a filter
/// that acts on the [
/// `DimensionValues`
/// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_DimensionValues.html).
///
/// * For each filter type, you can set the dimension name and values for
/// the filters that you plan to use.
///
/// * For example, you can filter for `REGION==us-east-1 OR
/// REGION==us-west-1`. For
/// `GetRightsizingRecommendation`, the Region is a
/// full name (for example, `REGION==US East (N.
/// Virginia)`.
///
/// * The corresponding `Expression` for this example is
/// as follows: `{ "Dimensions": { "Key": "REGION", "Values": [
/// "us-east-1", "us-west-1" ] } }`
///
/// * As shown in the previous example, lists of dimension values
/// are combined with `OR` when applying the
/// filter.
///
/// * You can also set different match options to further control how the
/// filter behaves. Not all APIs support match options. Refer to the
/// documentation for each specific API to see what is supported.
///
/// * For example, you can filter for linked account names that
/// start with "a".
///
/// * The corresponding `Expression` for this example is
/// as follows: `{ "Dimensions": { "Key":
/// "LINKED_ACCOUNT_NAME", "MatchOptions": [ "STARTS_WITH" ],
/// "Values": [ "a" ] } }`
///
/// * Compound `Expression` types with logical operations.
///
/// * You can use multiple `Expression` types and the logical
/// operators `AND/OR/NOT` to create a list of one or more
/// `Expression` objects. By doing this, you can filter by
/// more advanced options.
///
/// * For example, you can filter by `((REGION == us-east-1 OR REGION
/// == us-west-1) OR (TAG.Type == Type1)) AND (USAGE_TYPE !=
/// DataTransfer)`.
///
/// * The corresponding `Expression` for this example is as
/// follows: `{ "And": [ {"Or": [ {"Dimensions": { "Key": "REGION",
/// "Values": [ "us-east-1", "us-west-1" ] }}, {"Tags": { "Key":
/// "TagName", "Values": ["Value1"] } } ]}, {"Not": {"Dimensions": {
/// "Key": "USAGE_TYPE", "Values": ["DataTransfer"] }}} ] }
/// `
///
/// Because each `Expression` can have only one operator, the
/// service returns an error if more than one is specified. The following
/// example shows an `Expression` object that creates an error:
/// ` { "And": [ ... ], "Dimensions": { "Key": "USAGE_TYPE", "Values":
/// [ "DataTransfer" ] } } `
///
/// The following is an example of the corresponding error message:
/// `"Expression has more than one roots. Only one root operator is
/// allowed for each expression: And, Or, Not, Dimensions, Tags,
/// CostCategories"`
///
/// For the `GetRightsizingRecommendation` action, a combination of OR and
/// NOT isn't supported. OR isn't supported between different dimensions, or
/// dimensions
/// and tags. NOT operators aren't supported. Dimensions are also limited to
/// `LINKED_ACCOUNT`, `REGION`, or
/// `RIGHTSIZING_TYPE`.
///
/// For the `GetReservationPurchaseRecommendation` action, only NOT is
/// supported. AND and OR aren't supported. Dimensions are limited to
/// `LINKED_ACCOUNT`.
pub const Expression = struct {
    /// Return results that match both `Dimension` objects.
    @"and": ?[]const Expression = null,

    /// The filter that's based on `CostCategory` values.
    cost_categories: ?CostCategoryValues = null,

    /// The specific `Dimension` to use for `Expression`.
    dimensions: ?DimensionValues = null,

    /// Return results that don't match a `Dimension` object.
    not: ?*Expression = null,

    /// Return results that match either `Dimension` object.
    @"or": ?[]const Expression = null,

    /// The specific `Tag` to use for `Expression`.
    tags: ?TagValues = null,

    pub const json_field_names = .{
        .@"and" = "And",
        .cost_categories = "CostCategories",
        .dimensions = "Dimensions",
        .not = "Not",
        .@"or" = "Or",
        .tags = "Tags",
    };
};
