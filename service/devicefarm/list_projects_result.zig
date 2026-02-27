const Project = @import("project.zig").Project;

/// Represents the result of a list projects request.
pub const ListProjectsResult = struct {
    /// If the number of items that are returned is significantly large, this is an
    /// identifier that is also
    /// returned. It can be used in a subsequent call to this operation to return
    /// the next set of items in the
    /// list.
    next_token: ?[]const u8,

    /// Information about the projects.
    projects: ?[]const Project,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .projects = "projects",
    };
};
