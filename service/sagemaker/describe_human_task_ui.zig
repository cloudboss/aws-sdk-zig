const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HumanTaskUiStatus = @import("human_task_ui_status.zig").HumanTaskUiStatus;
const UiTemplateInfo = @import("ui_template_info.zig").UiTemplateInfo;

pub const DescribeHumanTaskUiInput = struct {
    /// The name of the human task user interface (worker task template) you want
    /// information about.
    human_task_ui_name: []const u8,

    pub const json_field_names = .{
        .human_task_ui_name = "HumanTaskUiName",
    };
};

pub const DescribeHumanTaskUiOutput = struct {
    /// The timestamp when the human task user interface was created.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the human task user interface (worker task
    /// template).
    human_task_ui_arn: []const u8,

    /// The name of the human task user interface (worker task template).
    human_task_ui_name: []const u8,

    /// The status of the human task user interface (worker task template). Valid
    /// values are listed below.
    human_task_ui_status: ?HumanTaskUiStatus = null,

    ui_template: ?UiTemplateInfo = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .human_task_ui_arn = "HumanTaskUiArn",
        .human_task_ui_name = "HumanTaskUiName",
        .human_task_ui_status = "HumanTaskUiStatus",
        .ui_template = "UiTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHumanTaskUiInput, options: CallOptions) !DescribeHumanTaskUiOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeHumanTaskUiInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeHumanTaskUi");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeHumanTaskUiOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeHumanTaskUiOutput, body, allocator);
}
