/// Configuration of the answering machine detection.
pub const AnswerMachineDetectionConfig = struct {
    /// Wait for the answering machine prompt.
    await_answer_machine_prompt: bool = false,

    /// The flag to indicate if answer machine detection analysis needs to be
    /// performed for a voice call. If set to
    /// `true`, `TrafficType` must be set as `CAMPAIGN`.
    enable_answer_machine_detection: bool = false,

    pub const json_field_names = .{
        .await_answer_machine_prompt = "AwaitAnswerMachinePrompt",
        .enable_answer_machine_detection = "EnableAnswerMachineDetection",
    };
};
