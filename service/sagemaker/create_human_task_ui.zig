const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const UiTemplate = @import("ui_template.zig").UiTemplate;

pub const CreateHumanTaskUiInput = struct {
    /// The name of the user interface you are creating.
    human_task_ui_name: []const u8,

    /// An array of key-value pairs that contain metadata to help you categorize and
    /// organize a human review workflow user interface. Each tag consists of a key
    /// and a value, both of which you define.
    tags: ?[]const Tag = null,

    ui_template: UiTemplate,

    pub const json_field_names = .{
        .human_task_ui_name = "HumanTaskUiName",
        .tags = "Tags",
        .ui_template = "UiTemplate",
    };
};

pub const CreateHumanTaskUiOutput = struct {
    /// The Amazon Resource Name (ARN) of the human review workflow user interface
    /// you create.
    human_task_ui_arn: []const u8,

    pub const json_field_names = .{
        .human_task_ui_arn = "HumanTaskUiArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHumanTaskUiInput, options: CallOptions) !CreateHumanTaskUiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHumanTaskUiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateHumanTaskUi");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHumanTaskUiOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateHumanTaskUiOutput, body, allocator);
}
