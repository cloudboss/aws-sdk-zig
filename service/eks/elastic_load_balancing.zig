/// Indicates the current configuration of the load balancing capability on your
/// EKS Auto
/// Mode cluster. For example, if the capability is enabled or disabled. For
/// more
/// information, see EKS Auto Mode load balancing capability in the *Amazon EKS
/// User Guide*.
pub const ElasticLoadBalancing = struct {
    /// Indicates if the load balancing capability is enabled on your EKS Auto Mode
    /// cluster.
    /// If the load balancing capability is enabled, EKS Auto Mode will create and
    /// delete load
    /// balancers in your Amazon Web Services account.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
