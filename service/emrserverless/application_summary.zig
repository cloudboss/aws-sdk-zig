const Architecture = @import("architecture.zig").Architecture;
const ApplicationState = @import("application_state.zig").ApplicationState;

/// The summary of attributes associated with an application.
pub const ApplicationSummary = struct {
    /// The CPU architecture of an application.
    architecture: ?Architecture = null,

    /// The ARN of the application.
    arn: []const u8,

    /// The date and time when the application was created.
    created_at: i64,

    /// The ID of the application.
    id: []const u8,

    /// The name of the application.
    name: ?[]const u8 = null,

    /// The Amazon EMR release associated with the application.
    release_label: []const u8,

    /// The state of the application.
    state: ApplicationState,

    /// The state details of the application.
    state_details: ?[]const u8 = null,

    /// The type of application, such as Spark or Hive.
    @"type": []const u8,

    /// The date and time when the application was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .architecture = "architecture",
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .name = "name",
        .release_label = "releaseLabel",
        .state = "state",
        .state_details = "stateDetails",
        .@"type" = "type",
        .updated_at = "updatedAt",
    };
};
