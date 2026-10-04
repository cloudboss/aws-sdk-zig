const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceActionSummary = @import("service_action_summary.zig").ServiceActionSummary;

pub const ListServiceActionsForProvisioningArtifactInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The maximum number of items to return with this call.
    page_size: ?i32 = null,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The product identifier. For example, `prod-abcdzk7xy33qa`.
    product_id: []const u8,

    /// The identifier of the provisioning artifact. For example,
    /// `pa-4abcdjnxjj6ne`.
    provisioning_artifact_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .page_size = "PageSize",
        .page_token = "PageToken",
        .product_id = "ProductId",
        .provisioning_artifact_id = "ProvisioningArtifactId",
    };
};

pub const ListServiceActionsForProvisioningArtifactOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// An object containing information about the self-service actions associated
    /// with the provisioning artifact.
    service_action_summaries: ?[]const ServiceActionSummary = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .service_action_summaries = "ServiceActionSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceActionsForProvisioningArtifactInput, options: CallOptions) !ListServiceActionsForProvisioningArtifactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceActionsForProvisioningArtifactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ListServiceActionsForProvisioningArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceActionsForProvisioningArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServiceActionsForProvisioningArtifactOutput, body, allocator);
}
