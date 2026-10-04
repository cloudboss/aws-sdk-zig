const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const LabelParameterVersionInput = struct {
    /// One or more labels to attach to the specified parameter version.
    labels: []const []const u8,

    /// The parameter name on which you want to attach one or more labels.
    ///
    /// You can't enter the Amazon Resource Name (ARN) for a parameter, only the
    /// parameter name
    /// itself.
    name: []const u8,

    /// The specific version of the parameter on which you want to attach one or
    /// more labels. If no
    /// version is specified, the system attaches the label to the latest version.
    parameter_version: ?i64 = null,

    pub const json_field_names = .{
        .labels = "Labels",
        .name = "Name",
        .parameter_version = "ParameterVersion",
    };
};

pub const LabelParameterVersionOutput = struct {
    /// The label doesn't meet the requirements. For information about parameter
    /// label requirements,
    /// see [Working with parameter
    /// labels](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-labels.html) in the *Amazon Web Services Systems Manager User Guide*.
    invalid_labels: ?[]const []const u8 = null,

    /// The version of the parameter that has been labeled.
    parameter_version: ?i64 = null,

    pub const json_field_names = .{
        .invalid_labels = "InvalidLabels",
        .parameter_version = "ParameterVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LabelParameterVersionInput, options: CallOptions) !LabelParameterVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: LabelParameterVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.LabelParameterVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !LabelParameterVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(LabelParameterVersionOutput, body, allocator);
}
