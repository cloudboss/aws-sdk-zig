const HealthState = @import("health_state.zig").HealthState;

/// A complex type for an endpoint. Each endpoint group can include one or more
/// endpoints, such as load
/// balancers.
pub const EndpointDescription = struct {
    /// Indicates whether client IP address preservation is enabled for an endpoint.
    /// The value is true or false. The default value is true for Application Load
    /// Balancers endpoints.
    ///
    /// If the value is set to true, the client's IP address is preserved in the
    /// `X-Forwarded-For` request header as
    /// traffic travels to applications on the endpoint fronted by the accelerator.
    ///
    /// Client IP address preservation is supported, in specific Amazon Web Services
    /// Regions, for endpoints that are Application Load
    /// Balancers, Amazon EC2 instances, and Network Load Balancers with security
    /// groups. IMPORTANT: You cannot use client IP address preservation
    /// with Network Load Balancers with TLS listeners.
    ///
    /// For more information, see [
    /// Preserve client IP addresses in Global
    /// Accelerator](https://docs.aws.amazon.com/global-accelerator/latest/dg/preserve-client-ip-address.html) in the *Global Accelerator Developer Guide*.
    client_ip_preservation_enabled: ?bool = null,

    /// An ID for the endpoint. If the endpoint is a Network Load Balancer or
    /// Application Load Balancer, this is the Amazon
    /// Resource Name (ARN) of the resource. If the endpoint is an Elastic IP
    /// address, this is the Elastic IP address
    /// allocation ID. For Amazon EC2 instances, this is the EC2 instance ID.
    ///
    /// An Application Load Balancer can be either internal or internet-facing.
    endpoint_id: ?[]const u8 = null,

    /// Returns a null result.
    health_reason: ?[]const u8 = null,

    /// The health status of the endpoint.
    health_state: ?HealthState = null,

    /// The weight associated with the endpoint. When you add weights to endpoints,
    /// you configure Global Accelerator to route traffic
    /// based on proportions that you specify. For example, you might specify
    /// endpoint weights of 4, 5, 5, and 6 (sum=20). The
    /// result is that 4/20 of your traffic, on average, is routed to the first
    /// endpoint, 5/20 is routed both to the second
    /// and third endpoints, and 6/20 is routed to the last endpoint. For more
    /// information, see [Endpoint
    /// weights](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-endpoints-endpoint-weights.html) in the
    /// *Global Accelerator Developer Guide*.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .client_ip_preservation_enabled = "ClientIPPreservationEnabled",
        .endpoint_id = "EndpointId",
        .health_reason = "HealthReason",
        .health_state = "HealthState",
        .weight = "Weight",
    };
};
