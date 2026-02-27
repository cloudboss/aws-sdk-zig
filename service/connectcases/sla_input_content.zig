const SlaInputConfiguration = @import("sla_input_configuration.zig").SlaInputConfiguration;

/// Represents the content of an SLA.
pub const SlaInputContent = union(enum) {
    /// Represents an input SLA configuration.
    sla_input_configuration: ?SlaInputConfiguration,

    pub const json_field_names = .{
        .sla_input_configuration = "slaInputConfiguration",
    };
};
