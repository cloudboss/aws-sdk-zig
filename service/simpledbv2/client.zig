const aws = @import("aws");
const std = @import("std");

const get_export = @import("get_export.zig");
const list_exports = @import("list_exports.zig");
const start_domain_export = @import("start_domain_export.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "SimpleDBv2";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Returns information for an existing domain export.
    pub fn getExport(self: *Self, allocator: std.mem.Allocator, input: get_export.GetExportInput, options: CallOptions) !get_export.GetExportOutput {
        return get_export.execute(self, allocator, input, options);
    }

    /// Lists all exports that were created. The results are paginated and can be
    /// filtered by domain name.
    pub fn listExports(self: *Self, allocator: std.mem.Allocator, input: list_exports.ListExportsInput, options: CallOptions) !list_exports.ListExportsOutput {
        return list_exports.execute(self, allocator, input, options);
    }

    /// Initiates the export of a SimpleDB domain to an S3 bucket.
    pub fn startDomainExport(self: *Self, allocator: std.mem.Allocator, input: start_domain_export.StartDomainExportInput, options: CallOptions) !start_domain_export.StartDomainExportOutput {
        return start_domain_export.execute(self, allocator, input, options);
    }

    pub fn listExportsPaginator(self: *Self, params: list_exports.ListExportsInput) paginator.ListExportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilExportSucceeded(self: *Self, params: get_export.GetExportInput) aws.waiter.WaiterError!void {
        var w = waiters.ExportSucceededWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
