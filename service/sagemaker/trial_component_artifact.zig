/// Represents an input or output artifact of a trial component. You specify
/// `TrialComponentArtifact` as part of the `InputArtifacts` and
/// `OutputArtifacts` parameters in the
/// [CreateTrialComponent](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_CreateTrialComponent.html) request.
///
/// Examples of input artifacts are datasets, algorithms, hyperparameters,
/// source code, and instance types. Examples of output artifacts are metrics,
/// snapshots, logs, and images.
pub const TrialComponentArtifact = struct {
    /// The media type of the artifact, which indicates the type of data in the
    /// artifact file. The media type consists of a *type* and a *subtype*
    /// concatenated with a slash (/) character, for example, text/csv, image/jpeg,
    /// and s3/uri. The type specifies the category of the media. The subtype
    /// specifies the kind of data.
    media_type: ?[]const u8,

    /// The location of the artifact.
    value: []const u8,

    pub const json_field_names = .{
        .media_type = "MediaType",
        .value = "Value",
    };
};
