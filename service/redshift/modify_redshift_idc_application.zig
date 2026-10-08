const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthorizedTokenIssuer = @import("authorized_token_issuer.zig").AuthorizedTokenIssuer;
const ServiceIntegrationsUnion = @import("service_integrations_union.zig").ServiceIntegrationsUnion;
const RedshiftIdcApplication = @import("redshift_idc_application.zig").RedshiftIdcApplication;
const serde = @import("serde.zig");

pub const ModifyRedshiftIdcApplicationInput = struct {
    /// The authorized token issuer list for the Amazon Redshift IAM Identity Center
    /// application to change.
    authorized_token_issuer_list: ?[]const AuthorizedTokenIssuer = null,

    /// The IAM role ARN associated with the Amazon Redshift IAM Identity Center
    /// application to change. It has the required permissions
    /// to be assumed and invoke the IDC Identity Center API.
    iam_role_arn: ?[]const u8 = null,

    /// The display name for the Amazon Redshift IAM Identity Center application to
    /// change. It appears on the console.
    idc_display_name: ?[]const u8 = null,

    /// The namespace for the Amazon Redshift IAM Identity Center application to
    /// change. It determines which managed application
    /// verifies the connection token.
    identity_namespace: ?[]const u8 = null,

    /// The ARN for the Redshift application that integrates with IAM Identity
    /// Center.
    redshift_idc_application_arn: []const u8,

    /// A collection of service integrations associated with the application.
    service_integrations: ?[]const ServiceIntegrationsUnion = null,
};

pub const ModifyRedshiftIdcApplicationOutput = struct {
    redshift_idc_application: ?RedshiftIdcApplication = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyRedshiftIdcApplicationInput, options: CallOptions) !ModifyRedshiftIdcApplicationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyRedshiftIdcApplicationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyRedshiftIdcApplication&Version=2012-12-01");
    if (input.authorized_token_issuer_list) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.authorized_audiences_list) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AuthorizedTokenIssuerList.member.{d}.AuthorizedAudiencesList.member.{d}=", .{ n, n_1 }) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.trusted_token_issuer_arn) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&AuthorizedTokenIssuerList.member.{d}.TrustedTokenIssuerArn=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.iam_role_arn) |v| {
        try body_buf.appendSlice(allocator, "&IamRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.idc_display_name) |v| {
        try body_buf.appendSlice(allocator, "&IdcDisplayName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.identity_namespace) |v| {
        try body_buf.appendSlice(allocator, "&IdentityNamespace=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&RedshiftIdcApplicationArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.redshift_idc_application_arn);
    if (input.service_integrations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            switch (item) {
                .lake_formation => |u_1| {
                    if (u_1) |v_1| {
                        for (v_1, 0..) |elem_1, idx_1| {
                            const n_1 = idx_1 + 1;
                            switch (elem_1) {
                                .lake_formation_query => |u_2| {
                                    if (u_2) |v_2| {
                                        {
                                            var prefix_buf: [256]u8 = undefined;
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ServiceIntegrations.member.{d}.LakeFormation.member.{d}.LakeFormationQuery.Authorization=", .{ n, n_1 }) catch continue;
                                            try body_buf.appendSlice(allocator, field_prefix);
                                            try aws.url.appendUrlEncoded(allocator, &body_buf, v_2.authorization.wireName());
                                        }
                                    }
                                },
                            }
                        }
                    }
                },
                .redshift => |u_1| {
                    if (u_1) |v_1| {
                        for (v_1, 0..) |elem_1, idx_1| {
                            const n_1 = idx_1 + 1;
                            switch (elem_1) {
                                .connect => |u_2| {
                                    if (u_2) |v_2| {
                                        {
                                            var prefix_buf: [256]u8 = undefined;
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ServiceIntegrations.member.{d}.Redshift.member.{d}.Connect.Authorization=", .{ n, n_1 }) catch continue;
                                            try body_buf.appendSlice(allocator, field_prefix);
                                            try aws.url.appendUrlEncoded(allocator, &body_buf, v_2.authorization.wireName());
                                        }
                                    }
                                },
                            }
                        }
                    }
                },
                .s3_access_grants => |u_1| {
                    if (u_1) |v_1| {
                        for (v_1, 0..) |elem_1, idx_1| {
                            const n_1 = idx_1 + 1;
                            switch (elem_1) {
                                .read_write_access => |u_2| {
                                    if (u_2) |v_2| {
                                        {
                                            var prefix_buf: [256]u8 = undefined;
                                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ServiceIntegrations.member.{d}.S3AccessGrants.member.{d}.ReadWriteAccess.Authorization=", .{ n, n_1 }) catch continue;
                                            try body_buf.appendSlice(allocator, field_prefix);
                                            try aws.url.appendUrlEncoded(allocator, &body_buf, v_2.authorization.wireName());
                                        }
                                    }
                                },
                            }
                        }
                    }
                },
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyRedshiftIdcApplicationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyRedshiftIdcApplicationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyRedshiftIdcApplicationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RedshiftIdcApplication")) {
                    result.redshift_idc_application = try serde.deserializeRedshiftIdcApplication(allocator, &reader);
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
