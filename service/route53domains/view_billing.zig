const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingRecord = @import("billing_record.zig").BillingRecord;

pub const ViewBillingInput = struct {
    /// The end date and time for the time period for which you want a list of
    /// billing
    /// records. Specify the date and time in Unix time format and Coordinated
    /// Universal time
    /// (UTC).
    end: ?i64 = null,

    /// For an initial request for a list of billing records, omit this element. If
    /// the number
    /// of billing records that are associated with the current Amazon Web Services
    /// account
    /// during the specified period is greater than the value that you specified for
    /// `MaxItems`, you can use `Marker` to return additional billing
    /// records. Get the value of `NextPageMarker` from the previous response, and
    /// submit another request that includes the value of `NextPageMarker` in the
    /// `Marker` element.
    ///
    /// Constraints: The marker must match the value of `NextPageMarker` that was
    /// returned in the previous response.
    marker: ?[]const u8 = null,

    /// The number of billing records to be returned.
    ///
    /// Default: 20
    max_items: ?i32 = null,

    /// The beginning date and time for the time period for which you want a list of
    /// billing
    /// records. Specify the date and time in Unix time format and Coordinated
    /// Universal time
    /// (UTC).
    start: ?i64 = null,

    pub const json_field_names = .{
        .end = "End",
        .marker = "Marker",
        .max_items = "MaxItems",
        .start = "Start",
    };
};

pub const ViewBillingOutput = struct {
    /// A summary of billing records.
    billing_records: ?[]const BillingRecord = null,

    /// If there are more billing records than you specified for `MaxItems` in the
    /// request, submit another request and include the value of `NextPageMarker` in
    /// the value of `Marker`.
    next_page_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_records = "BillingRecords",
        .next_page_marker = "NextPageMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ViewBillingInput, options: CallOptions) !ViewBillingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ViewBillingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.ViewBilling");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ViewBillingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ViewBillingOutput, body, allocator);
}
