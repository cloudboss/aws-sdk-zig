const aws = @import("aws");
const std = @import("std");

const create_application = @import("create_application.zig");
const create_data_integration = @import("create_data_integration.zig");
const create_data_integration_association = @import("create_data_integration_association.zig");
const create_event_integration = @import("create_event_integration.zig");
const delete_application = @import("delete_application.zig");
const delete_data_integration = @import("delete_data_integration.zig");
const delete_event_integration = @import("delete_event_integration.zig");
const get_application = @import("get_application.zig");
const get_data_integration = @import("get_data_integration.zig");
const get_event_integration = @import("get_event_integration.zig");
const list_application_associations = @import("list_application_associations.zig");
const list_applications = @import("list_applications.zig");
const list_data_integration_associations = @import("list_data_integration_associations.zig");
const list_data_integrations = @import("list_data_integrations.zig");
const list_event_integration_associations = @import("list_event_integration_associations.zig");
const list_event_integrations = @import("list_event_integrations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_data_integration = @import("update_data_integration.zig");
const update_data_integration_association = @import("update_data_integration_association.zig");
const update_event_integration = @import("update_event_integration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "AppIntegrations";

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

    /// Creates and persists an Application resource.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: create_application.Options) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates and persists a DataIntegration resource.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been
    /// previously associated. Use a different DataIntegration, or recreate the
    /// DataIntegration
    /// using the `CreateDataIntegration` API.
    pub fn createDataIntegration(self: *Self, allocator: std.mem.Allocator, input: create_data_integration.CreateDataIntegrationInput, options: create_data_integration.Options) !create_data_integration.CreateDataIntegrationOutput {
        return create_data_integration.execute(self, allocator, input, options);
    }

    /// Creates and persists a DataIntegrationAssociation resource.
    pub fn createDataIntegrationAssociation(self: *Self, allocator: std.mem.Allocator, input: create_data_integration_association.CreateDataIntegrationAssociationInput, options: create_data_integration_association.Options) !create_data_integration_association.CreateDataIntegrationAssociationOutput {
        return create_data_integration_association.execute(self, allocator, input, options);
    }

    /// Creates an EventIntegration, given a specified name, description, and a
    /// reference to an
    /// Amazon EventBridge bus in your account and a partner event source that
    /// pushes events to
    /// that bus. No objects are created in the your account, only metadata that is
    /// persisted on the
    /// EventIntegration control plane.
    pub fn createEventIntegration(self: *Self, allocator: std.mem.Allocator, input: create_event_integration.CreateEventIntegrationInput, options: create_event_integration.Options) !create_event_integration.CreateEventIntegrationOutput {
        return create_event_integration.execute(self, allocator, input, options);
    }

    /// Deletes the Application. Only Applications that don't have any Application
    /// Associations
    /// can be deleted.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: delete_application.Options) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes the DataIntegration. Only DataIntegrations that don't have any
    /// DataIntegrationAssociations can be deleted. Deleting a DataIntegration also
    /// deletes the
    /// underlying Amazon AppFlow flow and service linked role.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been previously associated.
    /// Use a different DataIntegration, or recreate the DataIntegration using the
    /// [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) API.
    pub fn deleteDataIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_data_integration.DeleteDataIntegrationInput, options: delete_data_integration.Options) !delete_data_integration.DeleteDataIntegrationOutput {
        return delete_data_integration.execute(self, allocator, input, options);
    }

    /// Deletes the specified existing event integration. If the event integration
    /// is associated
    /// with clients, the request is rejected.
    pub fn deleteEventIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_event_integration.DeleteEventIntegrationInput, options: delete_event_integration.Options) !delete_event_integration.DeleteEventIntegrationOutput {
        return delete_event_integration.execute(self, allocator, input, options);
    }

    /// Get an Application resource.
    pub fn getApplication(self: *Self, allocator: std.mem.Allocator, input: get_application.GetApplicationInput, options: get_application.Options) !get_application.GetApplicationOutput {
        return get_application.execute(self, allocator, input, options);
    }

    /// Returns information about the DataIntegration.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been previously associated.
    /// Use a different DataIntegration, or recreate the DataIntegration using the
    /// [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) API.
    pub fn getDataIntegration(self: *Self, allocator: std.mem.Allocator, input: get_data_integration.GetDataIntegrationInput, options: get_data_integration.Options) !get_data_integration.GetDataIntegrationOutput {
        return get_data_integration.execute(self, allocator, input, options);
    }

    /// Returns information about the event integration.
    pub fn getEventIntegration(self: *Self, allocator: std.mem.Allocator, input: get_event_integration.GetEventIntegrationInput, options: get_event_integration.Options) !get_event_integration.GetEventIntegrationOutput {
        return get_event_integration.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of application associations for an application.
    pub fn listApplicationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_application_associations.ListApplicationAssociationsInput, options: list_application_associations.Options) !list_application_associations.ListApplicationAssociationsOutput {
        return list_application_associations.execute(self, allocator, input, options);
    }

    /// Lists applications in the account.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: list_applications.Options) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of DataIntegration associations in the account.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been previously associated.
    /// Use a different DataIntegration, or recreate the DataIntegration using the
    /// [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) API.
    pub fn listDataIntegrationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_data_integration_associations.ListDataIntegrationAssociationsInput, options: list_data_integration_associations.Options) !list_data_integration_associations.ListDataIntegrationAssociationsOutput {
        return list_data_integration_associations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of DataIntegrations in the account.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been previously associated.
    /// Use a different DataIntegration, or recreate the DataIntegration using the
    /// [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) API.
    pub fn listDataIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_data_integrations.ListDataIntegrationsInput, options: list_data_integrations.Options) !list_data_integrations.ListDataIntegrationsOutput {
        return list_data_integrations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of event integration associations in the account.
    pub fn listEventIntegrationAssociations(self: *Self, allocator: std.mem.Allocator, input: list_event_integration_associations.ListEventIntegrationAssociationsInput, options: list_event_integration_associations.Options) !list_event_integration_associations.ListEventIntegrationAssociationsOutput {
        return list_event_integration_associations.execute(self, allocator, input, options);
    }

    /// Returns a paginated list of event integrations in the account.
    pub fn listEventIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_event_integrations.ListEventIntegrationsInput, options: list_event_integrations.Options) !list_event_integrations.ListEventIntegrationsOutput {
        return list_event_integrations.execute(self, allocator, input, options);
    }

    /// Lists the tags for the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds the specified tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates and persists an Application resource.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: update_application.Options) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the description of a DataIntegration.
    ///
    /// You cannot create a DataIntegration association for a DataIntegration that
    /// has been previously associated.
    /// Use a different DataIntegration, or recreate the DataIntegration using the
    /// [CreateDataIntegration](https://docs.aws.amazon.com/appintegrations/latest/APIReference/API_CreateDataIntegration.html) API.
    pub fn updateDataIntegration(self: *Self, allocator: std.mem.Allocator, input: update_data_integration.UpdateDataIntegrationInput, options: update_data_integration.Options) !update_data_integration.UpdateDataIntegrationOutput {
        return update_data_integration.execute(self, allocator, input, options);
    }

    /// Updates and persists a DataIntegrationAssociation resource.
    ///
    /// Updating a DataIntegrationAssociation with ExecutionConfiguration will rerun
    /// the on-demand job.
    pub fn updateDataIntegrationAssociation(self: *Self, allocator: std.mem.Allocator, input: update_data_integration_association.UpdateDataIntegrationAssociationInput, options: update_data_integration_association.Options) !update_data_integration_association.UpdateDataIntegrationAssociationOutput {
        return update_data_integration_association.execute(self, allocator, input, options);
    }

    /// Updates the description of an event integration.
    pub fn updateEventIntegration(self: *Self, allocator: std.mem.Allocator, input: update_event_integration.UpdateEventIntegrationInput, options: update_event_integration.Options) !update_event_integration.UpdateEventIntegrationOutput {
        return update_event_integration.execute(self, allocator, input, options);
    }

    pub fn listApplicationAssociationsPaginator(self: *Self, params: list_application_associations.ListApplicationAssociationsInput) paginator.ListApplicationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataIntegrationAssociationsPaginator(self: *Self, params: list_data_integration_associations.ListDataIntegrationAssociationsInput) paginator.ListDataIntegrationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataIntegrationsPaginator(self: *Self, params: list_data_integrations.ListDataIntegrationsInput) paginator.ListDataIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventIntegrationAssociationsPaginator(self: *Self, params: list_event_integration_associations.ListEventIntegrationAssociationsInput) paginator.ListEventIntegrationAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEventIntegrationsPaginator(self: *Self, params: list_event_integrations.ListEventIntegrationsInput) paginator.ListEventIntegrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
