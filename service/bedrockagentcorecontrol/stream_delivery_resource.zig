const KinesisResource = @import("kinesis_resource.zig").KinesisResource;

/// Supported stream delivery resource types.
pub const StreamDeliveryResource = union(enum) {
    /// Kinesis Data Stream configuration.
    kinesis: ?KinesisResource,

    pub const json_field_names = .{
        .kinesis = "kinesis",
    };
};
