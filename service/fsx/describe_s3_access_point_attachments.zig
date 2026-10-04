const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3AccessPointAttachmentsFilter = @import("s3_access_point_attachments_filter.zig").S3AccessPointAttachmentsFilter;
const S3AccessPointAttachment = @import("s3_access_point_attachment.zig").S3AccessPointAttachment;

pub const DescribeS3AccessPointAttachmentsInput = struct {
    /// Enter a filter Name and Values pair to view a select set of S3 access point
    /// attachments.
    filters: ?[]const S3AccessPointAttachmentsFilter = null,

    max_results: ?i32 = null,

    /// The names of the S3 access point attachments whose descriptions you want to
    /// retrieve.
    names: ?[]const []const u8 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .names = "Names",
        .next_token = "NextToken",
    };
};

pub const DescribeS3AccessPointAttachmentsOutput = struct {
    next_token: ?[]const u8 = null,

    /// Array of S3 access point attachments returned after a successful
    /// `DescribeS3AccessPointAttachments` operation.
    s3_access_point_attachments: ?[]const S3AccessPointAttachment = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .s3_access_point_attachments = "S3AccessPointAttachments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeS3AccessPointAttachmentsInput, options: CallOptions) !DescribeS3AccessPointAttachmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeS3AccessPointAttachmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DescribeS3AccessPointAttachments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeS3AccessPointAttachmentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeS3AccessPointAttachmentsOutput, body, allocator);
}
