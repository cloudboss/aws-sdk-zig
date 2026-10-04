const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HubContentType = @import("hub_content_type.zig").HubContentType;
const HubContentSupportStatus = @import("hub_content_support_status.zig").HubContentSupportStatus;

pub const UpdateHubContentInput = struct {
    /// The description of the hub content.
    hub_content_description: ?[]const u8 = null,

    /// The display name of the hub content.
    hub_content_display_name: ?[]const u8 = null,

    /// A string that provides a description of the hub content. This string can
    /// include links, tables, and standard markdown formatting.
    hub_content_markdown: ?[]const u8 = null,

    /// The name of the hub content resource that you want to update.
    hub_content_name: []const u8,

    /// The searchable keywords of the hub content.
    hub_content_search_keywords: ?[]const []const u8 = null,

    /// The content type of the resource that you want to update. Only specify a
    /// `Model` or `Notebook` resource for this API. To update a `ModelReference`,
    /// use the `UpdateHubContentReference` API instead.
    hub_content_type: HubContentType,

    /// The hub content version that you want to update. For example, if you have
    /// two versions of a resource in your hub, you can update the second version.
    hub_content_version: []const u8,

    /// The name of the SageMaker hub that contains the hub content you want to
    /// update. You can optionally use the hub ARN instead.
    hub_name: []const u8,

    /// Indicates the current status of the hub content resource.
    support_status: ?HubContentSupportStatus = null,

    pub const json_field_names = .{
        .hub_content_description = "HubContentDescription",
        .hub_content_display_name = "HubContentDisplayName",
        .hub_content_markdown = "HubContentMarkdown",
        .hub_content_name = "HubContentName",
        .hub_content_search_keywords = "HubContentSearchKeywords",
        .hub_content_type = "HubContentType",
        .hub_content_version = "HubContentVersion",
        .hub_name = "HubName",
        .support_status = "SupportStatus",
    };
};

pub const UpdateHubContentOutput = struct {
    /// The ARN of the private model hub that contains the updated hub content.
    hub_arn: []const u8,

    /// The ARN of the hub content resource that was updated.
    hub_content_arn: []const u8,

    pub const json_field_names = .{
        .hub_arn = "HubArn",
        .hub_content_arn = "HubContentArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateHubContentInput, options: CallOptions) !UpdateHubContentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateHubContentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateHubContent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateHubContentOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateHubContentOutput, body, allocator);
}
