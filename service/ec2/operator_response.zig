/// Describes whether the resource is managed by a service provider and, if so,
/// describes
/// the service provider that manages it.
pub const OperatorResponse = struct {
    /// If `true`, the resource is managed by a service provider.
    managed: ?bool = null,

    /// If `managed` is `true`, then the principal is returned. The
    /// principal is the service provider that manages the resource.
    principal: ?[]const u8 = null,
};
