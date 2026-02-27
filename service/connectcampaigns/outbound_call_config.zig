const AnswerMachineDetectionConfig = @import("answer_machine_detection_config.zig").AnswerMachineDetectionConfig;

/// The configuration used for outbound calls.
pub const OutboundCallConfig = struct {
    answer_machine_detection_config: ?AnswerMachineDetectionConfig,

    connect_contact_flow_id: []const u8,

    connect_queue_id: ?[]const u8,

    connect_source_phone_number: ?[]const u8,

    pub const json_field_names = .{
        .answer_machine_detection_config = "answerMachineDetectionConfig",
        .connect_contact_flow_id = "connectContactFlowId",
        .connect_queue_id = "connectQueueId",
        .connect_source_phone_number = "connectSourcePhoneNumber",
    };
};
