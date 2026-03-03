const aws = @import("aws");

/// Information about a document that matches the search request.
pub const Hit = struct {
    /// The expressions returned from a document that matches the search request.
    exprs: ?[]const aws.map.StringMapEntry = null,

    /// The fields returned from a document that matches the search request.
    fields: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The highlights returned from a document that matches the search request.
    highlights: ?[]const aws.map.StringMapEntry = null,

    /// The document ID of a document that matches the search request.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .exprs = "exprs",
        .fields = "fields",
        .highlights = "highlights",
        .id = "id",
    };
};
