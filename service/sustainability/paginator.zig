const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const get_estimated_carbon_emissions = @import("get_estimated_carbon_emissions.zig");
const get_estimated_carbon_emissions_dimension_values = @import("get_estimated_carbon_emissions_dimension_values.zig");
const get_estimated_water_allocation = @import("get_estimated_water_allocation.zig");
const get_estimated_water_allocation_dimension_values = @import("get_estimated_water_allocation_dimension_values.zig");

pub const GetEstimatedCarbonEmissionsPaginator = struct {
    client: *Client,
    params: get_estimated_carbon_emissions.GetEstimatedCarbonEmissionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_estimated_carbon_emissions.GetEstimatedCarbonEmissionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_estimated_carbon_emissions.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetEstimatedCarbonEmissionsDimensionValuesPaginator = struct {
    client: *Client,
    params: get_estimated_carbon_emissions_dimension_values.GetEstimatedCarbonEmissionsDimensionValuesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_estimated_carbon_emissions_dimension_values.GetEstimatedCarbonEmissionsDimensionValuesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_estimated_carbon_emissions_dimension_values.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetEstimatedWaterAllocationPaginator = struct {
    client: *Client,
    params: get_estimated_water_allocation.GetEstimatedWaterAllocationInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_estimated_water_allocation.GetEstimatedWaterAllocationOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_estimated_water_allocation.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};

pub const GetEstimatedWaterAllocationDimensionValuesPaginator = struct {
    client: *Client,
    params: get_estimated_water_allocation_dimension_values.GetEstimatedWaterAllocationDimensionValuesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !get_estimated_water_allocation_dimension_values.GetEstimatedWaterAllocationDimensionValuesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try get_estimated_water_allocation_dimension_values.execute(self.client, allocator, self.params, options);

        const next_token: ?[]const u8 = output.next_token;
        const owned_token = if (next_token) |token|
            if (token.len > 0) try self.client.allocator.dupe(u8, token) else null
        else
            null;
        if (self.next_token) |old| {
            self.client.allocator.free(old);
        }
        self.next_token = owned_token;
        self.done = self.next_token == null;

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.client.allocator.free(token);
        }
    }
};
