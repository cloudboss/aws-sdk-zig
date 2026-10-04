const ConsentPortalSource = @import("consent_portal_source.zig").ConsentPortalSource;
const ConsentPortalStatus = @import("consent_portal_status.zig").ConsentPortalStatus;

/// Summary information about a consent portal.
pub const ConsentPortalSummary = struct {
    /// The Amazon Resource Name (ARN) of the consent portal.
    consent_portal_arn: []const u8,

    /// The unique identifier of the consent portal.
    consent_portal_id: []const u8,

    /// The timestamp for when the consent portal was created.
    created_at: i64,

    /// The description of the consent portal.
    description: ?[]const u8 = null,

    /// The name of the consent portal.
    name: []const u8,

    /// The URL used to access the consent portal.
    portal_url: ?[]const u8 = null,

    /// The resources served by the consent portal.
    sources: []const ConsentPortalSource,

    /// The current status of the consent portal.
    status: ConsentPortalStatus,

    /// The timestamp for when the consent portal was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .consent_portal_arn = "consentPortalArn",
        .consent_portal_id = "consentPortalId",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .portal_url = "portalUrl",
        .sources = "sources",
        .status = "status",
        .updated_at = "updatedAt",
    };
};
