/// Specifies the configuration to use for the brokers.
pub const ConfigurationInfo = struct {
    /// ARN of the configuration to use.
    arn: []const u8,

    /// The revision of the configuration to use.
    revision: i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .revision = "Revision",
    };
};
