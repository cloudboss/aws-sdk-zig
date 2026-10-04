const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SpaceContributor = @import("space_contributor.zig").SpaceContributor;
const SpaceDetails = @import("space_details.zig").SpaceDetails;

pub const DescribeSpaceInput = struct {
    /// The ID of the Amazon Web Services account that contains the space.
    aws_account_id: []const u8,

    /// The maximum number of contributors to include in the response.
    max_contributors: ?i32 = null,

    /// The ID of the space that you want to describe.
    space_id: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .max_contributors = "MaxContributors",
        .space_id = "SpaceId",
    };
};

pub const DescribeSpaceOutput = struct {
    /// A list of contributors to the space.
    contributors: ?[]const SpaceContributor = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The details of the space.
    space: ?SpaceDetails = null,

    /// The ARN of the space.
    space_arn: ?[]const u8 = null,

    /// The ID of the space.
    space_id: []const u8,

    pub const json_field_names = .{
        .contributors = "Contributors",
        .request_id = "RequestId",
        .space = "Space",
        .space_arn = "spaceArn",
        .space_id = "spaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSpaceInput, options: CallOptions) !DescribeSpaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSpaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/spaces/");
    try path_buf.appendSlice(allocator, input.space_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_contributors) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxContributors=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSpaceOutput {
    const result: DescribeSpaceOutput = try aws.json.parseJsonObject(
        DescribeSpaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
