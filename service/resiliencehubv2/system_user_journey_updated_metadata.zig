const UserJourneyChanges = @import("user_journey_changes.zig").UserJourneyChanges;

/// Metadata for a system user journey updated event.
pub const SystemUserJourneyUpdatedMetadata = struct {
    /// The changes made to the user journey.
    changes: ?UserJourneyChanges = null,

    /// The name of the updated user journey.
    user_journey_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .changes = "changes",
        .user_journey_name = "userJourneyName",
    };
};
