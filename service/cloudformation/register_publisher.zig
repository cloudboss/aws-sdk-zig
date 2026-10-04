const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterPublisherInput = struct {
    /// Whether you accept the [Terms and
    /// Conditions](https://cloudformation-registry-documents.s3.amazonaws.com/Terms_and_Conditions_for_AWS_CloudFormation_Registry_Publishers.pdf) for publishing extensions in the CloudFormation registry. You must
    /// accept the terms and conditions in order to register to publish public
    /// extensions to the
    /// CloudFormation registry.
    ///
    /// The default is `false`.
    accept_terms_and_conditions: ?bool = null,

    /// If you are using a Bitbucket or GitHub account for identity verification,
    /// the Amazon
    /// Resource Name (ARN) for your connection to that account.
    ///
    /// For more information, see [Prerequisite: Registering your account to publish
    /// CloudFormation
    /// extensions](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/publish-extension.html#publish-extension-prereqs) in the
    /// *CloudFormation Command Line Interface (CLI) User Guide*.
    connection_arn: ?[]const u8 = null,
};

pub const RegisterPublisherOutput = struct {
    /// The ID assigned this account by CloudFormation for publishing extensions.
    publisher_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterPublisherInput, options: CallOptions) !RegisterPublisherOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterPublisherInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RegisterPublisher&Version=2010-05-15");
    if (input.accept_terms_and_conditions) |v| {
        try body_buf.appendSlice(allocator, "&AcceptTermsAndConditions=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.connection_arn) |v| {
        try body_buf.appendSlice(allocator, "&ConnectionArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterPublisherOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RegisterPublisherResult")) break;
            },
            else => {},
        }
    }

    var result: RegisterPublisherOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PublisherId")) {
                    result.publisher_id = try allocator.dupe(u8, try reader.readElementText());
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
