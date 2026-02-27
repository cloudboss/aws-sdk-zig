const CommandCapability = @import("command_capability.zig").CommandCapability;

/// The endpoint for a managed thing when sending a command.
pub const CommandEndpoint = struct {
    /// Describe the endpoint with an id, a name, and the relevant capabilities for
    /// sending commands.
    capabilities: []const CommandCapability,

    /// The id of the endpoint for a managed thing.
    endpoint_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .endpoint_id = "endpointId",
    };
};
