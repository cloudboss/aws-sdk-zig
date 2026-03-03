const AnswerMachineDetectionConfig = @import("answer_machine_detection_config.zig").AnswerMachineDetectionConfig;

/// Default Telephony Outbound config
pub const TelephonyOutboundConfig = struct {
    answer_machine_detection_config: ?AnswerMachineDetectionConfig = null,

    connect_contact_flow_id: []const u8,

    connect_source_phone_number: ?[]const u8 = null,

    ring_timeout: ?i32 = null,

    pub const json_field_names = .{
        .answer_machine_detection_config = "answerMachineDetectionConfig",
        .connect_contact_flow_id = "connectContactFlowId",
        .connect_source_phone_number = "connectSourcePhoneNumber",
        .ring_timeout = "ringTimeout",
    };
};
