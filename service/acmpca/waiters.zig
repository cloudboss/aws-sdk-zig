const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_certificate_authority_audit_report = @import("describe_certificate_authority_audit_report.zig");
const get_certificate_authority_csr = @import("get_certificate_authority_csr.zig");
const get_certificate = @import("get_certificate.zig");

pub const AuditReportCreatedWaiter = struct {
    client: *Client,
    params: describe_certificate_authority_audit_report.DescribeCertificateAuthorityAuditReportInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
        .max_delay_s = 180,
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
        const output = self.client.describeCertificateAuthorityAuditReport(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "AccessDeniedException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        if (output.audit_report_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "SUCCESS")) {
                return .success;
            }
        }
        if (output.audit_report_status) |val_0| {
            if (std.mem.eql(u8, val_0.wireName(), "FAILED")) {
                return .failure;
            }
        }
        return .retry;
    }
};

pub const CertificateAuthorityCSRCreatedWaiter = struct {
    client: *Client,
    params: get_certificate_authority_csr.GetCertificateAuthorityCsrInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 3,
        .max_delay_s = 180,
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
        _ = self.client.getCertificateAuthorityCsr(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "RequestInProgressException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "AccessDeniedException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        return .success;
    }
};

pub const CertificateIssuedWaiter = struct {
    client: *Client,
    params: get_certificate.GetCertificateInput,
    config: aws.waiter.WaiterConfig = .{
        .min_delay_s = 1,
        .max_delay_s = 60,
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
        _ = self.client.getCertificate(arena.allocator(), self.params, .{ .diagnostic = &diagnostic }) catch |err| {
            if (err == error.ServiceError) {
                defer diagnostic.deinit();
                if (std.mem.eql(u8, diagnostic.code(), "RequestInProgressException")) {
                    return .retry;
                }
                if (std.mem.eql(u8, diagnostic.code(), "AccessDeniedException")) {
                    return .failure;
                }
            }
            return .retry;
        };

        return .success;
    }
};
