const PortRange = @import("port_range.zig").PortRange;

/// A complex type for a listener for a custom routing accelerator.
pub const CustomRoutingListener = struct {
    /// The Amazon Resource Name (ARN) of the listener.
    listener_arn: ?[]const u8 = null,

    /// The port range to support for connections from clients to your accelerator.
    ///
    /// Separately, you set port ranges for endpoints. For more information, see
    /// [About
    /// endpoints for custom routing
    /// accelerators](https://docs.aws.amazon.com/global-accelerator/latest/dg/about-custom-routing-endpoints.html).
    port_ranges: ?[]const PortRange = null,

    pub const json_field_names = .{
        .listener_arn = "ListenerArn",
        .port_ranges = "PortRanges",
    };
};
