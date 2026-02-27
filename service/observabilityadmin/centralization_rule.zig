const CentralizationRuleDestination = @import("centralization_rule_destination.zig").CentralizationRuleDestination;
const CentralizationRuleSource = @import("centralization_rule_source.zig").CentralizationRuleSource;

/// Defines how telemetry data should be centralized across an Amazon Web
/// Services Organization, including source and destination configurations.
pub const CentralizationRule = struct {
    /// Configuration determining where the telemetry data should be centralized,
    /// backed up, as well as encryption configuration for the primary and backup
    /// destinations.
    destination: CentralizationRuleDestination,

    /// Configuration determining the source of the telemetry data to be
    /// centralized.
    source: CentralizationRuleSource,

    pub const json_field_names = .{
        .destination = "Destination",
        .source = "Source",
    };
};
