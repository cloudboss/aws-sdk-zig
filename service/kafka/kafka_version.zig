const KafkaVersionStatus = @import("kafka_version_status.zig").KafkaVersionStatus;

pub const KafkaVersion = struct {
    status: ?KafkaVersionStatus = null,

    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .version = "Version",
    };
};
