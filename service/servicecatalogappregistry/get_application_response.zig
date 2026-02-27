const aws = @import("aws");

const Integrations = @import("integrations.zig").Integrations;

pub const GetApplicationResponse = struct {
    /// A key-value pair that identifies an associated resource.
    application_tag: ?[]const aws.map.StringMapEntry,

    /// The Amazon resource name (ARN) that specifies the application across
    /// services.
    arn: ?[]const u8,

    /// The number of top-level resources that were registered as part of this
    /// application.
    associated_resource_count: i32 = 0,

    /// The ISO-8601 formatted timestamp of the moment when the application was
    /// created.
    creation_time: ?i64,

    /// The description of the application.
    description: ?[]const u8,

    /// The identifier of the application.
    id: ?[]const u8,

    /// The information
    /// about the integration
    /// of the application
    /// with other services,
    /// such as
    /// Resource Groups.
    integrations: ?Integrations,

    /// The ISO-8601 formatted timestamp of the moment when the application was last
    /// updated.
    last_update_time: ?i64,

    /// The name of the application. The name must be unique in the region in which
    /// you are creating the application.
    name: ?[]const u8,

    /// Key-value pairs associated with the application.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .application_tag = "applicationTag",
        .arn = "arn",
        .associated_resource_count = "associatedResourceCount",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .integrations = "integrations",
        .last_update_time = "lastUpdateTime",
        .name = "name",
        .tags = "tags",
    };
};
