const ProjectListFilter = @import("project_list_filter.zig").ProjectListFilter;

pub const ListProjectsRequest = struct {
    /// Information about filters to apply to narrow the results returned in the
    /// list.
    filters: ?[]const ProjectListFilter,

    /// The maximum number of results to show in a single call to this API. If the
    /// number of results is larger than the number you specified, the response will
    /// include a `NextToken` element, which you can use to obtain additional
    /// results.
    max_results: ?i32,

    /// A token returned from a call to this API to indicate the next batch of
    /// results to return, if any.
    next_token: ?[]const u8,

    /// The name of the space.
    space_name: []const u8,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .space_name = "spaceName",
    };
};
