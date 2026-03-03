const aws = @import("aws");
const std = @import("std");

const batch_describe_entities = @import("batch_describe_entities.zig");
const cancel_change_set = @import("cancel_change_set.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const describe_change_set = @import("describe_change_set.zig");
const describe_entity = @import("describe_entity.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const list_change_sets = @import("list_change_sets.zig");
const list_entities = @import("list_entities.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const start_change_set = @import("start_change_set.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Marketplace Catalog";

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

    /// Returns metadata and content for multiple entities. This is the Batch
    /// version of the `DescribeEntity` API and uses the same IAM permission action
    /// as `DescribeEntity` API.
    pub fn batchDescribeEntities(self: *Self, allocator: std.mem.Allocator, input: batch_describe_entities.BatchDescribeEntitiesInput, options: batch_describe_entities.Options) !batch_describe_entities.BatchDescribeEntitiesOutput {
        return batch_describe_entities.execute(self, allocator, input, options);
    }

    /// Used to cancel an open change request. Must be sent before the status of the
    /// request
    /// changes to `APPLYING`, the final stage of completing your change request.
    /// You
    /// can describe a change during the 60-day request history retention period for
    /// API
    /// calls.
    pub fn cancelChangeSet(self: *Self, allocator: std.mem.Allocator, input: cancel_change_set.CancelChangeSetInput, options: cancel_change_set.Options) !cancel_change_set.CancelChangeSetOutput {
        return cancel_change_set.execute(self, allocator, input, options);
    }

    /// Deletes a resource-based policy on an entity that is identified by its
    /// resource
    /// ARN.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: delete_resource_policy.Options) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Provides information about a given change set.
    pub fn describeChangeSet(self: *Self, allocator: std.mem.Allocator, input: describe_change_set.DescribeChangeSetInput, options: describe_change_set.Options) !describe_change_set.DescribeChangeSetOutput {
        return describe_change_set.execute(self, allocator, input, options);
    }

    /// Returns the metadata and content of the entity.
    pub fn describeEntity(self: *Self, allocator: std.mem.Allocator, input: describe_entity.DescribeEntityInput, options: describe_entity.Options) !describe_entity.DescribeEntityOutput {
        return describe_entity.execute(self, allocator, input, options);
    }

    /// Gets a resource-based policy of an entity that is identified by its resource
    /// ARN.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: get_resource_policy.Options) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns the list of change sets owned by the account being used to make the
    /// call. You
    /// can filter this list by providing any combination of `entityId`,
    /// `ChangeSetName`, and status. If you provide more than one filter, the API
    /// operation applies a logical AND between the filters.
    ///
    /// You can describe a change during the 60-day request history retention period
    /// for API
    /// calls.
    pub fn listChangeSets(self: *Self, allocator: std.mem.Allocator, input: list_change_sets.ListChangeSetsInput, options: list_change_sets.Options) !list_change_sets.ListChangeSetsOutput {
        return list_change_sets.execute(self, allocator, input, options);
    }

    /// Provides the list of entities of a given type.
    pub fn listEntities(self: *Self, allocator: std.mem.Allocator, input: list_entities.ListEntitiesInput, options: list_entities.Options) !list_entities.ListEntitiesOutput {
        return list_entities.execute(self, allocator, input, options);
    }

    /// Lists all tags that have been added to a resource (either an
    /// [entity](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#catalog-api-entities) or [change set](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#working-with-change-sets)).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Attaches a resource-based policy to an entity. Examples of an entity
    /// include:
    /// `AmiProduct` and `ContainerProduct`.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: put_resource_policy.Options) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Allows you to request changes for your entities. Within a single
    /// `ChangeSet`, you can't start the same change type against the same entity
    /// multiple times. Additionally, when a `ChangeSet` is running, all the
    /// entities
    /// targeted by the different changes are locked until the change set has
    /// completed (either
    /// succeeded, cancelled, or failed). If you try to start a change set
    /// containing a change
    /// against an entity that is already locked, you will receive a
    /// `ResourceInUseException` error.
    ///
    /// For example, you can't start the `ChangeSet` described in the
    /// [example](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/API_StartChangeSet.html#API_StartChangeSet_Examples) later in this topic because it contains two changes to run the same
    /// change type (`AddRevisions`) against the same entity
    /// (`entity-id@1`).
    ///
    /// For more information about working with change sets, see [ Working with
    /// change
    /// sets](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#working-with-change-sets). For information about change types for
    /// single-AMI products, see [Working with single-AMI
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/ami-products.html#working-with-single-AMI-products). Also, for more information about change
    /// types available for container-based products, see [Working with container
    /// products](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/container-products.html#working-with-container-products).
    ///
    /// To download "DetailsDocument" shapes, see
    /// [Python](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-python)
    /// and
    /// [Java](https://github.com/awslabs/aws-marketplace-catalog-api-shapes-for-java/tree/main) shapes on GitHub.
    pub fn startChangeSet(self: *Self, allocator: std.mem.Allocator, input: start_change_set.StartChangeSetInput, options: start_change_set.Options) !start_change_set.StartChangeSetOutput {
        return start_change_set.execute(self, allocator, input, options);
    }

    /// Tags a resource (either an
    /// [entity](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#catalog-api-entities) or [change set](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#working-with-change-sets)).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or list of tags from a resource (either an
    /// [entity](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#catalog-api-entities) or [change set](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/welcome.html#working-with-change-sets)).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listChangeSetsPaginator(self: *Self, params: list_change_sets.ListChangeSetsInput) paginator.ListChangeSetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEntitiesPaginator(self: *Self, params: list_entities.ListEntitiesInput) paginator.ListEntitiesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
