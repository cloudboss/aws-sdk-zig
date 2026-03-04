const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const describe_db_cluster_endpoints = @import("describe_db_cluster_endpoints.zig");
const describe_db_cluster_parameter_groups = @import("describe_db_cluster_parameter_groups.zig");
const describe_db_cluster_parameters = @import("describe_db_cluster_parameters.zig");
const describe_db_cluster_snapshots = @import("describe_db_cluster_snapshots.zig");
const describe_db_clusters = @import("describe_db_clusters.zig");
const describe_db_engine_versions = @import("describe_db_engine_versions.zig");
const describe_db_instances = @import("describe_db_instances.zig");
const describe_db_parameter_groups = @import("describe_db_parameter_groups.zig");
const describe_db_parameters = @import("describe_db_parameters.zig");
const describe_db_subnet_groups = @import("describe_db_subnet_groups.zig");
const describe_engine_default_parameters = @import("describe_engine_default_parameters.zig");
const describe_event_subscriptions = @import("describe_event_subscriptions.zig");
const describe_events = @import("describe_events.zig");
const describe_global_clusters = @import("describe_global_clusters.zig");
const describe_orderable_db_instance_options = @import("describe_orderable_db_instance_options.zig");
const describe_pending_maintenance_actions = @import("describe_pending_maintenance_actions.zig");

pub const DescribeDBClusterEndpointsPaginator = struct {
    client: *Client,
    params: describe_db_cluster_endpoints.DescribeDBClusterEndpointsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_cluster_endpoints.DescribeDBClusterEndpointsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_cluster_endpoints.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBClusterParameterGroupsPaginator = struct {
    client: *Client,
    params: describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_cluster_parameter_groups.DescribeDBClusterParameterGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_cluster_parameter_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBClusterParametersPaginator = struct {
    client: *Client,
    params: describe_db_cluster_parameters.DescribeDBClusterParametersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_cluster_parameters.DescribeDBClusterParametersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_cluster_parameters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBClusterSnapshotsPaginator = struct {
    client: *Client,
    params: describe_db_cluster_snapshots.DescribeDBClusterSnapshotsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_cluster_snapshots.DescribeDBClusterSnapshotsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_cluster_snapshots.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBClustersPaginator = struct {
    client: *Client,
    params: describe_db_clusters.DescribeDBClustersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_clusters.DescribeDBClustersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_clusters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBEngineVersionsPaginator = struct {
    client: *Client,
    params: describe_db_engine_versions.DescribeDBEngineVersionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_engine_versions.DescribeDBEngineVersionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_engine_versions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBInstancesPaginator = struct {
    client: *Client,
    params: describe_db_instances.DescribeDBInstancesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_instances.DescribeDBInstancesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_instances.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBParameterGroupsPaginator = struct {
    client: *Client,
    params: describe_db_parameter_groups.DescribeDBParameterGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_parameter_groups.DescribeDBParameterGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_parameter_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBParametersPaginator = struct {
    client: *Client,
    params: describe_db_parameters.DescribeDBParametersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_parameters.DescribeDBParametersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_parameters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeDBSubnetGroupsPaginator = struct {
    client: *Client,
    params: describe_db_subnet_groups.DescribeDBSubnetGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_db_subnet_groups.DescribeDBSubnetGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_db_subnet_groups.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeEngineDefaultParametersPaginator = struct {
    client: *Client,
    params: describe_engine_default_parameters.DescribeEngineDefaultParametersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_engine_default_parameters.DescribeEngineDefaultParametersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_engine_default_parameters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeEventSubscriptionsPaginator = struct {
    client: *Client,
    params: describe_event_subscriptions.DescribeEventSubscriptionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_event_subscriptions.DescribeEventSubscriptionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_event_subscriptions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeEventsPaginator = struct {
    client: *Client,
    params: describe_events.DescribeEventsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_events.DescribeEventsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_events.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeGlobalClustersPaginator = struct {
    client: *Client,
    params: describe_global_clusters.DescribeGlobalClustersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_global_clusters.DescribeGlobalClustersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_global_clusters.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribeOrderableDBInstanceOptionsPaginator = struct {
    client: *Client,
    params: describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_orderable_db_instance_options.DescribeOrderableDBInstanceOptionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_orderable_db_instance_options.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const DescribePendingMaintenanceActionsPaginator = struct {
    client: *Client,
    params: describe_pending_maintenance_actions.DescribePendingMaintenanceActionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !describe_pending_maintenance_actions.DescribePendingMaintenanceActionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_pending_maintenance_actions.execute(self.client, allocator, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};
