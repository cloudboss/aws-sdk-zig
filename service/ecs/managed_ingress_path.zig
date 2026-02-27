const AccessType = @import("access_type.zig").AccessType;
const ManagedCertificate = @import("managed_certificate.zig").ManagedCertificate;
const ManagedListener = @import("managed_listener.zig").ManagedListener;
const ManagedLoadBalancer = @import("managed_load_balancer.zig").ManagedLoadBalancer;
const ManagedSecurityGroup = @import("managed_security_group.zig").ManagedSecurityGroup;
const ManagedListenerRule = @import("managed_listener_rule.zig").ManagedListenerRule;
const ManagedTargetGroup = @import("managed_target_group.zig").ManagedTargetGroup;

/// The entry point into the Express service.
pub const ManagedIngressPath = struct {
    /// The type of access to the endpoint for the Express service.
    access_type: AccessType,

    /// The ACM certificate for the Express service's domain.
    certificate: ?ManagedCertificate,

    /// The endpoint for access to the Express service.
    endpoint: []const u8,

    /// The listeners associated with the Application Load Balancer.
    listener: ?ManagedListener,

    /// The Application Load Balancer associated with the Express service.
    load_balancer: ?ManagedLoadBalancer,

    /// The security groups associated with the Application Load Balancer.
    load_balancer_security_groups: ?[]const ManagedSecurityGroup,

    /// The listener rules for the Application Load Balancer.
    rule: ?ManagedListenerRule,

    /// The target groups associated with the Application Load Balancer.
    target_groups: ?[]const ManagedTargetGroup,

    pub const json_field_names = .{
        .access_type = "accessType",
        .certificate = "certificate",
        .endpoint = "endpoint",
        .listener = "listener",
        .load_balancer = "loadBalancer",
        .load_balancer_security_groups = "loadBalancerSecurityGroups",
        .rule = "rule",
        .target_groups = "targetGroups",
    };
};
