/// An object that contains the ID and revision number of a workflow or system
/// that is part of a deployment.
pub const DependencyRevision = struct {
    /// The ID of the workflow or system.
    id: ?[]const u8 = null,

    /// The revision number of the workflow or system.
    revision_number: ?i64 = null,

    pub const json_field_names = .{
        .id = "id",
        .revision_number = "revisionNumber",
    };
};
