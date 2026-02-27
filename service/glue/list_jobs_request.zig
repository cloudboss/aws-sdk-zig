const aws = @import("aws");

pub const ListJobsRequest = struct {
    /// The maximum size of a list to return.
    max_results: ?i32,

    /// A continuation token, if this is a continuation request.
    next_token: ?[]const u8,

    /// Specifies to return only these tagged resources.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .tags = "Tags",
    };
};
