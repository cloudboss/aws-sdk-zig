const aws = @import("aws");
const std = @import("std");

const create_endpoint = @import("create_endpoint.zig");
const delete_endpoint = @import("delete_endpoint.zig");
const list_endpoints = @import("list_endpoints.zig");
const list_outposts_with_s3 = @import("list_outposts_with_s3.zig");
const list_shared_endpoints = @import("list_shared_endpoints.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "S3Outposts";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates an endpoint and associates it with the specified Outpost.
    ///
    /// It can take up to 5 minutes for this action to finish.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_DeleteEndpoint.html)
    ///
    /// *
    ///   [ListEndpoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_ListEndpoints.html)
    pub fn createEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_endpoint.CreateEndpointInput, options: create_endpoint.Options) !create_endpoint.CreateEndpointOutput {
        return create_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes an endpoint.
    ///
    /// It can take up to 5 minutes for this action to finish.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_CreateEndpoint.html)
    ///
    /// *
    ///   [ListEndpoints](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_ListEndpoints.html)
    pub fn deleteEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint.DeleteEndpointInput, options: delete_endpoint.Options) !delete_endpoint.DeleteEndpointOutput {
        return delete_endpoint.execute(self, allocator, input, options);
    }

    /// Lists endpoints associated with the specified Outpost.
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_CreateEndpoint.html)
    ///
    /// *
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_DeleteEndpoint.html)
    pub fn listEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_endpoints.ListEndpointsInput, options: list_endpoints.Options) !list_endpoints.ListEndpointsOutput {
        return list_endpoints.execute(self, allocator, input, options);
    }

    /// Lists the Outposts with S3 on Outposts capacity for your Amazon Web Services
    /// account.
    /// Includes S3 on Outposts that you have access to as the Outposts owner, or as
    /// a shared user
    /// from Resource Access Manager (RAM).
    pub fn listOutpostsWithS3(self: *Self, allocator: std.mem.Allocator, input: list_outposts_with_s3.ListOutpostsWithS3Input, options: list_outposts_with_s3.Options) !list_outposts_with_s3.ListOutpostsWithS3Output {
        return list_outposts_with_s3.execute(self, allocator, input, options);
    }

    /// Lists all endpoints associated with an Outpost that has been shared by
    /// Amazon Web Services Resource Access Manager (RAM).
    ///
    /// Related actions include:
    ///
    /// *
    ///   [CreateEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_CreateEndpoint.html)
    ///
    /// *
    ///   [DeleteEndpoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_s3outposts_DeleteEndpoint.html)
    pub fn listSharedEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_shared_endpoints.ListSharedEndpointsInput, options: list_shared_endpoints.Options) !list_shared_endpoints.ListSharedEndpointsOutput {
        return list_shared_endpoints.execute(self, allocator, input, options);
    }

    pub fn listEndpointsPaginator(self: *Self, params: list_endpoints.ListEndpointsInput) paginator.ListEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOutpostsWithS3Paginator(self: *Self, params: list_outposts_with_s3.ListOutpostsWithS3Input) paginator.ListOutpostsWithS3Paginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSharedEndpointsPaginator(self: *Self, params: list_shared_endpoints.ListSharedEndpointsInput) paginator.ListSharedEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
