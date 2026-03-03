const ProjectSummary = @import("project_summary.zig").ProjectSummary;

pub const ListProjectsResponse = struct {
    /// Information about the projects.
    items: ?[]const ProjectSummary = null,

    /// A token returned from a call to this API to indicate the next batch of
    /// results to return, if any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "items",
        .next_token = "nextToken",
    };
};
