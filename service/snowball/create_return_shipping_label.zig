const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ShippingOption = @import("shipping_option.zig").ShippingOption;
const ShippingLabelStatus = @import("shipping_label_status.zig").ShippingLabelStatus;

pub const CreateReturnShippingLabelInput = struct {
    /// The ID for a job that you want to create the return shipping label for; for
    /// example,
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: []const u8,

    /// The shipping speed for a particular job. This speed doesn't dictate how soon
    /// the device
    /// is returned to Amazon Web Services. This speed represents how quickly it
    /// moves to its
    /// destination while in transit. Regional shipping speeds are as follows:
    shipping_option: ?ShippingOption = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .shipping_option = "ShippingOption",
    };
};

pub const CreateReturnShippingLabelOutput = struct {
    /// The status information of the task on a Snow device that is being returned
    /// to Amazon Web Services.
    status: ?ShippingLabelStatus = null,

    pub const json_field_names = .{
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReturnShippingLabelInput, options: CallOptions) !CreateReturnShippingLabelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReturnShippingLabelInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.CreateReturnShippingLabel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReturnShippingLabelOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReturnShippingLabelOutput, body, allocator);
}
