const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ThirdPartyFirewall = @import("third_party_firewall.zig").ThirdPartyFirewall;
const MarketplaceSubscriptionOnboardingStatus = @import("marketplace_subscription_onboarding_status.zig").MarketplaceSubscriptionOnboardingStatus;
const ThirdPartyFirewallAssociationStatus = @import("third_party_firewall_association_status.zig").ThirdPartyFirewallAssociationStatus;

pub const GetThirdPartyFirewallAssociationStatusInput = struct {
    /// The name of the third-party firewall vendor.
    third_party_firewall: ThirdPartyFirewall,

    pub const json_field_names = .{
        .third_party_firewall = "ThirdPartyFirewall",
    };
};

pub const GetThirdPartyFirewallAssociationStatusOutput = struct {
    /// The status for subscribing to the third-party firewall vendor in the Amazon
    /// Web Services Marketplace.
    ///
    /// * `NO_SUBSCRIPTION` - The Firewall Manager policy administrator isn't
    ///   subscribed to the third-party firewall service in the Amazon Web Services
    ///   Marketplace.
    ///
    /// * `NOT_COMPLETE` - The Firewall Manager policy administrator is in the
    ///   process of subscribing to the third-party firewall service in the Amazon
    ///   Web Services Marketplace, but doesn't yet have an active subscription.
    ///
    /// * `COMPLETE` - The Firewall Manager policy administrator has an active
    ///   subscription to the third-party firewall service in the Amazon Web
    ///   Services Marketplace.
    marketplace_onboarding_status: ?MarketplaceSubscriptionOnboardingStatus = null,

    /// The current status for setting a Firewall Manager policy administrators
    /// account as an administrator of the third-party firewall tenant.
    ///
    /// * `ONBOARDING` - The Firewall Manager policy administrator is being
    ///   designated as a tenant administrator.
    ///
    /// * `ONBOARD_COMPLETE` - The Firewall Manager policy administrator is
    ///   designated as a tenant administrator.
    ///
    /// * `OFFBOARDING` - The Firewall Manager policy administrator is being removed
    ///   as a tenant administrator.
    ///
    /// * `OFFBOARD_COMPLETE` - The Firewall Manager policy administrator has been
    ///   removed as a tenant administrator.
    ///
    /// * `NOT_EXIST` - The Firewall Manager policy administrator doesn't exist as a
    ///   tenant administrator.
    third_party_firewall_status: ?ThirdPartyFirewallAssociationStatus = null,

    pub const json_field_names = .{
        .marketplace_onboarding_status = "MarketplaceOnboardingStatus",
        .third_party_firewall_status = "ThirdPartyFirewallStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetThirdPartyFirewallAssociationStatusInput, options: CallOptions) !GetThirdPartyFirewallAssociationStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "fms");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetThirdPartyFirewallAssociationStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fms", "FMS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSFMS_20180101.GetThirdPartyFirewallAssociationStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetThirdPartyFirewallAssociationStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetThirdPartyFirewallAssociationStatusOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
