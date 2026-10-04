const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;
const Tag = @import("tag.zig").Tag;

pub const ImportHubContentInput = struct {
    /// The version of the hub content schema to import.
    document_schema_version: []const u8,

    /// A description of the hub content to import.
    hub_content_description: ?[]const u8 = null,

    /// The display name of the hub content to import.
    hub_content_display_name: ?[]const u8 = null,

    /// The hub content document that describes information about the hub content
    /// such as type, associated containers, scripts, and more.
    hub_content_document: []const u8,

    /// A string that provides a description of the hub content. This string can
    /// include links, tables, and standard markdown formating.
    hub_content_markdown: ?[]const u8 = null,

    /// The name of the hub content to import.
    hub_content_name: []const u8,

    /// The searchable keywords of the hub content.
    hub_content_search_keywords: ?[]const []const u8 = null,

    /// The type of hub content to import.
    hub_content_type: HubContentType,

    /// The version of the hub content to import.
    hub_content_version: ?[]const u8 = null,

    /// The name of the hub to import content into.
    hub_name: []const u8,

    /// The status of the hub content resource.
    support_status: ?HubContentSupportStatus = null,

    /// Any tags associated with the hub content.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .document_schema_version = "DocumentSchemaVersion",
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_document = "HubContentDocument",
        .hub_content_markdown = "HubContentMarkdown",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .support_status = "SupportStatus",
        .tags = "Tags",
    };
};

pub const ImportHubContentOutput = struct {
    /// The ARN of the hub that the content was imported into.
    hub_arn: []const u8,

    /// The ARN of the hub content that was imported.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportHubContentInput, options: CallOptions) !ImportHubContentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportHubContentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ImportHubContent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportHubContentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ImportHubContentOutput, body, allocator);
}
