const aws = @import("aws");
const std = @import("std");

const get_revocation_status = @import("get_revocation_status.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "Signer Data";

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

    /// Retrieves the revocation status for a signed artifact by checking if the
    /// signing profile, job, or certificate has been revoked.
    pub fn getRevocationStatus(self: *Self, allocator: std.mem.Allocator, input: get_revocation_status.GetRevocationStatusInput, options: CallOptions) !get_revocation_status.GetRevocationStatusOutput {
        return get_revocation_status.execute(self, allocator, input, options);
    }
};
