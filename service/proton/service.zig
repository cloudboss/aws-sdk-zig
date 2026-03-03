const ServicePipeline = @import("service_pipeline.zig").ServicePipeline;
const ServiceStatus = @import("service_status.zig").ServiceStatus;

/// Detailed data of an Proton service resource.
pub const Service = struct {
    /// The Amazon Resource Name (ARN) of the service.
    arn: []const u8,

    /// The name of the code repository branch that holds the code that's deployed
    /// in
    /// Proton.
    branch_name: ?[]const u8 = null,

    /// The time when the service was created.
    created_at: i64,

    /// A description of the service.
    description: ?[]const u8 = null,

    /// The time when the service was last modified.
    last_modified_at: i64,

    /// The name of the service.
    name: []const u8,

    /// The service pipeline detail data.
    pipeline: ?ServicePipeline = null,

    /// The Amazon Resource Name (ARN) of the repository connection. For more
    /// information, see
    /// [Setting up an
    /// AWS CodeStar
    /// connection](https://docs.aws.amazon.com/proton/latest/userguide/setting-up-for-service.html#setting-up-vcontrol) in the *Proton User Guide*.
    repository_connection_arn: ?[]const u8 = null,

    /// The ID of the source code repository.
    repository_id: ?[]const u8 = null,

    /// The formatted specification that defines the service.
    spec: []const u8,

    /// The status of the service.
    status: ServiceStatus,

    /// A service status message.
    status_message: ?[]const u8 = null,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .branch_name = "branchName",
        .created_at = "createdAt",
        .description = "description",
        .last_modified_at = "lastModifiedAt",
        .name = "name",
        .pipeline = "pipeline",
        .repository_connection_arn = "repositoryConnectionArn",
        .repository_id = "repositoryId",
        .spec = "spec",
        .status = "status",
        .status_message = "statusMessage",
        .template_name = "templateName",
    };
};
