const ClarifyTextGranularity = @import("clarify_text_granularity.zig").ClarifyTextGranularity;
const ClarifyTextLanguage = @import("clarify_text_language.zig").ClarifyTextLanguage;

/// A parameter used to configure the SageMaker Clarify explainer to treat text
/// features as text so that explanations are provided for individual units of
/// text. Required only for natural language processing (NLP) explainability.
pub const ClarifyTextConfig = struct {
    /// The unit of granularity for the analysis of text features. For example, if
    /// the unit is `'token'`, then each token (like a word in English) of the text
    /// is treated as a feature. SHAP values are computed for each unit/feature.
    granularity: ClarifyTextGranularity,

    /// Specifies the language of the text features in [ISO 639-1](
    /// https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) or [ISO
    /// 639-3](https://en.wikipedia.org/wiki/ISO_639-3) code of a supported
    /// language.
    ///
    /// For a mix of multiple languages, use code `'xx'`.
    language: ClarifyTextLanguage,

    pub const json_field_names = .{
        .granularity = "Granularity",
        .language = "Language",
    };
};
