const NotebookType = @import("notebook_type.zig").NotebookType;

/// Contains metadata for notebook, including the notebook name, ID, workgroup,
/// and time
/// created.
pub const NotebookMetadata = struct {
    /// The time when the notebook was created.
    creation_time: ?i64 = null,

    /// The time when the notebook was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the notebook.
    name: ?[]const u8 = null,

    /// The notebook ID.
    notebook_id: ?[]const u8 = null,

    /// The type of notebook. Currently, the only valid type is `IPYNB`.
    @"type": ?NotebookType = null,

    /// The name of the Spark enabled workgroup to which the notebook belongs.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .notebook_id = "NotebookId",
        .@"type" = "Type",
        .work_group = "WorkGroup",
    };
};
