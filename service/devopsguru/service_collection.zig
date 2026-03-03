const ServiceName = @import("service_name.zig").ServiceName;

/// A collection of the names of Amazon Web Services services.
pub const ServiceCollection = struct {
    /// An array of strings that each specifies the name of an Amazon Web Services
    /// service.
    service_names: ?[]const ServiceName = null,

    pub const json_field_names = .{
        .service_names = "ServiceNames",
    };
};
