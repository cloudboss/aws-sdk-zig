const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AccessScopePathRequest = @import("access_scope_path_request.zig").AccessScopePathRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NetworkInsightsAccessScope = @import("network_insights_access_scope.zig").NetworkInsightsAccessScope;
const NetworkInsightsAccessScopeContent = @import("network_insights_access_scope_content.zig").NetworkInsightsAccessScopeContent;
const serde = @import("serde.zig");

pub const CreateNetworkInsightsAccessScopeInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request. For more information,
    /// see [How to ensure
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: []const u8,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The paths to exclude.
    exclude_paths: ?[]const AccessScopePathRequest = null,

    /// The paths to match.
    match_paths: ?[]const AccessScopePathRequest = null,

    /// The tags to apply.
    tag_specifications: ?[]const TagSpecification = null,
};

pub const CreateNetworkInsightsAccessScopeOutput = struct {
    /// The Network Access Scope.
    network_insights_access_scope: ?NetworkInsightsAccessScope = null,

    /// The Network Access Scope content.
    network_insights_access_scope_content: ?NetworkInsightsAccessScopeContent = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateNetworkInsightsAccessScopeInput, options: CallOptions) !CreateNetworkInsightsAccessScopeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateNetworkInsightsAccessScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=CreateNetworkInsightsAccessScope&Version=2016-11-15");
    try body_buf.appendSlice(allocator, "&ClientToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.client_token);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.exclude_paths) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.destination) |sv_1| {
                if (sv_1.packet_header_statement) |sv_2| {
                    if (sv_2.destination_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.DestinationAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.DestinationPort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.DestinationPrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.Protocol.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.SourceAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.SourcePort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.PacketHeaderStatement.SourcePrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                if (sv_1.resource_statement) |sv_2| {
                    if (sv_2.resources) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.ResourceStatement.Resource.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Destination.ResourceStatement.ResourceType.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
            }
            if (item.source) |sv_1| {
                if (sv_1.packet_header_statement) |sv_2| {
                    if (sv_2.destination_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.DestinationAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.DestinationPort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.DestinationPrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.Protocol.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.SourceAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.SourcePort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.PacketHeaderStatement.SourcePrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                if (sv_1.resource_statement) |sv_2| {
                    if (sv_2.resources) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.ResourceStatement.Resource.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.Source.ResourceStatement.ResourceType.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
            }
            if (item.through_resources) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    if (item_1.resource_statement) |sv_2| {
                        if (sv_2.resources) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.ThroughResource.{d}.ResourceStatement.Resource.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.resource_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePath.{d}.ThroughResource.{d}.ResourceStatement.ResourceType.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (input.match_paths) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.destination) |sv_1| {
                if (sv_1.packet_header_statement) |sv_2| {
                    if (sv_2.destination_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.DestinationAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.DestinationPort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.DestinationPrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.Protocol.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.SourceAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.SourcePort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.PacketHeaderStatement.SourcePrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                if (sv_1.resource_statement) |sv_2| {
                    if (sv_2.resources) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.ResourceStatement.Resource.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Destination.ResourceStatement.ResourceType.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
            }
            if (item.source) |sv_1| {
                if (sv_1.packet_header_statement) |sv_2| {
                    if (sv_2.destination_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.DestinationAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.DestinationPort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.DestinationPrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.Protocol.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.wireName());
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.SourceAddress.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.SourcePort.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.PacketHeaderStatement.SourcePrefixList.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
                if (sv_1.resource_statement) |sv_2| {
                    if (sv_2.resources) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.ResourceStatement.Resource.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.Source.ResourceStatement.ResourceType.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                            }
                        }
                    }
                }
            }
            if (item.through_resources) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    if (item_1.resource_statement) |sv_2| {
                        if (sv_2.resources) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.ThroughResource.{d}.ResourceStatement.Resource.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.resource_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPath.{d}.ThroughResource.{d}.ResourceStatement.ResourceType.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(allocator, field_prefix);
                                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_3);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    if (input.tag_specifications) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.resource_type) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.ResourceType=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1.wireName());
                }
            }
            if (item.tags) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.key) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Key=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (item_1.value) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecification.{d}.Tag.{d}.Value=", .{n, n_1}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2);
                        }
                    }
                }
            }
        }
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateNetworkInsightsAccessScopeOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: CreateNetworkInsightsAccessScopeOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "networkInsightsAccessScope")) {
                    result.network_insights_access_scope = try serde.deserializeNetworkInsightsAccessScope(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "networkInsightsAccessScopeContent")) {
                    result.network_insights_access_scope_content = try serde.deserializeNetworkInsightsAccessScopeContent(allocator, &reader);
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
