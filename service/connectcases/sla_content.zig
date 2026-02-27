const SlaConfiguration = @import("sla_configuration.zig").SlaConfiguration;

/// Represents the content of an SLA to be returned to agents.
pub const SlaContent = struct {
    /// Represents an SLA configuration.
    sla_configuration: SlaConfiguration,

    pub const json_field_names = .{
        .sla_configuration = "slaConfiguration",
    };
};
