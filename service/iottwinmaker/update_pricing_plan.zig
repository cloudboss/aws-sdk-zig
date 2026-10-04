const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingMode = @import("pricing_mode.zig").PricingMode;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const UpdatePricingPlanInput = struct {
    /// The bundle names.
    bundle_names: ?[]const []const u8 = null,

    /// The pricing mode.
    pricing_mode: PricingMode,

    pub const json_field_names = .{
        .bundle_names = "bundleNames",
        .pricing_mode = "pricingMode",
    };
};

pub const UpdatePricingPlanOutput = struct {
    /// Update the current pricing plan.
    current_pricing_plan: ?PricingPlan = null,

    /// Update the pending pricing plan.
    pending_pricing_plan: ?PricingPlan = null,

    pub const json_field_names = .{
        .current_pricing_plan = "currentPricingPlan",
        .pending_pricing_plan = "pendingPricingPlan",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePricingPlanInput, options: CallOptions) !UpdatePricingPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsiottwinmaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePricingPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iottwinmaker", "IoTTwinMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/pricingplan";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bundle_names) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bundleNames\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"pricingMode\":");
    try aws.json.writeValue(@TypeOf(input.pricing_mode), input.pricing_mode, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePricingPlanOutput {
    const result: UpdatePricingPlanOutput = try aws.json.parseJsonObject(
        UpdatePricingPlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
