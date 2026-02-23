const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_images = @import("describe_images.zig");
const describe_instances = @import("describe_instances.zig");
const describe_instance_status = @import("describe_instance_status.zig");
const describe_internet_gateways = @import("describe_internet_gateways.zig");
const describe_key_pairs = @import("describe_key_pairs.zig");
const describe_nat_gateways = @import("describe_nat_gateways.zig");
const describe_network_interfaces = @import("describe_network_interfaces.zig");
const describe_security_groups = @import("describe_security_groups.zig");
const describe_spot_instance_requests = @import("describe_spot_instance_requests.zig");
const describe_volumes = @import("describe_volumes.zig");
const describe_vpcs = @import("describe_vpcs.zig");
const describe_vpc_peering_connections = @import("describe_vpc_peering_connections.zig");

pub const ImageExistsWaiter = struct {
    client: *Client,
    params: describe_images.DescribeImagesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeImages(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidAMIID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const InstanceExistsWaiter = struct {
    client: *Client,
    params: describe_instances.DescribeInstancesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeInstances(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidInstanceID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const InstanceRunningWaiter = struct {
    client: *Client,
    params: describe_instances.DescribeInstancesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeInstances(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidInstanceID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const InstanceStatusOkWaiter = struct {
    client: *Client,
    params: describe_instance_status.DescribeInstanceStatusInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeInstanceStatus(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidInstanceID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const InternetGatewayExistsWaiter = struct {
    client: *Client,
    params: describe_internet_gateways.DescribeInternetGatewaysInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeInternetGateways(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidInternetGateway.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const KeyPairExistsWaiter = struct {
    client: *Client,
    params: describe_key_pairs.DescribeKeyPairsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeKeyPairs(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidKeyPair.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const NatGatewayAvailableWaiter = struct {
    client: *Client,
    params: describe_nat_gateways.DescribeNatGatewaysInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeNatGateways(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "NatGatewayNotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const NatGatewayDeletedWaiter = struct {
    client: *Client,
    params: describe_nat_gateways.DescribeNatGatewaysInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeNatGateways(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "NatGatewayNotFound")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const NetworkInterfaceAvailableWaiter = struct {
    client: *Client,
    params: describe_network_interfaces.DescribeNetworkInterfacesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 20,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeNetworkInterfaces(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidNetworkInterfaceID.NotFound")) {
                    return .failure;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const SecurityGroupExistsWaiter = struct {
    client: *Client,
    params: describe_security_groups.DescribeSecurityGroupsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeSecurityGroups(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidGroup.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const SpotInstanceRequestFulfilledWaiter = struct {
    client: *Client,
    params: describe_spot_instance_requests.DescribeSpotInstanceRequestsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeSpotInstanceRequests(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidSpotInstanceRequestID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const VolumeDeletedWaiter = struct {
    client: *Client,
    params: describe_volumes.DescribeVolumesInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeVolumes(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidVolume.NotFound")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const VpcExistsWaiter = struct {
    client: *Client,
    params: describe_vpcs.DescribeVpcsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeVpcs(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidVpcID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .success;
    }
};

pub const VpcPeeringConnectionDeletedWaiter = struct {
    client: *Client,
    params: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeVpcPeeringConnections(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidVpcPeeringConnectionID.NotFound")) {
                    return .success;
                }
            }
            return .retry;
        };

        return .retry;
    }
};

pub const VpcPeeringConnectionExistsWaiter = struct {
    client: *Client,
    params: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 15,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const start = std.time.timestamp();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.time.timestamp() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(self.config.min_delay_s, delay_s);
            std.Thread.sleep(@as(u64, jittered) * std.time.ns_per_s);
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        _ = self.client.describeVpcPeeringConnections(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "InvalidVpcPeeringConnectionID.NotFound")) {
                    return .retry;
                }
            }
            return .retry;
        };

        return .success;
    }
};
