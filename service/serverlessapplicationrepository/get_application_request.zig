pub const GetApplicationRequest = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_id: []const u8,

    /// The semantic version of the application to get.
    semantic_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .semantic_version = "SemanticVersion",
    };
};
