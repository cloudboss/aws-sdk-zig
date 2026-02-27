const KafkaVersionStatus = @import("kafka_version_status.zig").KafkaVersionStatus;

pub const KafkaVersion = struct {
    status: ?KafkaVersionStatus,

    version: ?[]const u8,

    pub const json_field_names = .{
        .status = "Status",
        .version = "Version",
    };
};
