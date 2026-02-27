const SocketAddress = @import("socket_address.zig").SocketAddress;
const EndpointStatus = @import("endpoint_status.zig").EndpointStatus;

/// Information about a dataflow endpoint.
pub const DataflowEndpoint = struct {
    /// Socket address of a dataflow endpoint.
    address: ?SocketAddress,

    /// Maximum transmission unit (MTU) size in bytes of a dataflow endpoint.
    mtu: ?i32,

    /// Name of a dataflow endpoint.
    name: ?[]const u8,

    /// Status of a dataflow endpoint.
    status: ?EndpointStatus,

    pub const json_field_names = .{
        .address = "address",
        .mtu = "mtu",
        .name = "name",
        .status = "status",
    };
};
