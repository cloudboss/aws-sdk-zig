const TemplateFirewallType = @import("template_firewall_type.zig").TemplateFirewallType;
const EntityStatus = @import("entity_status.zig").EntityStatus;

/// Summary information about a template.
pub const TemplateSummary = struct {
    /// The firewall type associated with the resource.
    firewall_type: ?TemplateFirewallType = null,

    /// Specifies whether a published version of the resource exists.
    has_published_version: ?bool = null,

    /// The current status of the resource: `DRAFT` (unpublished, editable) or
    /// `ACTIVE` (published, in use).
    status: ?EntityStatus = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: []const u8,

    /// The service-generated id of the template.
    template_id: []const u8,

    /// The name of the template.
    template_name: []const u8,

    /// The time when the resource was last updated. For a snapshot, this is the
    /// time when the snapshot was created.
    updated_at: ?i64 = null,

    /// The version of the resource.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .firewall_type = "firewallType",
        .has_published_version = "hasPublishedVersion",
        .status = "status",
        .template_arn = "templateArn",
        .template_id = "templateId",
        .template_name = "templateName",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
