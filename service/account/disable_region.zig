const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisableRegionInput = struct {
    /// Specifies the 12-digit account ID number of the Amazon Web Services account
    /// that you want to access or modify with this operation. If you don't specify
    /// this parameter, it defaults to the Amazon Web Services account of the
    /// identity used to call the operation. To use this parameter, the caller must
    /// be an identity in the [organization's management
    /// account](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#account) or a delegated administrator account. The specified account ID must be a member account in the same organization. The organization must have [all features enabled](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_org_support-all-features.html), and the organization must have [trusted access](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) enabled for the Account Management service, and optionally a [delegated admin](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_getting-started_concepts.html#delegated-admin) account assigned.
    ///
    /// The management account can't specify its own `AccountId`. It must call the
    /// operation in standalone context by not including the `AccountId` parameter.
    ///
    /// To call this operation on an account that is not a member of an
    /// organization, don't specify this parameter. Instead, call the operation
    /// using an identity belonging to the account whose contacts you wish to
    /// retrieve or modify.
    account_id: ?[]const u8 = null,

    /// Specifies the Region-code for a given Region name (for example,
    /// `af-south-1`). When you disable a Region, Amazon Web Services performs
    /// actions to deactivate that Region in your account, such as destroying IAM
    /// resources in the Region. This process takes a few minutes for most accounts,
    /// but this can take several hours. You cannot enable the Region until the
    /// disabling process is fully completed.
    region_name: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .region_name = "RegionName",
    };
};

pub const DisableRegionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableRegionInput, options: CallOptions) !DisableRegionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "account", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableRegionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account", "Account", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/disableRegion";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RegionName\":");
    try aws.json.writeValue(@TypeOf(input.region_name), input.region_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableRegionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisableRegionOutput = .{};

    return result;
}
