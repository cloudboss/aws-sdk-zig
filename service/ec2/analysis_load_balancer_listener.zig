/// Describes a load balancer listener.
pub const AnalysisLoadBalancerListener = struct {
    /// [Classic Load Balancers] The back-end port for the listener.
    instance_port: ?i32,

    /// The port on which the load balancer is listening.
    load_balancer_port: ?i32,
};
