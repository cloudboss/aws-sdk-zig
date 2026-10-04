const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAs = @import("call_as.zig").CallAs;
const DeploymentTargets = @import("deployment_targets.zig").DeploymentTargets;
const StackSetOperationPreferences = @import("stack_set_operation_preferences.zig").StackSetOperationPreferences;
const Parameter = @import("parameter.zig").Parameter;
const serde = @import("serde.zig");

pub const UpdateStackInstancesInput = struct {
    /// [Self-managed permissions] The account IDs of one or more Amazon Web
    /// Services accounts in which you want
    /// to update parameter values for stack instances. The overridden parameter
    /// values will be
    /// applied to all stack instances in the specified accounts and Amazon Web
    /// Services Regions.
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

    /// [Service-managed permissions] The Organizations accounts in which you want
    /// to
    /// update parameter values for stack instances. If your update targets OUs, the
    /// overridden
    /// parameter values only apply to the accounts that are currently in the target
    /// OUs and their
    /// child OUs. Accounts added to the target OUs and their child OUs in the
    /// future won't use the
    /// overridden values.
    ///
    /// You can specify `Accounts` or `DeploymentTargets`, but not
    /// both.
    deployment_targets: ?DeploymentTargets = null,

    /// The unique identifier for this StackSet operation.
    ///
    /// The operation ID also functions as an idempotency token, to ensure that
    /// CloudFormation
    /// performs the StackSet operation only once, even if you retry the request
    /// multiple times. You
    /// might retry StackSet operation requests to ensure that CloudFormation
    /// successfully received
    /// them.
    ///
    /// If you don't specify an operation ID, the SDK generates one
    /// automatically.
    operation_id: ?[]const u8 = null,

    /// Preferences for how CloudFormation performs this StackSet operation.
    operation_preferences: ?StackSetOperationPreferences = null,

    /// A list of input parameters whose values you want to update for the specified
    /// stack
    /// instances.
    ///
    /// Any overridden parameter values will be applied to all stack instances in
    /// the specified
    /// accounts and Amazon Web Services Regions. When specifying parameters and
    /// their values, be aware of how
    /// CloudFormation sets parameter values during stack instance update
    /// operations:
    ///
    /// * To override the current value for a parameter, include the parameter and
    ///   specify its
    /// value.
    ///
    /// * To leave an overridden parameter set to its present value, include the
    ///   parameter and
    /// specify `UsePreviousValue` as `true`. (You can't specify both a
    /// value and set `UsePreviousValue` to `true`.)
    ///
    /// * To set an overridden parameter back to the value specified in the
    ///   StackSet, specify a
    /// parameter list but don't include the parameter in the list.
    ///
    /// * To leave all parameters set to their present values, don't specify this
    ///   property at
    /// all.
    ///
    /// During StackSet updates, any parameter values overridden for a stack
    /// instance aren't
    /// updated, but retain their overridden value.
    ///
    /// You can only override the parameter *values* that are specified in the
    /// StackSet. To add or delete a parameter itself, use `UpdateStackSet` to
    /// update the
    /// StackSet template. If you add a parameter to a template, before you can
    /// override the parameter
    /// value specified in the StackSet you must first use
    /// [UpdateStackSet](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_UpdateStackSet.html)
    /// to update all stack instances with the updated template and parameter value
    /// specified in the
    /// StackSet. Once a stack instance has been updated with the new parameter, you
    /// can then override
    /// the parameter value using `UpdateStackInstances`.
    parameter_overrides: ?[]const Parameter = null,

    /// The names of one or more Amazon Web Services Regions in which you want to
    /// update parameter values for
    /// stack instances. The overridden parameter values will be applied to all
    /// stack instances in the
    /// specified accounts and Amazon Web Services Regions.
    regions: []const []const u8,

    /// The name or unique ID of the StackSet associated with the stack instances.
    stack_set_name: []const u8,
};

pub const UpdateStackInstancesOutput = struct {
    /// The unique identifier for this StackSet operation.
    operation_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStackInstancesInput, options: CallOptions) !UpdateStackInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStackInstancesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateStackInstances&Version=2010-05-15");
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
    if (input.parameter_overrides) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.parameter_key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterOverrides.member.{d}.ParameterKey=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.parameter_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterOverrides.member.{d}.ParameterValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resolved_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterOverrides.member.{d}.ResolvedValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.use_previous_value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ParameterOverrides.member.{d}.UsePreviousValue=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStackInstancesOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateStackInstancesResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateStackInstancesOutput = .{};
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
