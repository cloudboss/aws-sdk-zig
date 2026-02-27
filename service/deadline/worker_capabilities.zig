const WorkerAmountCapability = @import("worker_amount_capability.zig").WorkerAmountCapability;
const WorkerAttributeCapability = @import("worker_attribute_capability.zig").WorkerAttributeCapability;

/// The details for worker capabilities.
pub const WorkerCapabilities = struct {
    /// The worker capabilities amounts on a list of worker capabilities.
    amounts: []const WorkerAmountCapability,

    /// The worker attribute capabilities in the list of attribute capabilities.
    attributes: []const WorkerAttributeCapability,

    pub const json_field_names = .{
        .amounts = "amounts",
        .attributes = "attributes",
    };
};
