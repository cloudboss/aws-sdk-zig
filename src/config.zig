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

/// Profile settings from ~/.aws/config
pub const Profile = struct {
    region: ?[]const u8 = null,
    // Assume role
    role_arn: ?[]const u8 = null,
    source_profile: ?[]const u8 = null,
    role_session_name: ?[]const u8 = null,
    external_id: ?[]const u8 = null,
    // Web identity
    web_identity_token_file: ?[]const u8 = null,
    // Process
    credential_process: ?[]const u8 = null,
    // SSO (legacy)
    sso_start_url: ?[]const u8 = null,
    sso_account_id: ?[]const u8 = null,
    sso_role_name: ?[]const u8 = null,
    sso_region: ?[]const u8 = null,
    // SSO (session-based)
    sso_session: ?[]const u8 = null,
};

/// SSO session settings from ~/.aws/config [sso-session name] sections
pub const SsoSession = struct {
    sso_start_url: ?[]const u8 = null,
    sso_region: ?[]const u8 = null,
    sso_registration_scopes: ?[]const u8 = null,
};

/// Parsed config file containing profiles and SSO sessions
pub const ConfigFile = struct {
    profiles: std.StringHashMap(Profile),
    sso_sessions: std.StringHashMap(SsoSession),
    allocator: Allocator,

    pub fn deinit(self: *ConfigFile) void {
        self.profiles.deinit();
        self.sso_sessions.deinit();
    }

    /// Get a profile by name
    pub fn getProfile(self: *const ConfigFile, name: []const u8) ?Profile {
        return self.profiles.get(name);
    }

    /// Get an SSO session by name
    pub fn getSsoSession(self: *const ConfigFile, name: []const u8) ?SsoSession {
        return self.sso_sessions.get(name);
    }
};

/// Parse an AWS config file into profiles and SSO sessions.
/// All returned string values borrow from `content` -- caller must keep content alive.
pub fn parseConfigFile(allocator: Allocator, content: []const u8) ConfigFile {
    var profiles = std.StringHashMap(Profile).init(allocator);
    var sso_sessions = std.StringHashMap(SsoSession).init(allocator);

    var current_kind: SectionInfo.Kind = .none;
    var current_name: []const u8 = "";

    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r");

        // Skip empty lines and comments
        if (trimmed.len == 0 or trimmed[0] == '#' or trimmed[0] == ';') continue;

        // Section header
        if (trimmed[0] == '[') {
            const section = parseSectionHeader(trimmed);
            current_kind = section.kind;
            current_name = section.name;
            // Ensure the section exists in the map
            switch (current_kind) {
                .profile => {
                    if (!profiles.contains(current_name)) {
                        profiles.put(current_name, .{}) catch {};
                    }
                },
                .sso_session => {
                    if (!sso_sessions.contains(current_name)) {
                        sso_sessions.put(current_name, .{}) catch {};
                    }
                },
                .none => {},
            }
            continue;
        }

        // Key = value
        if (current_kind == .none) continue;
        const eq_idx = std.mem.indexOfScalar(u8, trimmed, '=') orelse continue;
        const key = std.mem.trim(u8, trimmed[0..eq_idx], " \t");
        const value = std.mem.trim(u8, trimmed[eq_idx + 1 ..], " \t");

        switch (current_kind) {
            .profile => {
                if (profiles.getPtr(current_name)) |p| {
                    setProfileField(p, key, value);
                }
            },
            .sso_session => {
                if (sso_sessions.getPtr(current_name)) |s| {
                    setSsoSessionField(s, key, value);
                }
            },
            .none => {},
        }
    }

    return .{
        .profiles = profiles,
        .sso_sessions = sso_sessions,
        .allocator = allocator,
    };
}

const SectionInfo = struct {
    const Kind = enum { profile, sso_session, none };
    kind: Kind,
    name: []const u8,
};

fn parseSectionHeader(header: []const u8) SectionInfo {
    // Strip [ and ]
    if (header.len < 2 or header[header.len - 1] != ']') return .{ .kind = .none, .name = "" };
    const inner = std.mem.trim(u8, header[1 .. header.len - 1], " \t");

    // [default]
    if (std.mem.eql(u8, inner, "default")) return .{ .kind = .profile, .name = "default" };

    // [profile name]
    if (std.mem.startsWith(u8, inner, "profile ")) {
        const name = std.mem.trim(u8, inner["profile ".len..], " \t");
        if (name.len > 0) return .{ .kind = .profile, .name = name };
    }

    // [sso-session name]
    if (std.mem.startsWith(u8, inner, "sso-session ")) {
        const name = std.mem.trim(u8, inner["sso-session ".len..], " \t");
        if (name.len > 0) return .{ .kind = .sso_session, .name = name };
    }

    return .{ .kind = .none, .name = "" };
}

fn setProfileField(p: *Profile, key: []const u8, value: []const u8) void {
    if (std.mem.eql(u8, key, "region")) {
        p.region = value;
    } else if (std.mem.eql(u8, key, "role_arn")) {
        p.role_arn = value;
    } else if (std.mem.eql(u8, key, "source_profile")) {
        p.source_profile = value;
    } else if (std.mem.eql(u8, key, "role_session_name")) {
        p.role_session_name = value;
    } else if (std.mem.eql(u8, key, "external_id")) {
        p.external_id = value;
    } else if (std.mem.eql(u8, key, "web_identity_token_file")) {
        p.web_identity_token_file = value;
    } else if (std.mem.eql(u8, key, "credential_process")) {
        p.credential_process = value;
    } else if (std.mem.eql(u8, key, "sso_start_url")) {
        p.sso_start_url = value;
    } else if (std.mem.eql(u8, key, "sso_account_id")) {
        p.sso_account_id = value;
    } else if (std.mem.eql(u8, key, "sso_role_name")) {
        p.sso_role_name = value;
    } else if (std.mem.eql(u8, key, "sso_region")) {
        p.sso_region = value;
    } else if (std.mem.eql(u8, key, "sso_session")) {
        p.sso_session = value;
    }
}

fn setSsoSessionField(s: *SsoSession, key: []const u8, value: []const u8) void {
    if (std.mem.eql(u8, key, "sso_start_url")) {
        s.sso_start_url = value;
    } else if (std.mem.eql(u8, key, "sso_region")) {
        s.sso_region = value;
    } else if (std.mem.eql(u8, key, "sso_registration_scopes")) {
        s.sso_registration_scopes = value;
    }
}

/// Load and parse the config file from disk.
/// Returns empty ConfigFile if file is missing.
pub fn loadConfigFile(allocator: Allocator) !ConfigFile {
    const path = try resolveConfigPath(allocator);
    defer allocator.free(path);

    const file = std.fs.openFileAbsolute(path, .{}) catch |err| {
        if (err == error.FileNotFound) return parseConfigFile(allocator, "");
        return err;
    };
    defer file.close();

    const content = file.readToEndAlloc(allocator, 1024 * 1024) catch |err| {
        if (err == error.OutOfMemory) return err;
        return parseConfigFile(allocator, "");
    };
    defer allocator.free(content);

    return parseConfigFile(allocator, content);
}

fn resolveConfigPath(allocator: Allocator) ![]const u8 {
    if (std.posix.getenv("AWS_CONFIG_FILE")) |p| {
        return try allocator.dupe(u8, p);
    }
    const home = std.posix.getenv("HOME") orelse return error.RegionNotFound;
    return std.fmt.allocPrint(allocator, "{s}/.aws/config", .{home});
}

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

test "parseConfigFile with multiple profiles" {
    const content =
        \\[default]
        \\region = us-east-1
        \\
        \\[profile dev]
        \\role_arn = arn:aws:iam::123456789012:role/DevRole
        \\source_profile = default
        \\external_id = my-external-id
        \\region = eu-west-1
        \\
        \\[profile eks-pod]
        \\role_arn = arn:aws:iam::123456789012:role/MyRole
        \\web_identity_token_file = /var/run/secrets/token
        \\
        \\[profile custom-tool]
        \\credential_process = /usr/local/bin/my-cred-helper
    ;

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    // default profile
    const def = cf.getProfile("default").?;
    try std.testing.expectEqualStrings("us-east-1", def.region.?);

    // dev profile
    const dev = cf.getProfile("dev").?;
    try std.testing.expectEqualStrings("arn:aws:iam::123456789012:role/DevRole", dev.role_arn.?);
    try std.testing.expectEqualStrings("default", dev.source_profile.?);
    try std.testing.expectEqualStrings("my-external-id", dev.external_id.?);
    try std.testing.expectEqualStrings("eu-west-1", dev.region.?);

    // eks-pod profile
    const eks = cf.getProfile("eks-pod").?;
    try std.testing.expectEqualStrings("arn:aws:iam::123456789012:role/MyRole", eks.role_arn.?);
    try std.testing.expectEqualStrings("/var/run/secrets/token", eks.web_identity_token_file.?);

    // custom-tool profile
    const custom = cf.getProfile("custom-tool").?;
    try std.testing.expectEqualStrings("/usr/local/bin/my-cred-helper", custom.credential_process.?);

    // nonexistent
    try std.testing.expect(cf.getProfile("nonexistent") == null);
}

test "parseConfigFile sso-session sections" {
    const content =
        \\[profile sso-user]
        \\sso_session = my-sso
        \\sso_account_id = 123456789012
        \\sso_role_name = PowerUserAccess
        \\
        \\[sso-session my-sso]
        \\sso_start_url = https://my-org.awsapps.com/start
        \\sso_region = us-east-1
        \\sso_registration_scopes = sso:account:access
    ;

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const profile = cf.getProfile("sso-user").?;
    try std.testing.expectEqualStrings("my-sso", profile.sso_session.?);
    try std.testing.expectEqualStrings("123456789012", profile.sso_account_id.?);
    try std.testing.expectEqualStrings("PowerUserAccess", profile.sso_role_name.?);

    const session = cf.getSsoSession("my-sso").?;
    try std.testing.expectEqualStrings("https://my-org.awsapps.com/start", session.sso_start_url.?);
    try std.testing.expectEqualStrings("us-east-1", session.sso_region.?);
    try std.testing.expectEqualStrings("sso:account:access", session.sso_registration_scopes.?);
}

test "parseConfigFile empty content" {
    var cf = parseConfigFile(std.testing.allocator, "");
    defer cf.deinit();

    try std.testing.expect(cf.getProfile("default") == null);
}

test "parseConfigFile comments and whitespace" {
    const content =
        \\# Top-level comment
        \\[default]
        \\; inline comment
        \\region = us-west-2
        \\
        \\  role_arn  =  arn:aws:iam::123:role/Test
    ;

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const def = cf.getProfile("default").?;
    try std.testing.expectEqualStrings("us-west-2", def.region.?);
    try std.testing.expectEqualStrings("arn:aws:iam::123:role/Test", def.role_arn.?);
}

test "parseSectionHeader" {
    const s1 = parseSectionHeader("[default]");
    try std.testing.expectEqualStrings("default", s1.name);

    const s2 = parseSectionHeader("[profile dev]");
    try std.testing.expectEqualStrings("dev", s2.name);

    const s3 = parseSectionHeader("[sso-session my-sso]");
    try std.testing.expectEqualStrings("my-sso", s3.name);

    const s4 = parseSectionHeader("[unknown]");
    try std.testing.expect(s4.kind == .none);
}
