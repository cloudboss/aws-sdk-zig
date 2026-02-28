/// The configuration for the EC2 Auto Scaling group with mixed instance types.
pub const MixedInstanceConfiguration = struct {
    /// The instance type of the configuration.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
