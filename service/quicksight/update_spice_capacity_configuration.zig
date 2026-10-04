const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PurchaseMode = @import("purchase_mode.zig").PurchaseMode;

pub const UpdateSPICECapacityConfigurationInput = struct {
    /// The ID of the Amazon Web Services account that contains the SPICE
    /// configuration that you want to update.
    aws_account_id: []const u8,

    /// Determines how SPICE capacity can be purchased. The following options are
    /// available.
    ///
    /// * `MANUAL`: SPICE capacity can only be purchased manually.
    ///
    /// * `AUTO_PURCHASE`: Extra SPICE capacity is automatically purchased on your
    ///   behalf as needed. SPICE capacity can also be purchased manually with this
    ///   option.
    purchase_mode: PurchaseMode,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .purchase_mode = "PurchaseMode",
    };
};

pub const UpdateSPICECapacityConfigurationOutput = struct {
    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSPICECapacityConfigurationInput, options: CallOptions) !UpdateSPICECapacityConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSPICECapacityConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/spice-capacity-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PurchaseMode\":");
    try aws.json.writeValue(@TypeOf(input.purchase_mode), input.purchase_mode, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSPICECapacityConfigurationOutput {
    var result: UpdateSPICECapacityConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSPICECapacityConfigurationOutput, body, allocator);
    }
    result.status = @intCast(status);
    _ = headers;

    return result;
}
