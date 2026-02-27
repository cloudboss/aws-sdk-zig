const ResourceMetadata = @import("resource_metadata.zig").ResourceMetadata;
const VirtualGatewaySpec = @import("virtual_gateway_spec.zig").VirtualGatewaySpec;
const VirtualGatewayStatus = @import("virtual_gateway_status.zig").VirtualGatewayStatus;

/// An object that represents a virtual gateway returned by a describe
/// operation.
pub const VirtualGatewayData = struct {
    /// The name of the service mesh that the virtual gateway resides in.
    mesh_name: []const u8,

    metadata: ResourceMetadata,

    /// The specifications of the virtual gateway.
    spec: VirtualGatewaySpec,

    /// The current status of the virtual gateway.
    status: VirtualGatewayStatus,

    /// The name of the virtual gateway.
    virtual_gateway_name: []const u8,

    pub const json_field_names = .{
        .mesh_name = "meshName",
        .metadata = "metadata",
        .spec = "spec",
        .status = "status",
        .virtual_gateway_name = "virtualGatewayName",
    };
};
