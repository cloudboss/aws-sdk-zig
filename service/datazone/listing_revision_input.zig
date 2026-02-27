/// A revision to be made to an asset published in a Amazon DataZone catalog.
pub const ListingRevisionInput = struct {
    /// An identifier of revision to be made to an asset published in a Amazon
    /// DataZone catalog.
    identifier: []const u8,

    /// The details of a revision to be made to an asset published in a Amazon
    /// DataZone catalog.
    revision: []const u8,

    pub const json_field_names = .{
        .identifier = "identifier",
        .revision = "revision",
    };
};
