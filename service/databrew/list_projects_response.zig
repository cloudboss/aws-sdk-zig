const Project = @import("project.zig").Project;

pub const ListProjectsResponse = struct {
    /// A token that you can use in a subsequent call to retrieve the next set of
    /// results.
    next_token: ?[]const u8 = null,

    /// A list of projects that are defined .
    projects: []const Project,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .projects = "Projects",
    };
};
