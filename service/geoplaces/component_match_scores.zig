const AddressComponentMatchScores = @import("address_component_match_scores.zig").AddressComponentMatchScores;

/// Indicates how well the returned title and address components matches the
/// input TextQuery. For each component a score is provied with 1 indicating all
/// tokens were matched and 0 indicating no tokens were matched.
pub const ComponentMatchScores = struct {
    /// The place's address.
    address: ?AddressComponentMatchScores = null,

    /// Indicates the match score of the title in the text query that match the
    /// found title.
    title: f64 = 0,

    pub const json_field_names = .{
        .address = "Address",
        .title = "Title",
    };
};
