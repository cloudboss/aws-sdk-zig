const aws = @import("aws");

const DirectoryType = @import("directory_type.zig").DirectoryType;
const InstanceStatus = @import("instance_status.zig").InstanceStatus;
const InstanceStatusReason = @import("instance_status_reason.zig").InstanceStatusReason;

/// The Amazon Connect instance.
pub const Instance = struct {
    /// The Amazon Resource Name (ARN) of the instance.
    arn: ?[]const u8 = null,

    /// When the instance was created.
    created_time: ?i64 = null,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    id: ?[]const u8 = null,

    /// The identity management type.
    identity_management_type: ?DirectoryType = null,

    /// Whether inbound calls are enabled.
    inbound_calls_enabled: ?bool = null,

    /// This URL allows contact center users to access the Amazon Connect admin
    /// website.
    instance_access_url: ?[]const u8 = null,

    /// The alias of instance.
    instance_alias: ?[]const u8 = null,

    /// The state of the instance.
    instance_status: ?InstanceStatus = null,

    /// Whether outbound calls are enabled.
    outbound_calls_enabled: ?bool = null,

    /// The service role of the instance.
    service_role: ?[]const u8 = null,

    /// Relevant
    /// details why the instance was not successfully created.
    status_reason: ?InstanceStatusReason = null,

    /// The tags of an instance.
    tags: ?[]const aws.map.StringMapEntry = null,

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
        .status_reason = "StatusReason",
        .tags = "Tags",
    };
};
