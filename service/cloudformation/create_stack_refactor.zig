const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceMapping = @import("resource_mapping.zig").ResourceMapping;
const StackDefinition = @import("stack_definition.zig").StackDefinition;
const serde = @import("serde.zig");

pub const CreateStackRefactorInput = struct {
    /// A description to help you identify the stack refactor.
    description: ?[]const u8 = null,

    /// Determines if a new stack is created with the refactor.
    enable_stack_creation: ?bool = null,

    /// The mappings for the stack resource `Source` and stack resource
    /// `Destination`.
    resource_mappings: ?[]const ResourceMapping = null,

    /// The stacks being refactored.
    stack_definitions: []const StackDefinition,
};

pub const CreateStackRefactorOutput = struct {
    /// The ID associated with the stack refactor created from the
    /// CreateStackRefactor action.
    stack_refactor_id: []const u8,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStackRefactorInput, options: CallOptions) !CreateStackRefactorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStackRefactorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateStackRefactor&Version=2010-05-15");
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.enable_stack_creation) |v| {
        try body_buf.appendSlice(allocator, "&EnableStackCreation=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.resource_mappings) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceMappings.member.{d}.Destination.LogicalResourceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.destination.logical_resource_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceMappings.member.{d}.Destination.StackName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.destination.stack_name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceMappings.member.{d}.Source.LogicalResourceId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.source.logical_resource_id);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ResourceMappings.member.{d}.Source.StackName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.source.stack_name);
            }
        }
    }
    for (input.stack_definitions, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.stack_name) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackDefinitions.member.{d}.StackName=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.template_body) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackDefinitions.member.{d}.TemplateBody=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.template_url) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StackDefinitions.member.{d}.TemplateURL=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStackRefactorOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateStackRefactorResult")) break;
            },
            else => {},
        }
    }

    var result: CreateStackRefactorOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "StackRefactorId")) {
                    result.stack_refactor_id = try allocator.dupe(u8, try reader.readElementText());
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
