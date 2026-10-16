//! AWS Credentials
//!
//! Tagged union credential provider following our design decision.

const std = @import("std");
const Allocator = std.mem.Allocator;
const imds = @import("imds.zig");
const ecs = @import("ecs.zig");
const web_identity = @import("web_identity.zig");
const process = @import("process.zig");
const sso = @import("sso.zig");
const login = @import("login.zig");
const assume_role = @import("assume_role.zig");
const config_mod = @import("config.zig");
const sts_common = @import("sts_common.zig");

/// Default buffer (seconds) before expiration to consider credentials stale.
pub const default_expiry_buffer: i64 = 300;

/// AWS credentials for request signing
pub const Credentials = struct {
    access_key_id: []const u8,
    secret_access_key: []const u8,
    session_token: ?[]const u8 = null,
    /// Expiration time (epoch seconds), null if permanent
    expiration: ?i64 = null,

    /// Check if credentials are expired (with default 5 minute buffer)
    pub fn isExpired(self: Credentials, io: std.Io) bool {
        return self.isExpiredWithBuffer(io, default_expiry_buffer);
    }

    /// Check if credentials are expired with a custom buffer (seconds)
    pub fn isExpiredWithBuffer(self: Credentials, io: std.Io, buffer: i64) bool {
        const exp = self.expiration orelse return false;
        return std.Io.Clock.real.now(io).toSeconds() >= (exp - buffer);
    }
};

/// Return a jittered buffer value in [buffer/2, buffer] (seconds).
/// Jittered to avoid thundering herd on refresh.
pub fn jitteredBuffer(io: std.Io, buffer: i64) i64 {
    if (buffer <= 1) return buffer;
    const half: u64 = @intCast(@divTrunc(buffer, 2));
    const range: u64 = @intCast(buffer - @as(i64, @intCast(half)) + 1);
    var bytes: [8]u8 = undefined;
    io.random(&bytes);
    const jitter = std.mem.readInt(u64, &bytes, .little) % range;
    return @intCast(half + jitter);
}

/// Credential provider - tagged union of supported providers
pub const CredentialsProvider = union(enum) {
    /// Static credentials provided directly
    static: Credentials,
    /// Load from environment variables
    environment: *const std.process.Environ.Map,
    /// Load from shared credentials file (~/.aws/credentials)
    file: FileProvider,
    /// Load from web identity token file (OIDC)
    web_identity: web_identity.WebIdentityProvider,
    /// Load from EC2 instance metadata service
    imds: ImdsProvider,
    /// Load from ECS container metadata service
    ecs: EcsProvider,
    /// Load via external process (credential_process)
    process: process.ProcessProvider,
    /// Load via STS AssumeRole with source credentials
    assume_role: assume_role.AssumeRoleProvider,
    /// Load via SSO (cached access token)
    sso: sso.SsoProvider,
    /// Load from an AWS CLI login session and refresh through AWS Sign-In.
    login: login.LoginProvider,
    /// Automatic credential chain (environment -> file -> web_identity -> ecs -> imds)
    chain: ChainProvider,

    pub const GetCredentialsError = error{
        CredentialsNotFound,
        OutOfMemory,
    } || login.Error;

    /// Retrieve credentials from this provider
    pub fn getCredentials(
        self: *CredentialsProvider,
        allocator: Allocator,
    ) GetCredentialsError!Credentials {
        return switch (self.*) {
            .static => |creds| creds,
            .environment => |env_map| getFromEnvironment(env_map),
            .file => |*f| f.load(allocator) catch return error.CredentialsNotFound,
            .web_identity => |*w| w.getCredentials(allocator) catch
                return error.CredentialsNotFound,
            .imds => |*i| i.load(allocator) catch return error.CredentialsNotFound,
            .ecs => |*e| e.load(allocator) catch return error.CredentialsNotFound,
            .process => |*p| p.getCredentials(allocator) catch return error.CredentialsNotFound,
            .assume_role => |*a| a.getCredentials(allocator) catch |err|
                return login.credentialError(err) orelse error.CredentialsNotFound,
            .sso => |*s| s.getCredentials(allocator) catch return error.CredentialsNotFound,
            .login => |*l| l.getCredentials(allocator),
            .chain => |*c| c.getCredentials(allocator),
        };
    }

    pub fn deinit(self: *CredentialsProvider) void {
        switch (self.*) {
            .imds => |*i| i.deinit(),
            .ecs => |*e| e.deinit(),
            .chain => |*c| c.deinit(),
            else => {},
        }
    }
};

/// Load credentials from environment variables
pub fn getFromEnvironment(env_map: *const std.process.Environ.Map) !Credentials {
    const access_key = env_map.get("AWS_ACCESS_KEY_ID") orelse
        return error.CredentialsNotFound;
    const secret_key = env_map.get("AWS_SECRET_ACCESS_KEY") orelse
        return error.CredentialsNotFound;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .session_token = env_map.get("AWS_SESSION_TOKEN"),
    };
}

/// IMDS-based credential provider (EC2 instance metadata)
pub const ImdsProvider = struct {
    io: std.Io,
    env_map: *const std.process.Environ.Map,
    client: ?imds.Client = null,
    endpoint: ?[]const u8 = null,

    const Self = @This();

    /// Load credentials from IMDS
    pub fn load(self: *Self, allocator: Allocator) !Credentials {
        // Initialize client if needed
        if (self.client == null) {
            self.client = try imds.Client.init(allocator, self.io, self.env_map, .{
                .endpoint = self.endpoint,
            });
        }

        var client = &self.client.?;
        var iam_creds = try client.getIamCredentials(.{});
        defer iam_creds.deinit();

        // Copy strings since iam_creds will be freed
        const access_key = try allocator.dupe(u8, iam_creds.access_key_id);
        errdefer allocator.free(access_key);

        const secret_key = try allocator.dupe(u8, iam_creds.secret_access_key);
        errdefer allocator.free(secret_key);

        const token = try allocator.dupe(u8, iam_creds.token);

        return Credentials{
            .access_key_id = access_key,
            .secret_access_key = secret_key,
            .session_token = token,
            .expiration = iam_creds.expiration,
        };
    }

    pub fn deinit(self: *Self) void {
        if (self.client) |*client| {
            client.deinit();
        }
    }
};

/// ECS container credential provider
pub const EcsProvider = struct {
    io: std.Io,
    env_map: *const std.process.Environ.Map,
    provider: ?ecs.Provider = null,

    const Self = @This();

    /// Load credentials from ECS container metadata service
    pub fn load(self: *Self, allocator: Allocator) !Credentials {
        if (self.provider == null) {
            self.provider = try ecs.Provider.init(allocator, self.io, self.env_map);
        }

        var ecs_creds = try self.provider.?.getCredentials();
        defer ecs_creds.deinit();

        // Copy strings since ecs_creds will be freed
        const access_key = try allocator.dupe(u8, ecs_creds.access_key_id);
        errdefer allocator.free(access_key);

        const secret_key = try allocator.dupe(u8, ecs_creds.secret_access_key);
        errdefer allocator.free(secret_key);

        const token = try allocator.dupe(u8, ecs_creds.token);

        return Credentials{
            .access_key_id = access_key,
            .secret_access_key = secret_key,
            .session_token = token,
            .expiration = ecs_creds.expiration,
        };
    }

    pub fn deinit(self: *Self) void {
        if (self.provider) |*p| p.deinit();
    }
};

/// File-based credential provider (~/.aws/credentials)
pub const FileProvider = struct {
    io: std.Io,
    env_map: *const std.process.Environ.Map,
    profile: ?[]const u8 = null,
    path: ?[]const u8 = null,

    const Self = @This();

    /// Load credentials from file
    pub fn load(self: *Self, allocator: Allocator) !Credentials {
        const path = try self.resolvePath(allocator);
        defer allocator.free(path);

        const content = std.Io.Dir.cwd().readFileAlloc(
            self.io,
            path,
            allocator,
            std.Io.Limit.limited(1024 * 1024),
        ) catch return error.CredentialsNotFound;
        defer allocator.free(content);

        const profile = self.resolveProfile();
        return parseCredentialsFile(allocator, content, profile);
    }

    /// Resolve credentials file path
    fn resolvePath(self: *Self, allocator: Allocator) ![]const u8 {
        // 1. Explicit path
        if (self.path) |p| {
            return try allocator.dupe(u8, p);
        }

        // 2. AWS_SHARED_CREDENTIALS_FILE environment variable
        if (self.env_map.get("AWS_SHARED_CREDENTIALS_FILE")) |p| {
            return try allocator.dupe(u8, p);
        }

        // 3. Default: ~/.aws/credentials
        const home = self.env_map.get("HOME") orelse return error.CredentialsNotFound;
        return std.fmt.allocPrint(allocator, "{s}/.aws/credentials", .{home});
    }

    /// Resolve profile name.
    ///
    /// AWS_PROFILE is resolved centrally in Config.load, which passes
    /// the result through ChainProvider.profile. This method only
    /// handles the explicit-or-default fallback.
    fn resolveProfile(self: *Self) []const u8 {
        return self.profile orelse "default";
    }
};

/// Automatic credential chain provider
///
/// Tries providers in order: environment -> file ->
/// profile_assume_role -> profile_login -> profile_sso -> profile_process ->
/// profile_web_identity -> web_identity -> ecs -> imds
pub const ChainProvider = struct {
    /// Long-lived allocator used for owning cached credential strings.
    allocator: Allocator,
    /// Io instance used by inner providers when they need to perform I/O.
    io: std.Io,
    /// Environment variables for env-based providers and HOME/AWS_PROFILE lookups.
    env_map: *const std.process.Environ.Map,
    /// Cached credentials from last successful retrieval
    cached: ?Credentials = null,
    /// Whether cached credential strings are owned by this provider.
    cached_owned: bool = false,
    /// Which provider succeeded last time (for efficiency on refresh)
    successful_provider: ?ProviderType = null,
    /// Profile for file provider
    profile: ?[]const u8 = null,
    /// Region for web identity provider in chain
    region: ?[]const u8 = null,
    /// Endpoint URL override (for LocalStack, etc.)
    endpoint_url: ?[]const u8 = null,
    /// STS regional endpoint mode
    sts_regional_endpoints: sts_common.StsRegionalEndpoints = .regional,
    /// IMDS provider (reused across calls)
    imds_provider: ?ImdsProvider = null,
    /// ECS provider (reused across calls)
    ecs_provider: ?EcsProvider = null,
    /// Web identity provider (reused across calls)
    web_identity_provider: ?web_identity.WebIdentityProvider = null,
    /// Seconds before expiration to consider credentials stale
    expiry_buffer: i64 = default_expiry_buffer,
    /// Default expiration (seconds) for permanent credentials.
    /// null = cache forever (original behavior).
    default_expiration: ?i64 = 900,
    /// Mutex for thread-safe credential caching
    mutex: std.Io.Mutex = .init,
    profile_only: bool = false,
    profile_path: ?*const ProfilePath = null,

    const Self = @This();

    const ProfilePath = struct {
        name: []const u8,
        parent: ?*const ProfilePath,
    };

    const ProviderType = enum {
        environment,
        file,
        profile_assume_role,
        profile_login,
        profile_sso,
        profile_process,
        profile_web_identity,
        web_identity,
        ecs,
        imds,
    };

    /// Get credentials, using cache if valid
    pub fn getCredentials(
        self: *Self,
        allocator: Allocator,
    ) CredentialsProvider.GetCredentialsError!Credentials {
        self.mutex.lockUncancelable(self.io);
        defer self.mutex.unlock(self.io);

        // Return cached credentials if still valid
        if (self.cached) |creds| {
            if (!creds.isExpiredWithBuffer(self.io, jitteredBuffer(self.io, self.expiry_buffer))) {
                return creds;
            }
        }

        // If we previously succeeded with a provider, try it first
        if (self.successful_provider) |provider| {
            if (self.tryProvider(allocator, provider)) |creds| {
                defer freeProviderCreds(allocator, creds, provider);
                try self.cacheCredentials(creds);
                return self.cached.?;
            } else |err| {
                if (login.credentialError(err)) |cause| return cause;
                if (err == error.ProfileCredentialsFailed) return error.CredentialsNotFound;
                // Provider failed, clear it and try the full chain
                self.successful_provider = null;
            }
        }

        // Try each provider in order
        const providers = [_]ProviderType{
            .environment,
            .file,
            .profile_assume_role,
            .profile_login,
            .profile_sso,
            .profile_process,
            .profile_web_identity,
            .web_identity,
            .ecs,
            .imds,
        };
        for (providers) |provider| {
            // A source profile must not select credentials outside that profile.
            if (self.profile_only) switch (provider) {
                .environment, .web_identity, .ecs, .imds => continue,
                else => {},
            };
            if (self.tryProvider(allocator, provider)) |creds| {
                defer freeProviderCreds(allocator, creds, provider);
                try self.cacheCredentials(creds);
                self.successful_provider = provider;
                return self.cached.?;
            } else |err| {
                if (login.credentialError(err)) |cause| return cause;
                if (err == error.ProfileCredentialsFailed) return error.CredentialsNotFound;
                // Continue to next provider
            }
        }

        return error.CredentialsNotFound;
    }

    /// Free credentials returned by a provider after they have been cached.
    /// The environment provider returns non-owned pointers (from std.posix.getenv),
    /// so those must not be freed.
    fn freeProviderCreds(allocator: Allocator, creds: Credentials, provider: ProviderType) void {
        if (provider == .environment) return;
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    /// Try a specific provider
    fn tryProvider(self: *Self, allocator: Allocator, provider: ProviderType) !Credentials {
        return switch (provider) {
            .environment => getFromEnvironment(self.env_map),
            .file => blk: {
                var fp = FileProvider{
                    .io = self.io,
                    .env_map = self.env_map,
                    .profile = self.profile,
                };
                break :blk fp.load(allocator);
            },
            .profile_assume_role => blk: {
                var cf = config_mod.loadConfigFile(allocator, self.io, self.env_map) catch
                    break :blk error.CredentialsNotFound;
                defer cf.deinit();
                const p = cf.getProfile(
                    self.profile orelse "default",
                ) orelse
                    break :blk error.CredentialsNotFound;
                const role_arn = p.role_arn orelse
                    break :blk error.CredentialsNotFound;
                const src_profile = p.source_profile orelse {
                    if (p.web_identity_token_file != null) break :blk error.CredentialsNotFound;
                    break :blk error.ProfileCredentialsFailed;
                };
                const region = self.region orelse
                    break :blk error.ProfileCredentialsFailed;
                const profile_name = self.profile orelse "default";
                var ancestor = self.profile_path;
                while (ancestor) |node| : (ancestor = node.parent) {
                    if (std.mem.eql(u8, node.name, profile_name)) {
                        break :blk error.ProfileCredentialsFailed;
                    }
                }
                const path = ProfilePath{ .name = profile_name, .parent = self.profile_path };
                var source = CredentialsProvider{
                    .chain = .{
                        .allocator = allocator,
                        .io = self.io,
                        .env_map = self.env_map,
                        .profile = src_profile,
                        .region = region,
                        .endpoint_url = self.endpoint_url,
                        .sts_regional_endpoints = self.sts_regional_endpoints,
                        .profile_only = true,
                        .profile_path = &path,
                    },
                };
                defer source.deinit();
                var ar = assume_role.AssumeRoleProvider{
                    .io = self.io,
                    .env_map = self.env_map,
                    .role_arn = role_arn,
                    .session_name = p.role_session_name orelse
                        "aws-sdk-zig",
                    .external_id = p.external_id,
                    .region = region,
                    .source_provider = &source,
                    .endpoint_url = self.endpoint_url,
                    .sts_regional_endpoints = self.sts_regional_endpoints,
                };
                break :blk ar.getCredentials(allocator) catch |err| {
                    if (login.credentialError(err)) |cause| break :blk cause;
                    break :blk error.ProfileCredentialsFailed;
                };
            },
            .profile_login => blk: {
                var cf = try config_mod.loadConfigFile(allocator, self.io, self.env_map);
                defer cf.deinit();
                const p = cf.getProfile(self.profile orelse "default") orelse
                    break :blk error.CredentialsNotFound;
                const session = p.login_session orelse break :blk error.CredentialsNotFound;
                var login_provider = login.LoginProvider{
                    .io = self.io,
                    .env_map = self.env_map,
                    .login_session = session,
                    .region = p.region orelse self.region orelse
                        break :blk error.LoginCacheInvalid,
                };
                break :blk login_provider.getCredentials(allocator);
            },
            .profile_sso => blk: {
                var cf = config_mod.loadConfigFile(allocator, self.io, self.env_map) catch
                    break :blk error.CredentialsNotFound;
                defer cf.deinit();
                const p = cf.getProfile(
                    self.profile orelse "default",
                ) orelse
                    break :blk error.CredentialsNotFound;
                const sso_session_name = p.sso_session orelse
                    break :blk error.CredentialsNotFound;
                const acct = p.sso_account_id orelse
                    break :blk error.CredentialsNotFound;
                const role = p.sso_role_name orelse
                    break :blk error.CredentialsNotFound;
                const session = cf.getSsoSession(
                    sso_session_name,
                ) orelse
                    break :blk error.CredentialsNotFound;
                const sso_region = session.sso_region orelse
                    p.sso_region orelse
                    break :blk error.CredentialsNotFound;
                var sp = sso.SsoProvider{
                    .io = self.io,
                    .env_map = self.env_map,
                    .sso_account_id = acct,
                    .sso_role_name = role,
                    .sso_region = sso_region,
                    .cache_key = sso_session_name,
                };
                break :blk sp.getCredentials(allocator);
            },
            .profile_process => blk: {
                var cf = config_mod.loadConfigFile(allocator, self.io, self.env_map) catch
                    break :blk error.CredentialsNotFound;
                defer cf.deinit();
                const p = cf.getProfile(
                    self.profile orelse "default",
                ) orelse
                    break :blk error.CredentialsNotFound;
                const command = p.credential_process orelse
                    break :blk error.CredentialsNotFound;
                var pp = process.ProcessProvider{
                    .io = self.io,
                    .command = command,
                };
                break :blk pp.getCredentials(allocator);
            },
            .profile_web_identity => blk: {
                var cf = config_mod.loadConfigFile(allocator, self.io, self.env_map) catch
                    break :blk error.CredentialsNotFound;
                defer cf.deinit();
                const p = cf.getProfile(
                    self.profile orelse "default",
                ) orelse
                    break :blk error.CredentialsNotFound;
                const token_file =
                    p.web_identity_token_file orelse
                    break :blk error.CredentialsNotFound;
                const role_arn = p.role_arn orelse
                    break :blk error.CredentialsNotFound;
                const region = self.region orelse
                    break :blk error.CredentialsNotFound;
                var wp = web_identity.WebIdentityProvider{
                    .io = self.io,
                    .env_map = self.env_map,
                    .role_arn = role_arn,
                    .token_file = token_file,
                    .session_name = p.role_session_name orelse
                        "aws-sdk-zig",
                    .region = region,
                    .endpoint_url = self.endpoint_url,
                    .sts_regional_endpoints = self.sts_regional_endpoints,
                };
                break :blk wp.getCredentials(allocator);
            },
            .web_identity => blk: {
                // Only attempt if env vars are set
                const token_file = self.env_map.get("AWS_WEB_IDENTITY_TOKEN_FILE") orelse
                    break :blk error.CredentialsNotFound;
                const role_arn = self.env_map.get("AWS_ROLE_ARN") orelse
                    break :blk error.CredentialsNotFound;
                const region = self.region orelse
                    break :blk error.CredentialsNotFound;

                if (self.web_identity_provider == null) {
                    self.web_identity_provider = web_identity.WebIdentityProvider{
                        .io = self.io,
                        .env_map = self.env_map,
                        .role_arn = role_arn,
                        .token_file = token_file,
                        .session_name = self.env_map.get("AWS_ROLE_SESSION_NAME") orelse
                            "aws-sdk-zig",
                        .region = region,
                        .endpoint_url = self.endpoint_url,
                        .sts_regional_endpoints = self.sts_regional_endpoints,
                    };
                }
                break :blk self.web_identity_provider.?.getCredentials(allocator);
            },
            .ecs => blk: {
                if (self.ecs_provider == null) {
                    self.ecs_provider = EcsProvider{
                        .io = self.io,
                        .env_map = self.env_map,
                    };
                }
                break :blk self.ecs_provider.?.load(allocator);
            },
            .imds => blk: {
                // Respect AWS_EC2_METADATA_DISABLED (matches AWS SDK behavior)
                if (self.env_map.get("AWS_EC2_METADATA_DISABLED")) |val| {
                    if (std.mem.eql(u8, val, "true")) {
                        break :blk error.CredentialsNotFound;
                    }
                }
                if (self.imds_provider == null) {
                    self.imds_provider = ImdsProvider{
                        .io = self.io,
                        .env_map = self.env_map,
                    };
                }
                break :blk self.imds_provider.?.load(allocator);
            },
        };
    }

    /// Cache credentials, stamping permanent ones with a synthetic expiration.
    fn cacheCredentials(self: *Self, creds: Credentials) !void {
        const access_key_id = try self.allocator.dupe(u8, creds.access_key_id);
        errdefer self.allocator.free(access_key_id);

        const secret_access_key = try self.allocator.dupe(u8, creds.secret_access_key);
        errdefer self.allocator.free(secret_access_key);

        const session_token = if (creds.session_token) |token|
            try self.allocator.dupe(u8, token)
        else
            null;
        errdefer if (session_token) |token| self.allocator.free(token);

        self.freeCachedCredentials();

        var cached = creds;
        cached.access_key_id = access_key_id;
        cached.secret_access_key = secret_access_key;
        cached.session_token = session_token;
        if (cached.expiration == null) {
            if (self.default_expiration) |ttl| {
                cached.expiration = std.Io.Clock.real.now(self.io).toSeconds() + ttl;
            }
        }
        self.cached = cached;
        self.cached_owned = true;
    }

    fn freeCachedCredentials(self: *Self) void {
        if (self.cached_owned) {
            if (self.cached) |cached| {
                self.allocator.free(cached.access_key_id);
                self.allocator.free(cached.secret_access_key);
                if (cached.session_token) |token| {
                    self.allocator.free(token);
                }
            }
        }
        self.cached = null;
        self.cached_owned = false;
    }

    /// Clear cached credentials (forces refresh on next call)
    pub fn clearCache(self: *Self) void {
        self.mutex.lockUncancelable(self.io);
        defer self.mutex.unlock(self.io);
        self.freeCachedCredentials();
    }

    /// Clean up resources
    pub fn deinit(self: *Self) void {
        self.mutex.lockUncancelable(self.io);
        defer self.mutex.unlock(self.io);

        self.freeCachedCredentials();

        if (self.ecs_provider) |*provider| {
            provider.deinit();
        }
        if (self.imds_provider) |*provider| {
            provider.deinit();
        }
        if (self.web_identity_provider) |*provider| {
            provider.deinit(self.allocator);
        }
    }
};

/// Parse AWS credentials file content and extract credentials for profile
fn parseCredentialsFile(
    allocator: Allocator,
    content: []const u8,
    profile: []const u8,
) !Credentials {
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
            if (std.mem.findScalar(u8, trimmed, '=')) |eq_idx| {
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

    const ak_owned = try allocator.dupe(u8, ak);
    errdefer allocator.free(ak_owned);
    const sk_owned = try allocator.dupe(u8, sk);
    errdefer allocator.free(sk_owned);
    const token_owned = if (session_token) |t|
        try allocator.dupe(u8, t)
    else
        null;

    return Credentials{
        .access_key_id = ak_owned,
        .secret_access_key = sk_owned,
        .session_token = token_owned,
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
    try std.testing.expect(expired.isExpired(std.testing.io));

    const valid = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .expiration = std.Io.Clock.real.now(std.testing.io).toSeconds() + 3600,
    };
    try std.testing.expect(!valid.isExpired(std.testing.io));

    const permanent = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };
    try std.testing.expect(!permanent.isExpired(std.testing.io));
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

    const creds = try parseCredentialsFile(std.testing.allocator, content, "default");
    defer std.testing.allocator.free(creds.access_key_id);
    defer std.testing.allocator.free(creds.secret_access_key);
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

    const creds = try parseCredentialsFile(std.testing.allocator, content, "dev");
    defer std.testing.allocator.free(creds.access_key_id);
    defer std.testing.allocator.free(creds.secret_access_key);
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

    const creds = try parseCredentialsFile(std.testing.allocator, content, "default");
    defer std.testing.allocator.free(creds.access_key_id);
    defer std.testing.allocator.free(creds.secret_access_key);
    defer if (creds.session_token) |t| std.testing.allocator.free(t);
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

    const result = parseCredentialsFile(std.testing.allocator, content, "nonexistent");
    try std.testing.expectError(error.CredentialsNotFound, result);
}

test "parseCredentialsFile missing secret key" {
    const content =
        \\[default]
        \\aws_access_key_id = AKIAIOSFODNN7EXAMPLE
    ;

    const result = parseCredentialsFile(std.testing.allocator, content, "default");
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

    const creds = try parseCredentialsFile(std.testing.allocator, content, "default");
    defer std.testing.allocator.free(creds.access_key_id);
    defer std.testing.allocator.free(creds.secret_access_key);
    try std.testing.expectEqualStrings("AKIAIOSFODNN7EXAMPLE", creds.access_key_id);
    try std.testing.expectEqualStrings("wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY", creds.secret_access_key);
}

test "parseCredentialsFile returns owned strings surviving source free" {
    const allocator = std.testing.allocator;

    // Simulate FileProvider.load: read into a buffer, parse, free buffer.
    const source = try allocator.dupe(u8,
        \\[default]
        \\aws_access_key_id = AKIAOWNEDTEST
        \\aws_secret_access_key = OwnedSecretKey
    );

    const creds = try parseCredentialsFile(allocator, source, "default");
    defer allocator.free(creds.access_key_id);
    defer allocator.free(creds.secret_access_key);

    // Free the source buffer -- the strings must survive.
    allocator.free(source);

    try std.testing.expectEqualStrings("AKIAOWNEDTEST", creds.access_key_id);
    try std.testing.expectEqualStrings("OwnedSecretKey", creds.secret_access_key);
}

test "chain provider caches credentials" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{ .allocator = std.testing.allocator, .io = std.testing.io, .env_map = &env_map };
    defer chain.deinit();

    // Manually set cached credentials
    chain.cached = Credentials{
        .access_key_id = "CACHED_KEY",
        .secret_access_key = "CACHED_SECRET",
        .expiration = std.Io.Clock.real.now(std.testing.io).toSeconds() + 3600, // Valid for 1 hour
    };

    const creds = try chain.getCredentials(std.testing.allocator);
    try std.testing.expectEqualStrings("CACHED_KEY", creds.access_key_id);
}

test "chain provider clear cache" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{ .allocator = std.testing.allocator, .io = std.testing.io, .env_map = &env_map };
    defer chain.deinit();

    chain.cached = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
    };

    try std.testing.expect(chain.cached != null);
    chain.clearCache();
    try std.testing.expect(chain.cached == null);
}

test "profile_assume_role skips when profile lacks role_arn" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .profile = "no-such-profile",
        .region = "us-east-1",
    };
    const result = chain.tryProvider(
        std.testing.allocator,
        .profile_assume_role,
    );
    try std.testing.expectError(
        error.CredentialsNotFound,
        result,
    );
}

test "profile_process skips when profile lacks credential_process" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .profile = "no-such-profile",
        .region = "us-east-1",
    };
    const result = chain.tryProvider(
        std.testing.allocator,
        .profile_process,
    );
    try std.testing.expectError(
        error.CredentialsNotFound,
        result,
    );
}

test "profile_sso skips when profile lacks sso_session" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .profile = "no-such-profile",
        .region = "us-east-1",
    };
    const result = chain.tryProvider(
        std.testing.allocator,
        .profile_sso,
    );
    try std.testing.expectError(
        error.CredentialsNotFound,
        result,
    );
}

test "chain assumes role from process, file, login, and role source profiles" {
    if (@import("builtin").os.tag == .windows) return error.SkipZigTest;

    const allocator = std.testing.allocator;
    const role_config =
        \\[profile development-auto]
        \\region = us-west-2
        \\role_arn = arn:aws:iam::111111111111:role/automation/infra-automation
        \\role_session_name = joseph.wright
        \\external_id = test-external-id
        \\source_profile = infra
    ;
    const file_credentials =
        \\[infra]
        \\aws_access_key_id = SOURCE
        \\aws_secret_access_key = secret
        \\aws_session_token = source-token
    ;
    const cases = [_]struct {
        config: []const u8,
        credentials: []const u8 = "",
        signing_keys: []const []const u8,
        login_cache: bool = false,
    }{
        .{
            .config = role_config ++ "\n[profile infra]\ncredential_process = echo '" ++
                "{\"Version\":1,\"AccessKeyId\":\"SOURCE\",\"SecretAccessKey\":\"secret\"," ++
                "\"SessionToken\":\"source-token\"}'\n",
            .signing_keys = &.{"SOURCE"},
        },
        .{
            .config = role_config,
            .credentials = file_credentials,
            .signing_keys = &.{"SOURCE"},
        },
        .{
            .config = role_config ++ "\n[profile infra]\n" ++
                "login_session = arn:aws:iam::111111111111:user/test\n",
            .signing_keys = &.{"SOURCE"},
            .login_cache = true,
        },
        .{
            .config = role_config ++ "\n" ++
                \\[profile infra]
                \\role_arn = arn:aws:iam::111111111111:role/Intermediate
                \\source_profile = base
            ,
            .credentials =
            \\[base]
            \\aws_access_key_id = SOURCE
            \\aws_secret_access_key = secret
            \\aws_session_token = source-token
            ,
            .signing_keys = &.{ "SOURCE", "ASSUMED" },
        },
    };
    for (cases) |case| {
        var tmp = std.testing.tmpDir(.{});
        defer tmp.cleanup();
        try tmp.dir.writeFile(std.testing.io, .{ .sub_path = "config", .data = case.config });
        try tmp.dir.writeFile(std.testing.io, .{
            .sub_path = "credentials",
            .data = case.credentials,
        });

        var config_path: [std.fs.max_path_bytes]u8 = undefined;
        var env_map: std.process.Environ.Map = .init(allocator);
        defer env_map.deinit();
        try env_map.put("AWS_CONFIG_FILE", try std.fmt.bufPrint(
            &config_path,
            ".zig-cache/tmp/{s}/config",
            .{tmp.sub_path},
        ));
        var credentials_path: [std.fs.max_path_bytes]u8 = undefined;
        try env_map.put("AWS_SHARED_CREDENTIALS_FILE", try std.fmt.bufPrint(
            &credentials_path,
            ".zig-cache/tmp/{s}/credentials",
            .{tmp.sub_path},
        ));
        try env_map.put("AWS_PROFILE", "development-auto");
        try env_map.put("AWS_EC2_METADATA_DISABLED", "true");
        if (case.login_cache) {
            var hash: [32]u8 = undefined;
            std.crypto.hash.sha2.Sha256.hash("arn:aws:iam::111111111111:user/test", &hash, .{});
            try tmp.dir.writeFile(std.testing.io, .{
                .sub_path = std.fmt.bytesToHex(hash, .lower) ++ ".json",
                .data =
                \\{"accessToken":{"accessKeyId":"SOURCE","secretAccessKey":"secret",
                \\"sessionToken":"source-token","accountId":"111111111111",
                \\"expiresAt":"2099-01-01T00:00:00Z"},"clientId":"test-client",
                \\"refreshToken":"test-refresh-token","dpopKey":"test-key"}
                ,
            });
            var cache_path: [std.fs.max_path_bytes]u8 = undefined;
            try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", try std.fmt.bufPrint(
                &cache_path,
                ".zig-cache/tmp/{s}",
                .{tmp.sub_path},
            ));
        }

        var server = try ProfileTestServer.init();
        server.request_count = case.signing_keys.len;
        defer server.server.deinit(std.testing.io);
        var group: std.Io.Group = .init;
        defer group.cancel(std.testing.io);
        try group.concurrent(std.testing.io, ProfileTestServer.run, .{&server});

        var endpoint_buf: [64]u8 = undefined;
        const endpoint = try std.fmt.bufPrint(
            &endpoint_buf,
            "http://127.0.0.1:{d}",
            .{server.server.socket.address.getPort()},
        );
        var cfg = try config_mod.Config.load(allocator, std.testing.io, &env_map, .{
            .endpoint_url = endpoint,
        });
        defer cfg.deinit();
        // Credential providers make their own STS requests.
        cfg.credentials.chain.endpoint_url = endpoint;

        const creds = try cfg.credentials.getCredentials(allocator);
        try std.testing.expectEqualStrings("ASSUMED", creds.access_key_id);
        try std.testing.expectEqualStrings("assumed-secret", creds.secret_access_key);
        try std.testing.expectEqualStrings("assumed-token", creds.session_token.?);
        try std.testing.expect(creds.expiration != null);
        try group.await(std.testing.io);
        for (case.signing_keys, 0..) |signing_key, index| {
            var signing_buf: [64]u8 = undefined;
            const expected = try std.fmt.bufPrint(&signing_buf, "Credential={s}/", .{signing_key});
            try std.testing.expect(
                std.mem.find(u8, server.requests[index].bytes(), expected) != null,
            );
        }
        try std.testing.expect(
            std.mem.find(u8, server.requests[0].bytes(), "source-token") != null,
        );
        const request = server.requests[case.signing_keys.len - 1].bytes();
        try std.testing.expect(std.mem.find(u8, request, "Action=AssumeRole&") != null);
        try std.testing.expect(std.mem.find(u8, request, "RoleSessionName=joseph.wright") != null);
        try std.testing.expect(std.mem.find(u8, request, "ExternalId=test-external-id") != null);
        try std.testing.expect(std.mem.find(
            u8,
            request,
            "RoleArn=arn%3Aaws%3Aiam%3A%3A111111111111%3Arole%2Fautomation%2Finfra-automation",
        ) != null);
        try std.testing.expect(cfg.credentials.chain.imds_provider == null);
        try std.testing.expectEqualStrings(
            "ASSUMED",
            (try cfg.credentials.getCredentials(allocator)).access_key_id,
        );

        try tmp.dir.writeFile(std.testing.io, .{
            .sub_path = "config",
            .data = "[profile development-auto]\nrole_arn = test-role\nsource_profile = missing\n",
        });
        cfg.credentials.chain.clearCache();
        try std.testing.expectError(
            error.CredentialsNotFound,
            cfg.credentials.getCredentials(allocator),
        );
        try std.testing.expect(cfg.credentials.chain.ecs_provider == null);
        try std.testing.expect(cfg.credentials.chain.imds_provider == null);
    }
}

test "chain stops after a configured role fails" {
    const allocator = std.testing.allocator;
    const cases = [_][]const u8{
        "[profile development-auto]\nrole_arn = test-role\nsource_profile = missing\n",
        "[profile development-auto]\nrole_arn = test-role\nsource_profile = development-auto\n",
        "[profile development-auto]\nrole_arn = test-role\nsource_profile = infra\n" ++
            "[profile infra]\nrole_arn = other-role\nsource_profile = development-auto\n",
        "[profile development-auto]\nrole_arn = test-role\nsource_profile = infra\n" ++
            "[profile infra]\nsso_session = absent\n",
    };
    for (cases) |content| {
        var tmp = std.testing.tmpDir(.{});
        defer tmp.cleanup();
        try tmp.dir.writeFile(std.testing.io, .{
            .sub_path = "config",
            .data = content,
        });
        var config_path: [std.fs.max_path_bytes]u8 = undefined;
        var env_map: std.process.Environ.Map = .init(allocator);
        defer env_map.deinit();
        try env_map.put("AWS_CONFIG_FILE", try std.fmt.bufPrint(
            &config_path,
            ".zig-cache/tmp/{s}/config",
            .{tmp.sub_path},
        ));
        try env_map.put("AWS_EC2_METADATA_DISABLED", "true");
        var chain = ChainProvider{
            .allocator = allocator,
            .io = std.testing.io,
            .env_map = &env_map,
            .profile = "development-auto",
            .region = "us-west-2",
        };
        defer chain.deinit();

        try std.testing.expectError(error.CredentialsNotFound, chain.getCredentials(allocator));
        try std.testing.expect(chain.ecs_provider == null);
        try std.testing.expect(chain.imds_provider == null);
    }
}

const ProfileTestServer = struct {
    server: std.Io.net.Server,
    request_count: usize = 1,
    requests: [2]CapturedRequest = .{ .{}, .{} },

    const CapturedRequest = struct {
        buffer: [8192]u8 = undefined,
        len: usize = 0,

        fn bytes(self: *const CapturedRequest) []const u8 {
            return self.buffer[0..self.len];
        }
    };

    fn init() !ProfileTestServer {
        const address = try std.Io.net.IpAddress.parseIp4("127.0.0.1", 0);
        return .{ .server = try address.listen(std.testing.io, .{}) };
    }

    fn run(self: *ProfileTestServer) void {
        for (self.requests[0..self.request_count]) |*request| self.respond(request);
    }

    fn respond(self: *ProfileTestServer, request: *CapturedRequest) void {
        var stream = self.server.accept(std.testing.io) catch return;
        defer stream.close(std.testing.io);
        var read_buf: [8192]u8 = undefined;
        var reader = stream.reader(std.testing.io, &read_buf);
        var content_length: usize = 0;
        while (true) {
            const line = reader.interface.takeDelimiterInclusive('\n') catch return;
            if (request.len + line.len > request.buffer.len) return;
            @memcpy(request.buffer[request.len..][0..line.len], line);
            request.len += line.len;
            const prefix = "content-length:";
            if (std.ascii.startsWithIgnoreCase(line, prefix)) {
                content_length = std.fmt.parseInt(
                    usize,
                    std.mem.trim(u8, line[prefix.len..], " \r\n"),
                    10,
                ) catch return;
            }
            if (std.mem.eql(u8, line, "\r\n")) break;
        }
        if (request.len + content_length > request.buffer.len) return;
        reader.interface.readSliceAll(
            request.buffer[request.len..][0..content_length],
        ) catch return;
        request.len += content_length;

        const body =
            "<AssumeRoleResponse><AssumeRoleResult><Credentials>" ++
            "<AccessKeyId>ASSUMED</AccessKeyId>" ++
            "<SecretAccessKey>assumed-secret</SecretAccessKey>" ++
            "<SessionToken>assumed-token</SessionToken>" ++
            "<Expiration>2099-01-01T00:00:00Z</Expiration>" ++
            "</Credentials></AssumeRoleResult></AssumeRoleResponse>";
        var write_buf: [1024]u8 = undefined;
        var writer = stream.writer(std.testing.io, &write_buf);
        writer.interface.print(
            "HTTP/1.1 200 OK\r\nContent-Length: {d}\r\nConnection: close\r\n\r\n{s}",
            .{ body.len, body },
        ) catch return;
        writer.interface.flush() catch {};
    }
};

test "chain preserves login errors from direct and source profiles" {
    const allocator = std.testing.allocator;
    var tmp = std.testing.tmpDir(.{});
    defer tmp.cleanup();
    try tmp.dir.writeFile(std.testing.io, .{
        .sub_path = "config",
        .data =
        \\[profile development-auto]
        \\role_arn = arn:aws:iam::111111111111:role/Automation
        \\source_profile = infra
        \\[profile infra]
        \\login_session = test-session
        ,
    });
    var config_buf: [std.fs.max_path_bytes]u8 = undefined;
    var cache_buf: [std.fs.max_path_bytes]u8 = undefined;
    var env_map: std.process.Environ.Map = .init(allocator);
    defer env_map.deinit();
    try env_map.put("AWS_CONFIG_FILE", try std.fmt.bufPrint(
        &config_buf,
        ".zig-cache/tmp/{s}/config",
        .{tmp.sub_path},
    ));
    try env_map.put("AWS_LOGIN_CACHE_DIRECTORY", try std.fmt.bufPrint(
        &cache_buf,
        ".zig-cache/tmp/{s}",
        .{tmp.sub_path},
    ));
    for ([_][]const u8{ "development-auto", "infra" }) |profile| {
        var provider = CredentialsProvider{
            .chain = .{
                .allocator = allocator,
                .io = std.testing.io,
                .env_map = &env_map,
                .profile = profile,
                .region = "us-west-2",
            },
        };
        defer provider.deinit();
        try std.testing.expectError(error.LoginCacheNotFound, provider.getCredentials(allocator));
        try std.testing.expect(provider.chain.ecs_provider == null);
        try std.testing.expect(provider.chain.imds_provider == null);
    }
}

test "jitteredBuffer returns values in [buffer/2, buffer]" {
    const buffer: i64 = 300;
    const half = @divTrunc(buffer, 2);
    for (0..100) |_| {
        const result = jitteredBuffer(std.testing.io, buffer);
        try std.testing.expect(result >= half);
        try std.testing.expect(result <= buffer);
    }
}

test "jitteredBuffer edge cases" {
    try std.testing.expectEqual(@as(i64, 0), jitteredBuffer(std.testing.io, 0));
    try std.testing.expectEqual(@as(i64, 1), jitteredBuffer(std.testing.io, 1));
}

test "isExpiredWithBuffer with custom buffer" {
    const now = std.Io.Clock.real.now(std.testing.io).toSeconds();
    const creds = Credentials{
        .access_key_id = "test",
        .secret_access_key = "test",
        .expiration = now + 100,
    };
    // With a 200-second buffer, should be expired
    try std.testing.expect(creds.isExpiredWithBuffer(std.testing.io, 200));
    // With a 50-second buffer, should not be expired
    try std.testing.expect(!creds.isExpiredWithBuffer(std.testing.io, 50));
}

test "cacheCredentials stamps permanent credentials with synthetic expiration" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .default_expiration = 900,
    };
    defer chain.deinit();
    const creds = Credentials{
        .access_key_id = "PERM_KEY",
        .secret_access_key = "PERM_SECRET",
    };
    try chain.cacheCredentials(creds);
    // Cached copy should have an expiration set
    try std.testing.expect(chain.cached.?.expiration != null);
    const exp = chain.cached.?.expiration.?;
    const now = std.Io.Clock.real.now(std.testing.io).toSeconds();
    // Should be roughly now + 900 (allow 5 second tolerance)
    try std.testing.expect(exp >= now + 895);
    try std.testing.expect(exp <= now + 905);
}

test "cacheCredentials leaves already-expiring credentials unchanged" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .default_expiration = 900,
    };
    defer chain.deinit();
    const now = std.Io.Clock.real.now(std.testing.io).toSeconds();
    const original_exp = now + 3600;
    const creds = Credentials{
        .access_key_id = "TEMP_KEY",
        .secret_access_key = "TEMP_SECRET",
        .expiration = original_exp,
    };
    try chain.cacheCredentials(creds);
    try std.testing.expectEqual(original_exp, chain.cached.?.expiration.?);
}

test "multi-threaded getCredentials does not crash" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{
        .io = std.testing.io,
        .env_map = &env_map,
        .allocator = std.testing.allocator,
        .default_expiration = null,
    };
    // Pre-populate cache so threads don't hit real providers
    chain.cached = Credentials{
        .access_key_id = "MT_KEY",
        .secret_access_key = "MT_SECRET",
        .expiration = std.Io.Clock.real.now(std.testing.io).toSeconds() + 3600,
    };

    const Thread = std.Thread;
    const num_threads = 4;
    var threads: [num_threads]Thread = undefined;
    for (&threads) |*t| {
        t.* = try Thread.spawn(.{}, struct {
            fn run(c: *ChainProvider) void {
                for (0..50) |_| {
                    const creds = c.getCredentials(std.testing.allocator) catch return;
                    std.testing.expectEqualStrings("MT_KEY", creds.access_key_id) catch return;
                }
            }
        }.run, .{&chain});
    }
    for (&threads) |*t| {
        t.join();
    }
    // If we got here without crashing, the mutex is working
    try std.testing.expect(chain.cached != null);
}

test "cacheCredentials owns cached strings beyond source allocator lifetime" {
    var env_map: std.process.Environ.Map = .init(std.testing.allocator);
    defer env_map.deinit();
    var chain = ChainProvider{ .allocator = std.testing.allocator, .io = std.testing.io, .env_map = &env_map };
    defer chain.deinit();

    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    const arena_allocator = arena.allocator();

    const source_access_key = try arena_allocator.dupe(u8, "ARENA_ACCESS_KEY");
    const source_secret_key = try arena_allocator.dupe(u8, "ARENA_SECRET_KEY");
    const source_token = try arena_allocator.dupe(u8, "ARENA_TOKEN");

    const source_creds = Credentials{
        .access_key_id = source_access_key,
        .secret_access_key = source_secret_key,
        .session_token = source_token,
        .expiration = std.Io.Clock.real.now(std.testing.io).toSeconds() + 3600,
    };

    try chain.cacheCredentials(source_creds);
    arena.deinit();

    const cached = try chain.getCredentials(std.testing.allocator);
    try std.testing.expectEqualStrings("ARENA_ACCESS_KEY", cached.access_key_id);
    try std.testing.expectEqualStrings("ARENA_SECRET_KEY", cached.secret_access_key);
    try std.testing.expectEqualStrings("ARENA_TOKEN", cached.session_token.?);
}
