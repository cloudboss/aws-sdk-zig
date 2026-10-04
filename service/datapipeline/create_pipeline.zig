const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreatePipelineInput = struct {
    /// The description for the pipeline.
    description: ?[]const u8 = null,

    /// The name for the pipeline. You can use the same name for multiple pipelines
    /// associated with your AWS account,
    /// because AWS Data Pipeline assigns each pipeline a unique pipeline
    /// identifier.
    name: []const u8,

    /// A list of tags to associate with the pipeline at creation. Tags let you
    /// control access to pipelines.
    /// For more information, see [Controlling User Access to
    /// Pipelines](http://docs.aws.amazon.com/datapipeline/latest/DeveloperGuide/dp-control-access.html)
    /// in the *AWS Data Pipeline Developer Guide*.
    tags: ?[]const Tag = null,

    /// A unique identifier. This identifier is not the same as the pipeline
    /// identifier assigned by AWS Data Pipeline.
    /// You are responsible for defining the format and ensuring the uniqueness of
    /// this identifier. You use this
    /// parameter to ensure idempotency during repeated calls to `CreatePipeline`.
    /// For example, if the
    /// first call to `CreatePipeline` does not succeed, you can pass in the same
    /// unique identifier and
    /// pipeline name combination on a subsequent call to `CreatePipeline`.
    /// `CreatePipeline`
    /// ensures that if a pipeline already exists with the same name and unique
    /// identifier, a new pipeline is not
    /// created. Instead, you'll receive the pipeline identifier from the previous
    /// attempt. The uniqueness of the
    /// name and unique identifier combination is scoped to the AWS account or IAM
    /// user credentials.
    unique_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .tags = "tags",
        .unique_id = "uniqueId",
    };
};

pub const CreatePipelineOutput = struct {
    /// The ID that AWS Data Pipeline assigns the newly created pipeline. For
    /// example, `df-06372391ZG65EXAMPLE`.
    pipeline_id: []const u8,

    pub const json_field_names = .{
        .pipeline_id = "pipelineId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePipelineInput, options: CallOptions) !CreatePipelineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePipelineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.CreatePipeline");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePipelineOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreatePipelineOutput, body, allocator);
}
