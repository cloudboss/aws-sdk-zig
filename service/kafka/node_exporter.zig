/// Indicates whether you want to turn on or turn off the Node Exporter.
pub const NodeExporter = struct {
    /// Indicates whether you want to turn on or turn off the Node Exporter.
    enabled_in_broker: bool,

    pub const json_field_names = .{
        .enabled_in_broker = "EnabledInBroker",
    };
};
