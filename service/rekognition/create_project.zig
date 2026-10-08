const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectAutoUpdate = @import("project_auto_update.zig").ProjectAutoUpdate;
const CustomizationFeature = @import("customization_feature.zig").CustomizationFeature;

pub const CreateProjectInput = struct {
    /// Specifies whether automatic retraining should be attempted for the versions
    /// of the
    /// project. Automatic retraining is done as a best effort. Required argument
    /// for Content
    /// Moderation. Applicable only to adapters.
    auto_update: ?ProjectAutoUpdate = null,

    /// Specifies feature that is being customized. If no value is provided
    /// CUSTOM_LABELS is used as a default.
    feature: ?CustomizationFeature = null,

    /// The name of the project to create.
    project_name: []const u8,

    /// A set of tags (key-value pairs) that you want to attach to the project.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auto_update = "AutoUpdate",
        .feature = "Feature",
        .project_name = "ProjectName",
        .tags = "Tags",
    };
};

pub const CreateProjectOutput = struct {
    /// The Amazon Resource Name (ARN) of the new project. You can use the ARN to
    /// configure IAM access to the project.
    project_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_arn = "ProjectArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectInput, options: CallOptions) !CreateProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProjectOutput, body, allocator);
}
