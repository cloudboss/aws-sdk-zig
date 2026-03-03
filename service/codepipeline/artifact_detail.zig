const S3Location = @import("s3_location.zig").S3Location;

/// Artifact details for the action execution, such as the artifact location.
pub const ArtifactDetail = struct {
    /// The artifact object name for the action execution.
    name: ?[]const u8 = null,

    /// The Amazon S3 artifact location for the action execution.
    s_3_location: ?S3Location = null,

    pub const json_field_names = .{
        .name = "name",
        .s_3_location = "s3location",
    };
};
