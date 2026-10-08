const ListingBadgeType = @import("listing_badge_type.zig").ListingBadgeType;

/// A badge indicating a special attribute of a listing, such as free tier
/// eligibility or Quick Launch support.
pub const ListingBadge = struct {
    /// The machine-readable type of the badge.
    badge_type: ListingBadgeType,

    /// The human-readable name of the badge.
    display_name: []const u8,

    pub const json_field_names = .{
        .badge_type = "badgeType",
        .display_name = "displayName",
    };
};
