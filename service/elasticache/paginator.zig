const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_cache_clusters = @import("describe_cache_clusters.zig");
const describe_cache_engine_versions = @import("describe_cache_engine_versions.zig");
const describe_cache_parameter_groups = @import("describe_cache_parameter_groups.zig");
const describe_cache_parameters = @import("describe_cache_parameters.zig");
const describe_cache_security_groups = @import("describe_cache_security_groups.zig");
const describe_cache_subnet_groups = @import("describe_cache_subnet_groups.zig");
const describe_engine_default_parameters = @import("describe_engine_default_parameters.zig");
const describe_events = @import("describe_events.zig");
const describe_global_replication_groups = @import("describe_global_replication_groups.zig");
const describe_replication_groups = @import("describe_replication_groups.zig");
const describe_reserved_cache_nodes = @import("describe_reserved_cache_nodes.zig");
const describe_reserved_cache_nodes_offerings = @import("describe_reserved_cache_nodes_offerings.zig");
const describe_serverless_cache_snapshots = @import("describe_serverless_cache_snapshots.zig");
const describe_serverless_caches = @import("describe_serverless_caches.zig");
const describe_service_updates = @import("describe_service_updates.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_update_actions = @import("describe_update_actions.zig");
const describe_user_groups = @import("describe_user_groups.zig");
const describe_users = @import("describe_users.zig");

pub const DescribeCacheClustersPaginator = struct {
    client: *Client,
    params: describe_cache_clusters.DescribeCacheClustersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_clusters.Options) !describe_cache_clusters.DescribeCacheClustersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_clusters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCacheEngineVersionsPaginator = struct {
    client: *Client,
    params: describe_cache_engine_versions.DescribeCacheEngineVersionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_engine_versions.Options) !describe_cache_engine_versions.DescribeCacheEngineVersionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_engine_versions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCacheParameterGroupsPaginator = struct {
    client: *Client,
    params: describe_cache_parameter_groups.DescribeCacheParameterGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_parameter_groups.Options) !describe_cache_parameter_groups.DescribeCacheParameterGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_parameter_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCacheParametersPaginator = struct {
    client: *Client,
    params: describe_cache_parameters.DescribeCacheParametersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_parameters.Options) !describe_cache_parameters.DescribeCacheParametersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_parameters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCacheSecurityGroupsPaginator = struct {
    client: *Client,
    params: describe_cache_security_groups.DescribeCacheSecurityGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_security_groups.Options) !describe_cache_security_groups.DescribeCacheSecurityGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_security_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeCacheSubnetGroupsPaginator = struct {
    client: *Client,
    params: describe_cache_subnet_groups.DescribeCacheSubnetGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_cache_subnet_groups.Options) !describe_cache_subnet_groups.DescribeCacheSubnetGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_cache_subnet_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEngineDefaultParametersPaginator = struct {
    client: *Client,
    params: describe_engine_default_parameters.DescribeEngineDefaultParametersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_engine_default_parameters.Options) !describe_engine_default_parameters.DescribeEngineDefaultParametersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_engine_default_parameters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeEventsPaginator = struct {
    client: *Client,
    params: describe_events.DescribeEventsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_events.Options) !describe_events.DescribeEventsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_events.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeGlobalReplicationGroupsPaginator = struct {
    client: *Client,
    params: describe_global_replication_groups.DescribeGlobalReplicationGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_global_replication_groups.Options) !describe_global_replication_groups.DescribeGlobalReplicationGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_global_replication_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReplicationGroupsPaginator = struct {
    client: *Client,
    params: describe_replication_groups.DescribeReplicationGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_replication_groups.Options) !describe_replication_groups.DescribeReplicationGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_replication_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReservedCacheNodesPaginator = struct {
    client: *Client,
    params: describe_reserved_cache_nodes.DescribeReservedCacheNodesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_reserved_cache_nodes.Options) !describe_reserved_cache_nodes.DescribeReservedCacheNodesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_reserved_cache_nodes.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeReservedCacheNodesOfferingsPaginator = struct {
    client: *Client,
    params: describe_reserved_cache_nodes_offerings.DescribeReservedCacheNodesOfferingsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_reserved_cache_nodes_offerings.Options) !describe_reserved_cache_nodes_offerings.DescribeReservedCacheNodesOfferingsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_reserved_cache_nodes_offerings.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeServerlessCacheSnapshotsPaginator = struct {
    client: *Client,
    params: describe_serverless_cache_snapshots.DescribeServerlessCacheSnapshotsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_serverless_cache_snapshots.Options) !describe_serverless_cache_snapshots.DescribeServerlessCacheSnapshotsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_serverless_cache_snapshots.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeServerlessCachesPaginator = struct {
    client: *Client,
    params: describe_serverless_caches.DescribeServerlessCachesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_serverless_caches.Options) !describe_serverless_caches.DescribeServerlessCachesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try describe_serverless_caches.execute(self.client, allocator, self.params, options);

        if (output.next_token) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeServiceUpdatesPaginator = struct {
    client: *Client,
    params: describe_service_updates.DescribeServiceUpdatesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_service_updates.Options) !describe_service_updates.DescribeServiceUpdatesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_service_updates.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeSnapshotsPaginator = struct {
    client: *Client,
    params: describe_snapshots.DescribeSnapshotsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_snapshots.Options) !describe_snapshots.DescribeSnapshotsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_snapshots.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeUpdateActionsPaginator = struct {
    client: *Client,
    params: describe_update_actions.DescribeUpdateActionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_update_actions.Options) !describe_update_actions.DescribeUpdateActionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_update_actions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeUserGroupsPaginator = struct {
    client: *Client,
    params: describe_user_groups.DescribeUserGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_user_groups.Options) !describe_user_groups.DescribeUserGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_user_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const DescribeUsersPaginator = struct {
    client: *Client,
    params: describe_users.DescribeUsersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_users.Options) !describe_users.DescribeUsersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_users.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};
