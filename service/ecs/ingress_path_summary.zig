const AccessType = @import("access_type.zig").AccessType;

/// The entry point into an Express service.
pub const IngressPathSummary = struct {
    /// The type of access to the endpoint for the Express service.
    access_type: AccessType,

    /// The endpoint for access to the service.
    endpoint: []const u8,

    pub const json_field_names = .{
        .access_type = "accessType",
        .endpoint = "endpoint",
    };
};
