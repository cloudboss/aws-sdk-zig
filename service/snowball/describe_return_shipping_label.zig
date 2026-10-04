const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShippingLabelStatus = @import("shipping_label_status.zig").ShippingLabelStatus;

pub const DescribeReturnShippingLabelInput = struct {
    /// The automatically generated ID for a job, for example
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeReturnShippingLabelOutput = struct {
    /// The expiration date of the current return shipping label.
    expiration_date: ?i64 = null,

    /// The pre-signed Amazon S3 URI used to download the return shipping label.
    return_shipping_label_uri: ?[]const u8 = null,

    /// The status information of the task on a Snow device that is being returned
    /// to Amazon Web Services.
    status: ?ShippingLabelStatus = null,

    pub const json_field_names = .{
        .expiration_date = "ExpirationDate",
        .return_shipping_label_uri = "ReturnShippingLabelURI",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeReturnShippingLabelInput, options: CallOptions) !DescribeReturnShippingLabelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeReturnShippingLabelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.DescribeReturnShippingLabel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeReturnShippingLabelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeReturnShippingLabelOutput, body, allocator);
}
