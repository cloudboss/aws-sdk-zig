const SystemCreatedMetadata = @import("system_created_metadata.zig").SystemCreatedMetadata;
const SystemDeletedMetadata = @import("system_deleted_metadata.zig").SystemDeletedMetadata;
const SystemPolicyAssociatedMetadata = @import("system_policy_associated_metadata.zig").SystemPolicyAssociatedMetadata;
const SystemPolicyDisassociatedMetadata = @import("system_policy_disassociated_metadata.zig").SystemPolicyDisassociatedMetadata;
const SystemServiceAssociatedMetadata = @import("system_service_associated_metadata.zig").SystemServiceAssociatedMetadata;
const SystemServiceDisassociatedMetadata = @import("system_service_disassociated_metadata.zig").SystemServiceDisassociatedMetadata;
const SystemUserJourneyCreatedMetadata = @import("system_user_journey_created_metadata.zig").SystemUserJourneyCreatedMetadata;
const SystemUserJourneyDeletedMetadata = @import("system_user_journey_deleted_metadata.zig").SystemUserJourneyDeletedMetadata;
const SystemUserJourneyUpdatedMetadata = @import("system_user_journey_updated_metadata.zig").SystemUserJourneyUpdatedMetadata;

/// Type-specific metadata for each system event type.
pub const SystemEventMetadata = union(enum) {
    /// Metadata for a system created event.
    system_created: ?SystemCreatedMetadata,
    /// Metadata for a system deleted event.
    system_deleted: ?SystemDeletedMetadata,
    /// Metadata for a system policy associated event.
    system_policy_associated: ?SystemPolicyAssociatedMetadata,
    /// Metadata for a system policy disassociated event.
    system_policy_disassociated: ?SystemPolicyDisassociatedMetadata,
    /// Metadata for a system service associated event.
    system_service_associated: ?SystemServiceAssociatedMetadata,
    /// Metadata for a system service disassociated event.
    system_service_disassociated: ?SystemServiceDisassociatedMetadata,
    /// Metadata for a system user journey created event.
    system_user_journey_created: ?SystemUserJourneyCreatedMetadata,
    /// Metadata for a system user journey deleted event.
    system_user_journey_deleted: ?SystemUserJourneyDeletedMetadata,
    /// Metadata for a system user journey updated event.
    system_user_journey_updated: ?SystemUserJourneyUpdatedMetadata,

    pub const json_field_names = .{
        .system_created = "systemCreated",
        .system_deleted = "systemDeleted",
        .system_policy_associated = "systemPolicyAssociated",
        .system_policy_disassociated = "systemPolicyDisassociated",
        .system_service_associated = "systemServiceAssociated",
        .system_service_disassociated = "systemServiceDisassociated",
        .system_user_journey_created = "systemUserJourneyCreated",
        .system_user_journey_deleted = "systemUserJourneyDeleted",
        .system_user_journey_updated = "systemUserJourneyUpdated",
    };
};
