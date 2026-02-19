//! AWS SDK Configuration
//!
//! Central configuration struct for AWS service clients.

const std = @import("std");
const Allocator = std.mem.Allocator;

const credentials_mod = @import("credentials.zig");
const CredentialsProvider = credentials_mod.CredentialsProvider;
const ChainProvider = credentials_mod.ChainProvider;
const endpoint_mod = @import("endpoint.zig");

/// Retry mode for transient failures
pub const RetryMode = enum { standard, adaptive };

/// Parse retry mode from string value
pub fn parseRetryMode(value: []const u8) ?RetryMode {
    if (std.mem.eql(u8, value, "standard")) {
        return .standard;
    } else if (std.mem.eql(u8, value, "adaptive")) {
        return .adaptive;
    }
    return null;
}

/// Read retry mode from AWS_RETRY_MODE environment variable
fn readEnvRetryMode() ?RetryMode {
    if (std.posix.getenv("AWS_RETRY_MODE")) |value| {
        return parseRetryMode(value);
    }
    return null;
}

/// Read max attempts from AWS_MAX_ATTEMPTS environment variable
fn readEnvMaxAttempts() ?u32 {
    if (std.posix.getenv("AWS_MAX_ATTEMPTS")) |value| {
        return std.fmt.parseInt(u32, value, 10) catch null;
    }
    return null;
}

/// Read a boolean from an environment variable ("true" -> true)
fn resolveBoolEnv(env_var: []const u8) ?bool {
    if (std.posix.getenv(env_var)) |value| {
        return std.mem.eql(u8, value, "true");
    }
    return null;
}

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
    /// Use FIPS endpoints
    use_fips: ?bool = null,
    /// Use dual-stack endpoints
    use_dual_stack: ?bool = null,
    /// Maximum retry attempts
    max_attempts: ?u32 = null,
    /// Retry mode
    retry_mode: ?RetryMode = null,
    /// CA bundle path
    ca_bundle: ?[]const u8 = null,
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
    /// Retry mode for transient failures
    retry_mode: RetryMode = .standard,
    /// CA bundle path for TLS verification
    ca_bundle: ?[]const u8 = null,
    /// Parsed config file for downstream use
    config_file: ?ConfigFile = null,
    /// Profile name for config file lookups
    profile: []const u8 = "default",

    allocator: Allocator,

    const Self = @This();

    /// Load config with automatic resolution of all settings.
    /// Precedence: options (code) > environment > config file profile > default.
    pub fn load(allocator: Allocator, options: LoadOptions) !Self {
        var cf = try loadConfigFile(allocator);
        errdefer cf.deinit();

        const profile: ?Profile = cf.getProfile(options.profile);

        const region = try resolveRegion(allocator, options, profile);
        errdefer allocator.free(region);

        const credentials = options.credentials orelse CredentialsProvider{
            .chain = ChainProvider{
                .profile = options.profile,
                .region = region,
            },
        };

        const endpoint_url: ?[]const u8 = options.endpoint_url orelse
            std.posix.getenv("AWS_ENDPOINT_URL") orelse
            (if (profile) |p| p.endpoint_url else null);

        const use_fips: bool = options.use_fips orelse
            resolveBoolEnv("AWS_USE_FIPS_ENDPOINT") orelse
            (if (profile) |p| p.use_fips_endpoint else null) orelse
            false;

        const use_dual_stack: bool = options.use_dual_stack orelse
            resolveBoolEnv("AWS_USE_DUALSTACK_ENDPOINT") orelse
            (if (profile) |p| p.use_dualstack_endpoint else null) orelse
            false;

        const max_attempts: u32 = options.max_attempts orelse
            readEnvMaxAttempts() orelse
            (if (profile) |p| p.max_attempts else null) orelse
            3;

        const retry_mode: RetryMode = options.retry_mode orelse
            readEnvRetryMode() orelse
            (if (profile) |p|
                (if (p.retry_mode) |rm| parseRetryMode(rm) else null)
            else
                null) orelse
            .standard;

        const ca_bundle: ?[]const u8 = options.ca_bundle orelse
            std.posix.getenv("AWS_CA_BUNDLE") orelse
            (if (profile) |p| p.ca_bundle else null);

        return Self{
            .region = region,
            .credentials = credentials,
            .endpoint_url = endpoint_url,
            .use_fips = use_fips,
            .use_dual_stack = use_dual_stack,
            .max_attempts = max_attempts,
            .retry_mode = retry_mode,
            .ca_bundle = ca_bundle,
            .config_file = cf,
            .profile = options.profile,
            .allocator = allocator,
        };
    }

    /// Free owned resources
    pub fn deinit(self: *Self) void {
        self.allocator.free(self.region);
        if (self.config_file) |*cf| cf.deinit();
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
    pub fn getEndpoint(
        self: *const Self,
        service: []const u8,
        allocator: Allocator,
    ) ![]const u8 {
        return endpoint_mod.resolveEndpoint(allocator, service, self.region, .{
            .fips = self.use_fips,
            .dual_stack = self.use_dual_stack,
            .endpoint_override = self.endpoint_url,
        });
    }

    /// Resolve endpoint URL for a specific service with full
    /// 6-level precedence:
    ///   1. self.endpoint_url (code-level override)
    ///   2. AWS_ENDPOINT_URL_{SDK_ID} (per-service env var)
    ///   3. AWS_ENDPOINT_URL (global env var)
    ///   4. Services section endpoint (from config file)
    ///   5. Profile endpoint_url (from config file)
    ///   6. Partition-based default
    ///
    /// Levels 2-5 are skipped when
    /// AWS_IGNORE_CONFIGURED_ENDPOINT_URLS is "true" or the
    /// profile sets ignore_configured_endpoint_urls.
    pub fn getEndpointForService(
        self: *const Self,
        service: []const u8,
        sdk_id: []const u8,
        allocator: Allocator,
    ) ![]const u8 {
        // Level 1: Code-level override always wins
        if (self.endpoint_url) |url| {
            return try allocator.dupe(u8, url);
        }

        const ignore = shouldIgnoreConfiguredEndpoints(
            self.config_file,
            self.profile,
        );

        if (!ignore) {
            // Level 2: Per-service env var
            var env_buf: [256]u8 = undefined;
            const prefix = "AWS_ENDPOINT_URL_";
            @memcpy(env_buf[0..prefix.len], prefix);
            const upper = sdkIdToEnvKey(
                sdk_id,
                env_buf[prefix.len..],
            );
            const key_len = prefix.len + upper.len;
            env_buf[key_len] = 0;
            if (std.posix.getenv(
                env_buf[0..key_len :0],
            )) |url| {
                return try allocator.dupe(u8, url);
            }

            // Level 3: Global endpoint env var
            if (std.posix.getenv(
                "AWS_ENDPOINT_URL",
            )) |url| {
                return try allocator.dupe(u8, url);
            }

            if (self.config_file) |cf| {
                if (cf.getProfile(self.profile)) |p| {
                    // Level 4: Services section
                    if (p.services) |svc_name| {
                        if (cf.getServicesSection(
                            svc_name,
                        )) |section| {
                            var cfg_buf: [256]u8 = undefined;
                            const cfg_key = sdkIdToConfigKey(
                                sdk_id,
                                &cfg_buf,
                            );
                            if (section.get(cfg_key)) |sc| {
                                if (sc.endpoint_url) |url| {
                                    return try allocator.dupe(
                                        u8,
                                        url,
                                    );
                                }
                            }
                        }
                    }

                    // Level 5: Profile endpoint_url
                    if (p.endpoint_url) |url| {
                        return try allocator.dupe(u8, url);
                    }
                }
            }
        }

        // Level 6: Partition-based default
        return endpoint_mod.resolveEndpoint(
            allocator,
            service,
            self.region,
            .{
                .fips = self.use_fips,
                .dual_stack = self.use_dual_stack,
            },
        );
    }
};

/// Check whether configured endpoint URLs should be ignored
/// (env var or profile setting).
fn shouldIgnoreConfiguredEndpoints(
    config_file: ?ConfigFile,
    profile_name: []const u8,
) bool {
    if (std.posix.getenv(
        "AWS_IGNORE_CONFIGURED_ENDPOINT_URLS",
    )) |v| {
        if (std.mem.eql(u8, v, "true")) return true;
    }
    if (config_file) |cf| {
        if (cf.getProfile(profile_name)) |p| {
            return p.ignore_configured_endpoint_urls orelse
                false;
        }
    }
    return false;
}

/// Transform SDK ID to uppercase with underscores for env var keys.
/// "Secrets Manager" -> "SECRETS_MANAGER"
fn sdkIdToEnvKey(sdk_id: []const u8, buf: []u8) []const u8 {
    for (sdk_id, 0..) |c, i| {
        buf[i] = if (c == ' ')
            @as(u8, '_')
        else
            std.ascii.toUpper(c);
    }
    return buf[0..sdk_id.len];
}

/// Transform SDK ID to lowercase with underscores for config keys.
/// "Secrets Manager" -> "secrets_manager"
fn sdkIdToConfigKey(sdk_id: []const u8, buf: []u8) []const u8 {
    for (sdk_id, 0..) |c, i| {
        buf[i] = if (c == ' ')
            @as(u8, '_')
        else
            std.ascii.toLower(c);
    }
    return buf[0..sdk_id.len];
}

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
    // Endpoint and service configuration
    endpoint_url: ?[]const u8 = null,
    services: ?[]const u8 = null,
    use_fips_endpoint: ?bool = null,
    use_dualstack_endpoint: ?bool = null,
    max_attempts: ?u32 = null,
    retry_mode: ?[]const u8 = null,
    ec2_metadata_service_endpoint: ?[]const u8 = null,
    ec2_metadata_service_endpoint_mode: ?[]const u8 = null,
    ca_bundle: ?[]const u8 = null,
    s3_addressing_style: ?[]const u8 = null,
    s3_use_accelerate_endpoint: ?bool = null,
    ignore_configured_endpoint_urls: ?bool = null,
};

/// SSO session settings from ~/.aws/config [sso-session name] sections
pub const SsoSession = struct {
    sso_start_url: ?[]const u8 = null,
    sso_region: ?[]const u8 = null,
    sso_registration_scopes: ?[]const u8 = null,
};

/// Per-service configuration from [services] sections
pub const ServiceConfig = struct {
    endpoint_url: ?[]const u8 = null,
};

/// Parsed config file containing profiles, SSO sessions, and services
pub const ConfigFile = struct {
    profiles: std.StringHashMap(Profile),
    sso_sessions: std.StringHashMap(SsoSession),
    services: std.StringHashMap(std.StringHashMap(ServiceConfig)),
    allocator: Allocator,

    pub fn deinit(self: *ConfigFile) void {
        self.profiles.deinit();
        self.sso_sessions.deinit();
        var it = self.services.valueIterator();
        while (it.next()) |inner| {
            inner.deinit();
        }
        self.services.deinit();
    }

    /// Get a profile by name
    pub fn getProfile(self: *const ConfigFile, name: []const u8) ?Profile {
        return self.profiles.get(name);
    }

    /// Get an SSO session by name
    pub fn getSsoSession(
        self: *const ConfigFile,
        name: []const u8,
    ) ?SsoSession {
        return self.sso_sessions.get(name);
    }

    /// Get a services section by name
    pub fn getServicesSection(
        self: *const ConfigFile,
        name: []const u8,
    ) ?std.StringHashMap(ServiceConfig) {
        return self.services.get(name);
    }
};

/// Parse an AWS config file into profiles, SSO sessions, and services.
/// All returned string values borrow from `content` -- caller must
/// keep content alive.
pub fn parseConfigFile(
    allocator: Allocator,
    content: []const u8,
) ConfigFile {
    var profiles = std.StringHashMap(Profile).init(allocator);
    var sso_sessions = std.StringHashMap(SsoSession).init(allocator);
    var services = std.StringHashMap(
        std.StringHashMap(ServiceConfig),
    ).init(allocator);

    var current_kind: SectionInfo.Kind = .none;
    var current_name: []const u8 = "";
    var current_service_name: []const u8 = "";

    var lines = std.mem.splitScalar(u8, content, '\n');
    while (lines.next()) |line| {
        const trimmed = std.mem.trim(u8, line, " \t\r");

        if (trimmed.len == 0 or trimmed[0] == '#' or trimmed[0] == ';')
            continue;

        // Section header
        if (trimmed[0] == '[') {
            const section = parseSectionHeader(trimmed);
            current_kind = section.kind;
            current_name = section.name;
            current_service_name = "";
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
                .services => {
                    if (!services.contains(current_name)) {
                        services.put(
                            current_name,
                            std.StringHashMap(ServiceConfig).init(allocator),
                        ) catch {};
                    }
                },
                .none => {},
            }
            continue;
        }

        if (current_kind == .none) continue;

        // Services sections use nested INI with indentation
        if (current_kind == .services) {
            const is_indented = line.len > 0 and
                (line[0] == ' ' or line[0] == '\t');
            if (!is_indented) {
                // Service name line: "dynamodb ="
                const eq_idx = std.mem.indexOfScalar(
                    u8,
                    trimmed,
                    '=',
                ) orelse continue;
                const svc_name = std.mem.trim(
                    u8,
                    trimmed[0..eq_idx],
                    " \t",
                );
                current_service_name = svc_name;
                if (services.getPtr(current_name)) |inner| {
                    if (!inner.contains(svc_name)) {
                        inner.put(svc_name, .{}) catch {};
                    }
                }
            } else {
                // Sub-key line: "  endpoint_url = http://..."
                if (current_service_name.len == 0) continue;
                const eq_idx = std.mem.indexOfScalar(
                    u8,
                    trimmed,
                    '=',
                ) orelse continue;
                const key = std.mem.trim(
                    u8,
                    trimmed[0..eq_idx],
                    " \t",
                );
                const value = std.mem.trim(
                    u8,
                    trimmed[eq_idx + 1 ..],
                    " \t",
                );
                if (std.mem.eql(u8, key, "endpoint_url")) {
                    if (services.getPtr(current_name)) |inner| {
                        if (inner.getPtr(current_service_name)) |sc| {
                            sc.endpoint_url = value;
                        }
                    }
                }
            }
            continue;
        }

        // Standard key = value for profiles and sso-sessions
        const eq_idx = std.mem.indexOfScalar(
            u8,
            trimmed,
            '=',
        ) orelse continue;
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
            .services, .none => {},
        }
    }

    return .{
        .profiles = profiles,
        .sso_sessions = sso_sessions,
        .services = services,
        .allocator = allocator,
    };
}

const SectionInfo = struct {
    const Kind = enum { profile, sso_session, services, none };
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

    // [services name]
    if (std.mem.startsWith(u8, inner, "services ")) {
        const name = std.mem.trim(u8, inner["services ".len..], " \t");
        if (name.len > 0) return .{ .kind = .services, .name = name };
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
    } else if (std.mem.eql(u8, key, "endpoint_url")) {
        p.endpoint_url = value;
    } else if (std.mem.eql(u8, key, "services")) {
        p.services = value;
    } else if (std.mem.eql(u8, key, "use_fips_endpoint")) {
        p.use_fips_endpoint = std.mem.eql(u8, value, "true");
    } else if (std.mem.eql(u8, key, "use_dualstack_endpoint")) {
        p.use_dualstack_endpoint = std.mem.eql(u8, value, "true");
    } else if (std.mem.eql(u8, key, "max_attempts")) {
        p.max_attempts = std.fmt.parseInt(u32, value, 10) catch null;
    } else if (std.mem.eql(u8, key, "retry_mode")) {
        p.retry_mode = value;
    } else if (std.mem.eql(u8, key, "ec2_metadata_service_endpoint")) {
        p.ec2_metadata_service_endpoint = value;
    } else if (std.mem.eql(u8, key, "ec2_metadata_service_endpoint_mode")) {
        p.ec2_metadata_service_endpoint_mode = value;
    } else if (std.mem.eql(u8, key, "ca_bundle")) {
        p.ca_bundle = value;
    } else if (std.mem.eql(u8, key, "s3_addressing_style")) {
        p.s3_addressing_style = value;
    } else if (std.mem.eql(u8, key, "s3_use_accelerate_endpoint")) {
        p.s3_use_accelerate_endpoint = std.mem.eql(u8, value, "true");
    } else if (std.mem.eql(u8, key, "ignore_configured_endpoint_urls")) {
        p.ignore_configured_endpoint_urls = std.mem.eql(u8, value, "true");
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

/// Resolve region: options > AWS_REGION > AWS_DEFAULT_REGION > profile > error
fn resolveRegion(
    allocator: Allocator,
    options: LoadOptions,
    profile: ?Profile,
) ![]const u8 {
    if (options.region) |r| {
        return try allocator.dupe(u8, r);
    }
    if (std.posix.getenv("AWS_REGION")) |r| {
        return try allocator.dupe(u8, r);
    }
    if (std.posix.getenv("AWS_DEFAULT_REGION")) |r| {
        return try allocator.dupe(u8, r);
    }
    if (profile) |p| {
        if (p.region) |r| {
            return try allocator.dupe(u8, r);
        }
    }
    return error.RegionNotFound;
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

test "Config getEndpoint with China region" {
    const config_val = Config.fromEnvironment("cn-north-1");
    const ep = try config_val.getEndpoint("sts", std.testing.allocator);
    defer std.testing.allocator.free(ep);
    try std.testing.expectEqualStrings("sts.cn-north-1.amazonaws.com.cn", ep);
}

test "resolveRegion from explicit option" {
    const region = try resolveRegion(
        std.testing.allocator,
        .{ .region = "ap-northeast-1" },
        null,
    );
    defer std.testing.allocator.free(region);

    try std.testing.expectEqualStrings("ap-northeast-1", region);
}

test "resolveRegion from config profile" {
    const region = try resolveRegion(
        std.testing.allocator,
        .{},
        Profile{ .region = "eu-central-1" },
    );
    defer std.testing.allocator.free(region);

    try std.testing.expectEqualStrings("eu-central-1", region);
}

test "resolveRegion option overrides profile" {
    const region = try resolveRegion(
        std.testing.allocator,
        .{ .region = "us-west-2" },
        Profile{ .region = "eu-central-1" },
    );
    defer std.testing.allocator.free(region);

    try std.testing.expectEqualStrings("us-west-2", region);
}

test "resolveRegion error when no source" {
    const result = resolveRegion(std.testing.allocator, .{}, null);
    try std.testing.expectError(error.RegionNotFound, result);
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
    try std.testing.expectEqualStrings(
        "arn:aws:iam::123456789012:role/MyRole",
        eks.role_arn.?,
    );
    try std.testing.expectEqualStrings(
        "/var/run/secrets/token",
        eks.web_identity_token_file.?,
    );

    // custom-tool profile
    const custom = cf.getProfile("custom-tool").?;
    try std.testing.expectEqualStrings(
        "/usr/local/bin/my-cred-helper",
        custom.credential_process.?,
    );

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

    const s5 = parseSectionHeader("[services my-services]");
    try std.testing.expect(s5.kind == .services);
    try std.testing.expectEqualStrings("my-services", s5.name);
}

test "parseRetryMode" {
    try std.testing.expect(parseRetryMode("standard") == .standard);
    try std.testing.expect(parseRetryMode("adaptive") == .adaptive);
    try std.testing.expect(parseRetryMode("invalid") == null);
    try std.testing.expect(parseRetryMode("") == null);
}

test "Profile with new endpoint fields" {
    const content =
        \\[default]
        \\region = us-east-1
        \\endpoint_url = http://localhost:4566
        \\use_fips_endpoint = true
        \\max_attempts = 5
    ;

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const def = cf.getProfile("default").?;
    try std.testing.expectEqualStrings("us-east-1", def.region.?);
    try std.testing.expectEqualStrings("http://localhost:4566", def.endpoint_url.?);
    try std.testing.expect(def.use_fips_endpoint == true);
    try std.testing.expect(def.max_attempts == 5);
}

test "Profile with invalid max_attempts" {
    const content =
        \\[default]
        \\region = us-east-1
        \\max_attempts = invalid
    ;

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const def = cf.getProfile("default").?;
    try std.testing.expect(def.max_attempts == null);
}

test "Config defaults" {
    const config = Config.fromEnvironment("us-east-1");
    try std.testing.expect(config.retry_mode == .standard);
    try std.testing.expect(config.ca_bundle == null);
}

test "parseConfigFile services with multiple services" {
    const content =
        "[services my-services]\n" ++
        "dynamodb =\n" ++
        "  endpoint_url = http://localhost:8000\n" ++
        "s3 =\n" ++
        "  endpoint_url = http://localhost:9000\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const svc = cf.getServicesSection("my-services").?;
    const ddb = svc.get("dynamodb").?;
    try std.testing.expectEqualStrings(
        "http://localhost:8000",
        ddb.endpoint_url.?,
    );
    const s3 = svc.get("s3").?;
    try std.testing.expectEqualStrings(
        "http://localhost:9000",
        s3.endpoint_url.?,
    );
    try std.testing.expect(svc.get("nonexistent") == null);
}

test "parseConfigFile empty services section" {
    const content =
        "[services empty-svc]\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const svc = cf.getServicesSection("empty-svc").?;
    try std.testing.expect(svc.count() == 0);
    try std.testing.expect(cf.getServicesSection("missing") == null);
}

test "parseConfigFile profile with services section" {
    const content =
        "[default]\n" ++
        "region = us-east-1\n" ++
        "services = my-services\n" ++
        "\n" ++
        "[services my-services]\n" ++
        "dynamodb =\n" ++
        "  endpoint_url = http://localhost:8000\n" ++
        "\n" ++
        "[profile dev]\n" ++
        "region = eu-west-1\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    const def = cf.getProfile("default").?;
    try std.testing.expectEqualStrings("us-east-1", def.region.?);
    try std.testing.expectEqualStrings("my-services", def.services.?);

    const dev = cf.getProfile("dev").?;
    try std.testing.expectEqualStrings("eu-west-1", dev.region.?);

    const svc = cf.getServicesSection("my-services").?;
    const ddb = svc.get("dynamodb").?;
    try std.testing.expectEqualStrings(
        "http://localhost:8000",
        ddb.endpoint_url.?,
    );
}

test "resolveBoolEnv returns null for unset var" {
    try std.testing.expect(
        resolveBoolEnv("AWS_NONEXISTENT_TEST_VAR_XYZ") == null,
    );
}

test "endpoint_url: option overrides profile" {
    const prof: ?Profile = Profile{
        .endpoint_url = "http://from-profile",
    };
    const opts = LoadOptions{ .endpoint_url = "http://from-opts" };
    const got: ?[]const u8 = opts.endpoint_url orelse
        (if (prof) |p| p.endpoint_url else null);
    try std.testing.expectEqualStrings("http://from-opts", got.?);
}

test "endpoint_url: falls back to profile" {
    const prof: ?Profile = Profile{
        .endpoint_url = "http://from-profile",
    };
    const got: ?[]const u8 = @as(?[]const u8, null) orelse
        (if (prof) |p| p.endpoint_url else null);
    try std.testing.expectEqualStrings("http://from-profile", got.?);
}

test "endpoint_url: null when nothing set" {
    const prof: ?Profile = Profile{};
    const got: ?[]const u8 = @as(?[]const u8, null) orelse
        (if (prof) |p| p.endpoint_url else null);
    try std.testing.expect(got == null);
}

test "use_fips: defaults to false" {
    const prof: ?Profile = Profile{};
    const got: bool = @as(?bool, null) orelse
        @as(?bool, null) orelse
        (if (prof) |p| p.use_fips_endpoint else null) orelse
        false;
    try std.testing.expect(got == false);
}

test "use_fips: from profile" {
    const prof: ?Profile = Profile{ .use_fips_endpoint = true };
    const got: bool = @as(?bool, null) orelse
        @as(?bool, null) orelse
        (if (prof) |p| p.use_fips_endpoint else null) orelse
        false;
    try std.testing.expect(got == true);
}

test "use_fips: option overrides profile" {
    var opt: ?bool = false;
    const prof: ?Profile = Profile{ .use_fips_endpoint = true };
    _ = .{&opt};
    const got: bool = opt orelse
        @as(?bool, null) orelse
        (if (prof) |p| p.use_fips_endpoint else null) orelse
        false;
    try std.testing.expect(got == false);
}

test "use_dual_stack: defaults to false" {
    const prof: ?Profile = Profile{};
    const got: bool = @as(?bool, null) orelse
        @as(?bool, null) orelse
        (if (prof) |p| p.use_dualstack_endpoint else null) orelse
        false;
    try std.testing.expect(got == false);
}

test "use_dual_stack: from profile" {
    const prof: ?Profile = Profile{ .use_dualstack_endpoint = true };
    const got: bool = @as(?bool, null) orelse
        @as(?bool, null) orelse
        (if (prof) |p| p.use_dualstack_endpoint else null) orelse
        false;
    try std.testing.expect(got == true);
}

test "max_attempts: defaults to 3" {
    const prof: ?Profile = Profile{};
    const got: u32 = @as(?u32, null) orelse
        @as(?u32, null) orelse
        (if (prof) |p| p.max_attempts else null) orelse
        3;
    try std.testing.expect(got == 3);
}

test "max_attempts: from profile" {
    const prof: ?Profile = Profile{ .max_attempts = 10 };
    const got: u32 = @as(?u32, null) orelse
        @as(?u32, null) orelse
        (if (prof) |p| p.max_attempts else null) orelse
        3;
    try std.testing.expect(got == 10);
}

test "max_attempts: option overrides profile" {
    var opt: ?u32 = 5;
    const prof: ?Profile = Profile{ .max_attempts = 10 };
    _ = .{&opt};
    const got: u32 = opt orelse
        @as(?u32, null) orelse
        (if (prof) |p| p.max_attempts else null) orelse
        3;
    try std.testing.expect(got == 5);
}

test "retry_mode: defaults to standard" {
    const prof: ?Profile = Profile{};
    const got: RetryMode = @as(?RetryMode, null) orelse
        @as(?RetryMode, null) orelse
        (if (prof) |p|
            (if (p.retry_mode) |rm| parseRetryMode(rm) else null)
        else
            null) orelse
        .standard;
    try std.testing.expect(got == .standard);
}

test "retry_mode: from profile" {
    const prof: ?Profile = Profile{ .retry_mode = "adaptive" };
    const got: RetryMode = @as(?RetryMode, null) orelse
        @as(?RetryMode, null) orelse
        (if (prof) |p|
            (if (p.retry_mode) |rm| parseRetryMode(rm) else null)
        else
            null) orelse
        .standard;
    try std.testing.expect(got == .adaptive);
}

test "ca_bundle: from profile" {
    const prof: ?Profile = Profile{
        .ca_bundle = "/path/to/bundle.pem",
    };
    const got: ?[]const u8 = @as(?[]const u8, null) orelse
        @as(?[]const u8, null) orelse
        (if (prof) |p| p.ca_bundle else null);
    try std.testing.expectEqualStrings(
        "/path/to/bundle.pem",
        got.?,
    );
}

test "ca_bundle: null by default" {
    const prof: ?Profile = Profile{};
    const got: ?[]const u8 = @as(?[]const u8, null) orelse
        @as(?[]const u8, null) orelse
        (if (prof) |p| p.ca_bundle else null);
    try std.testing.expect(got == null);
}

test "sdkIdToEnvKey" {
    var buf: [256]u8 = undefined;
    try std.testing.expectEqualStrings(
        "SECRETS_MANAGER",
        sdkIdToEnvKey("Secrets Manager", &buf),
    );
    try std.testing.expectEqualStrings(
        "STS",
        sdkIdToEnvKey("STS", &buf),
    );
    try std.testing.expectEqualStrings(
        "S3",
        sdkIdToEnvKey("S3", &buf),
    );
    try std.testing.expectEqualStrings(
        "ELASTIC_LOAD_BALANCING",
        sdkIdToEnvKey("Elastic Load Balancing", &buf),
    );
}

test "sdkIdToConfigKey" {
    var buf: [256]u8 = undefined;
    try std.testing.expectEqualStrings(
        "secrets_manager",
        sdkIdToConfigKey("Secrets Manager", &buf),
    );
    try std.testing.expectEqualStrings(
        "sts",
        sdkIdToConfigKey("STS", &buf),
    );
    try std.testing.expectEqualStrings(
        "s3",
        sdkIdToConfigKey("S3", &buf),
    );
}

test "getEndpointForService: code override wins" {
    var config = Config.fromEnvironment("us-east-1");
    config.endpoint_url = "http://localhost:4566";

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "http://localhost:4566",
        ep,
    );
}

test "getEndpointForService: partition default" {
    const config = Config.fromEnvironment("us-west-2");

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "sts.us-west-2.amazonaws.com",
        ep,
    );
}

test "getEndpointForService: services section lookup" {
    const content =
        "[default]\n" ++
        "region = us-east-1\n" ++
        "services = my-services\n" ++
        "\n" ++
        "[services my-services]\n" ++
        "secrets_manager =\n" ++
        "  endpoint_url = http://secrets-svc:8080\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    var config = Config.fromEnvironment("us-east-1");
    config.config_file = cf;
    config.profile = "default";

    const ep = try config.getEndpointForService(
        "secretsmanager",
        "Secrets Manager",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "http://secrets-svc:8080",
        ep,
    );
}

test "getEndpointForService: profile endpoint_url" {
    const content =
        "[default]\n" ++
        "region = us-east-1\n" ++
        "endpoint_url = http://profile-endpoint\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    var config = Config.fromEnvironment("us-east-1");
    config.config_file = cf;
    config.profile = "default";

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "http://profile-endpoint",
        ep,
    );
}

test "getEndpointForService: ignore flag skips config" {
    const content =
        "[default]\n" ++
        "region = us-east-1\n" ++
        "endpoint_url = http://profile-endpoint\n" ++
        "ignore_configured_endpoint_urls = true\n" ++
        "services = my-services\n" ++
        "\n" ++
        "[services my-services]\n" ++
        "sts =\n" ++
        "  endpoint_url = http://services-sts\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    var config = Config.fromEnvironment("us-east-1");
    config.config_file = cf;
    config.profile = "default";

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    // Ignore flag causes fallback to partition default
    try std.testing.expectEqualStrings(
        "sts.us-east-1.amazonaws.com",
        ep,
    );
}

test "getEndpointForService: services beats profile" {
    const content =
        "[default]\n" ++
        "region = us-east-1\n" ++
        "endpoint_url = http://profile-endpoint\n" ++
        "services = my-services\n" ++
        "\n" ++
        "[services my-services]\n" ++
        "sts =\n" ++
        "  endpoint_url = http://services-sts\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    var config = Config.fromEnvironment("us-east-1");
    config.config_file = cf;
    config.profile = "default";

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "http://services-sts",
        ep,
    );
}

test "getEndpointForService: code override beats ignore" {
    const content =
        "[default]\n" ++
        "ignore_configured_endpoint_urls = true\n";

    var cf = parseConfigFile(std.testing.allocator, content);
    defer cf.deinit();

    var config = Config.fromEnvironment("us-east-1");
    config.config_file = cf;
    config.profile = "default";
    config.endpoint_url = "http://code-override";

    const ep = try config.getEndpointForService(
        "sts",
        "STS",
        std.testing.allocator,
    );
    defer std.testing.allocator.free(ep);

    try std.testing.expectEqualStrings(
        "http://code-override",
        ep,
    );
}
