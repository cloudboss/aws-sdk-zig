/// An application version summary.
pub const VersionSummary = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: []const u8,

    /// The date and time this resource was created.
    creation_time: []const u8,

    /// The semantic version of the application:
    ///
    /// [https://semver.org/](https://semver.org/)
    semantic_version: []const u8,

    /// A link to a public repository for the source code of your application, for
    /// example the URL of a specific GitHub commit.
    source_code_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_time = "CreationTime",
        .semantic_version = "SemanticVersion",
        .source_code_url = "SourceCodeUrl",
    };
};
