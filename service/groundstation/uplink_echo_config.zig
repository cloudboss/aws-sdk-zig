/// Information about an uplink echo `Config`.
///
/// Parameters from the `AntennaUplinkConfig`, corresponding to the specified `
/// AntennaUplinkConfigArn`, are used when this `UplinkEchoConfig` is used in a
/// contact.
pub const UplinkEchoConfig = struct {
    /// ARN of an uplink `Config`.
    antenna_uplink_config_arn: []const u8,

    /// Whether or not an uplink `Config` is enabled.
    enabled: bool,

    pub const json_field_names = .{
        .antenna_uplink_config_arn = "antennaUplinkConfigArn",
        .enabled = "enabled",
    };
};
