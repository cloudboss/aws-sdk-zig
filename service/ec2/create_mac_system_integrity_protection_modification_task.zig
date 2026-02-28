const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MacSystemIntegrityProtectionConfigurationRequest = @import("mac_system_integrity_protection_configuration_request.zig").MacSystemIntegrityProtectionConfigurationRequest;
const MacSystemIntegrityProtectionSettingStatus = @import("mac_system_integrity_protection_setting_status.zig").MacSystemIntegrityProtectionSettingStatus;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const MacModificationTask = @import("mac_modification_task.zig").MacModificationTask;
const serde = @import("serde.zig");

pub const CreateMacSystemIntegrityProtectionModificationTaskInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information, see [Ensuring
    /// Idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request, and provides an error response. If you have the
    /// required permissions, the error response is `DryRunOperation`. Otherwise, it
    /// is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The ID of the Amazon EC2 Mac instance.
    instance_id: []const u8,

    /// **[Apple silicon Mac instances only]** Specifies the
    /// following credentials:
    ///
    /// * **Internal disk administrative user**
    ///
    /// * **Username** - Only the default administrative
    /// user (`aws-managed-user`) is supported and it is used by default. You
    /// can't specify a different administrative user.
    ///
    /// * **Password** - If you did not change the default
    /// password for `aws-managed-user`, specify the default password, which
    /// is *blank*. Otherwise, specify your password.
    ///
    /// * **Amazon EBS root volume administrative user**
    ///
    /// * **Username** - If you did not change the default
    /// administrative user, specify `ec2-user`. Otherwise, specify the username
    /// for your administrative user.
    ///
    /// * **Password** - Specify the password for the
    /// administrative user.
    ///
    /// The credentials must be specified in the following JSON format:
    ///
    /// `{
    /// "internalDiskPassword":"*internal-disk-admin_password*",
    /// "rootVolumeUsername":"*root-volume-admin_username*",
    /// "rootVolumepassword":"*root-volume-admin_password*"
    /// }`
    mac_credentials: ?[]const u8 = null,

    /// Specifies the overrides to selectively enable or disable individual SIP
    /// settings.
    /// The individual settings you specify here override the overall SIP status you
    /// specify
    /// for **MacSystemIntegrityProtectionStatus**.
    mac_system_integrity_protection_configuration: ?MacSystemIntegrityProtectionConfigurationRequest = null,

    /// Specifies the overall SIP status for the instance. To enable all SIP
    /// settings, specify
    /// `enabled`. To disable all SIP settings, specify `disabled`.
    mac_system_integrity_protection_status: MacSystemIntegrityProtectionSettingStatus,

    /// Specifies tags to apply to the SIP modification task.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateMacSystemIntegrityProtectionModificationTaskOutput = struct {
    /// Information about the SIP modification task.
    mac_modification_task: ?MacModificationTask = null,
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMacSystemIntegrityProtectionModificationTaskInput, options: Options) !CreateMacSystemIntegrityProtectionModificationTaskOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMacSystemIntegrityProtectionModificationTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateMacSystemIntegrityProtectionModificationTask&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&InstanceId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.instance_id);
    if (input.mac_credentials) |v| {
        try body_buf.appendSlice(alloc, "&MacCredentials=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.mac_system_integrity_protection_configuration) |v| {
        if (v.apple_internal) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.AppleInternal=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.base_system) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.BaseSystem=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.debugging_restrictions) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.DebuggingRestrictions=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.d_trace_restrictions) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.DTraceRestrictions=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.filesystem_protections) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.FilesystemProtections=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.kext_signing) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.KextSigning=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
        if (v.nvram_protections) |sv| {
            try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionConfiguration.NvramProtections=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(sv));
        }
    }
    try body_buf.appendSlice(alloc, "&MacSystemIntegrityProtectionStatus=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(input.mac_system_integrity_protection_status));
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.ResourceType=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                if (item.resource_type) |fv_1| {
                    try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(fv_1));
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.value) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateMacSystemIntegrityProtectionModificationTaskOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateMacSystemIntegrityProtectionModificationTaskOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "macModificationTask")) {
                    result.mac_modification_task = try serde.deserializeMacModificationTask(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
