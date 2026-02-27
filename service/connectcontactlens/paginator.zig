const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const list_realtime_contact_analysis_segments = @import("list_realtime_contact_analysis_segments.zig");

pub const ListRealtimeContactAnalysisSegmentsPaginator = struct {
    client: *Client,
    params: list_realtime_contact_analysis_segments.ListRealtimeContactAnalysisSegmentsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_realtime_contact_analysis_segments.Options) !list_realtime_contact_analysis_segments.ListRealtimeContactAnalysisSegmentsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_realtime_contact_analysis_segments.execute(self.client, allocator, self.params, options);

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
