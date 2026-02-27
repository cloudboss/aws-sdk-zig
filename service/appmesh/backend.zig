const VirtualServiceBackend = @import("virtual_service_backend.zig").VirtualServiceBackend;

/// An object that represents the backends that a virtual node is expected to
/// send outbound
/// traffic to.
pub const Backend = union(enum) {
    /// Specifies a virtual service to use as a backend.
    virtual_service: ?VirtualServiceBackend,

    pub const json_field_names = .{
        .virtual_service = "virtualService",
    };
};
