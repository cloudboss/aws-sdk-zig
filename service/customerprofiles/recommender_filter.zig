const aws = @import("aws");

/// A filter that specifies criteria for including or excluding items from
/// recommendations.
pub const RecommenderFilter = struct {
    /// The name of the recommender filter to apply.
    name: ?[]const u8 = null,

    /// The values to use when filtering recommendations. For each placeholder
    /// parameter in your filter expression, provide the parameter name (in matching
    /// case) as a key and the filter value(s) as the corresponding value. Separate
    /// multiple values for one parameter with a comma.
    values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
