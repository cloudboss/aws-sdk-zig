const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportImageTask = @import("export_image_task.zig").ExportImageTask;

pub const CreateExportImageTaskInput = struct {
    /// An optional description for the exported AMI. This description will be
    /// applied to the resulting EC2 AMI.
    ami_description: ?[]const u8 = null,

    /// The name for the exported EC2 AMI. This is a required field that must be
    /// unique within your account and region.
    ami_name: []const u8,

    /// The ARN of the IAM role that allows WorkSpaces Applications to create the
    /// AMI. The role must have permissions to copy images, describe images, and
    /// create tags, with a trust relationship allowing appstream.amazonaws.com to
    /// assume the role.
    iam_role_arn: []const u8,

    /// The name of the WorkSpaces Applications image to export. The image must be
    /// in an available state and owned by your account.
    image_name: []const u8,

    /// The tags to apply to the exported AMI. These tags help you organize and
    /// manage your EC2 AMIs.
    tag_specifications: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ami_description = "AmiDescription",
        .ami_name = "AmiName",
        .iam_role_arn = "IamRoleArn",
        .image_name = "ImageName",
        .tag_specifications = "TagSpecifications",
    };
};

pub const CreateExportImageTaskOutput = struct {
    /// Information about the export image task that was created, including the task
    /// ID and initial state.
    export_image_task: ?ExportImageTask = null,

    pub const json_field_names = .{
        .export_image_task = "ExportImageTask",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExportImageTaskInput, options: CallOptions) !CreateExportImageTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExportImageTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateExportImageTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExportImageTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateExportImageTaskOutput, body, allocator);
}
