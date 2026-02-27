/// An object that contains the ID and revision number of a workflow or system
/// that is part of a deployment.
pub const DependencyRevision = struct {
    /// The ID of the workflow or system.
    id: ?[]const u8,

    /// The revision number of the workflow or system.
    revision_number: ?i64,

    pub const json_field_names = .{
        .id = "id",
        .revision_number = "revisionNumber",
    };
};
