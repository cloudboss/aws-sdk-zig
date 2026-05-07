//! Process Credentials Provider
//!
//! Executes an external command and parses JSON credential output.
//! Activated via `credential_process` in ~/.aws/config profiles.

const std = @import("std");
const builtin = @import("builtin");
const Allocator = std.mem.Allocator;

const Credentials = @import("credentials.zig").Credentials;
const date = @import("date.zig");
const json_mod = @import("json.zig");

pub const ProcessProvider = struct {
    io: std.Io,
    command: []const u8,
    cached: ?Credentials = null,

    const Self = @This();

    pub fn getCredentials(self: *Self, allocator: Allocator) !Credentials {
        if (self.cached) |c| if (!c.isExpired(self.io)) return c;

        const output = try runCommand(allocator, self.io, self.command);
        defer allocator.free(output);

        const creds = try parseProcessOutput(allocator, output);
        self.freeCachedCredentials(allocator);
        self.cached = creds;
        return creds;
    }

    pub fn deinit(self: *Self, allocator: Allocator) void {
        self.freeCachedCredentials(allocator);
    }

    fn freeCachedCredentials(self: *Self, allocator: Allocator) void {
        if (self.cached) |cached| {
            allocator.free(cached.access_key_id);
            allocator.free(cached.secret_access_key);
            if (cached.session_token) |token| allocator.free(token);
        }
        self.cached = null;
    }
};

fn runCommand(allocator: Allocator, io: std.Io, command: []const u8) ![]const u8 {
    const argv: [3][]const u8 = if (builtin.os.tag == .windows)
        .{ "cmd.exe", "/C", command }
    else
        .{ "sh", "-c", command };

    const result = std.process.run(allocator, io, .{
        .argv = &argv,
        .stdout_limit = .limited(1024 * 1024),
        .stderr_limit = .limited(1024 * 1024),
    }) catch return error.ProcessCredentialsFailed;
    defer allocator.free(result.stderr);
    errdefer allocator.free(result.stdout);

    switch (result.term) {
        .exited => |code| if (code != 0) return error.ProcessCredentialsFailed,
        else => return error.ProcessCredentialsFailed,
    }
    return result.stdout;
}

fn parseProcessOutput(allocator: Allocator, output: []const u8) !Credentials {
    const version = json_mod.findJsonNumberValue(output, "Version") orelse
        return error.ProcessCredentialsBadOutput;
    if (version != 1) return error.ProcessCredentialsBadOutput;

    const access_key_raw = json_mod.findJsonStringValue(output, "AccessKeyId") orelse
        return error.ProcessCredentialsBadOutput;
    const access_key = try allocator.dupe(u8, access_key_raw);
    errdefer allocator.free(access_key);

    const secret_key_raw = json_mod.findJsonStringValue(output, "SecretAccessKey") orelse
        return error.ProcessCredentialsBadOutput;
    const secret_key = try allocator.dupe(u8, secret_key_raw);
    errdefer allocator.free(secret_key);

    const session_token: ?[]const u8 = if (json_mod.findJsonStringValue(output, "SessionToken")) |t|
        try allocator.dupe(u8, t)
    else
        null;
    errdefer if (session_token) |t| allocator.free(t);

    const expiration: ?i64 = if (json_mod.findJsonStringValue(output, "Expiration")) |exp_str|
        date.parseIso8601(exp_str) catch null
    else
        null;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .session_token = session_token,
        .expiration = expiration,
    };
}

// Tests

test "ProcessProvider deinit frees cached credentials" {
    const allocator = std.testing.allocator;
    var provider = ProcessProvider{
        .io = std.testing.io,
        .command = "ignored",
    };
    provider.cached = .{
        .access_key_id = try allocator.dupe(u8, "AKIA1"),
        .secret_access_key = try allocator.dupe(u8, "secret1"),
        .session_token = try allocator.dupe(u8, "token1"),
    };
    provider.deinit(allocator);
}

test "parseProcessOutput valid JSON with all fields" {
    const allocator = std.testing.allocator;
    const output =
        \\{
        \\  "Version": 1,
        \\  "AccessKeyId": "AKIAIOSFODNN7EXAMPLE",
        \\  "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        \\  "SessionToken": "tokenXXX",
        \\  "Expiration": "2024-01-15T12:00:00Z"
        \\}
    ;

    const creds = try parseProcessOutput(allocator, output);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY", creds.secret_access_key);
    try std.testing.expectEqualStrings("tokenXXX", creds.session_token.?);
    try std.testing.expect(creds.expiration.? > 1705300000);
}

test "parseProcessOutput without optional fields" {
    const allocator = std.testing.allocator;
    const output =
        \\{
        \\  "Version": 1,
        \\  "AccessKeyId": "AKIAIOSFODNN7EXAMPLE",
        \\  "SecretAccessKey": "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
        \\}
    ;

    const creds = try parseProcessOutput(allocator, output);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
    }

    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expect(creds.session_token == null);
    try std.testing.expect(creds.expiration == null);
}

test "parseProcessOutput wrong version" {
    const output =
        \\{
        \\  "Version": 2,
        \\  "AccessKeyId": "AKIA...",
        \\  "SecretAccessKey": "secret"
        \\}
    ;

    try std.testing.expectError(error.ProcessCredentialsBadOutput, parseProcessOutput(std.testing.allocator, output));
}

test "parseProcessOutput missing AccessKeyId" {
    const output =
        \\{
        \\  "Version": 1,
        \\  "SecretAccessKey": "secret"
        \\}
    ;

    try std.testing.expectError(error.ProcessCredentialsBadOutput, parseProcessOutput(std.testing.allocator, output));
}

test "runCommand invokes shell and returns stdout" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;

    const allocator = std.testing.allocator;
    const output = try runCommand(
        allocator,
        std.testing.io,
        "echo '{\"Version\":1,\"AccessKeyId\":\"AKID\",\"SecretAccessKey\":\"SECRET\"}'",
    );
    defer allocator.free(output);

    const creds = try parseProcessOutput(allocator, output);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
    }

    try std.testing.expectEqualStrings("AKID", creds.access_key_id);
    try std.testing.expectEqualStrings("SECRET", creds.secret_access_key);
}

test "runCommand non-zero exit returns error" {
    if (builtin.os.tag == .windows) return error.SkipZigTest;

    try std.testing.expectError(
        error.ProcessCredentialsFailed,
        runCommand(std.testing.allocator, std.testing.io, "exit 1"),
    );
}
