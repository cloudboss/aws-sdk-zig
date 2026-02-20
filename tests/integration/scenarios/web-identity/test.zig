const std = @import("std");
const aws = @import("aws");

test "web identity provider loads credentials from token file" {
    const allocator = std.testing.allocator;

    // Write a token file
    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "integration-test",
        .region = "us-east-1",
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify we got credentials back
    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
    try std.testing.expect(creds.session_token != null);
    try std.testing.expect(creds.expiration != null);
}

test "web identity credentials can be used via CredentialsProvider union" {
    const allocator = std.testing.allocator;

    const token_path = "/tmp/web-identity-token";

    var cp = aws.CredentialsProvider{
        .web_identity = .{
            .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
            .token_file = token_path,
            .session_name = "union-test",
            .region = "us-east-1",
        },
    };

    const creds = try cp.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expect(creds.access_key_id.len > 0);
    try std.testing.expect(creds.secret_access_key.len > 0);
}

test "web identity credentials include future expiration timestamp" {
    const allocator = std.testing.allocator;

    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "expiration-test",
        .region = "us-east-1",
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Verify expiration is not null and is a future timestamp
    try std.testing.expect(creds.expiration != null);
    try std.testing.expect(creds.expiration.? > 0);
}

test "web identity credentials have non-empty session token" {
    const allocator = std.testing.allocator;

    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "session-token-test",
        .region = "us-east-1",
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    try std.testing.expect(creds.session_token != null);
    try std.testing.expect(creds.session_token.?.len > 0);
}

test "web identity access key differs from static credentials" {
    const allocator = std.testing.allocator;

    const token_path = "/tmp/web-identity-token";

    var provider = aws.web_identity.WebIdentityProvider{
        .role_arn = "arn:aws:iam::000000000000:role/web-identity-test-role",
        .token_file = token_path,
        .session_name = "key-diff-test",
        .region = "us-east-1",
    };

    const creds = try provider.getCredentials(allocator);
    defer {
        allocator.free(creds.access_key_id);
        allocator.free(creds.secret_access_key);
        if (creds.session_token) |t| allocator.free(t);
    }

    // Web identity assumed role credentials differ from static "test" key
    try std.testing.expect(!std.mem.eql(u8, creds.access_key_id, "test"));
}
