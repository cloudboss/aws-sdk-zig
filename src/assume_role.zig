//! Assume Role Credentials Provider
//!
//! Assumes an IAM role using credentials from another provider.
//! Uses SigV4-signed STS AssumeRole call.

const std = @import("std");
const Allocator = std.mem.Allocator;

const credentials_mod = @import("credentials.zig");
const Credentials = credentials_mod.Credentials;
const CredentialsProvider = credentials_mod.CredentialsProvider;
const sts_common = @import("sts_common.zig");

pub const AssumeRoleProvider = struct {
    role_arn: []const u8,
    session_name: []const u8,
    external_id: ?[]const u8,
    region: []const u8,
    source_provider: *CredentialsProvider,
    endpoint_url: ?[]const u8 = null,
    cached: ?Credentials = null,

    const Self = @This();

    pub fn getCredentials(self: *Self, allocator: Allocator) !Credentials {
        if (self.cached) |c| if (!c.isExpired()) return c;

        const source_creds = try self.source_provider.getCredentials(allocator);

        const endpoint = try sts_common.stsEndpoint(allocator, self.region, self.endpoint_url);
        defer allocator.free(endpoint);

        var params: [3][2][]const u8 = undefined;
        var param_count: usize = 0;

        params[param_count] = .{ "RoleArn", self.role_arn };
        param_count += 1;
        params[param_count] = .{ "RoleSessionName", self.session_name };
        param_count += 1;
        if (self.external_id) |eid| {
            params[param_count] = .{ "ExternalId", eid };
            param_count += 1;
        }

        const body = try sts_common.buildStsRequestBody(allocator, "AssumeRole", params[0..param_count]);
        defer allocator.free(body);

        const response = try sts_common.callStsSigned(allocator, endpoint, body, source_creds, self.region);
        defer allocator.free(response);

        const creds = try sts_common.parseStsCredentials(allocator, response);
        self.cached = creds;
        return creds;
    }
};

test "AssumeRoleProvider struct initialization" {
    var source = CredentialsProvider{
        .static = .{
            .access_key_id = "AKIAIOSFODNN7EXAMPLE",
            .secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        },
    };

    var provider = AssumeRoleProvider{
        .role_arn = "arn:aws:iam::123456789012:role/TestRole",
        .session_name = "test-session",
        .external_id = "my-external-id",
        .region = "us-east-1",
        .source_provider = &source,
    };

    try std.testing.expect(provider.cached == null);
    try std.testing.expectEqualStrings("my-external-id", provider.external_id.?);
    _ = &provider;
}

test "AssumeRoleProvider without external_id" {
    var source = CredentialsProvider{
        .static = .{
            .access_key_id = "AKIAIOSFODNN7EXAMPLE",
            .secret_access_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY",
        },
    };

    var provider = AssumeRoleProvider{
        .role_arn = "arn:aws:iam::123456789012:role/TestRole",
        .session_name = "test-session",
        .external_id = null,
        .region = "us-east-1",
        .source_provider = &source,
    };

    try std.testing.expect(provider.external_id == null);
    _ = &provider;
}
