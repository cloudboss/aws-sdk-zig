const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProcurementPortalSupplier = @import("procurement_portal_supplier.zig").ProcurementPortalSupplier;

pub const ListProcurementPortalSuppliersInput = struct {
    /// The maximum number of results to return in a single call. To retrieve the
    /// remaining results, make another call with the returned NextToken value.
    /// Default is 100.
    max_results: ?i32 = null,

    /// The token for the next set of results. You received this token from a
    /// previous call.
    next_token: ?[]const u8 = null,

    /// The unique identifier of the procurement portal for which to list suppliers.
    /// Use the `PortalIdentifier` value returned by `ListProcurementPortals`.
    portal_identifier: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .portal_identifier = "PortalIdentifier",
    };
};

pub const ListProcurementPortalSuppliersOutput = struct {
    /// The token to use to retrieve the next set of results, or null if there are
    /// no more results.
    next_token: ?[]const u8 = null,

    /// The list of suppliers configured for the specified procurement portal.
    procurement_portal_suppliers: ?[]const ProcurementPortalSupplier = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .procurement_portal_suppliers = "ProcurementPortalSuppliers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProcurementPortalSuppliersInput, options: CallOptions) !ListProcurementPortalSuppliersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "invoicing", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProcurementPortalSuppliersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("invoicing", "Invoicing", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.ListProcurementPortalSuppliers");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProcurementPortalSuppliersOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListProcurementPortalSuppliersOutput, body, allocator);
}
