const StateCapability = @import("state_capability.zig").StateCapability;

/// Describe the endpoint with an Id, a name, and the relevant capabilities for
/// reporting state
pub const StateEndpoint = struct {
    /// Describe the endpoint with an id, a name, and the relevant capabilities for
    /// the reporting state.
    capabilities: []const StateCapability,

    /// Numeric identifier of the endpoint
    endpoint_id: []const u8,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .endpoint_id = "endpointId",
    };
};
