const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetaFlowApplicationInfo = @import("meta_flow_application_info.zig").MetaFlowApplicationInfo;
const MetaFlowCategory = @import("meta_flow_category.zig").MetaFlowCategory;
const MetaFlowHealthStatus = @import("meta_flow_health_status.zig").MetaFlowHealthStatus;
const MetaFlowPreviewInfo = @import("meta_flow_preview_info.zig").MetaFlowPreviewInfo;
const MetaFlowWhatsAppBusinessAccountInfo = @import("meta_flow_whats_app_business_account_info.zig").MetaFlowWhatsAppBusinessAccountInfo;

pub const GetWhatsAppFlowInput = struct {
    /// The unique identifier of the Flow to retrieve.
    flow_id: []const u8,

    /// The ID of the WhatsApp Business Account associated with this Flow.
    id: []const u8,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .id = "id",
    };
};

pub const GetWhatsAppFlowOutput = struct {
    /// The Meta application information associated with this Flow.
    application: ?MetaFlowApplicationInfo = null,

    /// The categories that classify the business purpose of the Flow.
    categories: ?[]const MetaFlowCategory = null,

    /// The data API version for data exchange endpoint Flows.
    data_api_version: ?[]const u8 = null,

    /// The HTTPS endpoint that Meta calls for a data exchange Flow.
    endpoint_uri: ?[]const u8 = null,

    /// The unique identifier of the Flow.
    flow_id: []const u8,

    /// The name of the Flow.
    flow_name: []const u8,

    /// The lifecycle status of the Flow. Valid values are DRAFT, PUBLISHED,
    /// DEPRECATED, BLOCKED, and THROTTLED.
    flow_status: []const u8,

    /// The health status information for this Flow from Meta.
    health_status: ?MetaFlowHealthStatus = null,

    /// The version of the Flow JSON schema used by this Flow (for example, 7.3).
    json_version: ?[]const u8 = null,

    /// The preview URL and its expiration timestamp for testing the Flow.
    preview: ?MetaFlowPreviewInfo = null,

    /// A list of validation errors from Meta, if any.
    validation_errors: ?[]const []const u8 = null,

    /// The WhatsApp Business Account information from Meta associated with this
    /// Flow.
    whats_app_business_account: ?MetaFlowWhatsAppBusinessAccountInfo = null,

    pub const json_field_names = .{
        .application = "application",
        .categories = "categories",
        .data_api_version = "dataApiVersion",
        .endpoint_uri = "endpointUri",
        .flow_id = "flowId",
        .flow_name = "flowName",
        .flow_status = "flowStatus",
        .health_status = "healthStatus",
        .json_version = "jsonVersion",
        .preview = "preview",
        .validation_errors = "validationErrors",
        .whats_app_business_account = "whatsAppBusinessAccount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWhatsAppFlowInput, options: CallOptions) !GetWhatsAppFlowOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWhatsAppFlowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/flow";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "flowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.flow_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWhatsAppFlowOutput {
    const result: GetWhatsAppFlowOutput = try aws.json.parseJsonObject(
        GetWhatsAppFlowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
