const AutoTrainingConfig = @import("auto_training_config.zig").AutoTrainingConfig;
const EventsConfig = @import("events_config.zig").EventsConfig;

/// The configuration details of the solution update.
pub const SolutionUpdateConfig = struct {
    auto_training_config: ?AutoTrainingConfig = null,

    /// Describes the configuration of an event, which includes a list of event
    /// parameters. You can specify up to 10 event parameters. Events are used in
    /// solution creation.
    events_config: ?EventsConfig = null,

    pub const json_field_names = .{
        .auto_training_config = "autoTrainingConfig",
        .events_config = "eventsConfig",
    };
};
