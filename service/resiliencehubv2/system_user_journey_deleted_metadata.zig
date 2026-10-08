const ServiceReference = @import("service_reference.zig").ServiceReference;

/// Metadata for a system user journey deleted event.
pub const SystemUserJourneyDeletedMetadata = struct {
    /// The services that were associated at the time of deletion.
    associated_services_at_deletion: ?[]const ServiceReference = null,

    /// The name of the deleted user journey.
    user_journey_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_services_at_deletion = "associatedServicesAtDeletion",
        .user_journey_name = "userJourneyName",
    };
};
