const SlotDefaultValueSpecification = @import("slot_default_value_specification.zig").SlotDefaultValueSpecification;
const PromptSpecification = @import("prompt_specification.zig").PromptSpecification;
const SampleUtterance = @import("sample_utterance.zig").SampleUtterance;
const WaitAndContinueSpecification = @import("wait_and_continue_specification.zig").WaitAndContinueSpecification;

/// Subslot elicitation settings.
///
/// `DefaultValueSpecification` is a list of default values for a constituent
/// sub slot in a composite slot. Default values are used when
/// Amazon Lex hasn't determined a value for a slot. You can specify default
/// values from context variables,
/// session attributes, and defined values. This is similar to
/// `DefaultValueSpecification` for slots.
///
/// `PromptSpecification` is the prompt that Amazon Lex uses to elicit the sub
/// slot value from the user.
/// This is similar to `PromptSpecification` for slots.
pub const SubSlotValueElicitationSetting = struct {
    default_value_specification: ?SlotDefaultValueSpecification,

    prompt_specification: PromptSpecification,

    /// If you know a specific pattern that users might respond to an Amazon Lex
    /// request for a sub slot value,
    /// you can provide those utterances to improve accuracy. This is optional. In
    /// most cases Amazon Lex is capable
    /// of understanding user utterances. This is similar to `SampleUtterances` for
    /// slots.
    sample_utterances: ?[]const SampleUtterance,

    wait_and_continue_specification: ?WaitAndContinueSpecification,

    pub const json_field_names = .{
        .default_value_specification = "defaultValueSpecification",
        .prompt_specification = "promptSpecification",
        .sample_utterances = "sampleUtterances",
        .wait_and_continue_specification = "waitAndContinueSpecification",
    };
};
