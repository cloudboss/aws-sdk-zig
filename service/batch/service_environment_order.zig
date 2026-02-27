/// Specifies the order of a service environment for a job queue. This
/// determines the priority order when multiple service environments are
/// associated with the same job queue.
pub const ServiceEnvironmentOrder = struct {
    /// The order of the service environment. Job queues with a higher priority are
    /// evaluated first when associated with the same service environment.
    order: i32,

    /// The name or ARN of the service environment.
    service_environment: []const u8,

    pub const json_field_names = .{
        .order = "order",
        .service_environment = "serviceEnvironment",
    };
};
