//! AWS SDK Configuration
//!
//! Central configuration struct for AWS service clients.

const std = @import("std");
const Allocator = std.mem.Allocator;

const credentials_mod = @import("credentials.zig");
const CredentialsProvider = credentials_mod.CredentialsProvider;
const ChainProvider = credentials_mod.ChainProvider;

/// Options for Config.load()
pub const LoadOptions = struct {
    /// Explicit region override
    region: ?[]const u8 = null,
    /// Explicit credentials override
    credentials: ?CredentialsProvider = null,
    /// Profile name for file-based config
    profile: []const u8 = "default",
    /// Custom endpoint URL (for LocalStack, etc.)
    endpoint_url: ?[]const u8 = null,
};

/// AWS SDK configuration shared across service clients
pub const Config = struct {
    /// AWS region (e.g., "us-east-1") - owned, must be freed
    region: []const u8,
    /// Credential provider
    credentials: CredentialsProvider,
    /// Custom endpoint URL (for LocalStack, etc.)
    endpoint_url: ?[]const u8 = null,
    /// Maximum retry attempts for transient failures
    max_attempts: u32 = 3,
    /// Request timeout in milliseconds
    timeout_ms: u32 = 30_000,
    /// Use FIPS endpoints
    use_fips: bool = false,
    /// Use dual-stack endpoints
    use_dual_stack: bool = false,

    allocator: Allocator,

    const Self = @This();

    /// Load config with automatic region and credential resolution
    pub fn load(allocator: Allocator, options: LoadOptions) !Self {
        const region = try resolveRegion(allocator, options);
        errdefer allocator.free(region);

        // Default to credential chain (environment -> file -> imds -> ecs)
        const credentials = options.credentials orelse CredentialsProvider{
            .chain = ChainProvider{ .profile = options.profile },
        };

        return Self{
            .region = region,
            .credentials = credentials,
            .endpoint_url = options.endpoint_url,
            .allocator = allocator,
        };
    }

    /// Free owned resources
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.region);
    }

    /// Create config with static credentials (borrows strings, caller manages lifetime)
    pub fn withStaticCredentials(
        region: []const u8,
        access_key_id: []const u8,
        secret_access_key: []const u8,
        session_token: ?[]const u8,
    ) Self {
        return .{
            .region = region,
            .credentials = .{
                .static = .{
                    .access_key_id = access_key_id,
                    .secret_access_key = secret_access_key,
                    .session_token = session_token,
                },
            },
            .allocator = undefined, // Not owned, don't call deinit
        };
    }

    /// Create config loading credentials from environment (borrows region)
    pub fn fromEnvironment(region: []const u8) Self {
        return .{
            .region = region,
            .credentials = .{ .environment = {} },
            .allocator = undefined, // Not owned, don't call deinit
        };
    }

    /// Build service endpoint URL
    pub fn getEndpoint(self: *const Self, service: []const u8, allocator: Allocator) ![]const u8 {
        if (self.endpoint_url) |url| {
            return try allocator.dupe(u8, url);
        }

        const suffix = if (self.use_fips and self.use_dual_stack)
            "-fips.dualstack"
        else if (self.use_fips)
            "-fips"
        else if (self.use_dual_stack)
            ".dualstack"
        else
            "";

        return std.fmt.allocPrint(allocator, "{s}{s}.{s}.amazonaws.com", .{
            service,
            suffix,
            self.region,
        });
    }
};

/// Resolve region from options, environment, or config file
fn resolveRegion(allocator: Allocator, options: LoadOptions) ![]const u8 {
    // 1. Explicit option
    if (options.region) |r| {
        return try allocator.dupe(u8, r);
    }

    // 2. AWS_REGION environment variable
    if (std.posix.getenv("AWS_REGION")) |r| {
        return try allocator.dupe(u8, r);
    }

    // 3. AWS_DEFAULT_REGION environment variable
    if (std.posix.getenv("AWS_DEFAULT_REGION")) |r| {
        return try allocator.dupe(u8, r);
    }

    // 4. Config file (~/.aws/config)
    if (try readRegionFromConfigFile(allocator, options.profile)) |r| {
        return r;
    }

    return error.RegionNotFound;
}

/// Read region from ~/.aws/config file
fn readRegionFromConfigFile(allocator: Allocator, profile: []const u8) !?[]const u8 {
    const home = std.posix.getenv("HOME") orelse return null;

    const config_path = try std.fmt.allocPrint(allocator, "{s}/.aws/config", .{home});
    defer allocator.free(config_path);

    const file = std.fs.openFileAbsolute(config_path, .{}) catch |err| {
        if (err == error.FileNotFound) return null;
        return err;
    };
    defer file.close();

    const content = file.readToEndAlloc(allocator, 1024 * 1024) catch |err| {
        if (err == error.OutOfMemory) return err;
        return null;
    };
    defer allocator.free(content);

    return try parseRegionFromConfig(allocator, content, profile);
}

/// Parse region from AWS config file content
fn parseRegionFromConfig(allocator: Allocator, content: []const u8, profile: []const u8) !?[]const u8 {
    // Build target section name: [default] or [profile xyz]
    var target_section_buf: [256]u8 = undefined;
    const target_section = if (std.mem.eql(u8, profile, "default"))
        "[default]"
    else
        std.fmt.bufPrint(&target_section_buf, "[profile {s}]", .{profile}) catch return null;

    var in_target_section = false;
    var lines = std.mem.splitScalar(u8, content, '\n');

    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r");

        // Skip empty lines and comments
        if (trimmed.len == 0 or trimmed[0] == '#' or trimmed[0] == ';') {
            continue;
        }

        // Check for section header
        if (trimmed[0] == '[') {
            in_target_section = std.mem.eql(u8, trimmed, target_section);
            continue;
        }

        // Parse key=value in target section
        if (in_target_section) {
            if (std.mem.indexOfScalar(u8, trimmed, '=')) |eq_idx| {
                const key = std.mem.trim(u8, trimmed[0..eq_idx], " \t");
                const value = std.mem.trim(u8, trimmed[eq_idx + 1 ..], " \t");

                if (std.mem.eql(u8, key, "region")) {
                    return try allocator.dupe(u8, value);
                }
            }
        }
    }

    return null;
}

test "Config with static credentials" {
    const config = Config.withStaticCredentials(
        "us-east-1",
        "AKIAIOSFODNN7EXAMPLE",
        "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        null,
    );

    try std.testing.expectEqualStrings("us-east-1", config.region);
}

test "Config getEndpoint" {
    const config = Config.fromEnvironment("us-west-2");
    const endpoint = try config.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(endpoint);

    try std.testing.expectEqualStrings("sts.us-west-2.amazonaws.com", endpoint);
}

test "Config getEndpoint with custom URL" {
    var config = Config.fromEnvironment("us-east-1");
    config.endpoint_url = "http://localhost:4566";

    const endpoint = try config.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(endpoint);

    try std.testing.expectEqualStrings("http://localhost:4566", endpoint);
}

test "Config getEndpoint with FIPS" {
    var config = Config.fromEnvironment("us-east-1");
    config.use_fips = true;

    const endpoint = try config.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(endpoint);

    try std.testing.expectEqualStrings("sts-fips.us-east-1.amazonaws.com", endpoint);
}

test "parseRegionFromConfig default profile" {
    const content =
        \\[default]
        \\region = us-west-2
        \\output = json
        \\
        \\[profile dev]
        \\region = eu-west-1
    ;

    const region = try parseRegionFromConfig(std.testing.allocator, content, "default");
    defer if (region) |r| std.testing.allocator.free(r);

    try std.testing.expectEqualStrings("us-west-2", region.?);
}

test "parseRegionFromConfig named profile" {
    const content =
        \\[default]
        \\region = us-west-2
        \\
        \\[profile dev]
        \\region = eu-west-1
    ;

    const region = try parseRegionFromConfig(std.testing.allocator, content, "dev");
    defer if (region) |r| std.testing.allocator.free(r);

    try std.testing.expectEqualStrings("eu-west-1", region.?);
}

test "parseRegionFromConfig missing profile" {
    const content =
        \\[default]
        \\region = us-west-2
    ;

    const region = try parseRegionFromConfig(std.testing.allocator, content, "nonexistent");
    try std.testing.expect(region == null);
}

test "resolveRegion from explicit option" {
    const region = try resolveRegion(std.testing.allocator, .{ .region = "ap-northeast-1" });
    defer std.testing.allocator.free(region);

    try std.testing.expectEqualStrings("ap-northeast-1", region);
}
