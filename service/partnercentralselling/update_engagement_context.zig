const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateEngagementContextPayload = @import("update_engagement_context_payload.zig").UpdateEngagementContextPayload;
const EngagementContextType = @import("engagement_context_type.zig").EngagementContextType;

pub const UpdateEngagementContextInput = struct {
    /// Specifies the catalog associated with the engagement context update request.
    /// This field takes a string value from a predefined list: `AWS` or `Sandbox`.
    /// The catalog determines which environment the engagement context is updated
    /// in.
    catalog: []const u8,

    /// The unique identifier of the specific engagement context to be updated. This
    /// ensures that the correct context within the engagement is modified.
    context_identifier: []const u8,

    /// The unique identifier of the `Engagement` containing the context to be
    /// updated. This parameter ensures the context update is applied to the correct
    /// engagement.
    engagement_identifier: []const u8,

    /// The timestamp when the engagement was last modified, used for optimistic
    /// concurrency control. This helps prevent conflicts when multiple users
    /// attempt to update the same engagement simultaneously.
    engagement_last_modified_at: i64,

    /// Contains the updated contextual information for the engagement. The
    /// structure of this payload varies based on the context type specified in the
    /// Type field.
    payload: UpdateEngagementContextPayload,

    /// Specifies the type of context being updated within the engagement. This
    /// field determines the structure and content of the context payload being
    /// modified.
    type: EngagementContextType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .context_identifier = "ContextIdentifier",
        .engagement_identifier = "EngagementIdentifier",
        .engagement_last_modified_at = "EngagementLastModifiedAt",
        .payload = "Payload",
        .type = "Type",
    };
};

pub const UpdateEngagementContextOutput = struct {
    /// The unique identifier of the engagement context that was updated.
    context_id: []const u8,

    /// The Amazon Resource Name (ARN) of the updated engagement.
    engagement_arn: []const u8,

    /// The unique identifier of the engagement that was updated.
    engagement_id: []const u8,

    /// The timestamp when the engagement context was last modified.
    engagement_last_modified_at: i64,

    pub const json_field_names = .{
        .context_id = "ContextId",
        .engagement_arn = "EngagementArn",
        .engagement_id = "EngagementId",
        .engagement_last_modified_at = "EngagementLastModifiedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEngagementContextInput, options: CallOptions) !UpdateEngagementContextOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEngagementContextInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.UpdateEngagementContext");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEngagementContextOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateEngagementContextOutput, body, allocator);
}
