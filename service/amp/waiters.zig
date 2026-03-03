const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_anomaly_detector = @import("describe_anomaly_detector.zig");
const describe_scraper = @import("describe_scraper.zig");
const describe_workspace = @import("describe_workspace.zig");

pub const AnomalyDetectorActiveWaiter = struct {
    client: *Client,
    params: describe_anomaly_detector.DescribeAnomalyDetectorInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.describeAnomalyDetector(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.anomaly_detector) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "ACTIVE")) {
                        return .success;
                    }
                }
            }
        }
        if (output.anomaly_detector) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "CREATING")) {
                        return .retry;
                    }
                }
            }
        }
        if (output.anomaly_detector) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "UPDATING")) {
                        return .retry;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const AnomalyDetectorDeletedWaiter = struct {
    client: *Client,
    params: describe_anomaly_detector.DescribeAnomalyDetectorInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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
        const output = self.client.describeAnomalyDetector(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.anomaly_detector) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "DELETING")) {
                        return .retry;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const ScraperActiveWaiter = struct {
    client: *Client,
    params: describe_scraper.DescribeScraperInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.describeScraper(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.scraper) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "ACTIVE")) {
                        return .success;
                    }
                }
            }
        }
        if (output.scraper) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "CREATION_FAILED")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const ScraperDeletedWaiter = struct {
    client: *Client,
    params: describe_scraper.DescribeScraperInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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
        const output = self.client.describeScraper(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.scraper) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "DELETION_FAILED")) {
                        return .failure;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const WorkspaceActiveWaiter = struct {
    client: *Client,
    params: describe_workspace.DescribeWorkspaceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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

        const output = self.client.describeWorkspace(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.workspace) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "ACTIVE")) {
                        return .success;
                    }
                }
            }
        }
        if (output.workspace) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "UPDATING")) {
                        return .retry;
                    }
                }
            }
        }
        if (output.workspace) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "CREATING")) {
                        return .retry;
                    }
                }
            }
        }
        return .retry;
    }
};

pub const WorkspaceDeletedWaiter = struct {
    client: *Client,
    params: describe_workspace.DescribeWorkspaceInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 2,
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
        const output = self.client.describeWorkspace(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.workspace) |val_0| {
            if (val_0.status) |val_1| {
                if (val_1.status_code) |val_2| {
                    if (std.mem.eql(u8, val_2.wireName(), "DELETING")) {
                        return .retry;
                    }
                }
            }
        }
        return .retry;
    }
};
