const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomWorkspaceImageImportErrorDetails = @import("custom_workspace_image_import_error_details.zig").CustomWorkspaceImageImportErrorDetails;
const ImageSourceIdentifier = @import("image_source_identifier.zig").ImageSourceIdentifier;
const CustomWorkspaceImageImportState = @import("custom_workspace_image_import_state.zig").CustomWorkspaceImageImportState;

pub const DescribeCustomWorkspaceImageImportInput = struct {
    /// The identifier of the WorkSpace image.
    image_id: []const u8,

    pub const json_field_names = .{
        .image_id = "ImageId",
    };
};

pub const DescribeCustomWorkspaceImageImportOutput = struct {
    /// The timestamp when the WorkSpace image import was created.
    created: ?i64 = null,

    /// Describes in-depth details about the error. These details include the
    /// possible causes of the error and troubleshooting information.
    error_details: ?[]const CustomWorkspaceImageImportErrorDetails = null,

    /// The image builder instance ID of the WorkSpace image.
    image_builder_instance_id: ?[]const u8 = null,

    /// The identifier of the WorkSpace image.
    image_id: ?[]const u8 = null,

    /// Describes the image import source.
    image_source: ?ImageSourceIdentifier = null,

    /// The infrastructure configuration ARN that specifies how the WorkSpace image
    /// is built.
    infrastructure_configuration_arn: ?[]const u8 = null,

    /// The timestamp when the WorkSpace image import was last updated.
    last_updated_time: ?i64 = null,

    /// The estimated progress percentage of the WorkSpace image import workflow.
    progress_percentage: ?i32 = null,

    /// The state of the WorkSpace image.
    state: ?CustomWorkspaceImageImportState = null,

    /// The state message of the WorkSpace image import workflow.
    state_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .created = "Created",
        .error_details = "ErrorDetails",
        .image_builder_instance_id = "ImageBuilderInstanceId",
        .image_id = "ImageId",
        .image_source = "ImageSource",
        .infrastructure_configuration_arn = "InfrastructureConfigurationArn",
        .last_updated_time = "LastUpdatedTime",
        .progress_percentage = "ProgressPercentage",
        .state = "State",
        .state_message = "StateMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomWorkspaceImageImportInput, options: CallOptions) !DescribeCustomWorkspaceImageImportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomWorkspaceImageImportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeCustomWorkspaceImageImport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomWorkspaceImageImportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCustomWorkspaceImageImportOutput, body, allocator);
}
