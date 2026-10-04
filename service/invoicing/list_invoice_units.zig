const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filters = @import("filters.zig").Filters;
const InvoiceUnit = @import("invoice_unit.zig").InvoiceUnit;

pub const ListInvoiceUnitsInput = struct {
    /// The state of an invoice unit at a specified time. You can see legacy invoice
    /// units that are currently deleted if the `AsOf` time is set to before it was
    /// deleted. If an `AsOf` is not provided, the default value is the current
    /// time.
    as_of: ?i64 = null,

    /// An optional input to the list API. If multiple filters are specified, the
    /// returned list will be a configuration that match all of the provided
    /// filters. Supported filter types are `InvoiceReceivers`, `Names`, and
    /// `Accounts`.
    filters: ?Filters = null,

    /// The maximum number of invoice units that can be returned.
    max_results: ?i32 = null,

    /// The next token used to indicate where the returned list should start from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .as_of = "AsOf",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListInvoiceUnitsOutput = struct {
    /// An invoice unit is a set of mutually exclusive accounts that correspond to
    /// your business entity.
    invoice_units: ?[]const InvoiceUnit = null,

    /// The next token used to indicate where the returned list should start from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .invoice_units = "InvoiceUnits",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListInvoiceUnitsInput, options: CallOptions) !ListInvoiceUnitsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListInvoiceUnitsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Invoicing.ListInvoiceUnits");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListInvoiceUnitsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListInvoiceUnitsOutput, body, allocator);
}
