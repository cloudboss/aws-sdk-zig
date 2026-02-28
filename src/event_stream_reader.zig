const std = @import("std");
const Allocator = std.mem.Allocator;
const testing = std.testing;

const event_stream = @import("event_stream.zig");
const http = @import("http.zig");

pub const Event = struct {
    event_type: []const u8,
    content_type: ?[]const u8,
    headers: []const event_stream.Header,
    payload: []const u8,
};

pub const EventStreamReader = struct {
    reader: *std.Io.Reader,
    allocator: Allocator,
    buf: []u8,
    prev_msg: ?event_stream.Message,
    stream_body: ?http.StreamingBody,

    const initial_buf_size = 4096;

    pub fn init(
        allocator: Allocator,
        body: http.StreamingBody,
    ) !EventStreamReader {
        const buf = try allocator.alloc(u8, initial_buf_size);
        var b = body;
        return .{
            .reader = b.reader(),
            .allocator = allocator,
            .buf = buf,
            .prev_msg = null,
            .stream_body = body,
        };
    }

    pub fn initReader(
        allocator: Allocator,
        reader: *std.Io.Reader,
    ) !EventStreamReader {
        const buf = try allocator.alloc(u8, initial_buf_size);
        return .{
            .reader = reader,
            .allocator = allocator,
            .buf = buf,
            .prev_msg = null,
            .stream_body = null,
        };
    }

    pub fn deinit(self: *EventStreamReader) void {
        if (self.prev_msg) |*msg| {
            event_stream.deinitMessage(self.allocator, msg);
        }
        self.allocator.free(self.buf);
        if (self.stream_body) |*body| {
            body.deinit();
        }
    }

    pub fn next(self: *EventStreamReader) !?Event {
        if (self.prev_msg) |*msg| {
            event_stream.deinitMessage(self.allocator, msg);
            self.prev_msg = null;
        }

        var prelude: [12]u8 = undefined;
        const first_read = try self.reader.readSliceShort(
            &prelude,
        );
        if (first_read == 0) return null;
        if (first_read < 12) {
            try self.reader.readSliceAll(
                prelude[first_read..],
            );
        }

        const total_length = std.mem.readInt(
            u32,
            prelude[0..4],
            .big,
        );
        const total_len: usize = @intCast(total_length);
        if (total_len < 16) return error.TruncatedData;

        if (self.buf.len < total_len) {
            self.allocator.free(self.buf);
            self.buf = try self.allocator.alloc(
                u8,
                total_len,
            );
        }

        @memcpy(self.buf[0..12], &prelude);

        if (total_len > 12) {
            try self.reader.readSliceAll(
                self.buf[12..total_len],
            );
        }

        const msg = try event_stream.decodeMessage(
            self.allocator,
            self.buf[0..total_len],
        );
        self.prev_msg = msg;

        const msg_type = findHeaderString(
            msg.headers,
            ":message-type",
        );

        if (msg_type) |mt| {
            if (std.mem.eql(u8, mt, "exception")) {
                return error.EventStreamException;
            }
            if (std.mem.eql(u8, mt, "error")) {
                return error.EventStreamError;
            }
        }

        return .{
            .event_type = findHeaderString(
                msg.headers,
                ":event-type",
            ) orelse "",
            .content_type = findHeaderString(
                msg.headers,
                ":content-type",
            ),
            .headers = msg.headers,
            .payload = msg.payload,
        };
    }

    fn findHeaderString(
        headers: []const event_stream.Header,
        name: []const u8,
    ) ?[]const u8 {
        for (headers) |header| {
            if (std.mem.eql(u8, header.name, name)) {
                switch (header.value) {
                    .string => |s| return s,
                    else => return null,
                }
            }
        }
        return null;
    }
};

test "single event round trip" {
    const headers = [_]event_stream.Header{
        .{
            .name = ":message-type",
            .value = .{ .string = "event" },
        },
        .{
            .name = ":event-type",
            .value = .{ .string = "Foo" },
        },
    };
    const encoded = try event_stream.encodeMessage(
        testing.allocator,
        .{ .headers = &headers, .payload = "hello" },
    );
    defer testing.allocator.free(encoded);

    var r = std.Io.Reader.fixed(encoded);
    var reader = try EventStreamReader.initReader(
        testing.allocator,
        &r,
    );
    defer reader.deinit();

    const event = (try reader.next()) orelse
        return error.TestUnexpectedResult;
    try testing.expectEqualStrings("Foo", event.event_type);
    try testing.expectEqualStrings("hello", event.payload);
    try testing.expectEqual(null, try reader.next());
}

test "multiple events" {
    const alloc = testing.allocator;
    const names = [_][]const u8{ "Alpha", "Beta", "Gamma" };
    var total_len: usize = 0;

    var frame_bufs: [3][]const u8 = undefined;
    for (names, 0..) |name, i| {
        const hdrs = [_]event_stream.Header{
            .{
                .name = ":message-type",
                .value = .{ .string = "event" },
            },
            .{
                .name = ":event-type",
                .value = .{ .string = name },
            },
        };
        frame_bufs[i] = try event_stream.encodeMessage(
            alloc,
            .{ .headers = &hdrs, .payload = "" },
        );
        total_len += frame_bufs[i].len;
    }
    defer for (&frame_bufs) |buf| alloc.free(buf);

    const combined = try alloc.alloc(u8, total_len);
    defer alloc.free(combined);
    var offset: usize = 0;
    for (&frame_bufs) |buf| {
        @memcpy(combined[offset .. offset + buf.len], buf);
        offset += buf.len;
    }

    var r = std.Io.Reader.fixed(combined);
    var reader = try EventStreamReader.initReader(
        alloc,
        &r,
    );
    defer reader.deinit();

    for (names) |name| {
        const event = (try reader.next()) orelse
            return error.TestUnexpectedResult;
        try testing.expectEqualStrings(
            name,
            event.event_type,
        );
    }
    try testing.expectEqual(null, try reader.next());
}

test "exception event returns error" {
    const headers = [_]event_stream.Header{
        .{
            .name = ":message-type",
            .value = .{ .string = "exception" },
        },
        .{
            .name = ":exception-type",
            .value = .{ .string = "BadRequest" },
        },
    };
    const encoded = try event_stream.encodeMessage(
        testing.allocator,
        .{ .headers = &headers, .payload = "oops" },
    );
    defer testing.allocator.free(encoded);

    var r = std.Io.Reader.fixed(encoded);
    var reader = try EventStreamReader.initReader(
        testing.allocator,
        &r,
    );
    defer reader.deinit();

    try testing.expectError(
        error.EventStreamException,
        reader.next(),
    );
}

test "end of stream returns null" {
    const empty: []const u8 = &.{};
    var r = std.Io.Reader.fixed(empty);
    var reader = try EventStreamReader.initReader(
        testing.allocator,
        &r,
    );
    defer reader.deinit();

    try testing.expectEqual(null, try reader.next());
}

test "partial reads decode full frame" {
    const headers = [_]event_stream.Header{
        .{
            .name = ":message-type",
            .value = .{ .string = "event" },
        },
        .{
            .name = ":event-type",
            .value = .{ .string = "Bar" },
        },
        .{
            .name = ":content-type",
            .value = .{ .string = "text/plain" },
        },
    };
    const encoded = try event_stream.encodeMessage(
        testing.allocator,
        .{ .headers = &headers, .payload = "data" },
    );
    defer testing.allocator.free(encoded);

    // Use Reader.fixed which reads entire buffer at once
    var r = std.Io.Reader.fixed(encoded);
    var reader = try EventStreamReader.initReader(
        testing.allocator,
        &r,
    );
    defer reader.deinit();

    const event = (try reader.next()) orelse
        return error.TestUnexpectedResult;
    try testing.expectEqualStrings("Bar", event.event_type);
    try testing.expectEqualStrings(
        "text/plain",
        event.content_type.?,
    );
    try testing.expectEqualStrings("data", event.payload);
    try testing.expectEqual(null, try reader.next());
}
