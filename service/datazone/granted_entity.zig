const ListingRevision = @import("listing_revision.zig").ListingRevision;

/// The details of a listing for which a subscription is granted.
pub const GrantedEntity = union(enum) {
    /// The listing for which a subscription is granted.
    listing: ?ListingRevision,

    pub const json_field_names = .{
        .listing = "listing",
    };
};
