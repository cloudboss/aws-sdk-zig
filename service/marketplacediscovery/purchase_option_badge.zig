const PurchaseOptionBadgeType = @import("purchase_option_badge_type.zig").PurchaseOptionBadgeType;

/// A badge indicating a special attribute of a purchase option, such as private
/// pricing or future dated.
pub const PurchaseOptionBadge = struct {
    /// The machine-readable type of the badge.
    badge_type: PurchaseOptionBadgeType,

    /// The human-readable name of the badge.
    display_name: []const u8,

    pub const json_field_names = .{
        .badge_type = "badgeType",
        .display_name = "displayName",
    };
};
