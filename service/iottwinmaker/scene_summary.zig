/// An object that contains information about a scene.
pub const SceneSummary = struct {
    /// The ARN of the scene.
    arn: []const u8,

    /// The relative path that specifies the location of the content definition
    /// file.
    content_location: []const u8,

    /// The date and time when the scene was created.
    creation_date_time: i64,

    /// The scene description.
    description: ?[]const u8,

    /// The ID of the scene.
    scene_id: []const u8,

    /// The date and time when the scene was last updated.
    update_date_time: i64,

    pub const json_field_names = .{
        .arn = "arn",
        .content_location = "contentLocation",
        .creation_date_time = "creationDateTime",
        .description = "description",
        .scene_id = "sceneId",
        .update_date_time = "updateDateTime",
    };
};
