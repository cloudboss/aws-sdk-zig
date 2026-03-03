const aws = @import("aws");
const std = @import("std");

const delete_connection = @import("delete_connection.zig");
const get_connection = @import("get_connection.zig");
const post_to_connection = @import("post_to_connection.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ApiGatewayManagementApi";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Delete the connection with the provided id.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Get information about the connection with the provided id.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: get_connection.Options) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Sends the provided data to the specified connection.
    pub fn postToConnection(self: *Self, allocator: std.mem.Allocator, input: post_to_connection.PostToConnectionInput, options: post_to_connection.Options) !post_to_connection.PostToConnectionOutput {
        return post_to_connection.execute(self, allocator, input, options);
    }
};
