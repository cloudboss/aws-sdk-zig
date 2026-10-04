const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const Policy = @import("policy.zig").Policy;
const serde = @import("serde.zig");

pub const CreatePolicyInput = struct {
    /// A friendly description of the policy.
    ///
    /// Typically used to store information about the permissions defined in the
    /// policy. For
    /// example, "Grants access to production DynamoDB tables."
    ///
    /// The policy description is immutable. After a value is assigned, it cannot be
    /// changed.
    description: ?[]const u8 = null,

    /// The path for the policy.
    ///
    /// For more information about paths, see [IAM
    /// identifiers](https://docs.aws.amazon.com/IAM/latest/UserGuide/Using_Identifiers.html) in the
    /// *IAM User Guide*.
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
    ///
    /// You cannot use an asterisk (*) in the path name.
    path: ?[]const u8 = null,

    /// The JSON policy document that you want to use as the content for the new
    /// policy.
    ///
    /// You must provide policies in JSON format in IAM. However, for CloudFormation
    /// templates formatted in YAML, you can provide the policy in JSON or YAML
    /// format. CloudFormation always converts a YAML policy to JSON format before
    /// submitting it to
    /// IAM.
    ///
    /// The maximum length of the policy document that you can pass in this
    /// operation,
    /// including whitespace, is listed below. To view the maximum character counts
    /// of a managed policy with no whitespaces, see [IAM and STS character
    /// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html#reference_iam-quotas-entity-length).
    ///
    /// To learn more about JSON policy grammar, see [Grammar of the IAM JSON
    /// policy
    /// language](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_grammar.html) in the *IAM User Guide*.
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
    policy_document: []const u8,

    /// The friendly name of the policy.
    ///
    /// IAM user, group, role, and policy names must be unique within the account.
    /// Names are
    /// not distinguished by case. For example, you cannot create resources named
    /// both
    /// "MyResource" and "myresource".
    policy_name: []const u8,

    /// A list of tags that you want to attach to the new IAM customer managed
    /// policy.
    /// Each tag consists of a key name and an associated value. For more
    /// information about tagging, see [Tagging IAM
    /// resources](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_tags.html) in
    /// the
    /// *IAM User Guide*.
    ///
    /// If any one of the tags is invalid or if you exceed the allowed maximum
    /// number of tags, then the entire request
    /// fails and the resource is not created.
    tags: ?[]const Tag = null,
};

pub const CreatePolicyOutput = struct {
    /// A structure containing details about the new policy.
    policy: ?Policy = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyInput, options: CallOptions) !CreatePolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreatePolicy&Version=2010-05-08");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.path) |v| {
        try body_buf.appendSlice(allocator, "&Path=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&PolicyDocument=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_document);
    try body_buf.appendSlice(allocator, "&PolicyName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.policy_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreatePolicyResult")) break;
            },
            else => {},
        }
    }

    var result: CreatePolicyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policy")) {
                    result.policy = try serde.deserializePolicy(allocator, &reader);
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
