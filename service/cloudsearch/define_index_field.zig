const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const IndexField = @import("index_field.zig").IndexField;
const IndexFieldStatus = @import("index_field_status.zig").IndexFieldStatus;
const serde = @import("serde.zig");

pub const DefineIndexFieldInput = struct {
    domain_name: []const u8,

    /// The index field and field options you want to configure.
    index_field: IndexField,
};

pub const DefineIndexFieldOutput = struct {
    index_field: ?IndexFieldStatus = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DefineIndexFieldInput, options: CallOptions) !DefineIndexFieldOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudsearch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DefineIndexFieldInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearch", "CloudSearch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=DefineIndexField&Version=2013-01-01");
    try body_buf.appendSlice(allocator, "&DomainName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.domain_name);
    if (input.index_field.date_array_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateArrayOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateArrayOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateArrayOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateArrayOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_fields) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateArrayOptions.SourceFields=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.date_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DateOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.double_array_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleArrayOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleArrayOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleArrayOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleArrayOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_fields) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleArrayOptions.SourceFields=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.double_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.DoubleOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    try body_buf.appendSlice(allocator, "&IndexField.IndexFieldName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.index_field.index_field_name);
    try body_buf.appendSlice(allocator, "&IndexField.IndexFieldType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.index_field.index_field_type.wireName());
    if (input.index_field.int_array_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntArrayOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntArrayOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntArrayOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntArrayOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_fields) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntArrayOptions.SourceFields=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.int_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv2}) catch "");
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.IntOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.lat_lon_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LatLonOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.literal_array_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralArrayOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralArrayOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralArrayOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralArrayOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_fields) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralArrayOptions.SourceFields=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.literal_options) |sv| {
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.facet_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.FacetEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.search_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.SearchEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.LiteralOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.text_array_options) |sv| {
        if (sv.analysis_scheme) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextArrayOptions.AnalysisScheme=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextArrayOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.highlight_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextArrayOptions.HighlightEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextArrayOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_fields) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextArrayOptions.SourceFields=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }
    if (input.index_field.text_options) |sv| {
        if (sv.analysis_scheme) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.AnalysisScheme=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.default_value) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.DefaultValue=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
        if (sv.highlight_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.HighlightEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.return_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.ReturnEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.sort_enabled) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.SortEnabled=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv2) "true" else "false");
        }
        if (sv.source_field) |sv2| {
            try body_buf.appendSlice(allocator, "&IndexField.TextOptions.SourceField=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv2);
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DefineIndexFieldOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DefineIndexFieldResult")) break;
            },
            else => {},
        }
    }

    var result: DefineIndexFieldOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "IndexField")) {
                    result.index_field = try serde.deserializeIndexFieldStatus(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "BaseException")) {
        return .{ .arena = arena, .kind = .{ .base_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DisabledOperationException")) {
        return .{ .arena = arena, .kind = .{ .disabled_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
