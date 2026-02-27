/// The information required to specify a Maven reference. You can use Maven
/// references to specify dependency JAR files.
pub const MavenReference = struct {
    /// The artifact ID of the Maven reference.
    artifact_id: []const u8,

    /// The group ID of the Maven reference.
    group_id: []const u8,

    /// The version of the Maven reference.
    version: []const u8,

    pub const json_field_names = .{
        .artifact_id = "ArtifactId",
        .group_id = "GroupId",
        .version = "Version",
    };
};
