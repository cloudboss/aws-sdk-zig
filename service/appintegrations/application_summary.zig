const ApplicationType = @import("application_type.zig").ApplicationType;

/// Summary information about the Application.
pub const ApplicationSummary = struct {
    /// The type of application.
    application_type: ?ApplicationType,

    /// The Amazon Resource Name (ARN) of the Application.
    arn: ?[]const u8,

    /// The time when the application was created.
    created_time: ?i64,

    /// A unique identifier for the Application.
    id: ?[]const u8,

    /// Indicates whether the application is a service.
    is_service: bool = false,

    /// The time when the application was last modified.
    last_modified_time: ?i64,

    /// The name of the application.
    name: ?[]const u8,

    /// The namespace of the application.
    namespace: ?[]const u8,

    pub const json_field_names = .{
        .application_type = "ApplicationType",
        .arn = "Arn",
        .created_time = "CreatedTime",
        .id = "Id",
        .is_service = "IsService",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .namespace = "Namespace",
    };
};
