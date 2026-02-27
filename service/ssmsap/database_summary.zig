const aws = @import("aws");

const DatabaseType = @import("database_type.zig").DatabaseType;

/// The summary of the database.
pub const DatabaseSummary = struct {
    /// The ID of the application.
    application_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the database.
    arn: ?[]const u8,

    /// The ID of the component.
    component_id: ?[]const u8,

    /// The ID of the database.
    database_id: ?[]const u8,

    /// The type of the database.
    database_type: ?DatabaseType,

    /// The tags of the database.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .arn = "Arn",
        .component_id = "ComponentId",
        .database_id = "DatabaseId",
        .database_type = "DatabaseType",
        .tags = "Tags",
    };
};
