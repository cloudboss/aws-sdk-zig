//! HTTP utilities for AWS requests
//!
//! Simple wrapper around std.http.Client.

const std = @import("std");
const Allocator = std.mem.Allocator;

/// HTTP methods
pub const Method = enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD,
    PATCH,
};

/// HTTP request
pub const Request = struct {
    method: Method = .POST,
    host: []const u8,
    port: ?u16 = null,
    path: []const u8 = "/",
    query: ?[]const u8 = null,
    headers: std.StringHashMapUnmanaged([]const u8),
    body: ?[]const u8 = null,
    tls: bool = true,

    const Self = @This();

    pub fn init(host: []const u8) Self {
        return .{
            .host = host,
            .headers = std.StringHashMapUnmanaged([]const u8){},
        };
    }

    pub fn deinit(self: *Self, allocator: Allocator) void {
        self.headers.deinit(allocator);
    }

    /// Get full URI
    pub fn getUri(self: *const Self) std.Uri {
        return .{
            .scheme = if (self.tls) "https" else "http",
            .host = .{ .raw = self.host },
            .port = self.port,
            .path = .{ .raw = if (self.path.len > 0) self.path else "/" },
            .query = if (self.query) |q| .{ .raw = q } else null,
        };
    }
};

/// HTTP response
pub const Response = struct {
    status: u16,
    body: []const u8,
    allocator: Allocator,

    const Self = @This();

    pub fn deinit(self: *Self) void {
        self.allocator.free(self.body);
    }

    pub fn isSuccess(self: Self) bool {
        return self.status >= 200 and self.status < 300;
    }

    pub fn isServerError(self: Self) bool {
        return self.status >= 500;
    }
};

/// Persistent HTTP client wrapper for connection pooling
pub const HttpClient = struct {
    inner: std.http.Client,
    allocator: Allocator,

    const Self = @This();

    pub fn init(allocator: Allocator) Self {
        return .{
            .inner = std.http.Client{ .allocator = allocator },
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Self) void {
        self.inner.deinit();
    }

    pub fn sendRequest(self: *Self, request: *const Request) !Response {
        const uri = request.getUri();

        var server_header_buffer: [16 * 1024]u8 = undefined;
        var req = try self.inner.open(
            switch (request.method) {
                .GET => .GET,
                .POST => .POST,
                .PUT => .PUT,
                .DELETE => .DELETE,
                .HEAD => .HEAD,
                .PATCH => .PATCH,
            },
            uri,
            .{
                .server_header_buffer = &server_header_buffer,
            },
        );
        defer req.deinit();

        // Add headers
        var iter = request.headers.iterator();
        while (iter.next()) |entry| {
            req.headers.append(entry.key_ptr.*, entry.value_ptr.*);
        }

        // Send request
        try req.send();

        // Send body if present
        if (request.body) |body| {
            try req.writer().writeAll(body);
        }

        try req.finish();

        // Wait for response
        try req.wait();

        // Read response body
        const body = try req.reader().readAllAlloc(self.allocator, 10 * 1024 * 1024);

        return Response{
            .status = @intFromEnum(req.status),
            .body = body,
            .allocator = self.allocator,
        };
    }
};

/// Send an HTTP request using std.http.Client (stateless convenience function)
pub fn sendRequest(
    allocator: Allocator,
    request: *const Request,
) !Response {
    var client = HttpClient.init(allocator);
    defer client.deinit();
    return client.sendRequest(request);
}

test "Request getUri" {
    var request = Request.init("sts.us-east-1.amazonaws.com");
    request.path = "/";
    request.query = "Action=GetCallerIdentity&Version=2011-06-15";

    const uri = request.getUri();
    try std.testing.expectEqualStrings("https", uri.scheme);
    try std.testing.expectEqualStrings("sts.us-east-1.amazonaws.com", uri.host.?.raw);
}
