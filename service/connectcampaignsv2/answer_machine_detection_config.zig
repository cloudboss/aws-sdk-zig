/// Answering Machine Detection config
pub const AnswerMachineDetectionConfig = struct {
    /// Enable or disable await answer machine prompt
    await_answer_machine_prompt: ?bool,

    /// Enable or disable answering machine detection
    enable_answer_machine_detection: bool,

    pub const json_field_names = .{
        .await_answer_machine_prompt = "awaitAnswerMachinePrompt",
        .enable_answer_machine_detection = "enableAnswerMachineDetection",
    };
};
