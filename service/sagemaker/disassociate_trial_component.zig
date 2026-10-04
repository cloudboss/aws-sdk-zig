const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisassociateTrialComponentInput = struct {
    /// The name of the component to disassociate from the trial.
    trial_component_name: []const u8,

    /// The name of the trial to disassociate from.
    trial_name: []const u8,

    pub const json_field_names = .{
        .trial_component_name = "TrialComponentName",
        .trial_name = "TrialName",
    };
};

pub const DisassociateTrialComponentOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial.
    trial_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the trial component.
    trial_component_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_arn = "TrialArn",
        .trial_component_arn = "TrialComponentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisassociateTrialComponentInput, options: CallOptions) !DisassociateTrialComponentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisassociateTrialComponentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DisassociateTrialComponent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisassociateTrialComponentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DisassociateTrialComponentOutput, body, allocator);
}
