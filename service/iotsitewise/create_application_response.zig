const ApplicationStatus = @import("application_status.zig").ApplicationStatus;

pub const CreateApplicationResponse = struct {
    /// ARN of the application
    arn: []const u8,

    /// DNS subdomain for the application
    dns_subdomain: []const u8,

    /// Unique identifier of the application
    id: []const u8,

    /// Name of the application
    name: []const u8,

    /// Current status of the application
    status: ApplicationStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .dns_subdomain = "dnsSubdomain",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
