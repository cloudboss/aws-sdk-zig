const ListingStatus = @import("listing_status.zig").ListingStatus;

/// The details of an asset published in an Amazon DataZone catalog.
pub const AssetListingDetails = struct {
    /// The identifier of an asset published in an Amazon DataZone catalog.
    listing_id: []const u8,

    /// The status of an asset published in an Amazon DataZone catalog.
    listing_status: ListingStatus,

    pub const json_field_names = .{
        .listing_id = "listingId",
        .listing_status = "listingStatus",
    };
};
