const aws = @import("aws");

const AnswerMachineDetectionConfig = @import("answer_machine_detection_config.zig").AnswerMachineDetectionConfig;

/// Parameters for the Telephony Channel Subtype
pub const TelephonyChannelSubtypeParameters = struct {
    answer_machine_detection_config: ?AnswerMachineDetectionConfig,

    attributes: []const aws.map.StringMapEntry,

    connect_source_phone_number: ?[]const u8,

    destination_phone_number: []const u8,

    ring_timeout: ?i32,

    pub const json_field_names = .{
        .answer_machine_detection_config = "answerMachineDetectionConfig",
        .attributes = "attributes",
        .connect_source_phone_number = "connectSourcePhoneNumber",
        .destination_phone_number = "destinationPhoneNumber",
        .ring_timeout = "ringTimeout",
    };
};
