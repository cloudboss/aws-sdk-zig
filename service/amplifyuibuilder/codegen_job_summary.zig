/// A summary of the basic information about the code generation job.
pub const CodegenJobSummary = struct {
    /// The unique ID of the Amplify app associated with the code generation job.
    app_id: []const u8,

    /// The time that the code generation job summary was created.
    created_at: ?i64 = null,

    /// The name of the backend environment associated with the code generation job.
    environment_name: []const u8,

    /// The unique ID for the code generation job summary.
    id: []const u8,

    /// The time that the code generation job summary was modified.
    modified_at: ?i64 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .created_at = "createdAt",
        .environment_name = "environmentName",
        .id = "id",
        .modified_at = "modifiedAt",
    };
};
