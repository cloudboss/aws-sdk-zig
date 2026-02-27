const PortalResource = @import("portal_resource.zig").PortalResource;
const ProjectResource = @import("project_resource.zig").ProjectResource;

/// Contains an IoT SiteWise Monitor resource ID for a portal or project.
pub const Resource = struct {
    /// A portal resource.
    portal: ?PortalResource,

    /// A project resource.
    project: ?ProjectResource,

    pub const json_field_names = .{
        .portal = "portal",
        .project = "project",
    };
};
