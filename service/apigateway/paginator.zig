const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const get_api_keys = @import("get_api_keys.zig");
const get_base_path_mappings = @import("get_base_path_mappings.zig");
const get_client_certificates = @import("get_client_certificates.zig");
const get_deployments = @import("get_deployments.zig");
const get_domain_names = @import("get_domain_names.zig");
const get_models = @import("get_models.zig");
const get_resources = @import("get_resources.zig");
const get_rest_apis = @import("get_rest_apis.zig");
const get_usage = @import("get_usage.zig");
const get_usage_plan_keys = @import("get_usage_plan_keys.zig");
const get_usage_plans = @import("get_usage_plans.zig");
const get_vpc_links = @import("get_vpc_links.zig");

pub const GetApiKeysPaginator = struct {
    client: *Client,
    params: get_api_keys.GetApiKeysInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_api_keys.GetApiKeysOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_api_keys.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetBasePathMappingsPaginator = struct {
    client: *Client,
    params: get_base_path_mappings.GetBasePathMappingsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_base_path_mappings.GetBasePathMappingsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_base_path_mappings.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetClientCertificatesPaginator = struct {
    client: *Client,
    params: get_client_certificates.GetClientCertificatesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_client_certificates.GetClientCertificatesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_client_certificates.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetDeploymentsPaginator = struct {
    client: *Client,
    params: get_deployments.GetDeploymentsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_deployments.GetDeploymentsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_deployments.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetDomainNamesPaginator = struct {
    client: *Client,
    params: get_domain_names.GetDomainNamesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_domain_names.GetDomainNamesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_domain_names.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetModelsPaginator = struct {
    client: *Client,
    params: get_models.GetModelsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_models.GetModelsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_models.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetResourcesPaginator = struct {
    client: *Client,
    params: get_resources.GetResourcesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_resources.GetResourcesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_resources.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetRestApisPaginator = struct {
    client: *Client,
    params: get_rest_apis.GetRestApisInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_rest_apis.GetRestApisOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_rest_apis.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetUsagePaginator = struct {
    client: *Client,
    params: get_usage.GetUsageInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_usage.GetUsageOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_usage.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetUsagePlanKeysPaginator = struct {
    client: *Client,
    params: get_usage_plan_keys.GetUsagePlanKeysInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_usage_plan_keys.GetUsagePlanKeysOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_usage_plan_keys.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetUsagePlansPaginator = struct {
    client: *Client,
    params: get_usage_plans.GetUsagePlansInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_usage_plans.GetUsagePlansOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_usage_plans.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetVpcLinksPaginator = struct {
    client: *Client,
    params: get_vpc_links.GetVpcLinksInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_vpc_links.GetVpcLinksOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.position = self.next_token;

        const output = try get_vpc_links.execute(self.client, allocator, self.params, options);

        if (output.position) |token| {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = self.client.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.client.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};
