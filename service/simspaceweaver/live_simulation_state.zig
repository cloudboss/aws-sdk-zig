const SimulationClock = @import("simulation_clock.zig").SimulationClock;
const Domain = @import("domain.zig").Domain;

/// A collection of additional state information, such as
/// domain and clock configuration.
pub const LiveSimulationState = struct {
    /// A list of simulation clocks.
    ///
    /// At this time, a simulation has only one clock.
    clocks: ?[]const SimulationClock = null,

    /// A list of domains for the simulation. For more information about domains,
    /// see [Key concepts:
    /// Domains](https://docs.aws.amazon.com/simspaceweaver/latest/userguide/what-is_key-concepts.html#what-is_key-concepts_domains)
    /// in the *SimSpace Weaver User Guide*.
    domains: ?[]const Domain = null,

    pub const json_field_names = .{
        .clocks = "Clocks",
        .domains = "Domains",
    };
};
