const CustomRoutingDestinationDescription = @import("custom_routing_destination_description.zig").CustomRoutingDestinationDescription;
const CustomRoutingEndpointDescription = @import("custom_routing_endpoint_description.zig").CustomRoutingEndpointDescription;

/// A complex type for the endpoint group for a custom routing accelerator. An
/// Amazon Web Services Region can have only one endpoint group for a specific
/// listener.
pub const CustomRoutingEndpointGroup = struct {
    /// For a custom routing accelerator, describes the port range and protocol for
    /// all endpoints
    /// (virtual private cloud subnets) in an endpoint group to accept client
    /// traffic on.
    destination_descriptions: ?[]const CustomRoutingDestinationDescription = null,

    /// For a custom routing accelerator, describes the endpoints (virtual private
    /// cloud subnets) in an
    /// endpoint group to accept client traffic on.
    endpoint_descriptions: ?[]const CustomRoutingEndpointDescription = null,

    /// The Amazon Resource Name (ARN) of the endpoint group.
    endpoint_group_arn: ?[]const u8 = null,

    /// The Amazon Web Services Region where the endpoint group is located.
    endpoint_group_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_descriptions = "DestinationDescriptions",
        .endpoint_descriptions = "EndpointDescriptions",
        .endpoint_group_arn = "EndpointGroupArn",
        .endpoint_group_region = "EndpointGroupRegion",
    };
};
