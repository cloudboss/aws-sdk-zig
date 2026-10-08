const AssertionCreatedMetadata = @import("assertion_created_metadata.zig").AssertionCreatedMetadata;
const AssertionDeletedMetadata = @import("assertion_deleted_metadata.zig").AssertionDeletedMetadata;
const AssertionUpdatedMetadata = @import("assertion_updated_metadata.zig").AssertionUpdatedMetadata;
const ServiceAchievabilityUpdatedMetadata = @import("service_achievability_updated_metadata.zig").ServiceAchievabilityUpdatedMetadata;
const ServiceCreatedMetadata = @import("service_created_metadata.zig").ServiceCreatedMetadata;
const ServiceDeletedMetadata = @import("service_deleted_metadata.zig").ServiceDeletedMetadata;
const ServiceFunctionCreatedMetadata = @import("service_function_created_metadata.zig").ServiceFunctionCreatedMetadata;
const ServiceFunctionDeletedMetadata = @import("service_function_deleted_metadata.zig").ServiceFunctionDeletedMetadata;
const ServiceFunctionResourcesAddedMetadata = @import("service_function_resources_added_metadata.zig").ServiceFunctionResourcesAddedMetadata;
const ServiceFunctionResourcesRemovedMetadata = @import("service_function_resources_removed_metadata.zig").ServiceFunctionResourcesRemovedMetadata;
const ServiceFunctionUpdatedMetadata = @import("service_function_updated_metadata.zig").ServiceFunctionUpdatedMetadata;
const ServiceInputSourcesUpdatedMetadata = @import("service_input_sources_updated_metadata.zig").ServiceInputSourcesUpdatedMetadata;
const ServicePolicyAssociatedMetadata = @import("service_policy_associated_metadata.zig").ServicePolicyAssociatedMetadata;
const ServicePolicyDisassociatedMetadata = @import("service_policy_disassociated_metadata.zig").ServicePolicyDisassociatedMetadata;
const ServiceResourcesAssociatedMetadata = @import("service_resources_associated_metadata.zig").ServiceResourcesAssociatedMetadata;
const ServiceResourcesDisassociatedMetadata = @import("service_resources_disassociated_metadata.zig").ServiceResourcesDisassociatedMetadata;
const ServiceSystemAssociatedMetadata = @import("service_system_associated_metadata.zig").ServiceSystemAssociatedMetadata;
const ServiceSystemDisassociatedMetadata = @import("service_system_disassociated_metadata.zig").ServiceSystemDisassociatedMetadata;
const ServiceWorkflowUpdatedMetadata = @import("service_workflow_updated_metadata.zig").ServiceWorkflowUpdatedMetadata;

/// Type-specific metadata for each service event type.
pub const ServiceEventMetadata = union(enum) {
    /// Metadata for an assertion created event.
    assertion_created: ?AssertionCreatedMetadata,
    /// Metadata for an assertion deleted event.
    assertion_deleted: ?AssertionDeletedMetadata,
    /// Metadata for an assertion updated event.
    assertion_updated: ?AssertionUpdatedMetadata,
    /// Metadata for a service achievability updated event.
    service_achievability_updated: ?ServiceAchievabilityUpdatedMetadata,
    /// Metadata for a service created event.
    service_created: ?ServiceCreatedMetadata,
    /// Metadata for a service deleted event.
    service_deleted: ?ServiceDeletedMetadata,
    /// Metadata for a service function created event.
    service_function_created: ?ServiceFunctionCreatedMetadata,
    /// Metadata for a service function deleted event.
    service_function_deleted: ?ServiceFunctionDeletedMetadata,
    /// Metadata for a service function resources added event.
    service_function_resources_added: ?ServiceFunctionResourcesAddedMetadata,
    /// Metadata for a service function resources removed event.
    service_function_resources_removed: ?ServiceFunctionResourcesRemovedMetadata,
    /// Metadata for a service function updated event.
    service_function_updated: ?ServiceFunctionUpdatedMetadata,
    /// Metadata for a service input sources updated event.
    service_input_sources_updated: ?ServiceInputSourcesUpdatedMetadata,
    /// Metadata for a service policy associated event.
    service_policy_associated: ?ServicePolicyAssociatedMetadata,
    /// Metadata for a service policy disassociated event.
    service_policy_disassociated: ?ServicePolicyDisassociatedMetadata,
    /// Metadata for a service resources associated event.
    service_resources_associated: ?ServiceResourcesAssociatedMetadata,
    /// Metadata for a service resources disassociated event.
    service_resources_disassociated: ?ServiceResourcesDisassociatedMetadata,
    /// Metadata for a service system associated event.
    service_system_associated: ?ServiceSystemAssociatedMetadata,
    /// Metadata for a service system disassociated event.
    service_system_disassociated: ?ServiceSystemDisassociatedMetadata,
    /// Metadata for a service workflow updated event.
    service_workflow_updated: ?ServiceWorkflowUpdatedMetadata,

    pub const json_field_names = .{
        .assertion_created = "assertionCreated",
        .assertion_deleted = "assertionDeleted",
        .assertion_updated = "assertionUpdated",
        .service_achievability_updated = "serviceAchievabilityUpdated",
        .service_created = "serviceCreated",
        .service_deleted = "serviceDeleted",
        .service_function_created = "serviceFunctionCreated",
        .service_function_deleted = "serviceFunctionDeleted",
        .service_function_resources_added = "serviceFunctionResourcesAdded",
        .service_function_resources_removed = "serviceFunctionResourcesRemoved",
        .service_function_updated = "serviceFunctionUpdated",
        .service_input_sources_updated = "serviceInputSourcesUpdated",
        .service_policy_associated = "servicePolicyAssociated",
        .service_policy_disassociated = "servicePolicyDisassociated",
        .service_resources_associated = "serviceResourcesAssociated",
        .service_resources_disassociated = "serviceResourcesDisassociated",
        .service_system_associated = "serviceSystemAssociated",
        .service_system_disassociated = "serviceSystemDisassociated",
        .service_workflow_updated = "serviceWorkflowUpdated",
    };
};
