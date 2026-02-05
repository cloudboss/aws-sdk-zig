//! AWS Credentials
//!
//! Tagged union credential provider following our design decision.

const std = @import("std");
const Allocator = std.mem.Allocator;

/// AWS credentials for request signing
pub const Credentials = struct {
    access_key_id: []const u8,
    secret_access_key: []const u8,
    session_token: ?[]const u8 = null,
    /// Expiration time (epoch seconds), null if permanent
    expiration: ?i64 = null,

    /// Check if credentials are expired (with 5 minute buffer)
    pub fn isExpired(self: Credentials) bool {
        const exp = self.expiration orelse return false;
        return std.time.timestamp() >= (exp - 300);
    }
};

/// Credential provider - tagged union of supported providers
pub const CredentialsProvider = union(enum) {
    /// Static credentials provided directly
    static: Credentials,
    /// Load from environment variables
    environment: void,
    /// Load from shared credentials file (~/.aws/credentials)
    file: FileProvider,
    /// Automatic credential chain (environment -> file -> imds -> ecs)
    chain: ChainProvider,

    /// Retrieve credentials from this provider
    pub fn getCredentials(self: *CredentialsProvider, allocator: Allocator) !Credentials {
        return switch (self.*) {
            .static => |creds| creds,
            .environment => getFromEnvironment(),
            .file => |*f| f.load(allocator),
            .chain => |*c| c.getCredentials(allocator),
        };
    }
};

/// Load credentials from environment variables
pub fn getFromEnvironment() !Credentials {
    const access_key = std.posix.getenv("AWS_ACCESS_KEY_ID") orelse
        return error.CredentialsNotFound;
    const secret_key = std.posix.getenv("AWS_SECRET_ACCESS_KEY") orelse
        return error.CredentialsNotFound;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .session_token = std.posix.getenv("AWS_SESSION_TOKEN"),
    };
}

/// File-based credential provider (~/.aws/credentials)
pub const FileProvider = struct {
    profile: ?[]const u8 = null,
    path: ?[]const u8 = null,

    const Self = @This();

    /// Load credentials from file
    pub fn load(self: *Self, allocator: Allocator) !Credentials {
        const path = try self.resolvePath(allocator);
        defer allocator.free(path);

        const file = std.fs.openFileAbsolute(path, .{}) catch |err| {
            if (err == error.FileNotFound) return error.CredentialsNotFound;
            return error.CredentialsNotFound;
        };
        defer file.close();

        const content = file.readToEndAlloc(allocator, 1024 * 1024) catch {
            return error.CredentialsNotFound;
        };
        defer allocator.free(content);

        const profile = self.resolveProfile();
        return parseCredentialsFile(content, profile);
    }

    /// Resolve credentials file path
    fn resolvePath(self: *Self, allocator: Allocator) ![]const u8 {
        // 1. Explicit path
        if (self.path) |p| {
            return try allocator.dupe(u8, p);
        }

        // 2. AWS_SHARED_CREDENTIALS_FILE environment variable
        if (std.posix.getenv("AWS_SHARED_CREDENTIALS_FILE")) |p| {
            return try allocator.dupe(u8, p);
        }

        // 3. Default: ~/.aws/credentials
        const home = std.posix.getenv("HOME") orelse return error.CredentialsNotFound;
        return std.fmt.allocPrint(allocator, "{s}/.aws/credentials", .{home});
    }

    /// Resolve profile name
    fn resolveProfile(self: *Self) []const u8 {
        // 1. Explicit profile
        if (self.profile) |p| {
            return p;
        }

        // 2. AWS_PROFILE environment variable
        if (std.posix.getenv("AWS_PROFILE")) |p| {
            return p;
        }

        // 3. Default
        return "default";
    }
};

/// Automatic credential chain provider
/// Tries providers in order: environment -> file -> imds -> ecs
pub const ChainProvider = struct {
    /// Cached credentials from last successful retrieval
    cached: ?Credentials = null,
    /// Which provider succeeded last time (for efficiency on refresh)
    successful_provider: ?ProviderType = null,
    /// Profile for file provider
    profile: ?[]const u8 = null,

    const Self = @This();

    const ProviderType = enum {
        environment,
        file,
        // Future: imds, ecs
    };

    /// Get credentials, using cache if valid
    pub fn getCredentials(self: *Self, allocator: Allocator) !Credentials {
        // Return cached credentials if still valid
        if (self.cached) |creds| {
            if (!creds.isExpired()) {
                return creds;
            }
        }

        // If we previously succeeded with a provider, try it first
        if (self.successful_provider) |provider| {
            if (self.tryProvider(allocator, provider)) |creds| {
                self.cached = creds;
                return creds;
            } else |_| {
                // Provider failed, clear it and try the full chain
                self.successful_provider = null;
            }
        }

        // Try each provider in order
        const providers = [_]ProviderType{ .environment, .file };
        for (providers) |provider| {
            if (self.tryProvider(allocator, provider)) |creds| {
                self.cached = creds;
                self.successful_provider = provider;
                return creds;
            } else |_| {
                // Continue to next provider
            }
        }

        return error.CredentialsNotFound;
    }

    /// Try a specific provider
    fn tryProvider(self: *Self, allocator: Allocator, provider: ProviderType) !Credentials {
        return switch (provider) {
            .environment => getFromEnvironment(),
            .file => blk: {
                var fp = FileProvider{ .profile = self.profile };
                break :blk fp.load(allocator);
            },
        };
    }

    /// Clear cached credentials (forces refresh on next call)
    pub fn clearCache(self: *Self) void {
        self.cached = null;
    }
};

/// Parse AWS credentials file content and extract credentials for profile
fn parseCredentialsFile(content: []const u8, profile: []const u8) !Credentials {
    // Build target section: [profile_name]
    var target_section_buf: [258]u8 = undefined;
    const target_section = std.fmt.bufPrint(&target_section_buf, "[{s}]", .{profile}) catch {
        return error.CredentialsNotFound;
    };

    var in_target_section = false;
    var access_key: ?[]const u8 = null;
    var secret_key: ?[]const u8 = null;
    var session_token: ?[]const u8 = null;

    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r");

        // Skip empty lines and comments
        if (trimmed.len == 0 or trimmed[0] == '#' or trimmed[0] == ';') {
            continue;
        }

        // Check for section header
        if (trimmed[0] == '[') {
            // If we were in target section and found a new section, we're done
            if (in_target_section) {
                break;
            }
            in_target_section = std.mem.eql(u8, trimmed, target_section);
            continue;
        }

        // Parse key=value in target section
        if (in_target_section) {
            if (std.mem.indexOfScalar(u8, trimmed, '=')) |eq_idx| {
                const key = std.mem.trim(u8, trimmed[0..eq_idx], " \t");
                const value = std.mem.trim(u8, trimmed[eq_idx + 1 ..], " \t");

                if (std.mem.eql(u8, key, "aws_access_key_id")) {
                    access_key = value;
                } else if (std.mem.eql(u8, key, "aws_secret_access_key")) {
                    secret_key = value;
                } else if (std.mem.eql(u8, key, "aws_session_token")) {
                    session_token = value;
                }
            }
        }
    }

    // Validate we found required credentials
    const ak = access_key orelse return error.CredentialsNotFound;
    const sk = secret_key orelse return error.CredentialsNotFound;

    return Credentials{
        .access_key_id = ak,
        .secret_access_key = sk,
        .session_token = session_token,
    };
}

// Tests

test "static credentials" {
    var provider = CredentialsProvider{
        .static = .{
            .access_key_id = "AKIAIOSFODNN7EXAMPLE",
            .secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        },
    };

    const creds = try provider.getCredentials(std.testing.allocator);
    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
}

test "credentials expiration" {
    const expired = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .expiration = 0,
    };
    try std.testing.expect(expired.isExpired());

    const valid = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .expiration = std.time.timestamp() + 3600,
    };
    try std.testing.expect(!valid.isExpired());

    const permanent = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try std.testing.expect(!permanent.isExpired());
}

test "parseCredentialsFile default profile" {
    const content =
        \\[default]
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
        \\aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
        \\
        \\[dev]
        \\aws_access_key_id = AKIAI44QH8DHBEXAMPLE
        \\aws_secret_access_key = je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
    ;

    const creds = try parseCredentialsFile(content, "default");
    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY", creds.secret_access_key);
    try std.testing.expect(creds.session_token == null);
}

test "parseCredentialsFile named profile" {
    const content =
        \\[default]
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
        \\aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
        \\
        \\[dev]
        \\aws_access_key_id = AKIAI44QH8DHBEXAMPLE
        \\aws_secret_access_key = je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
    ;

    const creds = try parseCredentialsFile(content, "dev");
    try std.testing.expectEqualStrings("AKIAI44QH8DHBEXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY", creds.secret_access_key);
}

test "parseCredentialsFile with session token" {
    const content =
        \\[default]
        \\aws_access_key_id = ASIAXXX
        \\aws_secret_access_key = secretXXX
        \\aws_session_token = tokenXXX
    ;

    const creds = try parseCredentialsFile(content, "default");
    try std.testing.expectEqualStrings("ASIAXXX", creds.access_key_id);
    try std.testing.expectEqualStrings("secretXXX", creds.secret_access_key);
    try std.testing.expectEqualStrings("tokenXXX", creds.session_token.?);
}

test "parseCredentialsFile missing profile" {
    const content =
        \\[default]
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
        \\aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
    ;

    const result = parseCredentialsFile(content, "nonexistent");
    try std.testing.expectError(error.CredentialsNotFound, result);
}

test "parseCredentialsFile missing secret key" {
    const content =
        \\[default]
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
    ;

    const result = parseCredentialsFile(content, "default");
    try std.testing.expectError(error.CredentialsNotFound, result);
}

test "parseCredentialsFile with comments and whitespace" {
    const content =
        \\# This is a comment
        \\[default]
        \\; Another comment
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
        \\aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
        \\
    ;

    const creds = try parseCredentialsFile(content, "default");
    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY", creds.secret_access_key);
}

test "chain provider caches credentials" {
    var chain = ChainProvider{};

    // Manually set cached credentials
    chain.cached = Credentials{
        .access_key_id = "CACHED_KEY",
        .secret_access_key = "CACHED_SECRET",
        .expiration = std.time.timestamp() + 3600, // Valid for 1 hour
    };

    const creds = try chain.getCredentials(std.testing.allocator);
    try std.testing.expectEqualStrings("CACHED_KEY", creds.access_key_id);
}

test "chain provider refreshes expired credentials" {
    var chain = ChainProvider{};

    // Set expired cached credentials
    chain.cached = Credentials{
        .access_key_id = "EXPIRED_KEY",
        .secret_access_key = "EXPIRED_SECRET",
        .expiration = 0, // Already expired
    };

    // This should try to refresh - will fail without env vars or file
    const result = chain.getCredentials(std.testing.allocator);
    try std.testing.expectError(error.CredentialsNotFound, result);
}

test "chain provider clear cache" {
    var chain = ChainProvider{};

    chain.cached = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };

    try std.testing.expect(chain.cached != null);
    chain.clearCache();
    try std.testing.expect(chain.cached == null);
}
