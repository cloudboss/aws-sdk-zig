const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EngagementContextPayload = @import("engagement_context_payload.zig").EngagementContextPayload;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;

pub const CreateEngagementContextInput = struct {
    /// Specifies the catalog associated with the engagement context request. This
    /// field takes a string value from a predefined list: `AWS` or `Sandbox`. The
    /// catalog determines which environment the engagement context is created in.
    /// Use `AWS` to create contexts in the production environment, and `Sandbox`
    /// for testing in secure, isolated environments.
    catalog: []const u8,

    /// A unique, case-sensitive identifier provided by the client to ensure that
    /// the request is handled exactly once. This token helps prevent duplicate
    /// context creations and must not exceed sixty-four alphanumeric characters.
    /// Use a UUID or other unique string to ensure idempotency.
    client_token: []const u8,

    /// The unique identifier of the `Engagement` for which the context is being
    /// created. This parameter ensures the context is associated with the correct
    /// engagement and provides the necessary linkage between the engagement and its
    /// contextual information.
    engagement_identifier: []const u8,

    payload: EngagementContextPayload,

    /// Specifies the type of context being created for the engagement. This field
    /// determines the structure and content of the context payload. Valid values
    /// include `CustomerProject` for customer project-related contexts. The type
    /// field ensures that the context is properly categorized and processed
    /// according to its intended purpose.
    @"type": EngagementContextType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .engagement_identifier = "EngagementIdentifier",
        .payload = "Payload",
        .@"type" = "Type",
    };
};

pub const CreateEngagementContextOutput = struct {
    /// The unique identifier assigned to the newly created engagement context. This
    /// ID can be used to reference the specific context within the engagement for
    /// future operations.
    context_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the engagement to which the context was
    /// added. This globally unique identifier can be used for cross-service
    /// references and IAM policies.
    engagement_arn: ?[]const u8 = null,

    /// The unique identifier of the engagement to which the context was added. This
    /// ID confirms the successful association of the context with the specified
    /// engagement.
    engagement_id: ?[]const u8 = null,

    /// The timestamp indicating when the engagement was last modified as a result
    /// of adding the context, in ISO 8601 format (UTC). Example:
    /// "2023-05-01T20:37:46Z".
    engagement_last_modified_at: ?i64 = null,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .engagement_arn = "EngagementArn",
        .engagement_id = "EngagementId",
        .engagement_last_modified_at = "EngagementLastModifiedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEngagementContextInput, options: CallOptions) !CreateEngagementContextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEngagementContextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateEngagementContext");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEngagementContextOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEngagementContextOutput, body, allocator);
}
