/// Contains summary information about a user journey.
pub const UserJourneySummary = struct {
    /// The timestamp when the user journey was created.
    created_at: ?i64 = null,

    name: []const u8,

    /// The timestamp when the user journey was last updated.
    updated_at: ?i64 = null,

    /// The unique identifier of the user journey.
    user_journey_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .name = "name",
        .updated_at = "updatedAt",
        .user_journey_id = "userJourneyId",
    };
};
