const SelfManagedInput = @import("self_managed_input.zig").SelfManagedInput;
const ServiceManagedInput = @import("service_managed_input.zig").ServiceManagedInput;

/// The configuration for a private connection. Specify either a service-managed
/// or a self-managed mode.
pub const PrivateConnectionMode = union(enum) {
    /// The configuration for a self-managed private connection, where you manage
    /// your own resource configuration.
    self_managed: ?SelfManagedInput,
    /// The configuration for a service-managed private connection, where the
    /// service manages the resource gateway lifecycle.
    service_managed: ?ServiceManagedInput,

    pub const json_field_names = .{
        .self_managed = "selfManaged",
        .service_managed = "serviceManaged",
    };
};
