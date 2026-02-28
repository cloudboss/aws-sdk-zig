/// The instance configuration used for recommendations.
pub const InstanceConfiguration = struct {
    /// The instance type of the configuration.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};
