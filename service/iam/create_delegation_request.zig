const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DelegationPermission = @import("delegation_permission.zig").DelegationPermission;
const serde = @import("serde.zig");

pub const CreateDelegationRequestInput = struct {
    /// A description of the delegation request.
    description: []const u8,

    /// The notification channel for updates about the delegation request.
    ///
    /// At this time,only SNS topic ARNs are accepted for notification. This topic
    /// ARN must have a resource policy granting
    /// `SNS:Publish` permission to the IAM service principal (`iam.amazonaws.com`).
    /// See
    /// [partner onboarding
    /// documentation](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies-temporary-delegation-partner-guide.html) for more details.
    notification_channel: []const u8,

    /// Specifies whether the delegation token should only be sent by the owner.
    ///
    /// This flag prevents any party other than the owner from calling
    /// `SendDelegationToken` API for this delegation request.
    /// This behavior becomes useful when the delegation request owner needs to be
    /// present for subsequent partner interactions, but the delegation request was
    /// sent
    /// to a more privileged user for approval due to the owner lacking sufficient
    /// delegation permissions.
    only_send_by_owner: ?bool = null,

    /// The Amazon Web Services account ID this delegation request is targeted to.
    ///
    /// If the account ID is not known, this parameter can be omitted, resulting in
    /// a request that can be associated by
    /// any account. If the account ID passed, then the created delegation request
    /// can only be associated with an
    /// identity of that target account.
    owner_account_id: ?[]const u8 = null,

    /// The permissions to be delegated in this delegation request.
    permissions: DelegationPermission,

    /// The URL to redirect to after the delegation request is processed.
    ///
    /// This URL is used by the IAM console to show a link to the customer to
    /// re-load the partner workflow.
    redirect_url: ?[]const u8 = null,

    /// A message explaining the reason for the delegation request.
    ///
    /// Requesters can utilize this field to add a custom note to the delegation
    /// request. This field is different from the
    /// description such that this is to be utilized for a custom messaging on a
    /// case-by-case basis.
    ///
    /// For example, if the current delegation request is in response to a previous
    /// request being rejected, this explanation
    /// can be added to the request via this field.
    request_message: ?[]const u8 = null,

    /// The workflow ID associated with the requestor.
    ///
    /// This is the unique identifier on the partner side that can be used to track
    /// the progress of the request.
    ///
    /// IAM maintains a uniqueness check on this workflow id for each request - if a
    /// workflow id for an existing request
    /// is passed, this API call will fail.
    requestor_workflow_id: []const u8,

    /// The duration for which the delegated session should remain active, in
    /// seconds.
    ///
    /// The active time window for the session starts when the customer calls the
    /// [SendDelegationToken](https://docs.aws.amazon.com/IAM/latest/APIReference/API_SendDelegationToken.html) API.
    session_duration: i32,
};

pub const CreateDelegationRequestOutput = struct {
    /// A deep link URL to the Amazon Web Services Management Console for managing
    /// the delegation request.
    ///
    /// For a console based workflow, partners should redirect the customer to this
    /// URL.
    /// If the customer is not logged in to any Amazon Web Services account, the
    /// Amazon Web Services workflow will
    /// automatically direct the customer to log in and then display the delegation
    /// request approval page.
    console_deep_link: ?[]const u8 = null,

    /// The unique identifier for the created delegation request.
    delegation_request_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDelegationRequestInput, options: CallOptions) !CreateDelegationRequestOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDelegationRequestInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateDelegationRequest&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&Description=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.description);
    try body_buf.appendSlice(allocator, "&NotificationChannel=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.notification_channel);
    if (input.only_send_by_owner) |v| {
        try body_buf.appendSlice(allocator, "&OnlySendByOwner=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.owner_account_id) |v| {
        try body_buf.appendSlice(allocator, "&OwnerAccountId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.permissions.parameters) |list_d0| {
        for (list_d0, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.name) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Type=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.values) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Permissions.Parameters.member.{d}.Values.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
        }
    }
    if (input.permissions.policy_template_arn) |sv| {
        try body_buf.appendSlice(allocator, "&Permissions.PolicyTemplateArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
    }
    if (input.redirect_url) |v| {
        try body_buf.appendSlice(allocator, "&RedirectUrl=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.request_message) |v| {
        try body_buf.appendSlice(allocator, "&RequestMessage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RequestorWorkflowId=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.requestor_workflow_id);
    try body_buf.appendSlice(allocator, "&SessionDuration=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.session_duration}) catch "");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDelegationRequestOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDelegationRequestResult")) break;
            },
            else => {},
        }
    }

    var result: CreateDelegationRequestOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ConsoleDeepLink")) {
                    result.console_deep_link = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DelegationRequestId")) {
                    result.delegation_request_id = try allocator.dupe(u8, try reader.readElementText());
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
