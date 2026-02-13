const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AccessScopePathRequest = @import("access_scope_path_request.zig").AccessScopePathRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;
const NetworkInsightsAccessScope = @import("network_insights_access_scope.zig").NetworkInsightsAccessScope;
const NetworkInsightsAccessScopeContent = @import("network_insights_access_scope_content.zig").NetworkInsightsAccessScopeContent;
const serde = @import("serde.zig");

/// Creates a Network Access Scope.
///
/// Amazon Web Services Network Access Analyzer enables cloud networking and
/// cloud operations teams
/// to verify that their networks on Amazon Web Services conform to their
/// network security and governance
/// objectives. For more information, see the [Amazon Web Services Network
/// Access Analyzer
/// Guide](https://docs.aws.amazon.com/vpc/latest/network-access-analyzer/).
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

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *CreateNetworkInsightsAccessScopeOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: CreateNetworkInsightsAccessScopeInput, options: Options) !CreateNetworkInsightsAccessScopeOutput {
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

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateNetworkInsightsAccessScopeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=CreateNetworkInsightsAccessScope&Version=2016-11-15");
    try body_buf.appendSlice(alloc, "&ClientToken=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.client_token);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.DestinationAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.DestinationPorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.DestinationPrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.Protocols.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.SourceAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.SourcePorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.PacketHeaderStatement.SourcePrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.ResourceStatement.Resources.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Destination.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.DestinationAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.DestinationPorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.DestinationPrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.Protocols.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.SourceAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.SourcePorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.PacketHeaderStatement.SourcePrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.ResourceStatement.Resources.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.Source.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.ThroughResources.item.{d}.ResourceStatement.Resources.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.resource_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludePaths.item.{d}.ThroughResources.item.{d}.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.DestinationAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.DestinationPorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.DestinationPrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.Protocols.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.SourceAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.SourcePorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.PacketHeaderStatement.SourcePrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.ResourceStatement.Resources.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Destination.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.DestinationAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.DestinationPorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.destination_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.DestinationPrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.protocols) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.Protocols.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_addresses) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.SourceAddresses.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_ports) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.SourcePorts.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.source_prefix_lists) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.PacketHeaderStatement.SourcePrefixLists.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.ResourceStatement.Resources.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                            }
                        }
                    }
                    if (sv_2.resource_types) |lst_3| {
                        for (lst_3, 0..) |item_3, idx_3| {
                            const n_3 = idx_3 + 1;
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.Source.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(alloc, field_prefix);
                                try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.ThroughResources.item.{d}.ResourceStatement.Resources.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
                                }
                            }
                        }
                        if (sv_2.resource_types) |lst_3| {
                            for (lst_3, 0..) |item_3, idx_3| {
                                const n_3 = idx_3 + 1;
                                {
                                    var prefix_buf: [256]u8 = undefined;
                                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MatchPaths.item.{d}.ThroughResources.item.{d}.ResourceStatement.ResourceTypes.item.{d}=", .{n, n_1, n_3}) catch continue;
                                    try body_buf.appendSlice(alloc, field_prefix);
                                    try aws.url.appendUrlEncoded(alloc, &body_buf, item_3);
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
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.ResourceType=", .{n}) catch continue;
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Key=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(alloc, field_prefix);
                        if (item_1.key) |fv_2| {
                            try aws.url.appendUrlEncoded(alloc, &body_buf, fv_2);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&TagSpecifications.item.{d}.Tags.item.{d}.Value=", .{n, n_1}) catch continue;
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateNetworkInsightsAccessScopeOutput {
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
                    result.network_insights_access_scope = try serde.deserializeNetworkInsightsAccessScope(&reader, alloc);
                } else if (std.mem.eql(u8, e.local, "networkInsightsAccessScopeContent")) {
                    result.network_insights_access_scope_content = try serde.deserializeNetworkInsightsAccessScopeContent(&reader, alloc);
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

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
