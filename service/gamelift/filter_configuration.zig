/// A list of fleet locations where a game session queue can place new game
/// sessions. You
/// can use a filter to temporarily exclude specific locations from receiving
/// placements.
/// For queues that have multi-location fleets, you can use a filter
/// configuration allow
/// placement with some, but not all, of a fleet's locations.
pub const FilterConfiguration = struct {
    /// A list of locations to allow game session placement in, in the form of
    /// Amazon Web Services Region
    /// codes such as `us-west-2`.
    allowed_locations: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allowed_locations = "AllowedLocations",
    };
};
