const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionTaskFailureReasonType = @import("deletion_task_failure_reason_type.zig").DeletionTaskFailureReasonType;
const DeletionTaskStatusType = @import("deletion_task_status_type.zig").DeletionTaskStatusType;
const serde = @import("serde.zig");

pub const GetServiceLinkedRoleDeletionStatusInput = struct {
    /// The deletion task identifier. This identifier is returned by the
    /// [DeleteServiceLinkedRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_DeleteServiceLinkedRole.html) operation in the format
    /// `task/aws-service-role///`.
    deletion_task_id: []const u8,
};

pub const GetServiceLinkedRoleDeletionStatusOutput = struct {
    /// An object that contains details about the reason the deletion failed.
    reason: ?DeletionTaskFailureReasonType = null,

    /// The status of the deletion.
    status: DeletionTaskStatusType,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceLinkedRoleDeletionStatusInput, options: CallOptions) !GetServiceLinkedRoleDeletionStatusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceLinkedRoleDeletionStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetServiceLinkedRoleDeletionStatus&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&DeletionTaskId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.deletion_task_id);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceLinkedRoleDeletionStatusOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetServiceLinkedRoleDeletionStatusResult")) break;
            },
            else => {},
        }
    }

    var result: GetServiceLinkedRoleDeletionStatusOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try serde.deserializeDeletionTaskFailureReasonType(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = DeletionTaskStatusType.fromWireName(try reader.readElementText());
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
