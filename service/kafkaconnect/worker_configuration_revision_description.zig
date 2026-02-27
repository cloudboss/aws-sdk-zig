/// The description of the worker configuration revision.
pub const WorkerConfigurationRevisionDescription = struct {
    /// The time that the worker configuration was created.
    creation_time: ?i64,

    /// The description of the worker configuration revision.
    description: ?[]const u8,

    /// Base64 encoded contents of the connect-distributed.properties file.
    properties_file_content: ?[]const u8,

    /// The description of a revision of the worker configuration.
    revision: i64 = 0,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .properties_file_content = "propertiesFileContent",
        .revision = "revision",
    };
};
