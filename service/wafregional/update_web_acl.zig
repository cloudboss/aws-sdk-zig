const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WafAction = @import("waf_action.zig").WafAction;
const WebACLUpdate = @import("web_acl_update.zig").WebACLUpdate;

pub const UpdateWebACLInput = struct {
    /// The value returned by the most recent call to GetChangeToken.
    change_token: []const u8,

    /// A default action for the web ACL, either ALLOW or BLOCK. AWS WAF performs
    /// the default
    /// action if a request doesn't match the criteria in any of the rules in a web
    /// ACL.
    default_action: ?WafAction = null,

    /// An array of updates to make to the WebACL.
    ///
    /// An array of `WebACLUpdate` objects that you want to insert into or delete
    /// from a
    /// WebACL. For more information, see the applicable data types:
    ///
    /// * WebACLUpdate: Contains `Action` and `ActivatedRule`
    ///
    /// * ActivatedRule: Contains `Action`,
    /// `OverrideAction`, `Priority`, `RuleId`, and
    /// `Type`. `ActivatedRule|OverrideAction` applies only when
    /// updating or adding a `RuleGroup` to a `WebACL`. In this
    /// case,
    /// you do not use `ActivatedRule|Action`. For all other update requests,
    /// `ActivatedRule|Action` is used instead of
    /// `ActivatedRule|OverrideAction`.
    ///
    /// * WafAction: Contains `Type`
    updates: ?[]const WebACLUpdate = null,

    /// The `WebACLId` of the WebACL that you want to update. `WebACLId` is returned
    /// by CreateWebACL and by
    /// ListWebACLs.
    web_acl_id: []const u8,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
        .default_action = "DefaultAction",
        .updates = "Updates",
        .web_acl_id = "WebACLId",
    };
};

pub const UpdateWebACLOutput = struct {
    /// The `ChangeToken` that you used to submit the `UpdateWebACL` request. You
    /// can also use this value
    /// to query the status of the request. For more information, see
    /// GetChangeTokenStatus.
    change_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_token = "ChangeToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWebACLInput, options: CallOptions) !UpdateWebACLOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "waf-regional", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWebACLInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("waf-regional", "WAF Regional", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSWAF_Regional_20161128.UpdateWebACL");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWebACLOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateWebACLOutput, body, allocator);
}
