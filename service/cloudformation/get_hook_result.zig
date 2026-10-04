const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Annotation = @import("annotation.zig").Annotation;
const HookFailureMode = @import("hook_failure_mode.zig").HookFailureMode;
const HookInvocationPoint = @import("hook_invocation_point.zig").HookInvocationPoint;
const HookStatus = @import("hook_status.zig").HookStatus;
const HookTarget = @import("hook_target.zig").HookTarget;
const serde = @import("serde.zig");

pub const GetHookResultInput = struct {
    /// The unique identifier (ID) of the Hook invocation result that you want
    /// details about.
    /// You can get the ID from the
    /// [ListHookResults](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListHookResults.html)
    /// operation.
    hook_result_id: ?[]const u8 = null,
};

pub const GetHookResultOutput = struct {
    /// A list of objects with additional information and guidance that can help you
    /// resolve a
    /// failed Hook invocation.
    annotations: ?[]const Annotation = null,

    /// The failure mode of the invocation.
    failure_mode: ?HookFailureMode = null,

    /// The unique identifier of the Hook result.
    hook_result_id: ?[]const u8 = null,

    /// A message that provides additional details about the Hook invocation status.
    hook_status_reason: ?[]const u8 = null,

    /// The specific point in the provisioning process where the Hook is invoked.
    invocation_point: ?HookInvocationPoint = null,

    /// The timestamp when the Hook was invoked.
    invoked_at: ?i64 = null,

    /// The original public type name of the Hook when an alias is used.
    ///
    /// For example, if you activate `AWS::Hooks::GuardHook` with alias
    /// `MyCompany::Custom::GuardHook`, then `TypeName` will be
    /// `MyCompany::Custom::GuardHook` and `OriginalTypeName` will be
    /// `AWS::Hooks::GuardHook`.
    original_type_name: ?[]const u8 = null,

    /// The status of the Hook invocation. The following statuses are possible:
    ///
    /// * `HOOK_IN_PROGRESS`: The Hook is currently running.
    ///
    /// * `HOOK_COMPLETE_SUCCEEDED`: The Hook completed successfully.
    ///
    /// * `HOOK_COMPLETE_FAILED`: The Hook completed but failed validation.
    ///
    /// * `HOOK_FAILED`: The Hook encountered an error during execution.
    status: ?HookStatus = null,

    /// Information about the target of the Hook invocation.
    target: ?HookTarget = null,

    /// The Amazon Resource Name (ARN) of the Hook.
    type_arn: ?[]const u8 = null,

    /// The version identifier of the Hook configuration data that was used during
    /// invocation.
    type_configuration_version_id: ?[]const u8 = null,

    /// The name of the Hook that was invoked.
    type_name: ?[]const u8 = null,

    /// The version identifier of the Hook that was invoked.
    type_version_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetHookResultInput, options: CallOptions) !GetHookResultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetHookResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetHookResult&Version=2010-05-15");
    if (input.hook_result_id) |v| {
        try body_buf.appendSlice(allocator, "&HookResultId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetHookResultOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetHookResultResult")) break;
            },
            else => {},
        }
    }

    var result: GetHookResultOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Annotations")) {
                    result.annotations = try serde.deserializeAnnotationList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "FailureMode")) {
                    result.failure_mode = HookFailureMode.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookResultId")) {
                    result.hook_result_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "HookStatusReason")) {
                    result.hook_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvocationPoint")) {
                    result.invocation_point = HookInvocationPoint.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InvokedAt")) {
                    result.invoked_at = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "OriginalTypeName")) {
                    result.original_type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = HookStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Target")) {
                    result.target = try serde.deserializeHookTarget(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "TypeArn")) {
                    result.type_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeConfigurationVersionId")) {
                    result.type_configuration_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeName")) {
                    result.type_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TypeVersionId")) {
                    result.type_version_id = try allocator.dupe(u8, try reader.readElementText());
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
