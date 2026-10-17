const MatchOption = @import("match_option.zig").MatchOption;

/// The product attribute values used for filtering the costs by key and value
/// pairs.
/// Product attributes are supported for Amazon Bedrock only.
pub const ProductAttributeValues = struct {
    /// The name of the product attribute to filter on. Valid values are the
    /// following:
    ///
    /// * `feature` – The feature that was used, such as
    /// `On-demand Inference`.
    ///
    /// * `inferenceType` – The type of inference usage, such as
    /// `Input tokens` or `Output tokens`.
    ///
    /// * `model` – The model, such as `Claude Sonnet 5` or
    /// `Claude Haiku 4.5`.
    ///
    /// * `provider` – The model provider, such as `Anthropic`,
    /// `Cohere`, or `Amazon`.
    ///
    /// Keys are case-sensitive.
    key: []const u8,

    /// The match options for the `ProductAttributes` filter. Valid values:
    ///
    /// * `ABSENT` – Matches costs that have no value for the attribute.
    ///
    /// * `CASE_SENSITIVE` – Requires an exact case match.
    ///
    /// * `EQUALS` – Matches costs where the attribute equals the specified
    /// value.
    ///
    /// Specify either `EQUALS` or `ABSENT`. You can add
    /// `CASE_SENSITIVE` to `EQUALS`, but you can't use it by itself or
    /// with `ABSENT`.
    match_options: ?[]const MatchOption = null,

    /// The specific values of the product attribute, such as `Claude Sonnet 5` for
    /// the `model` key. Values are matched exactly.
    ///
    /// `Values` is required unless `MatchOptions` is
    /// `ABSENT`. To match costs that have no value for the key, set
    /// `MatchOptions` to `ABSENT` and omit `Values`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .match_options = "MatchOptions",
        .values = "Values",
    };
};
