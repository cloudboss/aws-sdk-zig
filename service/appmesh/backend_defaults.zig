const ClientPolicy = @import("client_policy.zig").ClientPolicy;

/// An object that represents the default properties for a backend.
pub const BackendDefaults = struct {
    /// A reference to an object that represents a client policy.
    client_policy: ?ClientPolicy = null,

    pub const json_field_names = .{
        .client_policy = "clientPolicy",
    };
};
