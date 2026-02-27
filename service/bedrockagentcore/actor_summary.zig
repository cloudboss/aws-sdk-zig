/// Contains summary information about an actor in an AgentCore Memory resource.
pub const ActorSummary = struct {
    /// The unique identifier of the actor.
    actor_id: []const u8,

    pub const json_field_names = .{
        .actor_id = "actorId",
    };
};
