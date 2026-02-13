//! Comptime-reflective JSON parser and serializer for AWS SDK types.
//!
//! Uses `json_field_names` declarations on structs to map between
//! snake_case Zig field names and PascalCase AWS JSON keys.

const std = @import("std");
const Allocator = std.mem.Allocator;

const Scanner = std.json.Scanner;
const Token = Scanner.Token;

/// Parse a JSON object from a byte slice into a Zig struct.
/// Uses `T.json_field_names` for field name mapping if declared.
/// Strings and nested structures are allocated with the provided allocator.
pub fn parseJsonObject(comptime T: type, source: []const u8, alloc: Allocator) !T {
    var scanner = Scanner.initCompleteInput(alloc, source);
    defer scanner.deinit();
    return parseValue(T, &scanner, alloc);
}

/// Serialize a Zig struct to a JSON byte slice.
/// Uses `T.json_field_names` for field name mapping if declared.
/// Caller owns the returned slice.
pub fn jsonStringify(value: anytype, alloc: Allocator) ![]const u8 {
    var buf: std.ArrayList(u8) = .{};
    errdefer buf.deinit(alloc);
    try writeValue(@TypeOf(value), value, alloc, &buf);
    return buf.toOwnedSlice(alloc);
}

// ---------------------------------------------------------------------------
// Deserialization
// ---------------------------------------------------------------------------

fn parseValue(comptime T: type, scanner: *Scanner, alloc: Allocator) !T {
    const info = @typeInfo(T);
    switch (info) {
        .optional => |opt| return parseOptional(opt.child, scanner, alloc),
        .@"struct" => return parseStruct(T, scanner, alloc),
        .@"union" => return parseUnion(T, scanner, alloc),
        .@"enum" => return parseEnum(T, scanner, alloc),
        .pointer => |ptr| switch (ptr.size) {
            .slice => {
                if (ptr.child == u8) {
                    return parseDupedString(scanner, alloc);
                } else {
                    return parseArray(ptr.child, scanner, alloc);
                }
            },
            else => @compileError("unsupported pointer type: " ++ @typeName(T)),
        },
        .int => return parseInt(T, scanner),
        .float => return parseFloat(T, scanner),
        .bool => return parseBool(scanner),
        else => @compileError("unsupported type: " ++ @typeName(T)),
    }
}

fn parseOptional(comptime Child: type, scanner: *Scanner, alloc: Allocator) !?Child {
    const peeked = try scanner.peekNextTokenType();
    if (peeked == .null) {
        _ = try scanner.nextAlloc(alloc, .alloc_if_needed);
        return null;
    }
    return try parseValue(Child, scanner, alloc);
}

fn parseStruct(comptime T: type, scanner: *Scanner, alloc: Allocator) !T {
    var result: T = undefined;

    // Initialize fields to defaults
    inline for (std.meta.fields(T)) |field| {
        if (comptime std.mem.eql(u8, field.name, "_arena")) {
            // Skip -- arena is set by caller after parsing
        } else if (comptime field.defaultValue()) |dv| {
            @field(result, field.name) = dv;
        }
    }

    // Expect opening brace
    const open = try scanner.nextAlloc(alloc, .alloc_if_needed);
    switch (open) {
        .object_begin => {},
        else => return error.SyntaxError,
    }

    // Read key-value pairs
    while (true) {
        const key_token = try scanner.nextAlloc(alloc, .alloc_if_needed);
        const json_key = switch (key_token) {
            .object_end => break,
            .string => |s| s,
            .allocated_string => |s| s,
            else => return error.SyntaxError,
        };

        var matched = false;
        inline for (std.meta.fields(T)) |field| {
            if (comptime std.mem.eql(u8, field.name, "_arena")) continue;
            const mapped = comptime jsonKeyForField(T, field.name);
            if (std.mem.eql(u8, json_key, mapped)) {
                @field(result, field.name) = try parseValue(field.type, scanner, alloc);
                matched = true;
            }
        }
        if (!matched) try scanner.skipValue();

        // Free allocated key if needed
        switch (key_token) {
            .allocated_string => |s| alloc.free(s),
            else => {},
        }
    }
    return result;
}

fn parseUnion(comptime T: type, scanner: *Scanner, alloc: Allocator) !T {
    // AWS tagged union: single-key object {"VariantName": value}
    const open = try scanner.nextAlloc(alloc, .alloc_if_needed);
    switch (open) {
        .object_begin => {},
        else => return error.SyntaxError,
    }

    const key_token = try scanner.nextAlloc(alloc, .alloc_if_needed);
    const variant_key = switch (key_token) {
        .string => |s| s,
        .allocated_string => |s| s,
        else => return error.SyntaxError,
    };
    defer switch (key_token) {
        .allocated_string => |s| alloc.free(s),
        else => {},
    };

    const fields = std.meta.fields(T);
    inline for (fields) |field| {
        const mapped = comptime jsonKeyForField(T, field.name);
        if (std.mem.eql(u8, variant_key, mapped)) {
            const val = try parseValue(field.type, scanner, alloc);
            // Consume closing brace
            const close = try scanner.nextAlloc(alloc, .alloc_if_needed);
            switch (close) {
                .object_end => {},
                else => return error.SyntaxError,
            }
            return @unionInit(T, field.name, val);
        }
    }

    // Unknown variant -- skip value and closing brace
    try scanner.skipValue();
    const close = try scanner.nextAlloc(alloc, .alloc_if_needed);
    switch (close) {
        .object_end => {},
        else => return error.SyntaxError,
    }
    // If the union has an "unknown" field, use it
    if (@hasField(T, "unknown")) {
        return @unionInit(T, "unknown", {});
    }
    return error.SyntaxError;
}

fn parseEnum(comptime T: type, scanner: *Scanner, alloc: Allocator) !T {
    const token = try scanner.nextAlloc(alloc, .alloc_if_needed);
    const str = switch (token) {
        .string => |s| s,
        .allocated_string => |s| s,
        else => return error.SyntaxError,
    };
    defer switch (token) {
        .allocated_string => |s| alloc.free(s),
        else => {},
    };
    return std.meta.stringToEnum(T, str) orelse {
        // Check json_field_names mapping for enum values
        if (@hasDecl(T, "json_field_names")) {
            const names = T.json_field_names;
            inline for (std.meta.fields(@TypeOf(names))) |field| {
                if (std.mem.eql(u8, str, @field(names, field.name))) {
                    return @field(T, field.name);
                }
            }
        }
        // Return a sentinel/unknown variant if available
        if (@hasField(T, "unknown")) {
            return .unknown;
        }
        return error.SyntaxError;
    };
}

fn parseDupedString(scanner: *Scanner, alloc: Allocator) ![]const u8 {
    const token = try scanner.nextAlloc(alloc, .alloc_if_needed);
    switch (token) {
        .string => |s| return try alloc.dupe(u8, s),
        .allocated_string => |s| return s, // already heap-owned
        .null => return error.SyntaxError,
        else => return error.SyntaxError,
    }
}

fn parseArray(comptime Child: type, scanner: *Scanner, alloc: Allocator) ![]const Child {
    const open = try scanner.nextAlloc(alloc, .alloc_if_needed);
    switch (open) {
        .array_begin => {},
        else => return error.SyntaxError,
    }

    var list: std.ArrayList(Child) = .{};
    errdefer list.deinit(alloc);

    while (true) {
        const peeked = try scanner.peekNextTokenType();
        if (peeked == .array_end) {
            _ = try scanner.nextAlloc(alloc, .alloc_if_needed);
            break;
        }
        try list.append(alloc, try parseValue(Child, scanner, alloc));
    }
    return list.toOwnedSlice(alloc);
}

fn parseInt(comptime T: type, scanner: *Scanner) !T {
    const alloc_unused = std.heap.page_allocator; // numbers don't allocate
    const token = try scanner.nextAlloc(alloc_unused, .alloc_if_needed);
    const str = switch (token) {
        .number => |s| s,
        .allocated_number => |s| s,
        else => return error.SyntaxError,
    };
    // Try direct integer parse first; fall back to float->int for values like "1.7076E9"
    return std.fmt.parseInt(T, str, 10) catch {
        const f = std.fmt.parseFloat(f64, str) catch return error.SyntaxError;
        return std.math.lossyCast(T, f);
    };
}

fn parseFloat(comptime T: type, scanner: *Scanner) !T {
    const alloc_unused = std.heap.page_allocator;
    const token = try scanner.nextAlloc(alloc_unused, .alloc_if_needed);
    const str = switch (token) {
        .number => |s| s,
        .allocated_number => |s| s,
        else => return error.SyntaxError,
    };
    return std.fmt.parseFloat(T, str) catch return error.SyntaxError;
}

fn parseBool(scanner: *Scanner) !bool {
    const alloc_unused = std.heap.page_allocator;
    const token = try scanner.nextAlloc(alloc_unused, .alloc_if_needed);
    return switch (token) {
        .true => true,
        .false => false,
        else => error.SyntaxError,
    };
}

// ---------------------------------------------------------------------------
// Simple JSON value finder (for error response parsing)
// ---------------------------------------------------------------------------

/// Simple JSON value finder that searches for "key": value patterns.
/// Returns the value as a string slice (without quotes for string values).
/// Used for error response parsing where a full JSON parse is not needed.
pub fn findJsonValue(json: []const u8, key: []const u8) ?[]const u8 {
    // Build search pattern: "key"
    var buf: [258]u8 = undefined;
    if (key.len + 2 > buf.len) return null;
    buf[0] = 0x22; // double-quote
    @memcpy(buf[1..][0..key.len], key);
    buf[key.len + 1] = 0x22; // double-quote
    const search = buf[0 .. key.len + 2];
    const key_start = std.mem.indexOf(u8, json, search) orelse return null;
    var pos = key_start + search.len;

    // Skip whitespace and colon
    while (pos < json.len) : (pos += 1) {
        if (json[pos] != ' ' and json[pos] != ':') break;
    }
    if (pos >= json.len) return null;

    if (json[pos] == 0x22) {
        const start = pos + 1;
        const end = std.mem.indexOfScalarPos(u8, json, start, 0x22) orelse return null;
        return json[start..end];
    }

    const start = pos;
    while (pos < json.len) : (pos += 1) {
        if (json[pos] == ',' or json[pos] == '}' or json[pos] == ' ') break;
    }
    return json[start..pos];
}

// ---------------------------------------------------------------------------
// Field name mapping
// ---------------------------------------------------------------------------

/// Look up the JSON key for a Zig field name.
/// Uses `T.json_field_names` if declared, otherwise uses the field name as-is.
fn jsonKeyForField(comptime T: type, comptime field_name: []const u8) []const u8 {
    if (@hasDecl(T, "json_field_names")) {
        const names = T.json_field_names;
        if (@hasField(@TypeOf(names), field_name)) {
            return @field(names, field_name);
        }
    }
    return field_name;
}

// ---------------------------------------------------------------------------
// Serialization
// ---------------------------------------------------------------------------

pub fn writeValue(comptime T: type, value: T, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    const info = @typeInfo(T);
    switch (info) {
        .optional => {
            if (value) |v| {
                try writeValue(@TypeOf(v), v, alloc, buf);
            } else {
                try buf.appendSlice(alloc, "null");
            }
        },
        .@"struct" => try writeStruct(T, value, alloc, buf),
        .@"union" => try writeUnion(T, value, alloc, buf),
        .@"enum" => try writeEnum(T, value, alloc, buf),
        .pointer => |ptr| switch (ptr.size) {
            .slice => {
                if (ptr.child == u8) {
                    try writeString(value, alloc, buf);
                } else {
                    try writeArray(ptr.child, value, alloc, buf);
                }
            },
            else => @compileError("unsupported pointer type: " ++ @typeName(T)),
        },
        .int => {
            const str = try std.fmt.allocPrint(alloc, "{d}", .{value});
            defer alloc.free(str);
            try buf.appendSlice(alloc, str);
        },
        .float => {
            const str = try std.fmt.allocPrint(alloc, "{d}", .{value});
            defer alloc.free(str);
            try buf.appendSlice(alloc, str);
        },
        .bool => {
            try buf.appendSlice(alloc, if (value) "true" else "false");
        },
        else => @compileError("unsupported type: " ++ @typeName(T)),
    }
}

fn writeStruct(comptime T: type, value: T, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    try buf.append(alloc, '{');
    var first = true;
    inline for (std.meta.fields(T)) |field| {
        if (comptime std.mem.eql(u8, field.name, "_arena")) continue;

        const field_val = @field(value, field.name);
        const key = comptime jsonKeyForField(T, field.name);

        if (comptime @typeInfo(field.type) == .optional) {
            // Runtime null check -- write only if non-null
            if (field_val) |_| {
                if (!first) try buf.append(alloc, ',');
                first = false;
                try buf.append(alloc, '"');
                try buf.appendSlice(alloc, key);
                try buf.appendSlice(alloc, "\":");
                try writeValue(field.type, field_val, alloc, buf);
            }
        } else {
            if (!first) try buf.append(alloc, ',');
            first = false;
            try buf.append(alloc, '"');
            try buf.appendSlice(alloc, key);
            try buf.appendSlice(alloc, "\":");
            try writeValue(field.type, field_val, alloc, buf);
        }
    }
    try buf.append(alloc, '}');
}

fn writeUnion(comptime T: type, value: T, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    // AWS tagged union: {"VariantName": value}
    const tag_name = @tagName(value);

    try buf.append(alloc, '{');
    try buf.append(alloc, '"');

    // Map tag name through json_field_names
    const mapped = comptime blk: {
        const fields = std.meta.fields(T);
        for (fields) |field| {
            if (@hasDecl(T, "json_field_names")) {
                const names = T.json_field_names;
                if (@hasField(@TypeOf(names), field.name)) {
                    // Can't easily index by runtime tag_name at comptime,
                    // so we handle this inline below
                    break :blk {};
                }
            }
        }
        break :blk {};
    };
    _ = mapped;

    // Write the key -- use json_field_names mapping
    inline for (std.meta.fields(T)) |field| {
        if (std.mem.eql(u8, tag_name, field.name)) {
            const key = comptime jsonKeyForField(T, field.name);
            try buf.appendSlice(alloc, key);
            try buf.appendSlice(alloc, "\":");
            try writeValue(field.type, @field(value, field.name), alloc, buf);
        }
    }

    try buf.append(alloc, '}');
}

fn writeEnum(comptime T: type, value: T, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    const tag_name = @tagName(value);

    // Check json_field_names for mapped name
    if (@hasDecl(T, "json_field_names")) {
        const names = T.json_field_names;
        inline for (std.meta.fields(@TypeOf(names))) |field| {
            if (std.mem.eql(u8, tag_name, field.name)) {
                try buf.append(alloc, '"');
                try buf.appendSlice(alloc, @field(names, field.name));
                try buf.append(alloc, '"');
                return;
            }
        }
    }

    try buf.append(alloc, '"');
    try buf.appendSlice(alloc, tag_name);
    try buf.append(alloc, '"');
}

fn writeString(value: []const u8, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    try buf.append(alloc, '"');
    for (value) |c| {
        switch (c) {
            '"' => {
                try buf.append(alloc, '\\');
                try buf.append(alloc, '"');
            },
            '\\' => {
                try buf.append(alloc, '\\');
                try buf.append(alloc, '\\');
            },
            '\n' => {
                try buf.append(alloc, '\\');
                try buf.append(alloc, 'n');
            },
            '\r' => {
                try buf.append(alloc, '\\');
                try buf.append(alloc, 'r');
            },
            '\t' => {
                try buf.append(alloc, '\\');
                try buf.append(alloc, 't');
            },
            else => {
                if (c < 0x20) {
                    const hex = "0123456789abcdef";
                    try buf.append(alloc, '\\');
                    try buf.append(alloc, 'u');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, '0');
                    try buf.append(alloc, hex[c >> 4]);
                    try buf.append(alloc, hex[c & 0x0F]);
                } else {
                    try buf.append(alloc, c);
                }
            },
        }
    }
    try buf.append(alloc, '"');
}

fn writeArray(comptime Child: type, items: []const Child, alloc: Allocator, buf: *std.ArrayList(u8)) !void {
    try buf.append(alloc, '[');
    for (items, 0..) |item, i| {
        if (i > 0) try buf.append(alloc, ',');
        try writeValue(Child, item, alloc, buf);
    }
    try buf.append(alloc, ']');
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

test "parse simple struct" {
    const TestStruct = struct {
        name: ?[]const u8 = null,
        count: ?i32 = null,
        active: ?bool = null,

        pub const json_field_names = .{
            .name = "Name",
            .count = "Count",
            .active = "Active",
        };
    };

    const json = "{\"Name\":\"hello\",\"Count\":42,\"Active\":true}";
    const result = try parseJsonObject(TestStruct, json, std.testing.allocator);
    defer {
        if (result.name) |v| std.testing.allocator.free(v);
    }

    try std.testing.expectEqualStrings("hello", result.name.?);
    try std.testing.expectEqual(@as(i32, 42), result.count.?);
    try std.testing.expect(result.active.?);
}

test "parse null fields" {
    const TestStruct = struct {
        name: ?[]const u8 = null,
        value: ?i32 = null,

        pub const json_field_names = .{
            .name = "Name",
            .value = "Value",
        };
    };

    const json = "{\"Name\":null}";
    const result = try parseJsonObject(TestStruct, json, std.testing.allocator);
    try std.testing.expect(result.name == null);
    try std.testing.expect(result.value == null);
}

test "parse unknown fields are skipped" {
    const TestStruct = struct {
        name: ?[]const u8 = null,

        pub const json_field_names = .{
            .name = "Name",
        };
    };

    const json = "{\"Name\":\"test\",\"Unknown\":\"ignored\",\"Also\":[1,2,3]}";
    const result = try parseJsonObject(TestStruct, json, std.testing.allocator);
    defer {
        if (result.name) |v| std.testing.allocator.free(v);
    }
    try std.testing.expectEqualStrings("test", result.name.?);
}

test "parse array of strings" {
    const TestStruct = struct {
        items: ?[]const []const u8 = null,

        pub const json_field_names = .{
            .items = "Items",
        };
    };

    const json = "{\"Items\":[\"a\",\"b\",\"c\"]}";
    const result = try parseJsonObject(TestStruct, json, std.testing.allocator);
    defer {
        if (result.items) |items| {
            for (items) |item| std.testing.allocator.free(item);
            std.testing.allocator.free(items);
        }
    }

    try std.testing.expectEqual(@as(usize, 3), result.items.?.len);
    try std.testing.expectEqualStrings("a", result.items.?[0]);
    try std.testing.expectEqualStrings("b", result.items.?[1]);
    try std.testing.expectEqualStrings("c", result.items.?[2]);
}

test "parse nested struct" {
    const Inner = struct {
        value: ?[]const u8 = null,

        pub const json_field_names = .{
            .value = "Value",
        };
    };

    const Outer = struct {
        inner: ?Inner = null,
        name: ?[]const u8 = null,

        pub const json_field_names = .{
            .inner = "Inner",
            .name = "Name",
        };
    };

    const json = "{\"Name\":\"test\",\"Inner\":{\"Value\":\"nested\"}}";
    const result = try parseJsonObject(Outer, json, std.testing.allocator);
    defer {
        if (result.name) |v| std.testing.allocator.free(v);
        if (result.inner) |inner| {
            if (inner.value) |v| std.testing.allocator.free(v);
        }
    }

    try std.testing.expectEqualStrings("test", result.name.?);
    try std.testing.expectEqualStrings("nested", result.inner.?.value.?);
}

test "parse array of structs" {
    const Item = struct {
        name: ?[]const u8 = null,
        count: ?i32 = null,

        pub const json_field_names = .{
            .name = "Name",
            .count = "Count",
        };
    };

    const Container = struct {
        items: ?[]const Item = null,

        pub const json_field_names = .{
            .items = "Items",
        };
    };

    const json = "{\"Items\":[{\"Name\":\"a\",\"Count\":1},{\"Name\":\"b\",\"Count\":2}]}";
    const result = try parseJsonObject(Container, json, std.testing.allocator);
    defer {
        if (result.items) |items| {
            for (items) |item| {
                if (item.name) |v| std.testing.allocator.free(v);
            }
            std.testing.allocator.free(items);
        }
    }

    try std.testing.expectEqual(@as(usize, 2), result.items.?.len);
    try std.testing.expectEqualStrings("a", result.items.?[0].name.?);
    try std.testing.expectEqual(@as(i32, 1), result.items.?[0].count.?);
    try std.testing.expectEqualStrings("b", result.items.?[1].name.?);
    try std.testing.expectEqual(@as(i32, 2), result.items.?[1].count.?);
}

test "parse enum" {
    const Status = enum {
        active,
        inactive,

        pub const json_field_names = .{
            .active = "ACTIVE",
            .inactive = "INACTIVE",
        };
    };

    const TestStruct = struct {
        status: ?Status = null,

        pub const json_field_names = .{
            .status = "Status",
        };
    };

    const json = "{\"Status\":\"ACTIVE\"}";
    const result = try parseJsonObject(TestStruct, json, std.testing.allocator);
    try std.testing.expectEqual(Status.active, result.status.?);
}

test "serialize simple struct" {
    const TestStruct = struct {
        name: ?[]const u8 = null,
        count: ?i32 = null,
        active: ?bool = null,

        pub const json_field_names = .{
            .name = "Name",
            .count = "Count",
            .active = "Active",
        };
    };

    const value = TestStruct{
        .name = "hello",
        .count = 42,
        .active = true,
    };

    const json = try jsonStringify(value, std.testing.allocator);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings("{\"Name\":\"hello\",\"Count\":42,\"Active\":true}", json);
}

test "serialize skips null optionals" {
    const TestStruct = struct {
        name: ?[]const u8 = null,
        count: ?i32 = null,

        pub const json_field_names = .{
            .name = "Name",
            .count = "Count",
        };
    };

    const value = TestStruct{ .name = "test" };
    const json = try jsonStringify(value, std.testing.allocator);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings("{\"Name\":\"test\"}", json);
}

test "serialize array of structs" {
    const Item = struct {
        name: []const u8,
        value: ?i32 = null,

        pub const json_field_names = .{
            .name = "Name",
            .value = "Value",
        };
    };

    const Container = struct {
        items: ?[]const Item = null,

        pub const json_field_names = .{
            .items = "Items",
        };
    };

    const items = [_]Item{
        .{ .name = "a", .value = 1 },
        .{ .name = "b", .value = 2 },
    };
    const value = Container{ .items = &items };
    const json = try jsonStringify(value, std.testing.allocator);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings("{\"Items\":[{\"Name\":\"a\",\"Value\":1},{\"Name\":\"b\",\"Value\":2}]}", json);
}

test "roundtrip parse and serialize" {
    const Inner = struct {
        tag: ?[]const u8 = null,

        pub const json_field_names = .{
            .tag = "Tag",
        };
    };

    const TestStruct = struct {
        name: ?[]const u8 = null,
        items: ?[]const Inner = null,
        count: ?i64 = null,

        pub const json_field_names = .{
            .name = "Name",
            .items = "Items",
            .count = "Count",
        };
    };

    const input = "{\"Name\":\"test\",\"Items\":[{\"Tag\":\"x\"},{\"Tag\":\"y\"}],\"Count\":99}";
    const parsed = try parseJsonObject(TestStruct, input, std.testing.allocator);
    defer {
        if (parsed.name) |v| std.testing.allocator.free(v);
        if (parsed.items) |items| {
            for (items) |item| {
                if (item.tag) |v| std.testing.allocator.free(v);
            }
            std.testing.allocator.free(items);
        }
    }

    const output = try jsonStringify(parsed, std.testing.allocator);
    defer std.testing.allocator.free(output);
    try std.testing.expectEqualStrings(input, output);
}

test "parse empty object" {
    const TestStruct = struct {
        name: ?[]const u8 = null,
    };

    const result = try parseJsonObject(TestStruct, "{}", std.testing.allocator);
    try std.testing.expect(result.name == null);
}

test "serialize string escaping" {
    const TestStruct = struct {
        msg: ?[]const u8 = null,

        pub const json_field_names = .{
            .msg = "Msg",
        };
    };

    const value = TestStruct{ .msg = "hello \"world\"\nnewline" };
    const json = try jsonStringify(value, std.testing.allocator);
    defer std.testing.allocator.free(json);
    try std.testing.expectEqualStrings("{\"Msg\":\"hello \\\"world\\\"\\nnewline\"}", json);
}

test "findJsonValue string value" {
    const json = "{\"__type\":\"ResourceNotFoundException\",\"message\":\"Table not found\"}";
    try std.testing.expectEqualStrings("ResourceNotFoundException", findJsonValue(json, "__type").?);
    try std.testing.expectEqualStrings("Table not found", findJsonValue(json, "message").?);
}

test "findJsonValue with namespace prefix" {
    const json = "{\"__type\":\"com.amazonaws.dynamodb.v20120810#ResourceNotFoundException\"}";
    const type_str = findJsonValue(json, "__type").?;
    try std.testing.expectEqualStrings("com.amazonaws.dynamodb.v20120810#ResourceNotFoundException", type_str);
}

test "findJsonValue number value" {
    const json = "{\"code\":404,\"message\":\"not found\"}";
    try std.testing.expectEqualStrings("404", findJsonValue(json, "code").?);
}

test "findJsonValue missing key" {
    const json = "{\"name\":\"test\"}";
    try std.testing.expect(findJsonValue(json, "missing") == null);
}

test "findJsonValue both message variants" {
    const json = "{\"Message\":\"uppercase\"}";
    try std.testing.expect(findJsonValue(json, "message") == null);
    try std.testing.expectEqualStrings("uppercase", findJsonValue(json, "Message").?);
}
