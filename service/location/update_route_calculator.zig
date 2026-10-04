const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const UpdateRouteCalculatorInput = struct {
    /// The name of the route calculator resource to update.
    calculator_name: []const u8,

    /// Updates the description for the route calculator resource.
    description: ?[]const u8 = null,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    pub const json_field_names = .{
        .calculator_name = "CalculatorName",
        .description = "Description",
        .pricing_plan = "PricingPlan",
    };
};

pub const UpdateRouteCalculatorOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated route calculator resource.
    /// Used to specify a resource across AWS.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:route-
    ///   calculator/ExampleCalculator`
    calculator_arn: []const u8,

    /// The name of the updated route calculator resource.
    calculator_name: []const u8,

    /// The timestamp for when the route calculator was last updated in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .calculator_arn = "CalculatorArn",
        .calculator_name = "CalculatorName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRouteCalculatorInput, options: CallOptions) !UpdateRouteCalculatorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRouteCalculatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/routes/v0/calculators/");
    try path_buf.appendSlice(allocator, input.calculator_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRouteCalculatorOutput {
    const result: UpdateRouteCalculatorOutput = try aws.json.parseJsonObject(
        UpdateRouteCalculatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
