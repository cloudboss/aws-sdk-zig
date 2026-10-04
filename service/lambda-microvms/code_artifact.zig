/// Contains the location of the code artifact for a MicroVM image.
pub const CodeArtifact = union(enum) {
    /// The URI of the code artifact in Amazon S3.
    uri: ?[]const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
