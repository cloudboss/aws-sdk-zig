const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const describe_load_balancers = @import("describe_load_balancers.zig");

pub const DescribeLoadBalancersPaginator = struct {
    client: *Client,
    params: describe_load_balancers.DescribeLoadBalancersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: describe_load_balancers.Options) !describe_load_balancers.DescribeLoadBalancersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try describe_load_balancers.execute(self.client, allocator, self.params, options);

        if (output.next_marker) |token| {
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
