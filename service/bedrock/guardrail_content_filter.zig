const GuardrailContentFilterAction = @import("guardrail_content_filter_action.zig").GuardrailContentFilterAction;
const GuardrailModality = @import("guardrail_modality.zig").GuardrailModality;
const GuardrailFilterStrength = @import("guardrail_filter_strength.zig").GuardrailFilterStrength;
const GuardrailContentFilterType = @import("guardrail_content_filter_type.zig").GuardrailContentFilterType;

/// Contains filter strengths for harmful content. Guardrails support the
/// following content filters to detect and filter harmful user inputs and
/// FM-generated outputs.
///
/// * **Hate** – Describes language or a statement that discriminates,
///   criticizes, insults, denounces, or dehumanizes a person or group on the
///   basis of an identity (such as race, ethnicity, gender, religion, sexual
///   orientation, ability, and national origin).
/// * **Insults** – Describes language or a statement that includes demeaning,
///   humiliating, mocking, insulting, or belittling language. This type of
///   language is also labeled as bullying.
/// * **Sexual** – Describes language or a statement that indicates sexual
///   interest, activity, or arousal using direct or indirect references to body
///   parts, physical traits, or sex.
/// * **Violence** – Describes language or a statement that includes
///   glorification of or threats to inflict physical pain, hurt, or injury
///   toward a person, group or thing.
///
/// Content filtering depends on the confidence classification of user inputs
/// and FM responses across each of the four harmful categories. All input and
/// output statements are classified into one of four confidence levels (NONE,
/// LOW, MEDIUM, HIGH) for each harmful category. For example, if a statement is
/// classified as *Hate* with HIGH confidence, the likelihood of the statement
/// representing hateful content is high. A single statement can be classified
/// across multiple categories with varying confidence levels. For example, a
/// single statement can be classified as *Hate* with HIGH confidence, *Insults*
/// with LOW confidence, *Sexual* with NONE confidence, and *Violence* with
/// MEDIUM confidence.
///
/// For more information, see [Guardrails content
/// filters](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-filters.html).
///
/// This data type is used in the following API operations:
///
/// * [GetGuardrail response
///   body](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_GetGuardrail.html#API_GetGuardrail_ResponseSyntax)
pub const GuardrailContentFilter = struct {
    /// The action to take when harmful content is detected in the input. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    input_action: ?GuardrailContentFilterAction,

    /// Indicates whether guardrail evaluation is enabled on the input. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    input_enabled: ?bool,

    /// The input modalities selected for the guardrail content filter.
    input_modalities: ?[]const GuardrailModality,

    /// The strength of the content filter to apply to prompts. As you increase the
    /// filter strength, the likelihood of filtering harmful content increases and
    /// the probability of seeing harmful content in your application reduces.
    input_strength: GuardrailFilterStrength,

    /// The action to take when harmful content is detected in the output. Supported
    /// values include:
    ///
    /// * `BLOCK` – Block the content and replace it with blocked messaging.
    /// * `NONE` – Take no action but return detection information in the trace
    ///   response.
    output_action: ?GuardrailContentFilterAction,

    /// Indicates whether guardrail evaluation is enabled on the output. When
    /// disabled, you aren't charged for the evaluation. The evaluation doesn't
    /// appear in the response.
    output_enabled: ?bool,

    /// The output modalities selected for the guardrail content filter.
    output_modalities: ?[]const GuardrailModality,

    /// The strength of the content filter to apply to model responses. As you
    /// increase the filter strength, the likelihood of filtering harmful content
    /// increases and the probability of seeing harmful content in your application
    /// reduces.
    output_strength: GuardrailFilterStrength,

    /// The harmful category that the content filter is applied to.
    @"type": GuardrailContentFilterType,

    pub const json_field_names = .{
        .input_action = "inputAction",
        .input_enabled = "inputEnabled",
        .input_modalities = "inputModalities",
        .input_strength = "inputStrength",
        .output_action = "outputAction",
        .output_enabled = "outputEnabled",
        .output_modalities = "outputModalities",
        .output_strength = "outputStrength",
        .@"type" = "type",
    };
};
