/// The application definition for a particular application.
pub const Definition = union(enum) {
    /// The content of the application definition. This is a JSON object that
    /// contains the
    /// resource configuration/definitions that identify an application.
    content: ?[]const u8,
    /// The S3 bucket that contains the application definition.
    s_3_location: ?[]const u8,

    pub const json_field_names = .{
        .content = "content",
        .s_3_location = "s3Location",
    };
};
