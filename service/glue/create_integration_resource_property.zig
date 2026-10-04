const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceProcessingProperties = @import("source_processing_properties.zig").SourceProcessingProperties;
const Tag = @import("tag.zig").Tag;
const TargetProcessingProperties = @import("target_processing_properties.zig").TargetProcessingProperties;

pub const CreateIntegrationResourcePropertyInput = struct {
    /// The connection ARN of the source, or the database ARN of the target.
    resource_arn: []const u8,

    /// The resource properties associated with the integration source.
    source_processing_properties: ?SourceProcessingProperties = null,

    /// Metadata assigned to the resource consisting of a list of key-value pairs.
    tags: ?[]const Tag = null,

    /// The resource properties associated with the integration target.
    target_processing_properties: ?TargetProcessingProperties = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .source_processing_properties = "SourceProcessingProperties",
        .tags = "Tags",
        .target_processing_properties = "TargetProcessingProperties",
    };
};

pub const CreateIntegrationResourcePropertyOutput = struct {
    /// The connection ARN of the source, or the database ARN of the target.
    resource_arn: []const u8,

    /// The resource ARN created through this create API. The format is something
    /// like arn:aws:glue:::integrationresourceproperty/*
    resource_property_arn: ?[]const u8 = null,

    /// The resource properties associated with the integration source.
    source_processing_properties: ?SourceProcessingProperties = null,

    /// The resource properties associated with the integration target.
    target_processing_properties: ?TargetProcessingProperties = null,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_property_arn = "ResourcePropertyArn",
        .source_processing_properties = "SourceProcessingProperties",
        .target_processing_properties = "TargetProcessingProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntegrationResourcePropertyInput, options: CallOptions) !CreateIntegrationResourcePropertyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntegrationResourcePropertyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateIntegrationResourceProperty");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntegrationResourcePropertyOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateIntegrationResourcePropertyOutput, body, allocator);
}
