const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Role = @import("role.zig").Role;
const serde = @import("serde.zig");

pub const CreateRoleInput = struct {
    /// The trust relationship policy document that grants an entity permission to
    /// assume the
    /// role.
    ///
    /// In IAM, you must provide a JSON policy that has been converted to a string.
    /// However,
    /// for CloudFormation templates formatted in YAML, you can provide the policy
    /// in JSON or YAML
    /// format. CloudFormation always converts a YAML policy to JSON format before
    /// submitting it to
    /// IAM.
    ///
    /// The [regex pattern](http://wikipedia.org/wiki/regex)
    /// used to validate this parameter is a string of characters consisting of the
    /// following:
    ///
    /// * Any printable ASCII
    /// character ranging from the space character (`\u0020`) through the end of the
    /// ASCII character range
    ///
    /// * The printable characters in the Basic Latin and Latin-1 Supplement
    ///   character set
    /// (through `\u00FF`)
    ///
    /// * The special characters tab (`\u0009`), line feed (`\u000A`), and
    /// carriage return (`\u000D`)
    ///
    /// Upon success, the response includes the same trust policy in JSON format.
    assume_role_policy_document: []const u8,

    /// A description of the role.
    description: ?[]const u8 = null,

    /// The maximum session duration (in seconds) that you want to set for the
    /// specified role.
    /// If you do not specify a value for this setting, the default value of one
    /// hour is
    /// applied. This setting can have a value from 1 hour to 12 hours.
    ///
    /// Anyone who assumes the role from the CLI or API can use the
    /// `DurationSeconds` API parameter or the `duration-seconds`
    /// CLI parameter to request a longer session. The `MaxSessionDuration` setting
    /// determines the maximum duration that can be requested using the
    /// `DurationSeconds` parameter. If users don't specify a value for the
    /// `DurationSeconds` parameter, their security credentials are valid for one
    /// hour by default. This applies when you use the `AssumeRole*` API operations
    /// or the `assume-role*` CLI operations but does not apply when you use those
    /// operations to create a console URL. For more information, see [Using IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)
    /// in the *IAM User Guide*.
    max_session_duration: ?i32 = null,

    /// The path to the role. For more information about paths, see [IAM
    /// Identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the *IAM User Guide*.
    ///
    /// This parameter is optional. If it is not included, it defaults to a slash
    /// (/).
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of either a forward slash (/) by itself or a string that must begin and end
    /// with forward slashes.
    /// In addition, it can contain any ASCII character from the ! (`\u0021`)
    /// through the DEL character (`\u007F`), including
    /// most punctuation characters, digits, and upper and lowercased letters.
    path: ?[]const u8 = null,

    /// The ARN of the managed policy that is used to set the permissions boundary
    /// for the
    /// role.
    ///
    /// A permissions boundary policy defines the maximum permissions that
    /// identity-based
    /// policies can grant to an entity, but does not grant permissions. Permissions
    /// boundaries
    /// do not define the maximum permissions that a resource-based policy can grant
    /// to an
    /// entity. To learn more, see [Permissions boundaries
    /// for IAM
    /// entities](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
    ///
    /// For more information about policy types, see [Policy types
    /// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies.html#access_policy-types) in the *IAM User Guide*.
    permissions_boundary: ?[]const u8 = null,

    /// The name of the role to create.
    ///
    /// IAM user, group, role, and policy names must be unique within the account.
    /// Names are
    /// not distinguished by case. For example, you cannot create resources named
    /// both
    /// "MyResource" and "myresource".
    ///
    /// This parameter allows (through its [regex
    /// pattern](http://wikipedia.org/wiki/regex)) a string of characters consisting
    /// of upper and lowercase alphanumeric
    /// characters with no spaces. You can also include any of the following
    /// characters: _+=,.@-
    role_name: []const u8,

    /// A list of tags that you want to attach to the new role. Each tag consists of
    /// a key name and an associated value.
    /// For more information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// If any one of the tags is invalid or if you exceed the allowed maximum
    /// number of tags, then the entire request
    /// fails and the resource is not created.
    tags: ?[]const Tag = null,
};

pub const CreateRoleOutput = struct {
    /// A structure containing details about the new role.
    role: ?Role = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRoleInput, options: CallOptions) !CreateRoleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateRole&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&AssumeRolePolicyDocument=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.assume_role_policy_document);
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.max_session_duration) |v| {
        try body_buf.appendSlice(allocator, "&MaxSessionDuration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.path) |v| {
        try body_buf.appendSlice(allocator, "&Path=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.permissions_boundary) |v| {
        try body_buf.appendSlice(allocator, "&PermissionsBoundary=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RoleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_name);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRoleOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateRoleResult")) break;
            },
            else => {},
        }
    }

    var result: CreateRoleOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Role")) {
                    result.role = try serde.deserializeRole(allocator, &reader);
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
