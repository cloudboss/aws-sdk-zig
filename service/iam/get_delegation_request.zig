const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegationRequest = @import("delegation_request.zig").DelegationRequest;
const permissionCheckResultType = @import("permission_check_result_type.zig").permissionCheckResultType;
const permissionCheckStatusType = @import("permission_check_status_type.zig").permissionCheckStatusType;
const serde = @import("serde.zig");

pub const GetDelegationRequestInput = struct {
    /// Specifies whether to perform a permission check for the delegation request.
    ///
    /// If set to true, the `GetDelegationRequest` API call will start a permission
    /// check process. This process
    /// calculates whether the caller has sufficient permissions to cover the asks
    /// from this delegation request.
    ///
    /// Setting this parameter to true does not guarantee an answer in the response.
    /// See the `PermissionCheckStatus`
    /// and the `PermissionCheckResult` response attributes for further details.
    delegation_permission_check: ?bool = null,

    /// The unique identifier of the delegation request to retrieve.
    delegation_request_id: []const u8,
};

pub const GetDelegationRequestOutput = struct {
    /// The delegation request object containing all details about the request.
    delegation_request: ?DelegationRequest = null,

    /// The result of the permission check, indicating whether the caller has
    /// sufficient permissions to cover the requested permissions.
    /// This is an approximate result.
    ///
    /// * `ALLOWED` : The caller has sufficient permissions cover all the requested
    ///   permissions.
    ///
    /// * `DENIED` : The caller does not have sufficient permissions to cover all
    ///   the requested permissions.
    ///
    /// * `UNSURE` : It is not possible to determine whether the caller has all the
    ///   permissions needed.
    /// This output is most likely for cases when the caller has permissions with
    /// conditions.
    permission_check_result: ?permissionCheckResultType = null,

    /// The status of the permission check for the delegation request.
    ///
    /// This value indicates the status of the process to check whether the caller
    /// has sufficient permissions to cover the requested actions in the delegation
    /// request.
    /// Since this is an asynchronous process, there are three potential values:
    ///
    /// * `IN_PROGRESS` : The permission check process has started.
    ///
    /// * `COMPLETED` : The permission check process has completed. The
    ///   `PermissionCheckResult` will include the result.
    ///
    /// * `FAILED` : The permission check process has failed.
    permission_check_status: ?permissionCheckStatusType = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDelegationRequestInput, options: CallOptions) !GetDelegationRequestOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDelegationRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetDelegationRequest&Version=2010-05-08");
    if (input.delegation_permission_check) |v| {
        try body_buf.appendSlice(allocator, "&DelegationPermissionCheck=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&DelegationRequestId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.delegation_request_id);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDelegationRequestOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetDelegationRequestResult")) break;
            },
            else => {},
        }
    }

    var result: GetDelegationRequestOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DelegationRequest")) {
                    result.delegation_request = try serde.deserializeDelegationRequest(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "PermissionCheckResult")) {
                    result.permission_check_result = permissionCheckResultType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionCheckStatus")) {
                    result.permission_check_status = permissionCheckStatusType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
