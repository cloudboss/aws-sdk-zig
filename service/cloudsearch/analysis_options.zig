const AlgorithmicStemming = @import("algorithmic_stemming.zig").AlgorithmicStemming;

/// Synonyms, stopwords, and stemming options for an analysis scheme. Includes
/// tokenization dictionary for Japanese.
pub const AnalysisOptions = struct {
    /// The level of algorithmic stemming to perform: `none`, `minimal`, `light`, or
    /// `full`. The available levels vary depending on the language. For more
    /// information, see [Language Specific Text Processing
    /// Settings](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/text-processing.html#text-processing-settings) in the *Amazon CloudSearch Developer Guide*
    algorithmic_stemming: ?AlgorithmicStemming,

    /// A JSON array that contains a collection of terms, tokens, readings and part
    /// of speech for Japanese Tokenizaiton. The Japanese tokenization dictionary
    /// enables you to override the default tokenization for selected terms. This is
    /// only valid for Japanese language fields.
    japanese_tokenization_dictionary: ?[]const u8,

    /// A JSON object that contains a collection of string:value pairs that each map
    /// a term to its stem. For example, `{"term1": "stem1", "term2": "stem2",
    /// "term3": "stem3"}`. The stemming dictionary is applied in addition to any
    /// algorithmic stemming. This enables you to override the results of the
    /// algorithmic stemming to correct specific cases of overstemming or
    /// understemming. The maximum size of a stemming dictionary is 500 KB.
    stemming_dictionary: ?[]const u8,

    /// A JSON array of terms to ignore during indexing and searching. For example,
    /// `["a", "an", "the", "of"]`. The stopwords dictionary must explicitly list
    /// each word you want to ignore. Wildcards and regular expressions are not
    /// supported.
    stopwords: ?[]const u8,

    /// A JSON object that defines synonym groups and aliases. A synonym group is an
    /// array of arrays, where each sub-array is a group of terms where each term in
    /// the group is considered a synonym of every other term in the group. The
    /// aliases value is an object that contains a collection of string:value pairs
    /// where the string specifies a term and the array of values specifies each of
    /// the aliases for that term. An alias is considered a synonym of the specified
    /// term, but the term is not considered a synonym of the alias. For more
    /// information about specifying synonyms, see
    /// [Synonyms](http://docs.aws.amazon.com/cloudsearch/latest/developerguide/configuring-analysis-schemes.html#synonyms) in the *Amazon CloudSearch Developer Guide*.
    synonyms: ?[]const u8,
};
