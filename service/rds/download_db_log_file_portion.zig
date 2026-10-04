const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DownloadDBLogFilePortionInput = struct {
    /// The customer-assigned name of the DB instance that contains the log files
    /// you want to list.
    ///
    /// Constraints:
    ///
    /// * Must match the identifier of an existing DBInstance.
    db_instance_identifier: []const u8,

    /// The name of the log file to be downloaded.
    log_file_name: []const u8,

    /// The pagination token provided in the previous request or "0". If the Marker
    /// parameter is specified the response includes only records beyond the marker
    /// until the end of the file or up to NumberOfLines.
    marker: ?[]const u8 = null,

    /// The number of lines to download. If the number of lines specified results in
    /// a file over 1 MB in size, the file is truncated at 1 MB in size.
    ///
    /// If the NumberOfLines parameter is specified, then the block of lines
    /// returned can be from the beginning or the end of the log file, depending on
    /// the value of the Marker parameter.
    ///
    /// * If neither Marker or NumberOfLines are specified, the entire log file is
    ///   returned up to a maximum of 10000 lines, starting with the most recent log
    ///   entries first.
    /// * If NumberOfLines is specified and Marker isn't specified, then the most
    ///   recent lines from the end of the log file are returned.
    /// * If Marker is specified as "0", then the specified number of lines from the
    ///   beginning of the log file are returned.
    /// * You can download the log file in blocks of lines by specifying the size of
    ///   the block using the NumberOfLines parameter, and by specifying a value of
    ///   "0" for the Marker parameter in your first request. Include the Marker
    ///   value returned in the response as the Marker value for the next request,
    ///   continuing until the AdditionalDataPending response element returns false.
    number_of_lines: ?i32 = null,
};

pub const DownloadDBLogFilePortionOutput = struct {
    /// A Boolean value that, if true, indicates there is more data to be
    /// downloaded.
    additional_data_pending: ?bool = null,

    /// Entries from the specified log file.
    log_file_data: ?[]const u8 = null,

    /// A pagination token that can be used in a later `DownloadDBLogFilePortion`
    /// request.
    marker: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DownloadDBLogFilePortionInput, options: CallOptions) !DownloadDBLogFilePortionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DownloadDBLogFilePortionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DownloadDBLogFilePortion&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&DBInstanceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.db_instance_identifier);
    try body_buf.appendSlice(allocator, "&LogFileName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.log_file_name);
    if (input.marker) |v| {
        try body_buf.appendSlice(allocator, "&Marker=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.number_of_lines) |v| {
        try body_buf.appendSlice(allocator, "&NumberOfLines=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DownloadDBLogFilePortionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DownloadDBLogFilePortionResult")) break;
            },
            else => {},
        }
    }

    var result: DownloadDBLogFilePortionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AdditionalDataPending")) {
                    result.additional_data_pending = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LogFileData")) {
                    result.log_file_data = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Marker")) {
                    result.marker = try allocator.dupe(u8, try reader.readElementText());
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
