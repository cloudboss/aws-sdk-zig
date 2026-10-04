const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OnboardingState = @import("onboarding_state.zig").OnboardingState;
const OperationalState = @import("operational_state.zig").OperationalState;
const UsageState = @import("usage_state.zig").UsageState;

pub const CreateSolFunctionPackageInput = struct {
    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};

pub const CreateSolFunctionPackageOutput = struct {
    /// Function package ARN.
    arn: []const u8,

    /// ID of the function package.
    id: []const u8,

    /// Onboarding state of the function package.
    onboarding_state: OnboardingState,

    /// Operational state of the function package.
    operational_state: OperationalState,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Usage state of the function package.
    usage_state: UsageState,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .onboarding_state = "onboardingState",
        .operational_state = "operationalState",
        .tags = "tags",
        .usage_state = "usageState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSolFunctionPackageInput, options: CallOptions) !CreateSolFunctionPackageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tnb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSolFunctionPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sol/vnfpkgm/v1/vnf_packages";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSolFunctionPackageOutput {
    var result: CreateSolFunctionPackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSolFunctionPackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
