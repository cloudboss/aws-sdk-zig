const aws = @import("aws");

const HealthStatus = @import("health_status.zig").HealthStatus;

/// In a response to a
/// [DiscoverInstances](https://docs.aws.amazon.com/cloud-map/latest/api/API_DiscoverInstances.html) request,
/// `HttpInstanceSummary` contains information about one instance that matches
/// the values
/// that you specified in the request.
pub const HttpInstanceSummary = struct {
    /// If you included any attributes when you registered the instance, the values
    /// of those
    /// attributes.
    attributes: ?[]const aws.map.StringMapEntry,

    /// If you configured health checking in the service, the current health status
    /// of the service
    /// instance.
    health_status: ?HealthStatus,

    /// The ID of an instance that matches the values that you specified in the
    /// request.
    instance_id: ?[]const u8,

    /// The `HttpName` name of the namespace. It's found in the
    /// `HttpProperties` member of the `Properties` member of the
    /// namespace.
    namespace_name: ?[]const u8,

    /// The name of the service that you specified when you registered the instance.
    service_name: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .health_status = "HealthStatus",
        .instance_id = "InstanceId",
        .namespace_name = "NamespaceName",
        .service_name = "ServiceName",
    };
};
