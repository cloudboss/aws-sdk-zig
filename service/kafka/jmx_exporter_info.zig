/// Indicates whether you want to turn on or turn off the JMX Exporter.
pub const JmxExporterInfo = struct {
    /// Indicates whether you want to turn on or turn off the JMX Exporter.
    enabled_in_broker: bool,

    pub const json_field_names = .{
        .enabled_in_broker = "EnabledInBroker",
    };
};
