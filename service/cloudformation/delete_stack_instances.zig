const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAs = @import("call_as.zig").CallAs;
const DeploymentTargets = @import("deployment_targets.zig").DeploymentTargets;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const serde = @import("serde.zig");

pub const DeleteStackInstancesInput = struct {
    /// [Self-managed permissions] The account IDs of the Amazon Web Services
    /// accounts that you want to delete
    /// stack instances for.
    ///
    /// You can specify `Accounts` or `DeploymentTargets`, but not
    /// both.
    accounts: ?[]const []const u8 = null,

    /// [Service-managed permissions] Specifies whether you are acting as an account
    /// administrator
    /// in the organization's management account or as a delegated administrator in
    /// a
    /// member account.
    ///
    /// By default, `SELF` is specified. Use `SELF` for StackSets with
    /// self-managed permissions.
    ///
    /// * If you are signed in to the management account, specify
    /// `SELF`.
    ///
    /// * If you are signed in to a delegated administrator account, specify
    /// `DELEGATED_ADMIN`.
    ///
    /// Your Amazon Web Services account must be registered as a delegated
    /// administrator in the management account. For more information, see [Register
    /// a
    /// delegated
    /// administrator](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-orgs-delegated-admin.html) in the *CloudFormation User Guide*.
    call_as: ?CallAs = null,

    /// [Service-managed permissions] The Organizations accounts from which to
    /// delete
    /// stack instances.
    ///
    /// You can specify `Accounts` or `DeploymentTargets`, but not
    /// both.
    deployment_targets: ?DeploymentTargets = null,

    /// The unique identifier for this StackSet operation.
    ///
    /// If you don't specify an operation ID, the SDK generates one
    /// automatically.
    ///
    /// The operation ID also functions as an idempotency token, to ensure that
    /// CloudFormation
    /// performs the StackSet operation only once, even if you retry the request
    /// multiple times. You
    /// can retry StackSet operation requests to ensure that CloudFormation
    /// successfully received
    /// them.
    ///
    /// Repeating this StackSet operation with a new operation ID retries all stack
    /// instances
    /// whose status is `OUTDATED`.
    operation_id: ?[]const u8 = null,

    /// Preferences for how CloudFormation performs this StackSet operation.
    operation_preferences: ?StackSetOperationPreferences = null,

    /// The Amazon Web Services Regions where you want to delete StackSet instances.
    regions: []const []const u8,

    /// Removes the stack instances from the specified StackSet, but doesn't delete
    /// the stacks.
    /// You can't reassociate a retained stack or add an existing, saved stack to a
    /// new stack
    /// set.
    ///
    /// For more information, see [StackSet operation
    /// options](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-concepts.html#stackset-ops-options).
    retain_stacks: bool,

    /// The name or unique ID of the StackSet that you want to delete stack
    /// instances for.
    stack_set_name: []const u8,
};

pub const DeleteStackInstancesOutput = struct {
    /// The unique identifier for this StackSet operation.
    operation_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteStackInstancesInput, options: CallOptions) !DeleteStackInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteStackInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteStackInstances&Version=2010-05-15");
    if (input.accounts) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Accounts.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.call_as) |v| {
        try body_buf.appendSlice(allocator, "&CallAs=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.deployment_targets) |v| {
        if (v.account_filter_type) |sv| {
            try body_buf.appendSlice(allocator, "&DeploymentTargets.AccountFilterType=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.accounts) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DeploymentTargets.Accounts.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
        if (v.accounts_url) |sv| {
            try body_buf.appendSlice(allocator, "&DeploymentTargets.AccountsUrl=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.organizational_unit_ids) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DeploymentTargets.OrganizationalUnitIds.member.{d}=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item);
            }
        }
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
    for (input.regions, 0..) |item, idx| {
        const n = idx + 1;
        var prefix_buf: [256]u8 = undefined;
        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Regions.member.{d}=", .{n}) catch continue;
        try body_buf.appendSlice(allocator, field_prefix);
        try aws.url.appendUrlEncoded(allocator, &body_buf, item);
    }
    try body_buf.appendSlice(allocator, "&RetainStacks=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, if (input.retain_stacks) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteStackInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteStackInstancesResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteStackInstancesOutput = .{};
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
