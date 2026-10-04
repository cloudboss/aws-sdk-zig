const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StackRefactorExecutionStatus = @import("stack_refactor_execution_status.zig").StackRefactorExecutionStatus;
const StackRefactorStatus = @import("stack_refactor_status.zig").StackRefactorStatus;
const serde = @import("serde.zig");

pub const DescribeStackRefactorInput = struct {
    /// The ID associated with the stack refactor created from the
    /// CreateStackRefactor action.
    stack_refactor_id: []const u8,
};

pub const DescribeStackRefactorOutput = struct {
    /// A description to help you identify the refactor.
    description: ?[]const u8 = null,

    /// The stack refactor execution operation status that's provided after calling
    /// the ExecuteStackRefactor action.
    execution_status: ?StackRefactorExecutionStatus = null,

    /// A detailed explanation for the stack refactor `ExecutionStatus`.
    execution_status_reason: ?[]const u8 = null,

    /// The unique ID for each stack.
    stack_ids: ?[]const []const u8 = null,

    /// The ID associated with the stack refactor created from the
    /// CreateStackRefactor action.
    stack_refactor_id: ?[]const u8 = null,

    /// The stack refactor operation status that's provided after calling the
    /// CreateStackRefactor action.
    status: ?StackRefactorStatus = null,

    /// A detailed explanation for the stack refactor operation `Status`.
    status_reason: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStackRefactorInput, options: CallOptions) !DescribeStackRefactorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStackRefactorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeStackRefactor&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&StackRefactorId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_refactor_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStackRefactorOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeStackRefactorResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeStackRefactorOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatus")) {
                    result.execution_status = StackRefactorExecutionStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExecutionStatusReason")) {
                    result.execution_status_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StackIds")) {
                    result.stack_ids = try serde.deserializeStackIds(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "StackRefactorId")) {
                    result.stack_refactor_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = StackRefactorStatus.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatusReason")) {
                    result.status_reason = try allocator.dupe(u8, try reader.readElementText());
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
