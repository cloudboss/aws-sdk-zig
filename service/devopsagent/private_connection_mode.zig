const SelfManagedInput = @import("self_managed_input.zig").SelfManagedInput;
const ServiceManagedInput = @import("service_managed_input.zig").ServiceManagedInput;

/// Private Connection mode — either service-managed or self-managed.
pub const PrivateConnectionMode = union(enum) {
    /// Caller manages their own resource configuration.
    self_managed: ?SelfManagedInput,
    /// Service manages the Resource Gateway lifecycle.
    service_managed: ?ServiceManagedInput,

    pub const json_field_names = .{
        .self_managed = "selfManaged",
        .service_managed = "serviceManaged",
    };
};
