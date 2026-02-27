const Operation = @import("operation.zig").Operation;
const Service = @import("service.zig").Service;

/// Contains information on the permissions an account has within Amazon
/// Inspector.
pub const Permission = struct {
    /// The operations that can be performed with the given permissions.
    operation: Operation,

    /// The services that the permissions allow an account to perform the given
    /// operations
    /// for.
    service: Service,

    pub const json_field_names = .{
        .operation = "operation",
        .service = "service",
    };
};
