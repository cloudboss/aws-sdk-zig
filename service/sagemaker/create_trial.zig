const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const Tag = @import("tag.zig").Tag;

pub const CreateTrialInput = struct {
    /// The name of the trial as displayed. The name doesn't need to be unique. If
    /// `DisplayName` isn't specified, `TrialName` is displayed.
    display_name: ?[]const u8 = null,

    /// The name of the experiment to associate the trial with.
    experiment_name: []const u8,

    metadata_properties: ?MetadataProperties = null,

    /// A list of tags to associate with the trial. You can use
    /// [Search](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_Search.html) API to search on the tags.
    tags: ?[]const Tag = null,

    /// The name of the trial. The name must be unique in your Amazon Web Services
    /// account and is not case-sensitive.
    trial_name: []const u8,

    pub const json_field_names = .{
        .display_name = "DisplayName",
        .experiment_name = "ExperimentName",
        .metadata_properties = "MetadataProperties",
        .tags = "Tags",
        .trial_name = "TrialName",
    };
};

pub const CreateTrialOutput = struct {
    /// The Amazon Resource Name (ARN) of the trial.
    trial_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .trial_arn = "TrialArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTrialInput, options: CallOptions) !CreateTrialOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTrialInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateTrial");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTrialOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateTrialOutput, body, allocator);
}
