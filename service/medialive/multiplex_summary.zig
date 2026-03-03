const aws = @import("aws");

const MultiplexSettingsSummary = @import("multiplex_settings_summary.zig").MultiplexSettingsSummary;
const MultiplexState = @import("multiplex_state.zig").MultiplexState;

/// Placeholder documentation for MultiplexSummary
pub const MultiplexSummary = struct {
    /// The unique arn of the multiplex.
    arn: ?[]const u8 = null,

    /// A list of availability zones for the multiplex.
    availability_zones: ?[]const []const u8 = null,

    /// The unique id of the multiplex.
    id: ?[]const u8 = null,

    /// Configuration for a multiplex event.
    multiplex_settings: ?MultiplexSettingsSummary = null,

    /// The name of the multiplex.
    name: ?[]const u8 = null,

    /// The number of currently healthy pipelines.
    pipelines_running_count: ?i32 = null,

    /// The number of programs in the multiplex.
    program_count: ?i32 = null,

    /// The current state of the multiplex.
    state: ?MultiplexState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zones = "AvailabilityZones",
        .id = "Id",
        .multiplex_settings = "MultiplexSettings",
        .name = "Name",
        .pipelines_running_count = "PipelinesRunningCount",
        .program_count = "ProgramCount",
        .state = "State",
        .tags = "Tags",
    };
};
