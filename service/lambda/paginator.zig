const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_durable_execution_history = @import("get_durable_execution_history.zig");
const get_durable_execution_state = @import("get_durable_execution_state.zig");
const list_aliases = @import("list_aliases.zig");
const list_capacity_providers = @import("list_capacity_providers.zig");
const list_code_signing_configs = @import("list_code_signing_configs.zig");
const list_durable_executions_by_function = @import("list_durable_executions_by_function.zig");
const list_event_source_mappings = @import("list_event_source_mappings.zig");
const list_function_event_invoke_configs = @import("list_function_event_invoke_configs.zig");
const list_function_url_configs = @import("list_function_url_configs.zig");
const list_function_versions_by_capacity_provider = @import("list_function_versions_by_capacity_provider.zig");
const list_functions = @import("list_functions.zig");
const list_functions_by_code_signing_config = @import("list_functions_by_code_signing_config.zig");
const list_layer_versions = @import("list_layer_versions.zig");
const list_layers = @import("list_layers.zig");
const list_provisioned_concurrency_configs = @import("list_provisioned_concurrency_configs.zig");
const list_versions_by_function = @import("list_versions_by_function.zig");

pub const GetDurableExecutionHistoryPaginator = struct {
    client: *Client,
    params: get_durable_execution_history.GetDurableExecutionHistoryInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: get_durable_execution_history.Options) !get_durable_execution_history.GetDurableExecutionHistoryOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try get_durable_execution_history.execute(self.client, self.params, options);


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

pub const GetDurableExecutionStatePaginator = struct {
    client: *Client,
    params: get_durable_execution_state.GetDurableExecutionStateInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: get_durable_execution_state.Options) !get_durable_execution_state.GetDurableExecutionStateOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try get_durable_execution_state.execute(self.client, self.params, options);


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

pub const ListAliasesPaginator = struct {
    client: *Client,
    params: list_aliases.ListAliasesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_aliases.Options) !list_aliases.ListAliasesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_aliases.execute(self.client, self.params, options);


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

pub const ListCapacityProvidersPaginator = struct {
    client: *Client,
    params: list_capacity_providers.ListCapacityProvidersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_capacity_providers.Options) !list_capacity_providers.ListCapacityProvidersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_capacity_providers.execute(self.client, self.params, options);


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

pub const ListCodeSigningConfigsPaginator = struct {
    client: *Client,
    params: list_code_signing_configs.ListCodeSigningConfigsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_code_signing_configs.Options) !list_code_signing_configs.ListCodeSigningConfigsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_code_signing_configs.execute(self.client, self.params, options);


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

pub const ListDurableExecutionsByFunctionPaginator = struct {
    client: *Client,
    params: list_durable_executions_by_function.ListDurableExecutionsByFunctionInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_durable_executions_by_function.Options) !list_durable_executions_by_function.ListDurableExecutionsByFunctionOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_durable_executions_by_function.execute(self.client, self.params, options);


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

pub const ListEventSourceMappingsPaginator = struct {
    client: *Client,
    params: list_event_source_mappings.ListEventSourceMappingsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_event_source_mappings.Options) !list_event_source_mappings.ListEventSourceMappingsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_event_source_mappings.execute(self.client, self.params, options);


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

pub const ListFunctionEventInvokeConfigsPaginator = struct {
    client: *Client,
    params: list_function_event_invoke_configs.ListFunctionEventInvokeConfigsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_function_event_invoke_configs.Options) !list_function_event_invoke_configs.ListFunctionEventInvokeConfigsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_function_event_invoke_configs.execute(self.client, self.params, options);


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

pub const ListFunctionUrlConfigsPaginator = struct {
    client: *Client,
    params: list_function_url_configs.ListFunctionUrlConfigsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_function_url_configs.Options) !list_function_url_configs.ListFunctionUrlConfigsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_function_url_configs.execute(self.client, self.params, options);


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

pub const ListFunctionVersionsByCapacityProviderPaginator = struct {
    client: *Client,
    params: list_function_versions_by_capacity_provider.ListFunctionVersionsByCapacityProviderInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_function_versions_by_capacity_provider.Options) !list_function_versions_by_capacity_provider.ListFunctionVersionsByCapacityProviderOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_function_versions_by_capacity_provider.execute(self.client, self.params, options);


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

pub const ListFunctionsPaginator = struct {
    client: *Client,
    params: list_functions.ListFunctionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_functions.Options) !list_functions.ListFunctionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_functions.execute(self.client, self.params, options);


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

pub const ListFunctionsByCodeSigningConfigPaginator = struct {
    client: *Client,
    params: list_functions_by_code_signing_config.ListFunctionsByCodeSigningConfigInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_functions_by_code_signing_config.Options) !list_functions_by_code_signing_config.ListFunctionsByCodeSigningConfigOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_functions_by_code_signing_config.execute(self.client, self.params, options);


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

pub const ListLayerVersionsPaginator = struct {
    client: *Client,
    params: list_layer_versions.ListLayerVersionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_layer_versions.Options) !list_layer_versions.ListLayerVersionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_layer_versions.execute(self.client, self.params, options);


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

pub const ListLayersPaginator = struct {
    client: *Client,
    params: list_layers.ListLayersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_layers.Options) !list_layers.ListLayersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_layers.execute(self.client, self.params, options);


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

pub const ListProvisionedConcurrencyConfigsPaginator = struct {
    client: *Client,
    params: list_provisioned_concurrency_configs.ListProvisionedConcurrencyConfigsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_provisioned_concurrency_configs.Options) !list_provisioned_concurrency_configs.ListProvisionedConcurrencyConfigsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_provisioned_concurrency_configs.execute(self.client, self.params, options);


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

pub const ListVersionsByFunctionPaginator = struct {
    client: *Client,
    params: list_versions_by_function.ListVersionsByFunctionInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_versions_by_function.Options) !list_versions_by_function.ListVersionsByFunctionOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_versions_by_function.execute(self.client, self.params, options);


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
