const S3Location = @import("s3_location.zig").S3Location;

/// The analysis template artifact.
pub const AnalysisTemplateArtifact = struct {
    /// The artifact location.
    location: S3Location,

    pub const json_field_names = .{
        .location = "location",
    };
};
