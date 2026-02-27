const aws = @import("aws");
const std = @import("std");

const put_audit_events = @import("put_audit_events.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudTrail Data";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Ingests your application events into CloudTrail Lake. A required parameter,
    /// `auditEvents`, accepts the JSON records (also called
    /// *payload*) of events that you want CloudTrail to ingest. You
    /// can add up to 100 of these events (or up to 1 MB) per `PutAuditEvents`
    /// request.
    pub fn putAuditEvents(self: *Self, allocator: std.mem.Allocator, input: put_audit_events.PutAuditEventsInput, options: put_audit_events.Options) !put_audit_events.PutAuditEventsOutput {
        return put_audit_events.execute(self, allocator, input, options);
    }
};
