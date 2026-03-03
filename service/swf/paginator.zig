const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const get_workflow_execution_history = @import("get_workflow_execution_history.zig");
const list_activity_types = @import("list_activity_types.zig");
const list_closed_workflow_executions = @import("list_closed_workflow_executions.zig");
const list_domains = @import("list_domains.zig");
const list_open_workflow_executions = @import("list_open_workflow_executions.zig");
const list_workflow_types = @import("list_workflow_types.zig");
const poll_for_decision_task = @import("poll_for_decision_task.zig");

pub const GetWorkflowExecutionHistoryPaginator = struct {
    client: *Client,
    params: get_workflow_execution_history.GetWorkflowExecutionHistoryInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_workflow_execution_history.GetWorkflowExecutionHistoryOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try get_workflow_execution_history.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const ListActivityTypesPaginator = struct {
    client: *Client,
    params: list_activity_types.ListActivityTypesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_activity_types.ListActivityTypesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_activity_types.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const ListClosedWorkflowExecutionsPaginator = struct {
    client: *Client,
    params: list_closed_workflow_executions.ListClosedWorkflowExecutionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_closed_workflow_executions.ListClosedWorkflowExecutionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_closed_workflow_executions.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const ListDomainsPaginator = struct {
    client: *Client,
    params: list_domains.ListDomainsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_domains.ListDomainsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_domains.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const ListOpenWorkflowExecutionsPaginator = struct {
    client: *Client,
    params: list_open_workflow_executions.ListOpenWorkflowExecutionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_open_workflow_executions.ListOpenWorkflowExecutionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_open_workflow_executions.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const ListWorkflowTypesPaginator = struct {
    client: *Client,
    params: list_workflow_types.ListWorkflowTypesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_workflow_types.ListWorkflowTypesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try list_workflow_types.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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

pub const PollForDecisionTaskPaginator = struct {
    client: *Client,
    params: poll_for_decision_task.PollForDecisionTaskInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !poll_for_decision_task.PollForDecisionTaskOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_page_token = self.next_token;

        const output = try poll_for_decision_task.execute(self.client, allocator, self.params, options);

        if (output.next_page_token) |token| {
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
