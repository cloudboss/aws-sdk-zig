const ClientPolicy = @import("client_policy.zig").ClientPolicy;

/// An object that represents a virtual service backend for a virtual node.
pub const VirtualServiceBackend = struct {
    /// A reference to an object that represents the client policy for a backend.
    client_policy: ?ClientPolicy,

    /// The name of the virtual service that is acting as a virtual node backend.
    virtual_service_name: []const u8,

    pub const json_field_names = .{
        .client_policy = "clientPolicy",
        .virtual_service_name = "virtualServiceName",
    };
};
