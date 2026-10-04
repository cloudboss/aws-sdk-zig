const KinesisTargetDefinition = @import("kinesis_target_definition.zig").KinesisTargetDefinition;

/// Target definition for stream destination.
pub const TargetDefinition = union(enum) {
    /// Kinesis stream target configuration.
    kinesis: ?KinesisTargetDefinition,

    pub const json_field_names = .{
        .kinesis = "kinesis",
    };
};
