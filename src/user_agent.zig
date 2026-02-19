const std = @import("std");
const builtin = @import("builtin");

const Allocator = std.mem.Allocator;

pub const sdk_version = "0.1.0";

/// Builds a User-Agent string for AWS SDK requests.
/// Format: aws-sdk-zig/VERSION ua/2.1 os/OS lang/zig#VERSION api/SERVICE#APIVERSION
/// Caller must free the returned string.
pub fn buildUserAgent(
    allocator: Allocator,
    service: []const u8,
    api_version: []const u8,
) ![]const u8 {
    const os_name = @tagName(builtin.os.tag);
    const zig_version = builtin.zig_version_string;

    return try std.fmt.allocPrint(
        allocator,
        "aws-sdk-zig/{s} ua/2.1 os/{s} lang/zig#{s} api/{s}#{s}",
        .{ sdk_version, os_name, zig_version, service, api_version },
    );
}

test "buildUserAgent starts with aws-sdk-zig/" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ua = try buildUserAgent(allocator, "sts", "2011-06-15");
    defer allocator.free(ua);

    try std.testing.expect(std.mem.startsWith(u8, ua, "aws-sdk-zig/"));
}

test "buildUserAgent contains ua/2.1" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ua = try buildUserAgent(allocator, "sts", "2011-06-15");
    defer allocator.free(ua);

    try std.testing.expect(std.mem.containsAtLeast(u8, ua, 1, "ua/2.1"));
}

test "buildUserAgent contains lang/zig#" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ua = try buildUserAgent(allocator, "sts", "2011-06-15");
    defer allocator.free(ua);

    try std.testing.expect(std.mem.containsAtLeast(u8, ua, 1, "lang/zig#"));
}

test "buildUserAgent contains api/sts#2011-06-15" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ua = try buildUserAgent(allocator, "sts", "2011-06-15");
    defer allocator.free(ua);

    try std.testing.expect(
        std.mem.containsAtLeast(u8, ua, 1, "api/sts#2011-06-15"),
    );
}

test "buildUserAgent contains os/" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const ua = try buildUserAgent(allocator, "sts", "2011-06-15");
    defer allocator.free(ua);

    try std.testing.expect(std.mem.containsAtLeast(u8, ua, 1, "os/"));
}
