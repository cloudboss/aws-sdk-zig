const InstanceInterruptionBehaviorEnum = @import("instance_interruption_behavior_enum.zig").InstanceInterruptionBehaviorEnum;
const SpotInstanceTypeEnum = @import("spot_instance_type_enum.zig").SpotInstanceTypeEnum;

/// Defines configuration for spot instance deployment.
pub const SpotMarketOptions = struct {
    /// Duration of spot instance block reservation.
    block_duration_minutes: ?i32,

    /// Specifies behavior when spot instance is interrupted.
    instance_interruption_behavior: ?InstanceInterruptionBehaviorEnum,

    /// Maximum hourly price for spot instance.
    max_price: ?[]const u8,

    /// Defines the type of spot instance request.
    spot_instance_type: ?SpotInstanceTypeEnum,

    /// Timestamp until which spot instance request is valid.
    valid_until_utc: ?i64,

    pub const json_field_names = .{
        .block_duration_minutes = "BlockDurationMinutes",
        .instance_interruption_behavior = "InstanceInterruptionBehavior",
        .max_price = "MaxPrice",
        .spot_instance_type = "SpotInstanceType",
        .valid_until_utc = "ValidUntilUtc",
    };
};
