/// Represents a system associated with a service.
pub const AssociatedSystem = struct {
    system_arn: []const u8,

    system_name: ?[]const u8 = null,

    /// The list of user journey identifiers that associate this system with the
    /// service.
    user_journey_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .system_arn = "systemArn",
        .system_name = "systemName",
        .user_journey_ids = "userJourneyIds",
    };
};
