const SlotDefaultValueSpecification = @import("slot_default_value_specification.zig").SlotDefaultValueSpecification;
const PromptSpecification = @import("prompt_specification.zig").PromptSpecification;
const SampleUtterance = @import("sample_utterance.zig").SampleUtterance;
const SlotCaptureSetting = @import("slot_capture_setting.zig").SlotCaptureSetting;
const SlotConstraint = @import("slot_constraint.zig").SlotConstraint;
const SlotResolutionSetting = @import("slot_resolution_setting.zig").SlotResolutionSetting;
const WaitAndContinueSpecification = @import("wait_and_continue_specification.zig").WaitAndContinueSpecification;

/// Specifies the elicitation setting details eliciting a slot.
pub const SlotValueElicitationSetting = struct {
    /// A list of default values for a slot. Default values are used when
    /// Amazon Lex hasn't determined a value for a slot. You can specify default
    /// values from context variables, session attributes, and defined
    /// values.
    default_value_specification: ?SlotDefaultValueSpecification,

    /// The prompt that Amazon Lex uses to elicit the slot value from the
    /// user.
    prompt_specification: ?PromptSpecification,

    /// If you know a specific pattern that users might respond to an Amazon Lex
    /// request for a slot value, you can provide those utterances to improve
    /// accuracy. This is optional. In most cases, Amazon Lex is capable of
    /// understanding user utterances.
    sample_utterances: ?[]const SampleUtterance,

    /// Specifies the settings that Amazon Lex uses when a slot
    /// value is successfully entered by a user.
    slot_capture_setting: ?SlotCaptureSetting,

    /// Specifies whether the slot is required or optional.
    slot_constraint: SlotConstraint,

    /// An object containing information about whether assisted slot resolution is
    /// turned on for the slot or not.
    slot_resolution_setting: ?SlotResolutionSetting,

    wait_and_continue_specification: ?WaitAndContinueSpecification,

    pub const json_field_names = .{
        .default_value_specification = "defaultValueSpecification",
        .prompt_specification = "promptSpecification",
        .sample_utterances = "sampleUtterances",
        .slot_capture_setting = "slotCaptureSetting",
        .slot_constraint = "slotConstraint",
        .slot_resolution_setting = "slotResolutionSetting",
        .wait_and_continue_specification = "waitAndContinueSpecification",
    };
};
