const DirectoryType = @import("directory_type.zig").DirectoryType;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;

/// Information about the instance.
pub const InstanceSummary = struct {
    /// The Amazon Resource Name (ARN) of the instance.
    arn: ?[]const u8 = null,

    /// When the instance was created.
    created_time: ?i64 = null,

    /// The identifier of the instance.
    id: ?[]const u8 = null,

    /// The identity management type of the instance.
    identity_management_type: ?DirectoryType = null,

    /// Whether inbound calls are enabled.
    inbound_calls_enabled: ?bool = null,

    /// This URL allows contact center users to access the Amazon Connect admin
    /// website.
    instance_access_url: ?[]const u8 = null,

    /// The alias of the instance.
    instance_alias: ?[]const u8 = null,

    /// The state of the instance.
    instance_status: ?InstanceStatus = null,

    /// Whether outbound calls are enabled.
    outbound_calls_enabled: ?bool = null,

    /// The service role of the instance.
    service_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .id = "Id",
        .identity_management_type = "IdentityManagementType",
        .inbound_calls_enabled = "InboundCallsEnabled",
        .instance_access_url = "InstanceAccessUrl",
        .instance_alias = "InstanceAlias",
        .instance_status = "InstanceStatus",
        .outbound_calls_enabled = "OutboundCallsEnabled",
        .service_role = "ServiceRole",
    };
};
