/// The attributes of a vector in the approximate nearest neighbor search.
pub const QueryOutputVector = struct {
    /// The measure of similarity between the vector in the response and the query
    /// vector.
    distance: ?f32,

    /// The key of the vector in the approximate nearest neighbor search.
    key: []const u8,

    /// The metadata associated with the vector, if requested.
    metadata: ?[]const u8,

    pub const json_field_names = .{
        .distance = "distance",
        .key = "key",
        .metadata = "metadata",
    };
};
