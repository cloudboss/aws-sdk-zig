const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAs = @import("call_as.zig").CallAs;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const serde = @import("serde.zig");

pub const ImportStacksToStackSetInput = struct {
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * If you are signed in to the management account, specify
    /// `SELF`.
    ///
    /// * For service managed StackSets, specify `DELEGATED_ADMIN`.
    call_as: ?CallAs = null,

    /// A unique, user defined, identifier for the StackSet operation.
    operation_id: ?[]const u8 = null,

    /// The user-specified preferences for how CloudFormation performs a StackSet
    /// operation.
    ///
    /// For more information about maximum concurrent accounts and failure
    /// tolerance, see [StackSet operation
    /// options](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options).
    operation_preferences: ?StackSetOperationPreferences = null,

    /// The list of OU ID's to which the imported stacks must be mapped as
    /// deployment
    /// targets.
    organizational_unit_ids: ?[]const []const u8 = null,

    /// The IDs of the stacks you are importing into a StackSet. You import up to 10
    /// stacks per
    /// StackSet at a time.
    ///
    /// Specify either `StackIds` or `StackIdsUrl`.
    stack_ids: ?[]const []const u8 = null,

    /// The Amazon S3 URL which contains list of stack ids to be inputted.
    ///
    /// Specify either `StackIds` or `StackIdsUrl`.
    stack_ids_url: ?[]const u8 = null,

    /// The name of the StackSet. The name must be unique in the Region where you
    /// create your
    /// StackSet.
    stack_set_name: []const u8,
};

pub const ImportStacksToStackSetOutput = struct {
    /// The unique identifier for the StackSet operation.
    operation_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportStacksToStackSetInput, options: CallOptions) !ImportStacksToStackSetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportStacksToStackSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ImportStacksToStackSet&Version=2010-05-15");
    if (input.call_as) |v| {
        try body_buf.appendSlice(allocator, "&CallAs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.operation_id) |v| {
        try body_buf.appendSlice(allocator, "&OperationId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.operation_preferences) |v| {
        if (v.concurrency_mode) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.ConcurrencyMode=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.failure_tolerance_count) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.FailureToleranceCount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.failure_tolerance_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.FailureTolerancePercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.max_concurrent_count) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.MaxConcurrentCount=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.max_concurrent_percentage) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.MaxConcurrentPercentage=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv}) catch "");
        }
        if (v.region_concurrency_type) |sv| {
            try body_buf.appendSlice(allocator, "&OperationPreferences.RegionConcurrencyType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.region_order) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OperationPreferences.RegionOrder.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
    }
    if (input.organizational_unit_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&OrganizationalUnitIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.stack_ids) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackIds.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.stack_ids_url) |v| {
        try body_buf.appendSlice(allocator, "&StackIdsUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&StackSetName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.stack_set_name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportStacksToStackSetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ImportStacksToStackSetResult")) break;
            },
            else => {},
        }
    }

    var result: ImportStacksToStackSetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OperationId")) {
                    result.operation_id = try allocator.dupe(u8, try reader.readElementText());
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
