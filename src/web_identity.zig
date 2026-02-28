//! Web Identity Token Provider (OIDC)
//!
//! Obtains AWS credentials by exchanging a web identity token (JWT) for
//! temporary STS credentials via AssumeRoleWithWebIdentity.
//! Used by Lambda (IAM roles), EKS (IRSA), and GitHub Actions OIDC.

const std = @import("std");
const Allocator = std.mem.Allocator;

const Credentials = @import("credentials.zig").Credentials;
const sts_common = @import("sts_common.zig");

pub const WebIdentityProvider = struct {
    role_arn: []const u8,
    token_file: []const u8,
    session_name: []const u8,
    region: []const u8,
    endpoint_url: ?[]const u8 = null,
    sts_regional_endpoints: sts_common.StsRegionalEndpoints = .regional,
    cached: ?Credentials = null,

    const Self = @This();

    pub fn getCredentials(self: *Self, allocator: Allocator) !Credentials {
        if (self.cached) |c| if (!c.isExpired()) return c;

        // Re-read token file each time (tokens rotate on EKS/Lambda)
        const token = std.fs.cwd().readFileAlloc(allocator, self.token_file, 64 * 1024) catch
            return error.WebIdentityTokenFileNotFound;
        defer allocator.free(token);

        // Trim whitespace from token
        const trimmed_token = std.mem.trim(u8, token, " \t\r\n");

        const endpoint = try sts_common.stsEndpoint(
            allocator,
            self.region,
            self.endpoint_url,
            self.sts_regional_endpoints,
        );
        defer allocator.free(endpoint);

        const body = try sts_common.buildStsRequestBody(allocator, "AssumeRoleWithWebIdentity", &.{
            .{ "RoleArn", self.role_arn },
            .{ "RoleSessionName", self.session_name },
            .{ "WebIdentityToken", trimmed_token },
        });
        defer allocator.free(body);

        const response = try sts_common.callStsUnsigned(allocator, endpoint, body);
        defer allocator.free(response);

        const creds = try sts_common.parseStsCredentials(allocator, response);
        self.cached = creds;
        return creds;
    }
};

test "WebIdentityProvider struct initialization" {
    var provider = WebIdentityProvider{
        .role_arn = "arn:aws:iam::123456789012:role/TestRole",
        .token_file = "/tmp/token",
        .session_name = "test-session",
        .region = "us-east-1",
    };

    try std.testing.expect(provider.cached == null);
    try std.testing.expectEqualStrings("arn:aws:iam::123456789012:role/TestRole", provider.role_arn);
    _ = &provider;
}
