const AutoScalingMode = @import("auto_scaling_mode.zig").AutoScalingMode;
const TagPropagationMode = @import("tag_propagation_mode.zig").TagPropagationMode;
const CustomerManagedWorkerCapabilities = @import("customer_managed_worker_capabilities.zig").CustomerManagedWorkerCapabilities;

/// The configuration details for a customer managed fleet.
pub const CustomerManagedFleetConfiguration = struct {
    /// The Auto Scaling mode for the customer managed fleet.
    mode: AutoScalingMode,

    /// The storage profile ID for the customer managed fleet.
    storage_profile_id: ?[]const u8,

    /// The tag propagation mode for the customer managed fleet.
    tag_propagation_mode: ?TagPropagationMode,

    /// The worker capabilities for the customer managed fleet.
    worker_capabilities: CustomerManagedWorkerCapabilities,

    pub const json_field_names = .{
        .mode = "mode",
        .storage_profile_id = "storageProfileId",
        .tag_propagation_mode = "tagPropagationMode",
        .worker_capabilities = "workerCapabilities",
    };
};
