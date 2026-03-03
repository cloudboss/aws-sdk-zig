const aws = @import("aws");
const std = @import("std");

const delete_object = @import("delete_object.zig");
const describe_object = @import("describe_object.zig");
const get_object = @import("get_object.zig");
const list_items = @import("list_items.zig");
const put_object = @import("put_object.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaStore Data";

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

    /// Deletes an object at the specified path.
    pub fn deleteObject(self: *Self, allocator: std.mem.Allocator, input: delete_object.DeleteObjectInput, options: delete_object.Options) !delete_object.DeleteObjectOutput {
        return delete_object.execute(self, allocator, input, options);
    }

    /// Gets the headers for an object at the specified path.
    pub fn describeObject(self: *Self, allocator: std.mem.Allocator, input: describe_object.DescribeObjectInput, options: describe_object.Options) !describe_object.DescribeObjectOutput {
        return describe_object.execute(self, allocator, input, options);
    }

    /// Downloads the object at the specified path. If the object’s upload
    /// availability is set to `streaming`, AWS Elemental MediaStore downloads the
    /// object even if it’s still uploading the object.
    pub fn getObject(self: *Self, allocator: std.mem.Allocator, input: get_object.GetObjectInput, options: get_object.Options) !get_object.GetObjectOutput {
        return get_object.execute(self, allocator, input, options);
    }

    /// Provides a list of metadata entries about folders and objects in the
    /// specified
    /// folder.
    pub fn listItems(self: *Self, allocator: std.mem.Allocator, input: list_items.ListItemsInput, options: list_items.Options) !list_items.ListItemsOutput {
        return list_items.execute(self, allocator, input, options);
    }

    /// Uploads an object to the specified path. Object sizes are limited to 25 MB
    /// for standard upload availability and 10 MB for streaming upload
    /// availability.
    pub fn putObject(self: *Self, allocator: std.mem.Allocator, input: put_object.PutObjectInput, options: put_object.Options) !put_object.PutObjectOutput {
        return put_object.execute(self, allocator, input, options);
    }

    pub fn listItemsPaginator(self: *Self, params: list_items.ListItemsInput) paginator.ListItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
