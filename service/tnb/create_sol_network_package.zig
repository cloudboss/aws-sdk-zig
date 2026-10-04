const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NsdOnboardingState = @import("nsd_onboarding_state.zig").NsdOnboardingState;
const NsdOperationalState = @import("nsd_operational_state.zig").NsdOperationalState;
const NsdUsageState = @import("nsd_usage_state.zig").NsdUsageState;

pub const CreateSolNetworkPackageInput = struct {
    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .tags = "tags",
    };
};

pub const CreateSolNetworkPackageOutput = struct {
    /// Network package ARN.
    arn: []const u8,

    /// ID of the network package.
    id: []const u8,

    /// Onboarding state of the network service descriptor in the network package.
    nsd_onboarding_state: NsdOnboardingState,

    /// Operational state of the network service descriptor in the network package.
    nsd_operational_state: NsdOperationalState,

    /// Usage state of the network service descriptor in the network package.
    nsd_usage_state: NsdUsageState,

    /// A tag is a label that you assign to an Amazon Web Services resource. Each
    /// tag consists of a key and an optional value. You can use tags to search and
    /// filter your resources or track your Amazon Web Services costs.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .nsd_onboarding_state = "nsdOnboardingState",
        .nsd_operational_state = "nsdOperationalState",
        .nsd_usage_state = "nsdUsageState",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSolNetworkPackageInput, options: CallOptions) !CreateSolNetworkPackageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSolNetworkPackageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tnb", "tnb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sol/nsd/v1/ns_descriptors";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSolNetworkPackageOutput {
    var result: CreateSolNetworkPackageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSolNetworkPackageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
