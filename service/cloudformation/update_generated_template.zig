const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceDefinition = @import("resource_definition.zig").ResourceDefinition;
const TemplateConfiguration = @import("template_configuration.zig").TemplateConfiguration;
const serde = @import("serde.zig");

pub const UpdateGeneratedTemplateInput = struct {
    /// An optional list of resources to be added to the generated template.
    add_resources: ?[]const ResourceDefinition = null,

    /// The name or Amazon Resource Name (ARN) of a generated template.
    generated_template_name: []const u8,

    /// An optional new name to assign to the generated template.
    new_generated_template_name: ?[]const u8 = null,

    /// If `true`, update the resource properties in the generated template with
    /// their
    /// current live state. This feature is useful when the resource properties in
    /// your generated a
    /// template does not reflect the live state of the resource properties. This
    /// happens when a user
    /// update the resource properties after generating a template.
    refresh_all_resources: ?bool = null,

    /// A list of logical ids for resources to remove from the generated template.
    remove_resources: ?[]const []const u8 = null,

    /// The configuration details of the generated template, including the
    /// `DeletionPolicy` and `UpdateReplacePolicy`.
    template_configuration: ?TemplateConfiguration = null,
};

pub const UpdateGeneratedTemplateOutput = struct {
    /// The Amazon Resource Name (ARN) of the generated template. The format is
    /// `arn:${Partition}:cloudformation:${Region}:${Account}:generatedtemplate/${Id}`.
    /// For example,
    /// `arn:aws:cloudformation:*us-east-1*:*123456789012*:generatedtemplate/*2e8465c1-9a80-43ea-a3a3-4f2d692fe6dc*
    /// `.
    generated_template_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGeneratedTemplateInput, options: CallOptions) !UpdateGeneratedTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGeneratedTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=UpdateGeneratedTemplate&Version=2010-05-15");
    if (input.add_resources) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.logical_resource_id) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddResources.member.{d}.LogicalResourceId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AddResources.member.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.resource_type);
            }
        }
    }
    try body_buf.appendSlice(allocator, "&GeneratedTemplateName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.generated_template_name);
    if (input.new_generated_template_name) |v| {
        try body_buf.appendSlice(allocator, "&NewGeneratedTemplateName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.refresh_all_resources) |v| {
        try body_buf.appendSlice(allocator, "&RefreshAllResources=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.remove_resources) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RemoveResources.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.template_configuration) |v| {
        if (v.deletion_policy) |sv| {
            try body_buf.appendSlice(allocator, "&TemplateConfiguration.DeletionPolicy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
        }
        if (v.update_replace_policy) |sv| {
            try body_buf.appendSlice(allocator, "&TemplateConfiguration.UpdateReplacePolicy=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGeneratedTemplateOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UpdateGeneratedTemplateResult")) break;
            },
            else => {},
        }
    }

    var result: UpdateGeneratedTemplateOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GeneratedTemplateId")) {
                    result.generated_template_id = try allocator.dupe(u8, try reader.readElementText());
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
