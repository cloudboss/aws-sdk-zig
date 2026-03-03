const aws = @import("aws");
const std = @import("std");

const create_container = @import("create_container.zig");
const delete_container = @import("delete_container.zig");
const delete_container_policy = @import("delete_container_policy.zig");
const delete_cors_policy = @import("delete_cors_policy.zig");
const delete_lifecycle_policy = @import("delete_lifecycle_policy.zig");
const delete_metric_policy = @import("delete_metric_policy.zig");
const describe_container = @import("describe_container.zig");
const get_container_policy = @import("get_container_policy.zig");
const get_cors_policy = @import("get_cors_policy.zig");
const get_lifecycle_policy = @import("get_lifecycle_policy.zig");
const get_metric_policy = @import("get_metric_policy.zig");
const list_containers = @import("list_containers.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_container_policy = @import("put_container_policy.zig");
const put_cors_policy = @import("put_cors_policy.zig");
const put_lifecycle_policy = @import("put_lifecycle_policy.zig");
const put_metric_policy = @import("put_metric_policy.zig");
const start_access_logging = @import("start_access_logging.zig");
const stop_access_logging = @import("stop_access_logging.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "MediaStore";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a storage container to hold objects. A container is similar to a
    /// bucket in
    /// the Amazon S3 service.
    pub fn createContainer(self: *Self, allocator: std.mem.Allocator, input: create_container.CreateContainerInput, options: create_container.Options) !create_container.CreateContainerOutput {
        return create_container.execute(self, allocator, input, options);
    }

    /// Deletes the specified container. Before you make a `DeleteContainer`
    /// request, delete any objects in the container or in any folders in the
    /// container. You can
    /// delete only empty containers.
    pub fn deleteContainer(self: *Self, allocator: std.mem.Allocator, input: delete_container.DeleteContainerInput, options: delete_container.Options) !delete_container.DeleteContainerOutput {
        return delete_container.execute(self, allocator, input, options);
    }

    /// Deletes the access policy that is associated with the specified container.
    pub fn deleteContainerPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_container_policy.DeleteContainerPolicyInput, options: delete_container_policy.Options) !delete_container_policy.DeleteContainerPolicyOutput {
        return delete_container_policy.execute(self, allocator, input, options);
    }

    /// Deletes the cross-origin resource sharing (CORS) configuration information
    /// that is
    /// set for the container.
    ///
    /// To use this operation, you must have permission to perform the
    /// `MediaStore:DeleteCorsPolicy` action. The container owner has this
    /// permission
    /// by default and can grant this permission to others.
    pub fn deleteCorsPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_cors_policy.DeleteCorsPolicyInput, options: delete_cors_policy.Options) !delete_cors_policy.DeleteCorsPolicyOutput {
        return delete_cors_policy.execute(self, allocator, input, options);
    }

    /// Removes an object lifecycle policy from a container. It takes up to 20
    /// minutes for the change to take effect.
    pub fn deleteLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_lifecycle_policy.DeleteLifecyclePolicyInput, options: delete_lifecycle_policy.Options) !delete_lifecycle_policy.DeleteLifecyclePolicyOutput {
        return delete_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Deletes the metric policy that is associated with the specified container.
    /// If there is no metric policy associated with the container, MediaStore
    /// doesn't send metrics to CloudWatch.
    pub fn deleteMetricPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_metric_policy.DeleteMetricPolicyInput, options: delete_metric_policy.Options) !delete_metric_policy.DeleteMetricPolicyOutput {
        return delete_metric_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the properties of the requested container. This request is
    /// commonly used to
    /// retrieve the endpoint of a container. An endpoint is a value assigned by the
    /// service when a
    /// new container is created. A container's endpoint does not change after it
    /// has been
    /// assigned. The `DescribeContainer` request returns a single
    /// `Container` object based on `ContainerName`. To return all
    /// `Container` objects that are associated with a specified AWS account, use
    /// ListContainers.
    pub fn describeContainer(self: *Self, allocator: std.mem.Allocator, input: describe_container.DescribeContainerInput, options: describe_container.Options) !describe_container.DescribeContainerOutput {
        return describe_container.execute(self, allocator, input, options);
    }

    /// Retrieves the access policy for the specified container. For information
    /// about the
    /// data that is included in an access policy, see the [AWS Identity and Access
    /// Management User
    /// Guide](https://aws.amazon.com/documentation/iam/).
    pub fn getContainerPolicy(self: *Self, allocator: std.mem.Allocator, input: get_container_policy.GetContainerPolicyInput, options: get_container_policy.Options) !get_container_policy.GetContainerPolicyOutput {
        return get_container_policy.execute(self, allocator, input, options);
    }

    /// Returns the cross-origin resource sharing (CORS) configuration information
    /// that is
    /// set for the container.
    ///
    /// To use this operation, you must have permission to perform the
    /// `MediaStore:GetCorsPolicy` action. By default, the container owner has this
    /// permission and can grant it to others.
    pub fn getCorsPolicy(self: *Self, allocator: std.mem.Allocator, input: get_cors_policy.GetCorsPolicyInput, options: get_cors_policy.Options) !get_cors_policy.GetCorsPolicyOutput {
        return get_cors_policy.execute(self, allocator, input, options);
    }

    /// Retrieves the object lifecycle policy that is assigned to a container.
    pub fn getLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: get_lifecycle_policy.GetLifecyclePolicyInput, options: get_lifecycle_policy.Options) !get_lifecycle_policy.GetLifecyclePolicyOutput {
        return get_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// Returns the metric policy for the specified container.
    pub fn getMetricPolicy(self: *Self, allocator: std.mem.Allocator, input: get_metric_policy.GetMetricPolicyInput, options: get_metric_policy.Options) !get_metric_policy.GetMetricPolicyOutput {
        return get_metric_policy.execute(self, allocator, input, options);
    }

    /// Lists the properties of all containers in AWS Elemental MediaStore.
    ///
    /// You can query to receive all the containers in one response. Or you can
    /// include the
    /// `MaxResults` parameter to receive a limited number of containers in each
    /// response. In this case, the response includes a token. To get the next set
    /// of containers,
    /// send the command again, this time with the `NextToken` parameter (with the
    /// returned token as its value). The next set of responses appears, with a
    /// token if there are
    /// still more containers to receive.
    ///
    /// See also DescribeContainer, which gets the properties of one
    /// container.
    pub fn listContainers(self: *Self, allocator: std.mem.Allocator, input: list_containers.ListContainersInput, options: list_containers.Options) !list_containers.ListContainersOutput {
        return list_containers.execute(self, allocator, input, options);
    }

    /// Returns a list of the tags assigned to the specified container.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates an access policy for the specified container to restrict the users
    /// and
    /// clients that can access it. For information about the data that is included
    /// in an access
    /// policy, see the [AWS Identity and
    /// Access Management User Guide](https://aws.amazon.com/documentation/iam/).
    ///
    /// For this release of the REST API, you can create only one policy for a
    /// container. If
    /// you enter `PutContainerPolicy` twice, the second command modifies the
    /// existing
    /// policy.
    pub fn putContainerPolicy(self: *Self, allocator: std.mem.Allocator, input: put_container_policy.PutContainerPolicyInput, options: put_container_policy.Options) !put_container_policy.PutContainerPolicyOutput {
        return put_container_policy.execute(self, allocator, input, options);
    }

    /// Sets the cross-origin resource sharing (CORS) configuration on a container
    /// so that
    /// the container can service cross-origin requests. For example, you might want
    /// to enable a
    /// request whose origin is http://www.example.com to access your AWS Elemental
    /// MediaStore
    /// container at my.example.container.com by using the browser's XMLHttpRequest
    /// capability.
    ///
    /// To enable CORS on a container, you attach a CORS policy to the container. In
    /// the CORS
    /// policy, you configure rules that identify origins and the HTTP methods that
    /// can be executed
    /// on your container. The policy can contain up to 398,000 characters. You can
    /// add up to 100
    /// rules to a CORS policy. If more than one rule applies, the service uses the
    /// first
    /// applicable rule listed.
    ///
    /// To learn more about CORS, see [Cross-Origin Resource Sharing (CORS) in AWS
    /// Elemental
    /// MediaStore](https://docs.aws.amazon.com/mediastore/latest/ug/cors-policy.html).
    pub fn putCorsPolicy(self: *Self, allocator: std.mem.Allocator, input: put_cors_policy.PutCorsPolicyInput, options: put_cors_policy.Options) !put_cors_policy.PutCorsPolicyOutput {
        return put_cors_policy.execute(self, allocator, input, options);
    }

    /// Writes an object lifecycle policy to a container. If the container already
    /// has an object lifecycle policy, the service replaces the existing policy
    /// with the new policy. It takes up to 20 minutes for the change to take
    /// effect.
    ///
    /// For information about how to construct an object lifecycle policy, see
    /// [Components of an Object Lifecycle
    /// Policy](https://docs.aws.amazon.com/mediastore/latest/ug/policies-object-lifecycle-components.html).
    pub fn putLifecyclePolicy(self: *Self, allocator: std.mem.Allocator, input: put_lifecycle_policy.PutLifecyclePolicyInput, options: put_lifecycle_policy.Options) !put_lifecycle_policy.PutLifecyclePolicyOutput {
        return put_lifecycle_policy.execute(self, allocator, input, options);
    }

    /// The metric policy that you want to add to the container. A metric policy
    /// allows AWS Elemental MediaStore to send metrics to Amazon CloudWatch. It
    /// takes up to 20 minutes for the new policy to take effect.
    pub fn putMetricPolicy(self: *Self, allocator: std.mem.Allocator, input: put_metric_policy.PutMetricPolicyInput, options: put_metric_policy.Options) !put_metric_policy.PutMetricPolicyOutput {
        return put_metric_policy.execute(self, allocator, input, options);
    }

    /// Starts access logging on the specified container. When you enable access
    /// logging on a container, MediaStore delivers access logs for objects stored
    /// in that container to Amazon CloudWatch Logs.
    pub fn startAccessLogging(self: *Self, allocator: std.mem.Allocator, input: start_access_logging.StartAccessLoggingInput, options: start_access_logging.Options) !start_access_logging.StartAccessLoggingOutput {
        return start_access_logging.execute(self, allocator, input, options);
    }

    /// Stops access logging on the specified container. When you stop access
    /// logging on a container, MediaStore stops sending access logs to Amazon
    /// CloudWatch Logs. These access logs are not saved and are not retrievable.
    pub fn stopAccessLogging(self: *Self, allocator: std.mem.Allocator, input: stop_access_logging.StopAccessLoggingInput, options: stop_access_logging.Options) !stop_access_logging.StopAccessLoggingOutput {
        return stop_access_logging.execute(self, allocator, input, options);
    }

    /// Adds tags to the specified AWS Elemental MediaStore container. Tags are
    /// key:value pairs that you can associate with AWS resources. For example, the
    /// tag key might be "customer" and the tag value might be "companyA." You can
    /// specify one or more tags to add to each container. You can add up to 50
    /// tags to each container. For more information about tagging, including naming
    /// and usage conventions, see [Tagging Resources in
    /// MediaStore](https://docs.aws.amazon.com/mediastore/latest/ug/tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified container. You can specify one or more tags
    /// to remove.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listContainersPaginator(self: *Self, params: list_containers.ListContainersInput) paginator.ListContainersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
