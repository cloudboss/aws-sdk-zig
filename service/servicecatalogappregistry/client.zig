const aws = @import("aws");
const std = @import("std");

const associate_attribute_group = @import("associate_attribute_group.zig");
const associate_resource = @import("associate_resource.zig");
const create_application = @import("create_application.zig");
const create_attribute_group = @import("create_attribute_group.zig");
const delete_application = @import("delete_application.zig");
const delete_attribute_group = @import("delete_attribute_group.zig");
const disassociate_attribute_group = @import("disassociate_attribute_group.zig");
const disassociate_resource = @import("disassociate_resource.zig");
const get_application = @import("get_application.zig");
const get_associated_resource = @import("get_associated_resource.zig");
const get_attribute_group = @import("get_attribute_group.zig");
const get_configuration = @import("get_configuration.zig");
const list_applications = @import("list_applications.zig");
const list_associated_attribute_groups = @import("list_associated_attribute_groups.zig");
const list_associated_resources = @import("list_associated_resources.zig");
const list_attribute_groups = @import("list_attribute_groups.zig");
const list_attribute_groups_for_application = @import("list_attribute_groups_for_application.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_configuration = @import("put_configuration.zig");
const sync_resource = @import("sync_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_attribute_group = @import("update_attribute_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Service Catalog AppRegistry";

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

    /// Associates an attribute group with an application to augment the
    /// application's metadata
    /// with the group's attributes. This feature enables applications to be
    /// described with
    /// user-defined details that are machine-readable, such as third-party
    /// integrations.
    pub fn associateAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: associate_attribute_group.AssociateAttributeGroupInput, options: associate_attribute_group.Options) !associate_attribute_group.AssociateAttributeGroupOutput {
        return associate_attribute_group.execute(self, allocator, input, options);
    }

    /// Associates a resource with an application.
    /// The resource can be specified by its ARN or name.
    /// The application can be specified by ARN, ID, or name.
    ///
    /// **Minimum permissions**
    ///
    /// You must have the following permissions to associate a resource using the
    /// `OPTIONS` parameter set to `APPLY_APPLICATION_TAG`.
    ///
    /// * `tag:GetResources`
    ///
    /// * `tag:TagResources`
    ///
    /// You must also have these additional permissions if you don't use the
    /// `AWSServiceCatalogAppRegistryFullAccess` policy.
    /// For more information, see
    /// [AWSServiceCatalogAppRegistryFullAccess](https://docs.aws.amazon.com/servicecatalog/latest/arguide/full.html) in the AppRegistry Administrator Guide.
    ///
    /// * `resource-groups:AssociateResource`
    ///
    /// * `cloudformation:UpdateStack`
    ///
    /// * `cloudformation:DescribeStacks`
    ///
    /// In addition, you must have the tagging permission defined by the Amazon Web
    /// Services service that creates the resource.
    /// For more information, see
    /// [TagResources](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_TagResources.html) in the *Resource Groups Tagging API Reference*.
    pub fn associateResource(self: *Self, allocator: std.mem.Allocator, input: associate_resource.AssociateResourceInput, options: associate_resource.Options) !associate_resource.AssociateResourceOutput {
        return associate_resource.execute(self, allocator, input, options);
    }

    /// Creates a new application that is the top-level node in a hierarchy of
    /// related cloud resource abstractions.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates a new attribute group as a container for user-defined attributes.
    /// This feature
    /// enables users to have full control over their cloud application's metadata
    /// in a rich
    /// machine-readable format to facilitate integration with automated workflows
    /// and third-party
    /// tools.
    pub fn createAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: create_attribute_group.CreateAttributeGroupInput, options: create_attribute_group.Options) !create_attribute_group.CreateAttributeGroupOutput {
        return create_attribute_group.execute(self, allocator, input, options);
    }

    /// Deletes an application that is specified either by its application ID, name,
    /// or ARN. All associated attribute groups and resources must be disassociated
    /// from it before deleting an application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an attribute group, specified either by its attribute group ID,
    /// name, or ARN.
    pub fn deleteAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: delete_attribute_group.DeleteAttributeGroupInput, options: delete_attribute_group.Options) !delete_attribute_group.DeleteAttributeGroupOutput {
        return delete_attribute_group.execute(self, allocator, input, options);
    }

    /// Disassociates an attribute group from an application to remove the extra
    /// attributes contained in the attribute group from the application's metadata.
    /// This operation reverts `AssociateAttributeGroup`.
    pub fn disassociateAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: disassociate_attribute_group.DisassociateAttributeGroupInput, options: disassociate_attribute_group.Options) !disassociate_attribute_group.DisassociateAttributeGroupOutput {
        return disassociate_attribute_group.execute(self, allocator, input, options);
    }

    /// Disassociates a resource from application.
    /// Both the resource and the application can be specified either by ID or name.
    ///
    /// **Minimum permissions**
    ///
    /// You must have the following permissions to remove a resource that's been
    /// associated with an application using the `APPLY_APPLICATION_TAG` option for
    /// [AssociateResource](https://docs.aws.amazon.com/servicecatalog/latest/dg/API_app-registry_AssociateResource.html).
    ///
    /// * `tag:GetResources`
    ///
    /// * `tag:UntagResources`
    ///
    /// You must also have the following permissions if you don't use the
    /// `AWSServiceCatalogAppRegistryFullAccess` policy.
    /// For more information, see
    /// [AWSServiceCatalogAppRegistryFullAccess](https://docs.aws.amazon.com/servicecatalog/latest/arguide/full.html) in the AppRegistry Administrator Guide.
    ///
    /// * `resource-groups:DisassociateResource`
    ///
    /// * `cloudformation:UpdateStack`
    ///
    /// * `cloudformation:DescribeStacks`
    ///
    /// In addition, you must have the tagging permission defined by the Amazon Web
    /// Services service that creates the resource.
    /// For more information, see
    /// [UntagResources](https://docs.aws.amazon.com/resourcegroupstagging/latest/APIReference/API_UntTagResources.html) in the *Resource Groups Tagging API Reference*.
    pub fn disassociateResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource.DisassociateResourceInput, options: disassociate_resource.Options) !disassociate_resource.DisassociateResourceOutput {
        return disassociate_resource.execute(self, allocator, input, options);
    }

    /// Retrieves metadata information
    /// about one
    /// of your applications.
    /// The application can be specified
    /// by its ARN, ID, or name
    /// (which is unique
    /// within one account
    /// in one region
    /// at a given point
    /// in time).
    /// Specify
    /// by ARN or ID
    /// in automated workflows
    /// if you want
    /// to make sure
    /// that the exact same application is returned or a `ResourceNotFoundException`
    /// is thrown,
    /// avoiding the ABA addressing problem.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Gets the resource associated with the application.
    pub fn getAssociatedResource(self: *Self, allocator: std.mem.Allocator, input: get_associated_resource.GetAssociatedResourceInput, options: get_associated_resource.Options) !get_associated_resource.GetAssociatedResourceOutput {
        return get_associated_resource.execute(self, allocator, input, options);
    }

    /// Retrieves an attribute group
    /// by its ARN, ID, or name.
    /// The attribute group can be specified
    /// by its ARN, ID, or name.
    pub fn getAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: get_attribute_group.GetAttributeGroupInput, options: get_attribute_group.Options) !get_attribute_group.GetAttributeGroupOutput {
        return get_attribute_group.execute(self, allocator, input, options);
    }

    /// Retrieves a `TagKey` configuration
    /// from an account.
    pub fn getConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_configuration.GetConfigurationInput, options: get_configuration.Options) !get_configuration.GetConfigurationOutput {
        return get_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all of your applications. Results are paginated.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Lists all attribute groups that are associated with specified application.
    /// Results are paginated.
    pub fn listAssociatedAttributeGroups(self: *Self, allocator: std.mem.Allocator, input: list_associated_attribute_groups.ListAssociatedAttributeGroupsInput, options: list_associated_attribute_groups.Options) !list_associated_attribute_groups.ListAssociatedAttributeGroupsOutput {
        return list_associated_attribute_groups.execute(self, allocator, input, options);
    }

    /// Lists all
    /// of the resources
    /// that are associated
    /// with the specified application.
    /// Results are paginated.
    ///
    /// If you share an application,
    /// and a consumer account associates a tag query
    /// to the application,
    /// all of the users
    /// who can access the application
    /// can also view the tag values
    /// in all accounts
    /// that are associated
    /// with it
    /// using this API.
    pub fn listAssociatedResources(self: *Self, allocator: std.mem.Allocator, input: list_associated_resources.ListAssociatedResourcesInput, options: list_associated_resources.Options) !list_associated_resources.ListAssociatedResourcesOutput {
        return list_associated_resources.execute(self, allocator, input, options);
    }

    /// Lists all attribute groups which you have access to. Results are paginated.
    pub fn listAttributeGroups(self: *Self, allocator: std.mem.Allocator, input: list_attribute_groups.ListAttributeGroupsInput, options: list_attribute_groups.Options) !list_attribute_groups.ListAttributeGroupsOutput {
        return list_attribute_groups.execute(self, allocator, input, options);
    }

    /// Lists the details of all attribute groups associated with a specific
    /// application. The results display in pages.
    pub fn listAttributeGroupsForApplication(self: *Self, allocator: std.mem.Allocator, input: list_attribute_groups_for_application.ListAttributeGroupsForApplicationInput, options: list_attribute_groups_for_application.Options) !list_attribute_groups_for_application.ListAttributeGroupsForApplicationOutput {
        return list_attribute_groups_for_application.execute(self, allocator, input, options);
    }

    /// Lists all of the tags on the resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Associates a `TagKey` configuration
    /// to an account.
    pub fn putConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_configuration.PutConfigurationInput, options: put_configuration.Options) !put_configuration.PutConfigurationOutput {
        return put_configuration.execute(self, allocator, input, options);
    }

    /// Syncs the resource with current AppRegistry records.
    ///
    /// Specifically, the resource’s AppRegistry system tags sync with its
    /// associated application. We remove the resource's AppRegistry system tags if
    /// it does not associate with the application. The caller must have permissions
    /// to read and update the resource.
    pub fn syncResource(self: *Self, allocator: std.mem.Allocator, input: sync_resource.SyncResourceInput, options: sync_resource.Options) !sync_resource.SyncResourceOutput {
        return sync_resource.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified resource.
    ///
    /// Each tag consists of a key and an optional value. If a tag with the same key
    /// is already associated with the resource, this action updates its value.
    ///
    /// This operation returns an empty response if the call was successful.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a resource.
    ///
    /// This operation returns an empty response if the call was successful.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing application with new attributes.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates an existing attribute group with new details.
    pub fn updateAttributeGroup(self: *Self, allocator: std.mem.Allocator, input: update_attribute_group.UpdateAttributeGroupInput, options: update_attribute_group.Options) !update_attribute_group.UpdateAttributeGroupOutput {
        return update_attribute_group.execute(self, allocator, input, options);
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedAttributeGroupsPaginator(self: *Self, params: list_associated_attribute_groups.ListAssociatedAttributeGroupsInput) paginator.ListAssociatedAttributeGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAssociatedResourcesPaginator(self: *Self, params: list_associated_resources.ListAssociatedResourcesInput) paginator.ListAssociatedResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttributeGroupsPaginator(self: *Self, params: list_attribute_groups.ListAttributeGroupsInput) paginator.ListAttributeGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listAttributeGroupsForApplicationPaginator(self: *Self, params: list_attribute_groups_for_application.ListAttributeGroupsForApplicationInput) paginator.ListAttributeGroupsForApplicationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
