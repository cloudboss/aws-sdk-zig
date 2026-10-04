const aws = @import("aws");

pub const CreateApplicationRequest = struct {
    /// Unique client token for idempotent request handling
    client_token: ?[]const u8 = null,

    /// Description of the application
    description: ?[]const u8 = null,

    /// Identity Center Instance ARN to create the application in
    idc_instance_arn: []const u8,

    /// Name of the application
    name: []const u8,

    /// A list of key-value pairs that contain metadata for the application.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Name of the workspace to associate with the underlying Application
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .idc_instance_arn = "idcInstanceArn",
        .name = "name",
        .tags = "tags",
        .workspace_name = "workspaceName",
    };
};
