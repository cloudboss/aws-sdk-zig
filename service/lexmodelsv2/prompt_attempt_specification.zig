const AllowedInputTypes = @import("allowed_input_types.zig").AllowedInputTypes;
const AudioAndDTMFInputSpecification = @import("audio_and_dtmf_input_specification.zig").AudioAndDTMFInputSpecification;
const TextInputSpecification = @import("text_input_specification.zig").TextInputSpecification;

/// Specifies the settings on a prompt attempt.
pub const PromptAttemptSpecification = struct {
    /// Indicates the allowed input types of the prompt attempt.
    allowed_input_types: AllowedInputTypes,

    /// Indicates whether the user can interrupt a speech prompt attempt from the
    /// bot.
    allow_interrupt: ?bool,

    /// Specifies the settings on audio and DTMF input.
    audio_and_dtmf_input_specification: ?AudioAndDTMFInputSpecification,

    /// Specifies the settings on text input.
    text_input_specification: ?TextInputSpecification,

    pub const json_field_names = .{
        .allowed_input_types = "allowedInputTypes",
        .allow_interrupt = "allowInterrupt",
        .audio_and_dtmf_input_specification = "audioAndDTMFInputSpecification",
        .text_input_specification = "textInputSpecification",
    };
};
