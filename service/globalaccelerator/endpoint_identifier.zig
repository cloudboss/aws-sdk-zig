/// A complex type for an endpoint. Specifies information about the endpoint to
/// remove from the endpoint group.
pub const EndpointIdentifier = struct {
    /// Indicates whether client IP address preservation is enabled for an endpoint.
    /// The value is true or false.
    ///
    /// If the value is set to true, the client's IP address is preserved in the
    /// `X-Forwarded-For` request header as
    /// traffic travels to applications on the endpoint fronted by the accelerator.
    client_ip_preservation_enabled: ?bool,

    /// An ID for the endpoint. If the endpoint is a Network Load Balancer or
    /// Application Load Balancer, this is the Amazon
    /// Resource Name (ARN) of the resource. If the endpoint is an Elastic IP
    /// address, this is the Elastic IP address
    /// allocation ID. For Amazon EC2 instances, this is the EC2 instance ID.
    ///
    /// An Application Load Balancer can be either internal or internet-facing.
    endpoint_id: []const u8,

    pub const json_field_names = .{
        .client_ip_preservation_enabled = "ClientIPPreservationEnabled",
        .endpoint_id = "EndpointId",
    };
};
