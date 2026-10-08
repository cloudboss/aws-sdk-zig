const aws = @import("aws");
const std = @import("std");

const CallOptions = @import("call_options.zig").CallOptions;
const Client = @import("client.zig").Client;

const list_brand_profile_attributes = @import("list_brand_profile_attributes.zig");
const list_brand_profiles = @import("list_brand_profiles.zig");
const list_jobs = @import("list_jobs.zig");
const list_notify_code_configurations = @import("list_notify_code_configurations.zig");
const list_registrations_from_brand_profile = @import("list_registrations_from_brand_profile.zig");

pub const ListBrandProfileAttributesPaginator = struct {
    client: *Client,
    params: list_brand_profile_attributes.ListBrandProfileAttributesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_brand_profile_attributes.ListBrandProfileAttributesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_brand_profile_attributes.execute(self.client, allocator, self.params, options);

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

pub const ListBrandProfilesPaginator = struct {
    client: *Client,
    params: list_brand_profiles.ListBrandProfilesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_brand_profiles.ListBrandProfilesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_brand_profiles.execute(self.client, allocator, self.params, options);

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

pub const ListJobsPaginator = struct {
    client: *Client,
    params: list_jobs.ListJobsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_jobs.ListJobsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_jobs.execute(self.client, allocator, self.params, options);

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

pub const ListNotifyCodeConfigurationsPaginator = struct {
    client: *Client,
    params: list_notify_code_configurations.ListNotifyCodeConfigurationsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_notify_code_configurations.ListNotifyCodeConfigurationsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_notify_code_configurations.execute(self.client, allocator, self.params, options);

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

pub const ListRegistrationsFromBrandProfilePaginator = struct {
    client: *Client,
    params: list_registrations_from_brand_profile.ListRegistrationsFromBrandProfileInput,
    next_token: ?[]const u8 = null,
    done: bool = false,

    const Self = @This();

    pub fn next(self: *Self, allocator: std.mem.Allocator, options: CallOptions) !list_registrations_from_brand_profile.ListRegistrationsFromBrandProfileOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.next_token = self.next_token;

        const output = try list_registrations_from_brand_profile.execute(self.client, allocator, self.params, options);

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
