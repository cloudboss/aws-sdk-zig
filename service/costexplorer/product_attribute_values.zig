const MatchOption = @import("match_option.zig").MatchOption;

/// The product attribute values that you can use to filter the costs of
/// supported services.
/// Currently, Amazon Bedrock is the only supported service.
///
/// The following product attribute keys are available for each supported
/// service:
///
/// * Amazon Bedrock
///
/// * `provider` - The model provider, such as
/// `Anthropic`, `Cohere`, or
/// `OpenAI`.
///
/// * `model` - The model, such as `Claude Sonnet 5` or
/// `Claude Haiku 4.5`.
///
/// * `inferenceType` - The type of inference usage, such as
/// `Input tokens` or `Output tokens`.
///
/// * `feature` - The feature that was used, such as
/// `On-demand Inference` or `Reranker`.
///
/// The following operations support product attributes: `GetCostAndUsage`,
/// `GetCostAndUsageWithResources`, `GetDimensionValues` (in the
/// `COST_AND_USAGE` context), `GetTags`, and
/// `GetCostCategories`.
///
/// Product attribute data is available for time periods that start on or after
/// September 1,
/// 2026. Requests for earlier time periods that use product attributes fail
/// with a
/// `DataUnavailableException`.
///
/// The `SERVICE` filter rules for product attributes depend on the
/// operation:
///
/// * `GetCostAndUsage` and `GetCostAndUsageWithResources` -
/// Optional.
///
/// * `GetDimensionValues` - Required when the filter includes
/// `ProductAttributes`, for any `Dimension`. Otherwise,
/// optional.
///
/// * `GetTags` and `GetCostCategories` - Required when the
/// filter includes `ProductAttributes`.
///
/// A `SERVICE` filter must contain only supported services, or the request
/// fails with a `ValidationException`. Service names are matched exactly. To
/// list
/// them, use `GetDimensionValues` with `Dimension` set to
/// `SERVICE` and the same `TimePeriod`, for example with
/// `SearchString` set to `Bedrock`.
///
/// The costs of a supported service can appear under multiple service names.
/// When the
/// `SERVICE` filter is optional, omit it so that your results include all of
/// those costs.
///
/// For example, the following `Expression` filters for the costs of one
/// model: `{ "ProductAttributes": { "Key": "model", "Values": [
/// "Claude Sonnet 5" ], "MatchOptions": [ "EQUALS" ] } }`
pub const ProductAttributeValues = struct {
    /// The name of the product attribute, such as `model`. The keys that are
    /// available depend on the service. For the keys of each supported service, see
    /// [
    /// `ProductAttributeValues`
    /// ](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_ProductAttributeValues.html).
    ///
    /// Keys are case-sensitive. A key that doesn't exist doesn't return an error:
    /// `EQUALS` matches no costs, and `ABSENT` matches all costs of
    /// supported services.
    key: []const u8,

    /// The match options that you can use to filter your results. Valid values:
    ///
    /// * `EQUALS` - Matches the values that you specify.
    ///
    /// * `ABSENT` - Matches costs that have no value for the key. Omit
    /// `Values`.
    ///
    /// * `CASE_SENSITIVE` - Use only with `EQUALS`. Values are
    /// always matched case-sensitively.
    ///
    /// Default values are `EQUALS` and `CASE_SENSITIVE`.
    match_options: ?[]const MatchOption = null,

    /// The specific values of the product attribute, such as `Claude Sonnet 5` for
    /// the `model` key. Values are matched exactly, including case. To list the
    /// values
    /// of a key, use `GetDimensionValues` with `Dimension` set to
    /// `PRODUCT_ATTRIBUTE` and `DimensionKey` set to the key.
    ///
    /// To match costs that have no value for the key, set `MatchOptions` to
    /// `ABSENT` and omit `Values`. Otherwise, `Values` is
    /// required.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
