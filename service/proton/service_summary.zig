const ServiceStatus = @import("service_status.zig").ServiceStatus;

/// Summary data of an Proton service resource.
pub const ServiceSummary = struct {
    /// The Amazon Resource Name (ARN) of the service.
    arn: []const u8,

    /// The time when the service was created.
    created_at: i64,

    /// A description of the service.
    description: ?[]const u8,

    /// The time when the service was last modified.
    last_modified_at: i64,

    /// The name of the service.
    name: []const u8,

    /// The status of the service.
    status: ServiceStatus,

    /// A service status message.
    status_message: ?[]const u8,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .last_modified_at = "lastModifiedAt",
        .name = "name",
        .status = "status",
        .status_message = "statusMessage",
        .template_name = "templateName",
    };
};
