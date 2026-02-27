const ServiceName = @import("service_name.zig").ServiceName;
const ServiceVersion = @import("service_version.zig").ServiceVersion;

/// The name and version of the service dependant on the requested service.
pub const DependentService = struct {
    /// The name of the dependent service.
    service_name: ?ServiceName,

    /// The version of the dependent service.
    service_version: ?ServiceVersion,

    pub const json_field_names = .{
        .service_name = "ServiceName",
        .service_version = "ServiceVersion",
    };
};
