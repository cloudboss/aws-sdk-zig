const PartnerIntegrationStatus = @import("partner_integration_status.zig").PartnerIntegrationStatus;

/// Describes a partner integration.
pub const PartnerIntegrationInfo = struct {
    /// The date (UTC) that the partner integration was created.
    created_at: ?i64 = null,

    /// The name of the database that receives data from a partner.
    database_name: ?[]const u8 = null,

    /// The name of the partner.
    partner_name: ?[]const u8 = null,

    /// The partner integration status.
    status: ?PartnerIntegrationStatus = null,

    /// The status message provided by the partner.
    status_message: ?[]const u8 = null,

    /// The date (UTC) that the partner integration status was last updated by the
    /// partner.
    updated_at: ?i64 = null,
};
