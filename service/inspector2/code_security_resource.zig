/// Identifies a specific resource in a code repository that will be scanned.
pub const CodeSecurityResource = union(enum) {
    /// The unique identifier of the project in the code repository.
    project_id: ?[]const u8,

    pub const json_field_names = .{
        .project_id = "projectId",
    };
};
