const aws = @import("aws");

const Branch = @import("branch.zig").Branch;
const MetadataValue = @import("metadata_value.zig").MetadataValue;
const PayloadType = @import("payload_type.zig").PayloadType;

/// Contains information about an event in an AgentCore Memory resource.
pub const Event = struct {
    /// The identifier of the actor associated with the event.
    actor_id: []const u8,

    /// The branch information for the event.
    branch: ?Branch,

    /// The unique identifier of the event.
    event_id: []const u8,

    /// The timestamp when the event occurred.
    event_timestamp: i64,

    /// The identifier of the AgentCore Memory resource containing the event.
    memory_id: []const u8,

    /// Metadata associated with an event.
    metadata: ?[]const aws.map.MapEntry(MetadataValue),

    /// The content payload of the event.
    payload: []const PayloadType,

    /// The identifier of the session containing the event.
    session_id: []const u8,

    pub const json_field_names = .{
        .actor_id = "actorId",
        .branch = "branch",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .memory_id = "memoryId",
        .metadata = "metadata",
        .payload = "payload",
        .session_id = "sessionId",
    };
};
