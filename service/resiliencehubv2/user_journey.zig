/// Represents a user journey that defines a critical path through a system.
pub const UserJourney = struct {
    /// The timestamp when the user journey was created.
    created_at: ?i64 = null,

    description: ?[]const u8 = null,

    name: []const u8,

    policy_arn: ?[]const u8 = null,

    /// The timestamp when the user journey was last updated.
    updated_at: ?i64 = null,

    /// The unique identifier of the user journey.
    user_journey_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .policy_arn = "policyArn",
        .updated_at = "updatedAt",
        .user_journey_id = "userJourneyId",
    };
};
