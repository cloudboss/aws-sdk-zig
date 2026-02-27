const ElasticLoadBalancing = @import("elastic_load_balancing.zig").ElasticLoadBalancing;
const IpFamily = @import("ip_family.zig").IpFamily;

/// The Kubernetes network configuration for the cluster. The response contains
/// a value for
/// **serviceIpv6Cidr** or **serviceIpv4Cidr**, but not both.
pub const KubernetesNetworkConfigResponse = struct {
    /// Indicates the current configuration of the load balancing capability on your
    /// EKS Auto
    /// Mode cluster. For example, if the capability is enabled or disabled.
    elastic_load_balancing: ?ElasticLoadBalancing,

    /// The IP family used to assign Kubernetes `Pod` and `Service` objects
    /// IP addresses. The IP family is always `ipv4`, unless you have a
    /// `1.21` or later cluster running version `1.10.1` or later of
    /// the Amazon VPC CNI plugin for Kubernetes and specified `ipv6` when you
    /// created the cluster.
    ip_family: ?IpFamily,

    /// The CIDR block that Kubernetes `Pod` and `Service` object IP
    /// addresses are assigned from. Kubernetes assigns addresses from an `IPv4`
    /// CIDR
    /// block assigned to a subnet that the node is in. If you didn't specify a CIDR
    /// block when
    /// you created the cluster, then Kubernetes assigns addresses from either the
    /// `10.100.0.0/16` or `172.20.0.0/16` CIDR blocks. If this was
    /// specified, then it was specified when the cluster was created and it can't
    /// be
    /// changed.
    service_ipv_4_cidr: ?[]const u8,

    /// The CIDR block that Kubernetes pod and service IP addresses are assigned
    /// from if you
    /// created a 1.21 or later cluster with version 1.10.1 or later of the Amazon
    /// VPC CNI add-on and
    /// specified `ipv6` for **ipFamily** when you
    /// created the cluster. Kubernetes assigns service addresses from the unique
    /// local address range
    /// (`fc00::/7`) because you can't specify a custom IPv6 CIDR block when you
    /// create the cluster.
    service_ipv_6_cidr: ?[]const u8,

    pub const json_field_names = .{
        .elastic_load_balancing = "elasticLoadBalancing",
        .ip_family = "ipFamily",
        .service_ipv_4_cidr = "serviceIpv4Cidr",
        .service_ipv_6_cidr = "serviceIpv6Cidr",
    };
};
