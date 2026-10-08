/// Represents a fault action that a test runs, along with the resource type it
/// targets.
pub const TestAction = struct {
    /// The identifier of the fault action.
    action_id: []const u8,

    /// A description of the fault action.
    description: ?[]const u8 = null,

    /// The resource type that the action targets.
    resource_type: []const u8,

    pub const json_field_names = .{
        .action_id = "actionId",
        .description = "description",
        .resource_type = "resourceType",
    };
};
