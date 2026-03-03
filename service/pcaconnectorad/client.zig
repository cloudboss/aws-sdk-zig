const aws = @import("aws");
const std = @import("std");

const create_connector = @import("create_connector.zig");
const create_directory_registration = @import("create_directory_registration.zig");
const create_service_principal_name = @import("create_service_principal_name.zig");
const create_template = @import("create_template.zig");
const create_template_group_access_control_entry = @import("create_template_group_access_control_entry.zig");
const delete_connector = @import("delete_connector.zig");
const delete_directory_registration = @import("delete_directory_registration.zig");
const delete_service_principal_name = @import("delete_service_principal_name.zig");
const delete_template = @import("delete_template.zig");
const delete_template_group_access_control_entry = @import("delete_template_group_access_control_entry.zig");
const get_connector = @import("get_connector.zig");
const get_directory_registration = @import("get_directory_registration.zig");
const get_service_principal_name = @import("get_service_principal_name.zig");
const get_template = @import("get_template.zig");
const get_template_group_access_control_entry = @import("get_template_group_access_control_entry.zig");
const list_connectors = @import("list_connectors.zig");
const list_directory_registrations = @import("list_directory_registrations.zig");
const list_service_principal_names = @import("list_service_principal_names.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_group_access_control_entries = @import("list_template_group_access_control_entries.zig");
const list_templates = @import("list_templates.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_template = @import("update_template.zig");
const update_template_group_access_control_entry = @import("update_template_group_access_control_entry.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Pca Connector Ad";

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

    /// Creates a connector between Amazon Web Services Private CA and an Active
    /// Directory. You must specify the private CA,
    /// directory ID, and security groups.
    pub fn createConnector(self: *Self, allocator: std.mem.Allocator, input: create_connector.CreateConnectorInput, options: CallOptions) !create_connector.CreateConnectorOutput {
        return create_connector.execute(self, allocator, input, options);
    }

    /// Creates a directory registration that authorizes communication between
    /// Amazon Web Services Private CA and an
    /// Active Directory
    pub fn createDirectoryRegistration(self: *Self, allocator: std.mem.Allocator, input: create_directory_registration.CreateDirectoryRegistrationInput, options: CallOptions) !create_directory_registration.CreateDirectoryRegistrationOutput {
        return create_directory_registration.execute(self, allocator, input, options);
    }

    /// Creates a service principal name (SPN) for the service account in Active
    /// Directory. Kerberos
    /// authentication uses SPNs to associate a service instance with a service
    /// sign-in
    /// account.
    pub fn createServicePrincipalName(self: *Self, allocator: std.mem.Allocator, input: create_service_principal_name.CreateServicePrincipalNameInput, options: CallOptions) !create_service_principal_name.CreateServicePrincipalNameOutput {
        return create_service_principal_name.execute(self, allocator, input, options);
    }

    /// Creates an Active Directory compatible certificate template. The connectors
    /// issues certificates
    /// using these templates based on the requester’s Active Directory group
    /// membership.
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: CallOptions) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// Create a group access control entry. Allow or deny Active Directory groups
    /// from enrolling and/or
    /// autoenrolling with the template based on the group security identifiers
    /// (SIDs).
    pub fn createTemplateGroupAccessControlEntry(self: *Self, allocator: std.mem.Allocator, input: create_template_group_access_control_entry.CreateTemplateGroupAccessControlEntryInput, options: CallOptions) !create_template_group_access_control_entry.CreateTemplateGroupAccessControlEntryOutput {
        return create_template_group_access_control_entry.execute(self, allocator, input, options);
    }

    /// Deletes a connector for Active Directory. You must provide the Amazon
    /// Resource Name (ARN) of the
    /// connector that you want to delete. You can find the ARN by calling the
    /// [https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_ListConnectors](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_ListConnectors)
    /// action. Deleting a connector does not deregister your directory with Amazon
    /// Web Services Private CA. You can
    /// deregister your directory by calling the
    /// [https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_DeleteDirectoryRegistration](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_DeleteDirectoryRegistration)
    /// action.
    pub fn deleteConnector(self: *Self, allocator: std.mem.Allocator, input: delete_connector.DeleteConnectorInput, options: CallOptions) !delete_connector.DeleteConnectorOutput {
        return delete_connector.execute(self, allocator, input, options);
    }

    /// Deletes a directory registration. Deleting a directory registration
    /// deauthorizes
    /// Amazon Web Services Private CA with the directory.
    pub fn deleteDirectoryRegistration(self: *Self, allocator: std.mem.Allocator, input: delete_directory_registration.DeleteDirectoryRegistrationInput, options: CallOptions) !delete_directory_registration.DeleteDirectoryRegistrationOutput {
        return delete_directory_registration.execute(self, allocator, input, options);
    }

    /// Deletes the service principal name (SPN) used by a connector to authenticate
    /// with your
    /// Active Directory.
    pub fn deleteServicePrincipalName(self: *Self, allocator: std.mem.Allocator, input: delete_service_principal_name.DeleteServicePrincipalNameInput, options: CallOptions) !delete_service_principal_name.DeleteServicePrincipalNameOutput {
        return delete_service_principal_name.execute(self, allocator, input, options);
    }

    /// Deletes a template. Certificates issued using the template are still valid
    /// until they
    /// are revoked or expired.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: CallOptions) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Deletes a group access control entry.
    pub fn deleteTemplateGroupAccessControlEntry(self: *Self, allocator: std.mem.Allocator, input: delete_template_group_access_control_entry.DeleteTemplateGroupAccessControlEntryInput, options: CallOptions) !delete_template_group_access_control_entry.DeleteTemplateGroupAccessControlEntryOutput {
        return delete_template_group_access_control_entry.execute(self, allocator, input, options);
    }

    /// Lists information about your connector. You specify the connector on input
    /// by its ARN
    /// (Amazon Resource Name).
    pub fn getConnector(self: *Self, allocator: std.mem.Allocator, input: get_connector.GetConnectorInput, options: CallOptions) !get_connector.GetConnectorOutput {
        return get_connector.execute(self, allocator, input, options);
    }

    /// A structure that contains information about your directory registration.
    pub fn getDirectoryRegistration(self: *Self, allocator: std.mem.Allocator, input: get_directory_registration.GetDirectoryRegistrationInput, options: CallOptions) !get_directory_registration.GetDirectoryRegistrationOutput {
        return get_directory_registration.execute(self, allocator, input, options);
    }

    /// Lists the service principal name that the connector uses to authenticate
    /// with
    /// Active Directory.
    pub fn getServicePrincipalName(self: *Self, allocator: std.mem.Allocator, input: get_service_principal_name.GetServicePrincipalNameInput, options: CallOptions) !get_service_principal_name.GetServicePrincipalNameOutput {
        return get_service_principal_name.execute(self, allocator, input, options);
    }

    /// Retrieves a certificate template that the connector uses to issue
    /// certificates from a
    /// private CA.
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: CallOptions) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Retrieves the group access control entries for a template.
    pub fn getTemplateGroupAccessControlEntry(self: *Self, allocator: std.mem.Allocator, input: get_template_group_access_control_entry.GetTemplateGroupAccessControlEntryInput, options: CallOptions) !get_template_group_access_control_entry.GetTemplateGroupAccessControlEntryOutput {
        return get_template_group_access_control_entry.execute(self, allocator, input, options);
    }

    /// Lists the connectors that you created by using the
    /// [https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateConnector) action.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: CallOptions) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// Lists the directory registrations that you created by using the
    /// [https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateDirectoryRegistration](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateDirectoryRegistration)
    /// action.
    pub fn listDirectoryRegistrations(self: *Self, allocator: std.mem.Allocator, input: list_directory_registrations.ListDirectoryRegistrationsInput, options: CallOptions) !list_directory_registrations.ListDirectoryRegistrationsOutput {
        return list_directory_registrations.execute(self, allocator, input, options);
    }

    /// Lists the service principal names that the connector uses to authenticate
    /// with
    /// Active Directory.
    pub fn listServicePrincipalNames(self: *Self, allocator: std.mem.Allocator, input: list_service_principal_names.ListServicePrincipalNamesInput, options: CallOptions) !list_service_principal_names.ListServicePrincipalNamesOutput {
        return list_service_principal_names.execute(self, allocator, input, options);
    }

    /// Lists the tags, if any, that are associated with your resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists group access control entries you created.
    pub fn listTemplateGroupAccessControlEntries(self: *Self, allocator: std.mem.Allocator, input: list_template_group_access_control_entries.ListTemplateGroupAccessControlEntriesInput, options: CallOptions) !list_template_group_access_control_entries.ListTemplateGroupAccessControlEntriesOutput {
        return list_template_group_access_control_entries.execute(self, allocator, input, options);
    }

    /// Lists the templates, if any, that are associated with a connector.
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: CallOptions) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to your resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from your resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update template configuration to define the information included in
    /// certificates.
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: CallOptions) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    /// Update a group access control entry you created using
    /// [CreateTemplateGroupAccessControlEntry](https://docs.aws.amazon.com/pca-connector-ad/latest/APIReference/API_CreateTemplateGroupAccessControlEntry.html).
    pub fn updateTemplateGroupAccessControlEntry(self: *Self, allocator: std.mem.Allocator, input: update_template_group_access_control_entry.UpdateTemplateGroupAccessControlEntryInput, options: CallOptions) !update_template_group_access_control_entry.UpdateTemplateGroupAccessControlEntryOutput {
        return update_template_group_access_control_entry.execute(self, allocator, input, options);
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDirectoryRegistrationsPaginator(self: *Self, params: list_directory_registrations.ListDirectoryRegistrationsInput) paginator.ListDirectoryRegistrationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listServicePrincipalNamesPaginator(self: *Self, params: list_service_principal_names.ListServicePrincipalNamesInput) paginator.ListServicePrincipalNamesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTemplateGroupAccessControlEntriesPaginator(self: *Self, params: list_template_group_access_control_entries.ListTemplateGroupAccessControlEntriesInput) paginator.ListTemplateGroupAccessControlEntriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTemplatesPaginator(self: *Self, params: list_templates.ListTemplatesInput) paginator.ListTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
