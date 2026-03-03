const CapabilityOptions = @import("capability_options.zig").CapabilityOptions;

/// A structure that contains the details for a partnership. A partnership
/// represents the connection between you and your trading partner. It ties
/// together a profile and one or more trading capabilities.
pub const PartnershipSummary = struct {
    /// Returns one or more capabilities associated with this partnership.
    capabilities: ?[]const []const u8 = null,

    capability_options: ?CapabilityOptions = null,

    /// Returns a timestamp for creation date and time of the partnership.
    created_at: i64,

    /// Returns a timestamp that identifies the most recent date and time that the
    /// partnership was modified.
    modified_at: ?i64 = null,

    /// Returns the name of the partnership.
    name: ?[]const u8 = null,

    /// Returns the unique, system-generated identifier for a partnership.
    partnership_id: []const u8,

    /// Returns the unique, system-generated identifier for the profile connected to
    /// this partnership.
    profile_id: []const u8,

    /// Returns the unique, system-generated identifier for a trading partner.
    trading_partner_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .capabilities = "capabilities",
        .capability_options = "capabilityOptions",
        .created_at = "createdAt",
        .modified_at = "modifiedAt",
        .name = "name",
        .partnership_id = "partnershipId",
        .profile_id = "profileId",
        .trading_partner_id = "tradingPartnerId",
    };
};
