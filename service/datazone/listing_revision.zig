/// A revision of an asset published in a Amazon DataZone catalog.
pub const ListingRevision = struct {
    /// An identifier of a revision of an asset published in a Amazon DataZone
    /// catalog.
    id: []const u8,

    /// The details of a revision of an asset published in a Amazon DataZone
    /// catalog.
    revision: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .revision = "revision",
    };
};
