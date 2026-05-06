const aws = @import("aws");
const std = @import("std");

const put_audit_events = @import("put_audit_events.zig");
const CallOptions = @import("call_options.zig").CallOptions;

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "CloudTrail Data";

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

    /// Ingests your application events into CloudTrail Lake. A required parameter,
    /// `auditEvents`, accepts the JSON records (also called
    /// *payload*) of events that you want CloudTrail to ingest. You
    /// can add up to 100 of these events (or up to 1 MB) per `PutAuditEvents`
    /// request.
    pub fn putAuditEvents(self: *Self, allocator: std.mem.Allocator, input: put_audit_events.PutAuditEventsInput, options: CallOptions) !put_audit_events.PutAuditEventsOutput {
        return put_audit_events.execute(self, allocator, input, options);
    }
};
