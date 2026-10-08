/// Contains summary information about a system.
pub const SystemSummary = struct {
    /// The timestamp when the system was created.
    created_at: ?i64 = null,

    name: []const u8,

    /// Displayed only if caller has access.
    organization_id: ?[]const u8 = null,

    /// Displayed only if caller has access.
    ou_id: ?[]const u8 = null,

    /// The number of services in the system.
    services_count: ?i32 = null,

    system_arn: ?[]const u8 = null,

    system_id: []const u8,

    /// The timestamp when the system was last updated.
    updated_at: ?i64 = null,

    /// The number of user journeys in the system.
    user_journeys_count: ?i32 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .name = "name",
        .organization_id = "organizationId",
        .ou_id = "ouId",
        .services_count = "servicesCount",
        .system_arn = "systemArn",
        .system_id = "systemId",
        .updated_at = "updatedAt",
        .user_journeys_count = "userJourneysCount",
    };
};
