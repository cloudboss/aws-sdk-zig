const AnalysisOptions = @import("analysis_options.zig").AnalysisOptions;
const AnalysisSchemeLanguage = @import("analysis_scheme_language.zig").AnalysisSchemeLanguage;

/// Configuration information for an analysis scheme. Each analysis scheme has a
/// unique name and specifies the language of the text to be processed. The
/// following options can be configured for an analysis scheme: `Synonyms`,
/// `Stopwords`, `StemmingDictionary`, `JapaneseTokenizationDictionary` and
/// `AlgorithmicStemming`.
pub const AnalysisScheme = struct {
    analysis_options: ?AnalysisOptions = null,

    analysis_scheme_language: AnalysisSchemeLanguage,

    analysis_scheme_name: []const u8,
};
