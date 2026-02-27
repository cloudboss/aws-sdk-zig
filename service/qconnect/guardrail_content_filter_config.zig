const GuardrailFilterStrength = @import("guardrail_filter_strength.zig").GuardrailFilterStrength;
const GuardrailContentFilterType = @import("guardrail_content_filter_type.zig").GuardrailContentFilterType;

/// Contains filter strengths for harmful content. AI Guardrail's support the
/// following content filters to detect and filter harmful user inputs and
/// FM-generated outputs.
///
/// * **Hate**: Describes input prompts and model responses that discriminate,
///   criticize, insult, denounce, or dehumanize a person or group on the basis
///   of an identity (such as race, ethnicity, gender, religion, sexual
///   orientation, ability, and national origin).
/// * **Insults**: Describes input prompts and model responses that includes
///   demeaning, humiliating, mocking, insulting, or belittling language. This
///   type of language is also labeled as bullying.
/// * **Sexual**: Describes input prompts and model responses that indicates
///   sexual interest, activity, or arousal using direct or indirect references
///   to body parts, physical traits, or sex.
/// * **Violence**: Describes input prompts and model responses that includes
///   glorification of, or threats to inflict physical pain, hurt, or injury
///   toward a person, group, or thing.
///
/// Content filtering depends on the confidence classification of user inputs
/// and FM responses across each of the four harmful categories. All input and
/// output statements are classified into one of four confidence levels (NONE,
/// LOW, MEDIUM, HIGH) for each harmful category. For example, if a statement is
/// classified as *Hate* with HIGH confidence, the likelihood of the statement
/// representing hateful content is high. A single statement can be classified
/// across multiple categories with varying confidence levels. For example, a
/// single statement can be classified as *Hate* with HIGH confidence, *
/// Insults* with LOW confidence, *Sexual* with NONE confidence, and *Violence*
/// with MEDIUM confidence.
pub const GuardrailContentFilterConfig = struct {
    /// The strength of the content filter to apply to prompts. As you increase the
    /// filter strength, the likelihood of filtering harmful content increases and
    /// the probability of seeing harmful content in your application reduces.
    input_strength: GuardrailFilterStrength,

    /// The strength of the content filter to apply to model responses. As you
    /// increase the filter strength, the likelihood of filtering harmful content
    /// increases and the probability of seeing harmful content in your application
    /// reduces.
    output_strength: GuardrailFilterStrength,

    /// The harmful category that the content filter is applied to.
    type: GuardrailContentFilterType,

    pub const json_field_names = .{
        .input_strength = "inputStrength",
        .output_strength = "outputStrength",
        .type = "type",
    };
};
