const PostStreamArtifactGenerationStatus = @import("post_stream_artifact_generation_status.zig").PostStreamArtifactGenerationStatus;

/// Details about a generated artifact including location and status
pub const ArtifactDetails = struct {
    /// The reason for failure if the artifact generation failed
    failure_reason: ?[]const u8 = null,

    output_location: ?[]const u8 = null,

    /// The generation status of the artifact
    status: ?PostStreamArtifactGenerationStatus = null,

    pub const json_field_names = .{
        .failure_reason = "failureReason",
        .output_location = "outputLocation",
        .status = "status",
    };
};
