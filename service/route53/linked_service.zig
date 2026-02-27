/// If a health check or hosted zone was created by another service,
/// `LinkedService` is a complex type that describes the service that created
/// the resource. When a resource is created by another service, you can't edit
/// or delete it
/// using Amazon Route 53.
pub const LinkedService = struct {
    /// If the health check or hosted zone was created by another service, an
    /// optional
    /// description that can be provided by the other service. When a resource is
    /// created by
    /// another service, you can't edit or delete it using Amazon Route 53.
    description: ?[]const u8,

    /// If the health check or hosted zone was created by another service, the
    /// service that
    /// created the resource. When a resource is created by another service, you
    /// can't edit or
    /// delete it using Amazon Route 53.
    service_principal: ?[]const u8,
};
