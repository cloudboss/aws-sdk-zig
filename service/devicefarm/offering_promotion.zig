/// Represents information about an offering promotion.
pub const OfferingPromotion = struct {
    /// A string that describes the offering promotion.
    description: ?[]const u8,

    /// The ID of the offering promotion.
    id: ?[]const u8,

    pub const json_field_names = .{
        .description = "description",
        .id = "id",
    };
};
