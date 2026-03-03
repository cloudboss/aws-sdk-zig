/// Information about the `ConnectionDraining` attribute.
pub const ConnectionDraining = struct {
    /// Specifies whether connection draining is enabled for the load balancer.
    enabled: bool = false,

    /// The maximum time, in seconds, to keep the existing connections open before
    /// deregistering the instances.
    timeout: ?i32 = null,
};
