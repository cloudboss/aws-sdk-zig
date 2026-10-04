const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Scope = @import("scope.zig").Scope;

pub const GetIntegrationInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The URI of the S3 bucket or any other type of data source.
    uri: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .uri = "Uri",
    };
};

pub const GetIntegrationOutput = struct {
    /// The timestamp of when the domain was created.
    created_at: i64,

    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of unique names for active event triggers associated with the
    /// integration. This
    /// list would be empty if no Event Trigger is associated with the integration.
    event_trigger_names: ?[]const []const u8 = null,

    /// Boolean that shows if the Flow that's associated with the Integration is
    /// created in
    /// Amazon Appflow, or with ObjectTypeName equals _unstructured via API/CLI in
    /// flowDefinition.
    is_unstructured: ?bool = null,

    /// The timestamp of when the domain was most recently edited.
    last_updated_at: i64,

    /// The name of the profile object type.
    object_type_name: ?[]const u8 = null,

    /// A map in which each key is an event type from an external application such
    /// as Segment or Shopify, and each value is an `ObjectTypeName` (template) used
    /// to ingest the event.
    /// It supports the following event types: `SegmentIdentify`,
    /// `ShopifyCreateCustomers`, `ShopifyUpdateCustomers`,
    /// `ShopifyCreateDraftOrders`,
    /// `ShopifyUpdateDraftOrders`, `ShopifyCreateOrders`, and
    /// `ShopifyUpdatedOrders`.
    object_type_names: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the IAM role. The Integration uses this
    /// role to make
    /// Customer Profiles requests on your behalf.
    role_arn: ?[]const u8 = null,

    /// Specifies whether the integration applies to profile level data (associated
    /// with profiles) or domain level data (not associated with any specific
    /// profile). The default value is PROFILE.
    scope: ?Scope = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The URI of the S3 bucket or any other type of data source.
    uri: []const u8,

    /// Unique identifier for the workflow.
    workflow_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .event_trigger_names = "EventTriggerNames",
        .is_unstructured = "IsUnstructured",
        .last_updated_at = "LastUpdatedAt",
        .object_type_name = "ObjectTypeName",
        .object_type_names = "ObjectTypeNames",
        .role_arn = "RoleArn",
        .scope = "Scope",
        .tags = "Tags",
        .uri = "Uri",
        .workflow_id = "WorkflowId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIntegrationInput, options: CallOptions) !GetIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/integrations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Uri\":");
    try aws.json.writeValue(@TypeOf(input.uri), input.uri, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIntegrationOutput {
    const result: GetIntegrationOutput = try aws.json.parseJsonObject(
        GetIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
