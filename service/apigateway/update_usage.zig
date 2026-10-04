const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOperation = @import("patch_operation.zig").PatchOperation;

pub const UpdateUsageInput = struct {
    /// The identifier of the API key associated with the usage plan in which a
    /// temporary extension is granted to the remaining quota.
    key_id: []const u8,

    /// For more information about supported patch operations, see [Patch
    /// Operations](https://docs.aws.amazon.com/apigateway/latest/api/patch-operations.html).
    patch_operations: ?[]const PatchOperation = null,

    /// The Id of the usage plan associated with the usage data.
    usage_plan_id: []const u8,

    pub const json_field_names = .{
        .key_id = "keyId",
        .patch_operations = "patchOperations",
        .usage_plan_id = "usagePlanId",
    };
};

pub const UpdateUsageOutput = struct {
    /// The ending date of the usage data.
    end_date: ?[]const u8 = null,

    /// The usage data, as daily logs of used and remaining quotas, over the
    /// specified time interval indexed over the API keys in a usage plan. For
    /// example, `{..., "values" : { "{api_key}" : [ [0, 100], [10, 90], [100,
    /// 10]]}`, where `{api_key}` stands for an API key value and the daily log
    /// entry is of the format `[used quota, remaining quota]`.
    items: ?[]const aws.map.MapEntry([]const []const i64) = null,

    /// The current pagination position in the paged result set.
    position: ?[]const u8 = null,

    /// The starting date of the usage data.
    start_date: ?[]const u8 = null,

    /// The plan Id associated with this usage data.
    usage_plan_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_date = "endDate",
        .items = "items",
        .position = "position",
        .start_date = "startDate",
        .usage_plan_id = "usagePlanId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUsageInput, options: CallOptions) !UpdateUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUsageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/usageplans/");
    try path_buf.appendSlice(allocator, input.usage_plan_id);
    try path_buf.appendSlice(allocator, "/keys/");
    try path_buf.appendSlice(allocator, input.key_id);
    try path_buf.appendSlice(allocator, "/usage");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.patch_operations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"patchOperations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUsageOutput {
    var result: UpdateUsageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateUsageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
