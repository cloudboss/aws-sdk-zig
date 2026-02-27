const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const list_human_loops = @import("list_human_loops.zig");

pub const ListHumanLoopsPaginator = struct {
    client: *Client,
    params: list_human_loops.ListHumanLoopsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: list_human_loops.Options) !list_human_loops.ListHumanLoopsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_human_loops.execute(self.client, allocator, self.params, options);

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
