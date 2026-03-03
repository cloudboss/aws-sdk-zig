const SlotDefaultValueSpec = @import("slot_default_value_spec.zig").SlotDefaultValueSpec;
const ObfuscationSetting = @import("obfuscation_setting.zig").ObfuscationSetting;
const SlotConstraint = @import("slot_constraint.zig").SlotConstraint;
const Prompt = @import("prompt.zig").Prompt;

/// Identifies the version of a specific slot.
pub const Slot = struct {
    /// A list of default values for the slot. Default values are used when
    /// Amazon Lex hasn't determined a value for a slot. You can specify default
    /// values
    /// from context variables, session attributes, and defined values.
    default_value_spec: ?SlotDefaultValueSpec = null,

    /// A description of the slot.
    description: ?[]const u8 = null,

    /// The name of the slot.
    name: []const u8,

    /// Determines whether a slot is obfuscated in conversation logs and
    /// stored utterances. When you obfuscate a slot, the value is replaced by the
    /// slot name in curly braces ({}). For example, if the slot name is
    /// "full_name", obfuscated values are replaced with "{full_name}". For more
    /// information, see [ Slot Obfuscation
    /// ](https://docs.aws.amazon.com/lex/latest/dg/how-obfuscate.html).
    obfuscation_setting: ?ObfuscationSetting = null,

    /// Directs Amazon Lex the order in which to elicit this slot value from
    /// the user. For example, if the intent has two slots with priorities 1 and
    /// 2, AWS Amazon Lex first elicits a value for the slot with priority 1.
    ///
    /// If multiple slots share the same priority, the order in which Amazon Lex
    /// elicits values is arbitrary.
    priority: ?i32 = null,

    /// A set of possible responses for the slot type used by text-based
    /// clients. A user chooses an option from the response card, instead of using
    /// text to reply.
    response_card: ?[]const u8 = null,

    /// If you know a specific pattern with which users might respond to
    /// an Amazon Lex request for a slot value, you can provide those utterances to
    /// improve accuracy. This is optional. In most cases, Amazon Lex is capable of
    /// understanding user utterances.
    sample_utterances: ?[]const []const u8 = null,

    /// Specifies whether the slot is required or optional.
    slot_constraint: SlotConstraint,

    /// The type of the slot, either a custom slot type that you defined or
    /// one of the built-in slot types.
    slot_type: ?[]const u8 = null,

    /// The version of the slot type.
    slot_type_version: ?[]const u8 = null,

    /// The prompt that Amazon Lex uses to elicit the slot value from the
    /// user.
    value_elicitation_prompt: ?Prompt = null,

    pub const json_field_names = .{
        .default_value_spec = "defaultValueSpec",
        .description = "description",
        .name = "name",
        .obfuscation_setting = "obfuscationSetting",
        .priority = "priority",
        .response_card = "responseCard",
        .sample_utterances = "sampleUtterances",
        .slot_constraint = "slotConstraint",
        .slot_type = "slotType",
        .slot_type_version = "slotTypeVersion",
        .value_elicitation_prompt = "valueElicitationPrompt",
    };
};
