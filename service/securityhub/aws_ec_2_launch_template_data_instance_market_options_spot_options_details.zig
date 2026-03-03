/// Provides details about the market (purchasing) options for Spot Instances.
pub const AwsEc2LaunchTemplateDataInstanceMarketOptionsSpotOptionsDetails = struct {
    /// Deprecated.
    block_duration_minutes: ?i32 = null,

    /// The behavior when a Spot Instance is interrupted.
    instance_interruption_behavior: ?[]const u8 = null,

    /// The maximum hourly price you're willing to pay for the Spot Instances.
    max_price: ?[]const u8 = null,

    /// The Spot Instance request type.
    spot_instance_type: ?[]const u8 = null,

    /// The end date of the request, in UTC format (YYYY-MM-DDTHH:MM:SSZ), for
    /// persistent requests.
    valid_until: ?[]const u8 = null,

    pub const json_field_names = .{
        .block_duration_minutes = "BlockDurationMinutes",
        .instance_interruption_behavior = "InstanceInterruptionBehavior",
        .max_price = "MaxPrice",
        .spot_instance_type = "SpotInstanceType",
        .valid_until = "ValidUntil",
    };
};
