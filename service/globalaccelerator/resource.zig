/// A resource is one of the following: the ARN for an Amazon Web Services
/// resource that is supported by
/// Global Accelerator to be added as an endpoint, or a CIDR range that
/// specifies a bring your own IP (BYOIP) address pool.
pub const Resource = struct {
    /// An IP address range, in CIDR format, that is specified as resource. The
    /// address must
    /// be provisioned and advertised in Global Accelerator by following the bring
    /// your own IP address (BYOIP) process
    /// for Global Accelerator
    ///
    /// For more information, see
    /// [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/global-accelerator/latest/dg/using-byoip.html) in
    /// the Global Accelerator Developer Guide.
    cidr: ?[]const u8 = null,

    /// The endpoint ID for the endpoint that is specified as a Amazon Web Services
    /// resource.
    ///
    /// An endpoint ID for the cross-account feature is the ARN of an Amazon Web
    /// Services resource, such as a
    /// Network Load Balancer, that Global Accelerator supports as an endpoint for
    /// an accelerator.
    endpoint_id: []const u8 = "",

    /// The Amazon Web Services Region where a shared endpoint resource is located.
    region: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr = "Cidr",
        .endpoint_id = "EndpointId",
        .region = "Region",
    };
};
