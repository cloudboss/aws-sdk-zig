const Brevity = @import("brevity.zig").Brevity;
const Formality = @import("formality.zig").Formality;
const Profanity = @import("profanity.zig").Profanity;

/// Settings to configure your translation output. You can configure the
/// following options:
///
/// * Brevity: reduces the length of the translation output for most
///   translations. Available for
/// `TranslateText` only.
///
/// * Formality: sets the formality level of the translation output.
///
/// * Profanity: masks profane words and phrases in the translation output.
pub const TranslationSettings = struct {
    /// When you turn on brevity, Amazon Translate reduces the length of the
    /// translation output for most translations (when
    /// compared with the same translation with brevity turned off). By default,
    /// brevity is turned
    /// off.
    ///
    /// If you turn on brevity for a translation request with an unsupported
    /// language pair, the
    /// translation proceeds with the brevity setting turned off.
    ///
    /// For the language pairs that brevity supports, see [Using
    /// brevity](https://docs.aws.amazon.com/translate/latest/dg/customizing-translations-brevity) in the
    /// Amazon Translate Developer Guide.
    brevity: ?Brevity,

    /// You can specify the desired level of formality for translations
    /// to supported target languages. The formality
    /// setting controls the level of formal language usage (also known as
    /// [register](https://en.wikipedia.org/wiki/Register_(sociolinguistics))) in
    /// the
    /// translation output. You can set the value to informal or formal. If you
    /// don't specify a value for
    /// formality, or if the target language doesn't support formality, the
    /// translation will
    /// ignore the formality setting.
    ///
    /// If you specify multiple target languages for the job, translate ignores
    /// the formality setting for any unsupported target language.
    ///
    /// For a list of target languages that support formality, see [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/customizing-translations-formality.html#customizing-translations-formality-languages)
    /// in the Amazon Translate Developer Guide.
    formality: ?Formality,

    /// You can enable the profanity setting if you want to mask profane words and
    /// phrases in your translation output.
    ///
    /// To mask profane words and phrases, Amazon Translate replaces them with the
    /// grawlix string
    /// “?$#@$“. This 5-character sequence is used for each profane word or phrase,
    /// regardless of the
    /// length or number of words.
    ///
    /// Amazon Translate doesn't detect profanity in all of its supported languages.
    /// For languages
    /// that don't support profanity detection, see [Unsupported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/customizing-translations-profanity.html#customizing-translations-profanity-languages) in the Amazon Translate Developer Guide.
    ///
    /// If you specify multiple target languages for the job, all the
    /// target languages must support profanity masking. If any of the
    /// target languages don't support profanity masking, the
    /// translation job won't mask profanity for any target
    /// language.
    profanity: ?Profanity,

    pub const json_field_names = .{
        .brevity = "Brevity",
        .formality = "Formality",
        .profanity = "Profanity",
    };
};
