const ServiceReference = @import("service_reference.zig").ServiceReference;

/// Metadata for a system user journey created event.
pub const SystemUserJourneyCreatedMetadata = struct {
    /// The services associated with the created user journey.
    associated_services: ?[]const ServiceReference = null,

    /// The name of the created user journey.
    user_journey_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .associated_services = "associatedServices",
        .user_journey_name = "userJourneyName",
    };
};
