const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const TrialSource = @import("trial_source.zig").TrialSource;

pub const DescribeTrialInput = struct {
    /// The name of the trial to describe.
    trial_name: []const u8,

    pub const json_field_names = .{
        .trial_name = "TrialName",
    };
};

pub const DescribeTrialOutput = struct {
    /// Who created the trial.
    created_by: ?UserContext = null,

    /// When the trial was created.
    creation_time: ?i64 = null,

    /// The name of the trial as displayed. If `DisplayName` isn't specified,
    /// `TrialName` is displayed.
    display_name: ?[]const u8 = null,

    /// The name of the experiment the trial is part of.
    experiment_name: ?[]const u8 = null,

    /// Who last modified the trial.
    last_modified_by: ?UserContext = null,

    /// When the trial was last modified.
    last_modified_time: ?i64 = null,

    metadata_properties: ?MetadataProperties = null,

    /// The Amazon Resource Name (ARN) of the source and, optionally, the job type.
    source: ?TrialSource = null,

    /// The Amazon Resource Name (ARN) of the trial.
    trial_arn: ?[]const u8 = null,

    /// The name of the trial.
    trial_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .experiment_name = "ExperimentName",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .metadata_properties = "MetadataProperties",
        .source = "Source",
        .trial_arn = "TrialArn",
        .trial_name = "TrialName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrialInput, options: CallOptions) !DescribeTrialOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrialInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeTrial");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrialOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTrialOutput, body, allocator);
}
