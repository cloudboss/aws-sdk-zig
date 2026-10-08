const ServiceReferenceChanges = @import("service_reference_changes.zig").ServiceReferenceChanges;
const StringChange = @import("string_change.zig").StringChange;

/// Describes changes made to a user journey.
pub const UserJourneyChanges = struct {
    /// Changes to the services associated with the user journey.
    associated_services: ?ServiceReferenceChanges = null,

    /// Changes to the user journey description.
    journey_description: ?StringChange = null,

    pub const json_field_names = .{
        .associated_services = "associatedServices",
        .journey_description = "journeyDescription",
    };
};
