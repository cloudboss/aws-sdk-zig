/// Describes the entity list submitted with an entity recognizer.
pub const EntityRecognizerEntityList = struct {
    /// Specifies the Amazon S3 location where the entity list is located. The URI
    /// must be in the
    /// same Region as the API endpoint that you are calling.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
