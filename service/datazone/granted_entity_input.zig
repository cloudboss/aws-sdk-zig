const ListingRevisionInput = @import("listing_revision_input.zig").ListingRevisionInput;

/// The details of a listing for which a subscription is to be granted.
pub const GrantedEntityInput = union(enum) {
    /// The listing for which a subscription is to be granted.
    listing: ?ListingRevisionInput,

    pub const json_field_names = .{
        .listing = "listing",
    };
};
