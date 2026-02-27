/// Summary of a Amazon Web Services Service Catalog AppRegistry application.
pub const ApplicationSummary = struct {
    /// The Amazon resource name (ARN) that specifies the application across
    /// services.
    arn: ?[]const u8,

    /// The ISO-8601 formatted timestamp of the moment when the application was
    /// created.
    creation_time: ?i64,

    /// The description of the application.
    description: ?[]const u8,

    /// The identifier of the application.
    id: ?[]const u8,

    /// The ISO-8601 formatted timestamp of the moment when the application was last
    /// updated.
    last_update_time: ?i64,

    /// The name of the application. The name must be unique in the region in which
    /// you are creating the application.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_update_time = "lastUpdateTime",
        .name = "name",
    };
};
