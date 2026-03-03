const SendingStatus = @import("sending_status.zig").SendingStatus;
const Tag = @import("tag.zig").Tag;

/// A structure that contains details about a tenant.
pub const Tenant = struct {
    /// The date and time when the tenant was created.
    created_timestamp: ?i64 = null,

    /// The status of sending capability for the tenant.
    sending_status: ?SendingStatus = null,

    /// An array of objects that define the tags (keys and values) associated with
    /// the tenant.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the tenant.
    tenant_arn: ?[]const u8 = null,

    /// A unique identifier for the tenant.
    tenant_id: ?[]const u8 = null,

    /// The name of the tenant.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .sending_status = "SendingStatus",
        .tags = "Tags",
        .tenant_arn = "TenantArn",
        .tenant_id = "TenantId",
        .tenant_name = "TenantName",
    };
};
