const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

/// Associates an Identity and Access Management (IAM) role with an Certificate
/// Manager (ACM) certificate.
/// This enables the certificate to be used by the ACM for Nitro Enclaves
/// application inside an enclave. For more
/// information, see [Certificate Manager for Nitro
/// Enclaves](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave-refapp.html) in the *Amazon Web Services Nitro Enclaves
/// User Guide*.
///
/// When the IAM role is associated with the ACM certificate, the certificate,
/// certificate chain, and encrypted
/// private key are placed in an Amazon S3 location that only the associated IAM
/// role can access. The private key of the certificate
/// is encrypted with an Amazon Web Services managed key that has an attached
/// attestation-based key policy.
///
/// To enable the IAM role to access the Amazon S3 object, you must grant it
/// permission to call `s3:GetObject`
/// on the Amazon S3 bucket returned by the command. To enable the IAM role to
/// access the KMS key,
/// you must grant it permission to call `kms:Decrypt` on the KMS key returned
/// by the command.
/// For more information, see [
/// Grant the role permission to access the certificate and encryption
/// key](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave-refapp.html#add-policy) in the
/// *Amazon Web Services Nitro Enclaves User Guide*.
pub const AssociateEnclaveCertificateIamRoleInput = struct {
    /// The ARN of the ACM certificate with which to associate the IAM role.
    certificate_arn: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ARN of the IAM role to associate with the ACM certificate. You can
    /// associate up to 16 IAM roles with an ACM
    /// certificate.
    role_arn: []const u8,
};

pub const AssociateEnclaveCertificateIamRoleOutput = struct {
    /// The name of the Amazon S3 bucket to which the certificate was uploaded.
    certificate_s_3_bucket_name: ?[]const u8 = null,

    /// The Amazon S3 object key where the certificate, certificate chain, and
    /// encrypted private key bundle are stored. The
    /// object key is formatted as follows: `role_arn`/`certificate_arn`.
    certificate_s_3_object_key: ?[]const u8 = null,

    /// The ID of the KMS key used to encrypt the private key of the certificate.
    encryption_kms_key_id: ?[]const u8 = null,

    allocator: std.mem.Allocator,

    pub fn deinit(self: *const AssociateEnclaveCertificateIamRoleOutput) void {
        if (self.certificate_s_3_bucket_name) |v| {
            self.allocator.free(v);
        }
        if (self.certificate_s_3_object_key) |v| {
            self.allocator.free(v);
        }
        if (self.encryption_kms_key_id) |v| {
            self.allocator.free(v);
        }
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: AssociateEnclaveCertificateIamRoleInput, options: Options) !AssociateEnclaveCertificateIamRoleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    return try deserializeResponse(response.body, response.status, client.allocator);
}

fn serializeRequest(alloc: std.mem.Allocator, input: AssociateEnclaveCertificateIamRoleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=AssociateEnclaveCertificateIamRole&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&CertificateArn=");
    try appendUrlEncoded(alloc, &body_buf, input.certificate_arn);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&RoleArn=");
    try appendUrlEncoded(alloc, &body_buf, input.role_arn);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !AssociateEnclaveCertificateIamRoleOutput {
    _ = status;
    var result: AssociateEnclaveCertificateIamRoleOutput = .{ .allocator = alloc };
    if (findElement(body, "certificateS3BucketName")) |content| {
        result.certificate_s_3_bucket_name = try alloc.dupe(u8, content);
    }
    if (findElement(body, "certificateS3ObjectKey")) |content| {
        result.certificate_s_3_object_key = try alloc.dupe(u8, content);
    }
    if (findElement(body, "encryptionKmsKeyId")) |content| {
        result.encryption_kms_key_id = try alloc.dupe(u8, content);
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
