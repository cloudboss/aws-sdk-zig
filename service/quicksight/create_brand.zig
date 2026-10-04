const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrandDefinition = @import("brand_definition.zig").BrandDefinition;
const Tag = @import("tag.zig").Tag;
const BrandDetail = @import("brand_detail.zig").BrandDetail;

pub const CreateBrandInput = struct {
    /// The ID of the Amazon Web Services account that owns the brand.
    aws_account_id: []const u8,

    /// The definition of the brand.
    brand_definition: ?BrandDefinition = null,

    /// The ID of the Quick brand.
    brand_id: []const u8,

    /// A map of the key-value pairs that are assigned to the brand.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .brand_definition = "BrandDefinition",
        .brand_id = "BrandId",
        .tags = "Tags",
    };
};

pub const CreateBrandOutput = struct {
    /// The definition of the brand.
    brand_definition: ?BrandDefinition = null,

    /// The details of the brand.
    brand_detail: ?BrandDetail = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .brand_definition = "BrandDefinition",
        .brand_detail = "BrandDetail",
        .request_id = "RequestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBrandInput, options: CallOptions) !CreateBrandOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBrandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/brands/");
    try path_buf.appendSlice(allocator, input.brand_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.brand_definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BrandDefinition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBrandOutput {
    var result: CreateBrandOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBrandOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
