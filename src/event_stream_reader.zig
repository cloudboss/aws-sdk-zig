const std = @import("std");
const event_stream = @import("event_stream.zig");

const Allocator = std.mem.Allocator;

pub const Event = struct {
    event_type: []const u8,
    content_type: ?[]const u8,
    headers: []const event_stream.Header,
    payload: []const u8,
};

pub const EventStreamReader = struct {
    reader: std.io.AnyReader,
    allocator: Allocator,
    buf: []u8,
    prev_msg: ?event_stream.Message,

    const initial_buf_size = 4096;

    pub fn init(
        allocator: Allocator,
        reader: std.io.AnyReader,
    ) !EventStreamReader {
        const buf = try allocator.alloc(u8, initial_buf_size);
        return .{
            .reader = reader,
            .allocator = allocator,
            .buf = buf,
            .prev_msg = null,
        };
    }

    pub fn deinit(self: *EventStreamReader) void {
        if (self.prev_msg) |*msg| {
            event_stream.deinitMessage(self.allocator, msg);
        }
        self.allocator.free(self.buf);
    }

    pub fn next(self: *EventStreamReader) !?Event {
        if (self.prev_msg) |*msg| {
            event_stream.deinitMessage(self.allocator, msg);
            self.prev_msg = null;
        }

        var prelude: [12]u8 = undefined;
        const first_read = try self.reader.read(&prelude);
        if (first_read == 0) return null;
        if (first_read < 12) {
            try self.reader.readNoEof(prelude[first_read..]);
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
            try self.reader.readNoEof(
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

const testing = std.testing;

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

    var fbs = std.io.fixedBufferStream(encoded);
    var reader = try EventStreamReader.init(
        testing.allocator,
        fbs.reader().any(),
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

    var fbs = std.io.fixedBufferStream(combined);
    var reader = try EventStreamReader.init(
        alloc,
        fbs.reader().any(),
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

    var fbs = std.io.fixedBufferStream(encoded);
    var reader = try EventStreamReader.init(
        testing.allocator,
        fbs.reader().any(),
    );
    defer reader.deinit();

    try testing.expectError(
        error.EventStreamException,
        reader.next(),
    );
}

test "end of stream returns null" {
    const empty: []const u8 = &.{};
    var fbs = std.io.fixedBufferStream(empty);
    var reader = try EventStreamReader.init(
        testing.allocator,
        fbs.reader().any(),
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

    var throttled = ThrottledReader{
        .data = encoded,
        .pos = 0,
        .max_per_read = 3,
    };
    var reader = try EventStreamReader.init(
        testing.allocator,
        throttled.any(),
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

const ThrottledReader = struct {
    data: []const u8,
    pos: usize,
    max_per_read: usize,

    fn readFn(
        context: *const anyopaque,
        buffer: []u8,
    ) anyerror!usize {
        const ptr: *const ThrottledReader =
            @ptrCast(@alignCast(context));
        const self: *ThrottledReader = @constCast(ptr);
        const remaining = self.data[self.pos..];
        if (remaining.len == 0) return 0;
        const n = @min(
            @min(buffer.len, self.max_per_read),
            remaining.len,
        );
        @memcpy(buffer[0..n], remaining[0..n]);
        self.pos += n;
        return n;
    }

    fn any(self: *const ThrottledReader) std.io.AnyReader {
        return .{
            .context = @ptrCast(self),
            .readFn = &readFn,
        };
    }
};
