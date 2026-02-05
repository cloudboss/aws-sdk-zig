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
    // Future: imds, ecs, etc.

    /// Retrieve credentials from this provider
    pub fn getCredentials(self: *CredentialsProvider, allocator: Allocator) !Credentials {
        return switch (self.*) {
            .static => |creds| creds,
            .environment => getFromEnvironment(),
            .file => |*f| try f.load(allocator),
        };
    }
};

/// Load credentials from environment variables
fn getFromEnvironment() !Credentials {
    const access_key = std.posix.getenv("AWS_ACCESS_KEY_ID") orelse
        return error.CredentialsError;
    const secret_key = std.posix.getenv("AWS_SECRET_ACCESS_KEY") orelse
        return error.CredentialsError;

    return Credentials{
        .access_key_id = access_key,
        .secret_access_key = secret_key,
        .session_token = std.posix.getenv("AWS_SESSION_TOKEN"),
    };
}

/// File-based credential provider
pub const FileProvider = struct {
    profile: []const u8 = "default",
    path: ?[]const u8 = null, // null = use default ~/.aws/credentials

    pub fn load(self: *FileProvider, allocator: Allocator) !Credentials {
        _ = self;
        _ = allocator;
        // TODO: Implement INI file parsing
        return error.CredentialsError;
    }
};

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
