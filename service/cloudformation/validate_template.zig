const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Capability = @import("capability.zig").Capability;
const TemplateParameter = @import("template_parameter.zig").TemplateParameter;
const serde = @import("serde.zig");

pub const ValidateTemplateInput = struct {
    /// Structure that contains the template body with a minimum length of 1 byte
    /// and a maximum
    /// length of 51,200 bytes.
    ///
    /// Conditional: You must pass `TemplateURL` or `TemplateBody`. If both
    /// are passed, only `TemplateBody` is used.
    template_body: ?[]const u8 = null,

    /// The URL of a file that contains the template body. The URL must point to a
    /// template (max
    /// size: 1 MB) that is located in an Amazon S3 bucket or a Systems Manager
    /// document. The location for
    /// an Amazon S3 bucket must start with `https://`.
    ///
    /// Conditional: You must pass `TemplateURL` or `TemplateBody`. If both
    /// are passed, only `TemplateBody` is used.
    template_url: ?[]const u8 = null,
};

pub const ValidateTemplateOutput = struct {
    /// The capabilities found within the template. If your template contains IAM
    /// resources, you
    /// must specify the CAPABILITY_IAM or CAPABILITY_NAMED_IAM value for this
    /// parameter when you use
    /// the CreateStack or UpdateStack actions with your template;
    /// otherwise, those actions return an InsufficientCapabilities error.
    ///
    /// For more information, see [Acknowledging IAM resources in CloudFormation
    /// templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/control-access-with-iam.html#using-iam-capabilities).
    capabilities: ?[]const Capability = null,

    /// The list of resources that generated the values in the `Capabilities`
    /// response
    /// element.
    capabilities_reason: ?[]const u8 = null,

    /// A list of the transforms that are declared in the template.
    declared_transforms: ?[]const []const u8 = null,

    /// The description found within the template.
    description: ?[]const u8 = null,

    /// A list of `TemplateParameter` structures.
    parameters: ?[]const TemplateParameter = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateTemplateInput, options: CallOptions) !ValidateTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ValidateTemplate&Version=2010-05-15");
    if (input.template_body) |v| {
        try body_buf.appendSlice(allocator, "&TemplateBody=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.template_url) |v| {
        try body_buf.appendSlice(allocator, "&TemplateURL=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ValidateTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: ValidateTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Capabilities")) {
                    result.capabilities = try serde.deserializeCapabilities(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "CapabilitiesReason")) {
                    result.capabilities_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DeclaredTransforms")) {
                    result.declared_transforms = try serde.deserializeTransformsList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try serde.deserializeTemplateParameters(allocator, &reader, "member");
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
