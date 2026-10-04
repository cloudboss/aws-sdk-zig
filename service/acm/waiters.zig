const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_acme_domain_validation = @import("describe_acme_domain_validation.zig");
const describe_acme_endpoint = @import("describe_acme_endpoint.zig");
const describe_certificate = @import("describe_certificate.zig");

pub const AcmeDomainValidationDeletedWaiter = struct {
    client: *Client,
    params: describe_acme_domain_validation.DescribeAcmeDomainValidationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 300,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeAcmeDomainValidation(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.acme_domain_validation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const AcmeDomainValidationValidatedWaiter = struct {
    client: *Client,
    params: describe_acme_domain_validation.DescribeAcmeDomainValidationInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 300,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.describeAcmeDomainValidation(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.acme_domain_validation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "VALID")) {
                    return .success;
                }
            }
        }
        if (output.acme_domain_validation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "INVALID")) {
                    return .failure;
                }
            }
        }
        if (output.acme_domain_validation) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "VALIDATING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const AcmeEndpointActiveWaiter = struct {
    client: *Client,
    params: describe_acme_endpoint.DescribeAcmeEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 300,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        const output = self.client.describeAcmeEndpoint(arena.allocator(), self.params, .{}) catch  {
            return .retry;
        };

        if (output.acme_endpoint) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "ACTIVE")) {
                    return .success;
                }
            }
        }
        if (output.acme_endpoint) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "FAILED")) {
                    return .failure;
                }
            }
        }
        if (output.acme_endpoint) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "CREATING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const AcmeEndpointDeletedWaiter = struct {
    client: *Client,
    params: describe_acme_endpoint.DescribeAcmeEndpointInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 5,
        .max_delay_s = 300,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeAcmeEndpoint(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .success;
                }
            }
            return .retry;
        };

        if (output.acme_endpoint) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "DELETING")) {
                    return .retry;
                }
            }
        }
        return .retry;
    }
};

pub const CertificateValidatedWaiter = struct {
    client: *Client,
    params: describe_certificate.DescribeCertificateInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 60,
        .max_delay_s = 120,
        .max_wait_time_s = 300,
    },

    const Self = @This();

    pub fn wait(self: *Self) aws.waiter.WaiterError!void {
        const io = self.client.config.io;
        const start = std.Io.Clock.real.now(io).toSeconds();
        var delay_s: u32 = self.config.min_delay_s;

        while (true) {
            const state = self.poll();

            switch (state) {
                .success => return,
                .failure => return error.WaiterFailed,
                .retry => {},
            }

            const elapsed: u32 = @intCast(std.Io.Clock.real.now(io).toSeconds() - start);
            if (elapsed >= self.config.max_wait_time_s) {
                return error.WaiterTimedOut;
            }

            const jittered = aws.waiter.jitteredDelay(io, self.config.min_delay_s, delay_s);
            io.sleep(.fromSeconds(@intCast(jittered)), .awake) catch {};
            delay_s = @min(delay_s * 2, self.config.max_delay_s);
        }
    }

    fn poll(self: *Self) aws.waiter.AcceptorState {
        var arena = std.heap.ArenaAllocator.init(self.client.allocator);
        defer arena.deinit();

        var diagnostic: @import("errors.zig").ServiceError = undefined;
        const output = self.client.describeCertificate(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "ResourceNotFoundException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.certificate) |val_0| {
            if (val_0.status) |val_1| {
                if (std.mem.eql(u8, val_1.wireName(), "FAILED")) {
                    return .failure;
                }
            }
        }
        return .retry;
    }
};
