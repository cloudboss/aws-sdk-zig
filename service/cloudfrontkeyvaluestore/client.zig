const aws = @import("aws");
const std = @import("std");

const delete_key = @import("delete_key.zig");
const describe_key_value_store = @import("describe_key_value_store.zig");
const get_key = @import("get_key.zig");
const list_keys = @import("list_keys.zig");
const put_key = @import("put_key.zig");
const update_keys = @import("update_keys.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "CloudFront KeyValueStore";

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

    /// Deletes the key value pair specified by the key.
    pub fn deleteKey(self: *Self, allocator: std.mem.Allocator, input: delete_key.DeleteKeyInput, options: delete_key.Options) !delete_key.DeleteKeyOutput {
        return delete_key.execute(self, allocator, input, options);
    }

    /// Returns metadata information about Key Value Store.
    pub fn describeKeyValueStore(self: *Self, allocator: std.mem.Allocator, input: describe_key_value_store.DescribeKeyValueStoreInput, options: describe_key_value_store.Options) !describe_key_value_store.DescribeKeyValueStoreOutput {
        return describe_key_value_store.execute(self, allocator, input, options);
    }

    /// Returns a key value pair.
    pub fn getKey(self: *Self, allocator: std.mem.Allocator, input: get_key.GetKeyInput, options: get_key.Options) !get_key.GetKeyOutput {
        return get_key.execute(self, allocator, input, options);
    }

    /// Returns a list of key value pairs.
    pub fn listKeys(self: *Self, allocator: std.mem.Allocator, input: list_keys.ListKeysInput, options: list_keys.Options) !list_keys.ListKeysOutput {
        return list_keys.execute(self, allocator, input, options);
    }

    /// Creates a new key value pair or replaces the value of an existing key.
    pub fn putKey(self: *Self, allocator: std.mem.Allocator, input: put_key.PutKeyInput, options: put_key.Options) !put_key.PutKeyOutput {
        return put_key.execute(self, allocator, input, options);
    }

    /// Puts or Deletes multiple key value pairs in a single, all-or-nothing
    /// operation.
    pub fn updateKeys(self: *Self, allocator: std.mem.Allocator, input: update_keys.UpdateKeysInput, options: update_keys.Options) !update_keys.UpdateKeysOutput {
        return update_keys.execute(self, allocator, input, options);
    }

    pub fn listKeysPaginator(self: *Self, params: list_keys.ListKeysInput) paginator.ListKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
