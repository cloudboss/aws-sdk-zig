const WorkspaceResourceAssociation = @import("workspace_resource_association.zig").WorkspaceResourceAssociation;

/// Describes the WorkSpace application deployment.
pub const WorkSpaceApplicationDeployment = struct {
    /// The associations between the applications and the associated resources.
    associations: ?[]const WorkspaceResourceAssociation = null,

    pub const json_field_names = .{
        .associations = "Associations",
    };
};
