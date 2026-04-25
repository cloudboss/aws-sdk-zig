const aws = @import("aws");
const std = @import("std");

const batch_get_case_rule = @import("batch_get_case_rule.zig");
const batch_get_field = @import("batch_get_field.zig");
const batch_put_field_options = @import("batch_put_field_options.zig");
const create_case = @import("create_case.zig");
const create_case_rule = @import("create_case_rule.zig");
const create_domain = @import("create_domain.zig");
const create_field = @import("create_field.zig");
const create_layout = @import("create_layout.zig");
const create_related_item = @import("create_related_item.zig");
const create_template = @import("create_template.zig");
const delete_case = @import("delete_case.zig");
const delete_case_rule = @import("delete_case_rule.zig");
const delete_domain = @import("delete_domain.zig");
const delete_field = @import("delete_field.zig");
const delete_layout = @import("delete_layout.zig");
const delete_related_item = @import("delete_related_item.zig");
const delete_template = @import("delete_template.zig");
const get_case = @import("get_case.zig");
const get_case_audit_events = @import("get_case_audit_events.zig");
const get_case_event_configuration = @import("get_case_event_configuration.zig");
const get_domain = @import("get_domain.zig");
const get_layout = @import("get_layout.zig");
const get_template = @import("get_template.zig");
const list_case_rules = @import("list_case_rules.zig");
const list_cases_for_contact = @import("list_cases_for_contact.zig");
const list_domains = @import("list_domains.zig");
const list_field_options = @import("list_field_options.zig");
const list_fields = @import("list_fields.zig");
const list_layouts = @import("list_layouts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_templates = @import("list_templates.zig");
const put_case_event_configuration = @import("put_case_event_configuration.zig");
const search_all_related_items = @import("search_all_related_items.zig");
const search_cases = @import("search_cases.zig");
const search_related_items = @import("search_related_items.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_case = @import("update_case.zig");
const update_case_rule = @import("update_case_rule.zig");
const update_field = @import("update_field.zig");
const update_layout = @import("update_layout.zig");
const update_related_item = @import("update_related_item.zig");
const update_template = @import("update_template.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ConnectCases";

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

    /// Gets a batch of case rules. In the Amazon Connect admin website, case rules
    /// are known as *case field conditions*. For more information about case field
    /// conditions, see [Add case field conditions to a case
    /// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
    pub fn batchGetCaseRule(self: *Self, allocator: std.mem.Allocator, input: batch_get_case_rule.BatchGetCaseRuleInput, options: CallOptions) !batch_get_case_rule.BatchGetCaseRuleOutput {
        return batch_get_case_rule.execute(self, allocator, input, options);
    }

    /// Returns the description for the list of fields in the request parameters.
    pub fn batchGetField(self: *Self, allocator: std.mem.Allocator, input: batch_get_field.BatchGetFieldInput, options: CallOptions) !batch_get_field.BatchGetFieldOutput {
        return batch_get_field.execute(self, allocator, input, options);
    }

    /// Creates and updates a set of field options for a single select field in a
    /// Cases domain.
    pub fn batchPutFieldOptions(self: *Self, allocator: std.mem.Allocator, input: batch_put_field_options.BatchPutFieldOptionsInput, options: CallOptions) !batch_put_field_options.BatchPutFieldOptionsOutput {
        return batch_put_field_options.execute(self, allocator, input, options);
    }

    /// If you provide a value for `PerformedBy.UserArn` you must also have
    /// [connect:DescribeUser](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeUser.html) permission on the User ARN resource that you provide
    ///
    /// Creates a case in the specified Cases domain. Case system and custom fields
    /// are taken as an array id/value pairs with a declared data types.
    ///
    /// When creating a case from a template that has tag propagation
    /// configurations, the specified tags are automatically applied to the case.
    ///
    /// The following fields are required when creating a case:
    ///
    /// * `customer_id` - You must provide the full customer profile ARN in this
    ///   format: `arn:aws:profile:your_AWS_Region:your_AWS_account
    ///   ID:domains/your_profiles_domain_name/profiles/profile_ID`
    /// * `title`
    pub fn createCase(self: *Self, allocator: std.mem.Allocator, input: create_case.CreateCaseInput, options: CallOptions) !create_case.CreateCaseOutput {
        return create_case.execute(self, allocator, input, options);
    }

    /// Creates a new case rule. In the Amazon Connect admin website, case rules are
    /// known as *case field conditions*. For more information about case field
    /// conditions, see [Add case field conditions to a case
    /// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
    pub fn createCaseRule(self: *Self, allocator: std.mem.Allocator, input: create_case_rule.CreateCaseRuleInput, options: CallOptions) !create_case_rule.CreateCaseRuleOutput {
        return create_case_rule.execute(self, allocator, input, options);
    }

    /// Creates a domain, which is a container for all case data, such as cases,
    /// fields, templates and layouts. Each Amazon Connect instance can be
    /// associated with only one Cases domain.
    ///
    /// This will not associate your connect instance to Cases domain. Instead, use
    /// the Amazon Connect
    /// [CreateIntegrationAssociation](https://docs.aws.amazon.com/connect/latest/APIReference/API_CreateIntegrationAssociation.html) API. You need specific IAM permissions to successfully associate the Cases domain. For more information, see [Onboard to Cases](https://docs.aws.amazon.com/connect/latest/adminguide/required-permissions-iam-cases.html#onboard-cases-iam).
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: CallOptions) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates a field in the Cases domain. This field is used to define the case
    /// object model (that is, defines what data can be captured on cases) in a
    /// Cases domain.
    pub fn createField(self: *Self, allocator: std.mem.Allocator, input: create_field.CreateFieldInput, options: CallOptions) !create_field.CreateFieldOutput {
        return create_field.execute(self, allocator, input, options);
    }

    /// Creates a layout in the Cases domain. Layouts define the following
    /// configuration in the top section and More Info tab of the Cases user
    /// interface:
    ///
    /// * Fields to display to the users
    /// * Field ordering
    ///
    /// Title and Status fields cannot be part of layouts since they are not
    /// configurable.
    pub fn createLayout(self: *Self, allocator: std.mem.Allocator, input: create_layout.CreateLayoutInput, options: CallOptions) !create_layout.CreateLayoutOutput {
        return create_layout.execute(self, allocator, input, options);
    }

    /// Creates a related item (comments, tasks, and contacts) and associates it
    /// with a case.
    ///
    /// There's a quota for the number of fields allowed in a Custom type related
    /// item. See [Amazon Connect Cases
    /// quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#cases-quotas).
    ///
    /// **Use cases**
    ///
    /// Following are examples of related items that you may want to associate with
    /// a case:
    ///
    /// * Related contacts, such as calls, chats, emails tasks
    /// * Comments, for agent notes
    /// * SLAs, to capture target resolution goals
    /// * Cases, to capture related Amazon Connect Cases
    /// * Files, such as policy documentation or customer-provided attachments
    /// * Custom related items, which provide flexibility for you to define related
    ///   items that such as bookings, orders, products, notices, and more
    ///
    /// **Important things to know**
    ///
    /// * If you are associating a contact to a case by passing in `Contact` for a
    ///   `type`, you must have
    ///   [DescribeContact](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeContact.html) permission on the ARN of the contact that you provide in `content.contact.contactArn`.
    /// * A Related Item is a resource that is associated with a case. It may or may
    ///   not have an external identifier linking it to an external resource (for
    ///   example, a `contactArn`). All Related Items have their own internal
    ///   identifier, the `relatedItemArn`. Examples of related items include
    ///   `comments` and `contacts`.
    /// * If you provide a value for `performedBy.userArn` you must also have
    ///   [DescribeUser](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeUser.html) permission on the ARN of the user that you provide.
    /// * The `type` field is reserved for internal use only.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn createRelatedItem(self: *Self, allocator: std.mem.Allocator, input: create_related_item.CreateRelatedItemInput, options: CallOptions) !create_related_item.CreateRelatedItemOutput {
        return create_related_item.execute(self, allocator, input, options);
    }

    /// Creates a template in the Cases domain. This template is used to define the
    /// case object model (that is, to define what data can be captured on cases) in
    /// a Cases domain. A template must have a unique name within a domain, and it
    /// must reference existing field IDs and layout IDs. Additionally, multiple
    /// fields with same IDs are not allowed within the same Template. A template
    /// can be either Active or Inactive, as indicated by its status. Inactive
    /// templates cannot be used to create cases.
    ///
    /// Other template APIs are:
    ///
    /// *
    ///   [DeleteTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_DeleteTemplate.html)
    /// *
    ///   [GetTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_GetTemplate.html)
    /// *
    ///   [ListTemplates](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_ListTemplates.html)
    /// *
    ///   [UpdateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_UpdateTemplate.html)
    pub fn createTemplate(self: *Self, allocator: std.mem.Allocator, input: create_template.CreateTemplateInput, options: CallOptions) !create_template.CreateTemplateOutput {
        return create_template.execute(self, allocator, input, options);
    }

    /// The DeleteCase API permanently deletes a case and all its associated
    /// resources from the cases data store. After a successful deletion, you
    /// cannot:
    ///
    /// * Retrieve related items
    /// * Access audit history
    /// * Perform any operations that require the CaseID
    ///
    /// This action is irreversible. After you delete a case, you cannot recover its
    /// data.
    pub fn deleteCase(self: *Self, allocator: std.mem.Allocator, input: delete_case.DeleteCaseInput, options: CallOptions) !delete_case.DeleteCaseOutput {
        return delete_case.execute(self, allocator, input, options);
    }

    /// Deletes a case rule. In the Amazon Connect admin website, case rules are
    /// known as *case field conditions*. For more information about case field
    /// conditions, see [Add case field conditions to a case
    /// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
    pub fn deleteCaseRule(self: *Self, allocator: std.mem.Allocator, input: delete_case_rule.DeleteCaseRuleInput, options: CallOptions) !delete_case_rule.DeleteCaseRuleOutput {
        return delete_case_rule.execute(self, allocator, input, options);
    }

    /// Deletes a Cases domain.
    ///
    /// After deleting your domain you must disassociate the deleted domain from
    /// your Amazon Connect instance with another API call before being able to use
    /// Cases again with this Amazon Connect instance. See
    /// [DeleteIntegrationAssociation](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteIntegrationAssociation.html).
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes a field from a cases template.
    ///
    /// After a field is deleted:
    ///
    /// * You can still retrieve the field by calling `BatchGetField`.
    /// * You cannot update a deleted field by calling `UpdateField`; it throws a
    ///   `ValidationException`.
    /// * Deleted fields are not included in the `ListFields` response.
    /// * Calling `CreateCase` with a deleted field throws a `ValidationException`
    ///   denoting which field identifiers in the request have been deleted.
    /// * Calling `GetCase` with a deleted field identifier returns the deleted
    ///   field's value if one exists.
    /// * Calling `UpdateCase` with a deleted field ID throws a
    ///   `ValidationException` if the case does not already contain a value for the
    ///   deleted field. Otherwise it succeeds, allowing you to update or remove
    ///   (using `emptyValue: {}`) the field's value from the case.
    /// * `GetTemplate` does not return field IDs for deleted fields.
    /// * `GetLayout` does not return field IDs for deleted fields.
    /// * Calling `SearchCases` with the deleted field ID as a filter returns any
    ///   cases that have a value for the deleted field that matches the filter
    ///   criteria.
    /// * Calling `SearchCases` with a `searchTerm` value that matches a deleted
    ///   field's value on a case returns the case in the response.
    /// * Calling `BatchPutFieldOptions` with a deleted field ID throw a
    ///   `ValidationException`.
    /// * Calling `GetCaseEventConfiguration` does not return field IDs for deleted
    ///   fields.
    pub fn deleteField(self: *Self, allocator: std.mem.Allocator, input: delete_field.DeleteFieldInput, options: CallOptions) !delete_field.DeleteFieldOutput {
        return delete_field.execute(self, allocator, input, options);
    }

    /// Deletes a layout from a cases template. You can delete up to 100 layouts per
    /// domain.
    ///
    /// After a layout is deleted:
    ///
    /// * You can still retrieve the layout by calling `GetLayout`.
    /// * You cannot update a deleted layout by calling `UpdateLayout`; it throws a
    ///   `ValidationException`.
    /// * Deleted layouts are not included in the `ListLayouts` response.
    pub fn deleteLayout(self: *Self, allocator: std.mem.Allocator, input: delete_layout.DeleteLayoutInput, options: CallOptions) !delete_layout.DeleteLayoutOutput {
        return delete_layout.execute(self, allocator, input, options);
    }

    /// Deletes the related item resource under a case.
    ///
    /// This API cannot be used on a FILE type related attachment. To delete this
    /// type of file, use the
    /// [DeleteAttachedFile](https://docs.aws.amazon.com/connect/latest/APIReference/API_DeleteAttachedFile.html) API
    pub fn deleteRelatedItem(self: *Self, allocator: std.mem.Allocator, input: delete_related_item.DeleteRelatedItemInput, options: CallOptions) !delete_related_item.DeleteRelatedItemOutput {
        return delete_related_item.execute(self, allocator, input, options);
    }

    /// Deletes a cases template. You can delete up to 100 templates per domain.
    ///
    /// After a cases template is deleted:
    ///
    /// * You can still retrieve the template by calling `GetTemplate`.
    /// * You cannot update the template.
    /// * You cannot create a case by using the deleted template.
    /// * Deleted templates are not included in the `ListTemplates` response.
    pub fn deleteTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_template.DeleteTemplateInput, options: CallOptions) !delete_template.DeleteTemplateOutput {
        return delete_template.execute(self, allocator, input, options);
    }

    /// Returns information about a specific case if it exists.
    pub fn getCase(self: *Self, allocator: std.mem.Allocator, input: get_case.GetCaseInput, options: CallOptions) !get_case.GetCaseOutput {
        return get_case.execute(self, allocator, input, options);
    }

    /// Returns the audit history about a specific case if it exists.
    pub fn getCaseAuditEvents(self: *Self, allocator: std.mem.Allocator, input: get_case_audit_events.GetCaseAuditEventsInput, options: CallOptions) !get_case_audit_events.GetCaseAuditEventsOutput {
        return get_case_audit_events.execute(self, allocator, input, options);
    }

    /// Returns the case event publishing configuration.
    pub fn getCaseEventConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_case_event_configuration.GetCaseEventConfigurationInput, options: CallOptions) !get_case_event_configuration.GetCaseEventConfigurationOutput {
        return get_case_event_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about a specific domain if it exists.
    pub fn getDomain(self: *Self, allocator: std.mem.Allocator, input: get_domain.GetDomainInput, options: CallOptions) !get_domain.GetDomainOutput {
        return get_domain.execute(self, allocator, input, options);
    }

    /// Returns the details for the requested layout.
    pub fn getLayout(self: *Self, allocator: std.mem.Allocator, input: get_layout.GetLayoutInput, options: CallOptions) !get_layout.GetLayoutOutput {
        return get_layout.execute(self, allocator, input, options);
    }

    /// Returns the details for the requested template. Other template APIs are:
    ///
    /// *
    ///   [CreateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_CreateTemplate.html)
    /// *
    ///   [DeleteTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_DeleteTemplate.html)
    /// *
    ///   [ListTemplates](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_ListTemplates.html)
    /// *
    ///   [UpdateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_UpdateTemplate.html)
    pub fn getTemplate(self: *Self, allocator: std.mem.Allocator, input: get_template.GetTemplateInput, options: CallOptions) !get_template.GetTemplateOutput {
        return get_template.execute(self, allocator, input, options);
    }

    /// Lists all case rules in a Cases domain. In the Amazon Connect admin website,
    /// case rules are known as *case field conditions*. For more information about
    /// case field conditions, see [Add case field conditions to a case
    /// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
    pub fn listCaseRules(self: *Self, allocator: std.mem.Allocator, input: list_case_rules.ListCaseRulesInput, options: CallOptions) !list_case_rules.ListCaseRulesOutput {
        return list_case_rules.execute(self, allocator, input, options);
    }

    /// Lists cases for a given contact.
    pub fn listCasesForContact(self: *Self, allocator: std.mem.Allocator, input: list_cases_for_contact.ListCasesForContactInput, options: CallOptions) !list_cases_for_contact.ListCasesForContactOutput {
        return list_cases_for_contact.execute(self, allocator, input, options);
    }

    /// Lists all cases domains in the Amazon Web Services account. Each list item
    /// is a condensed summary object of the domain.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: CallOptions) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Lists all of the field options for a field identifier in the domain.
    pub fn listFieldOptions(self: *Self, allocator: std.mem.Allocator, input: list_field_options.ListFieldOptionsInput, options: CallOptions) !list_field_options.ListFieldOptionsOutput {
        return list_field_options.execute(self, allocator, input, options);
    }

    /// Lists all fields in a Cases domain.
    pub fn listFields(self: *Self, allocator: std.mem.Allocator, input: list_fields.ListFieldsInput, options: CallOptions) !list_fields.ListFieldsOutput {
        return list_fields.execute(self, allocator, input, options);
    }

    /// Lists all layouts in the given cases domain. Each list item is a condensed
    /// summary object of the layout.
    pub fn listLayouts(self: *Self, allocator: std.mem.Allocator, input: list_layouts.ListLayoutsInput, options: CallOptions) !list_layouts.ListLayoutsOutput {
        return list_layouts.execute(self, allocator, input, options);
    }

    /// Lists tags for a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists all of the templates in a Cases domain. Each list item is a condensed
    /// summary object of the template.
    ///
    /// Other template APIs are:
    ///
    /// *
    ///   [CreateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_CreateTemplate.html)
    /// *
    ///   [DeleteTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_DeleteTemplate.html)
    /// *
    ///   [GetTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_GetTemplate.html)
    /// *
    ///   [UpdateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_UpdateTemplate.html)
    pub fn listTemplates(self: *Self, allocator: std.mem.Allocator, input: list_templates.ListTemplatesInput, options: CallOptions) !list_templates.ListTemplatesOutput {
        return list_templates.execute(self, allocator, input, options);
    }

    /// Adds case event publishing configuration. For a complete list of fields you
    /// can add to the event message, see [Create case
    /// fields](https://docs.aws.amazon.com/connect/latest/adminguide/case-fields.html) in the *Amazon Connect Administrator Guide*
    pub fn putCaseEventConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_case_event_configuration.PutCaseEventConfigurationInput, options: CallOptions) !put_case_event_configuration.PutCaseEventConfigurationOutput {
        return put_case_event_configuration.execute(self, allocator, input, options);
    }

    /// Searches for related items across all cases within a domain. This is a
    /// global search operation that returns related items from multiple cases,
    /// unlike the case-specific
    /// [SearchRelatedItems](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_SearchRelatedItems.html) API.
    ///
    /// **Use cases**
    ///
    /// Following are common uses cases for this API:
    ///
    /// * Find cases with similar issues across the domain. For example, search for
    ///   all cases containing comments about "product defect" to identify patterns
    ///   and existing solutions.
    /// * Locate all cases associated with specific contacts or orders. For example,
    ///   find all cases linked to a contactArn to understand the complete customer
    ///   journey.
    /// * Monitor SLA compliance across cases. For example, search for all cases
    ///   with "Active" SLA status to prioritize remediation efforts.
    ///
    /// **Important things to know**
    ///
    /// * This API returns case identifiers, not complete case objects. To retrieve
    ///   full case details, you must make additional calls to the
    ///   [GetCase](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_GetCase.html) API for each returned case ID.
    /// * This API searches across related items content, not case fields. Use the
    ///   [SearchCases](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_SearchCases.html) API to search within case field values.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn searchAllRelatedItems(self: *Self, allocator: std.mem.Allocator, input: search_all_related_items.SearchAllRelatedItemsInput, options: CallOptions) !search_all_related_items.SearchAllRelatedItemsOutput {
        return search_all_related_items.execute(self, allocator, input, options);
    }

    /// Searches for cases within their associated Cases domain. Search results are
    /// returned as a paginated list of abridged case documents.
    ///
    /// For `customer_id` you must provide the full customer profile ARN in this
    /// format: ` arn:aws:profile:your AWS Region:your AWS account
    /// ID:domains/profiles domain name/profiles/profile ID`.
    pub fn searchCases(self: *Self, allocator: std.mem.Allocator, input: search_cases.SearchCasesInput, options: CallOptions) !search_cases.SearchCasesOutput {
        return search_cases.execute(self, allocator, input, options);
    }

    /// Searches for related items that are associated with a case.
    ///
    /// If no filters are provided, this returns all related items associated with a
    /// case.
    pub fn searchRelatedItems(self: *Self, allocator: std.mem.Allocator, input: search_related_items.SearchRelatedItemsInput, options: CallOptions) !search_related_items.SearchRelatedItemsOutput {
        return search_related_items.execute(self, allocator, input, options);
    }

    /// Adds tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Untags a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// If you provide a value for `PerformedBy.UserArn` you must also have
    /// [connect:DescribeUser](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeUser.html) permission on the User ARN resource that you provide
    ///
    /// Updates the values of fields on a case. Fields to be updated are received as
    /// an array of id/value pairs identical to the `CreateCase` input .
    ///
    /// If the action is successful, the service sends back an HTTP 200 response
    /// with an empty HTTP body.
    pub fn updateCase(self: *Self, allocator: std.mem.Allocator, input: update_case.UpdateCaseInput, options: CallOptions) !update_case.UpdateCaseOutput {
        return update_case.execute(self, allocator, input, options);
    }

    /// Updates a case rule. In the Amazon Connect admin website, case rules are
    /// known as *case field conditions*. For more information about case field
    /// conditions, see [Add case field conditions to a case
    /// template](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html).
    pub fn updateCaseRule(self: *Self, allocator: std.mem.Allocator, input: update_case_rule.UpdateCaseRuleInput, options: CallOptions) !update_case_rule.UpdateCaseRuleOutput {
        return update_case_rule.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing field.
    pub fn updateField(self: *Self, allocator: std.mem.Allocator, input: update_field.UpdateFieldInput, options: CallOptions) !update_field.UpdateFieldOutput {
        return update_field.execute(self, allocator, input, options);
    }

    /// Updates the attributes of an existing layout.
    ///
    /// If the action is successful, the service sends back an HTTP 200 response
    /// with an empty HTTP body.
    ///
    /// A `ValidationException` is returned when you add non-existent `fieldIds` to
    /// a layout.
    ///
    /// Title and Status fields cannot be part of layouts because they are not
    /// configurable.
    pub fn updateLayout(self: *Self, allocator: std.mem.Allocator, input: update_layout.UpdateLayoutInput, options: CallOptions) !update_layout.UpdateLayoutOutput {
        return update_layout.execute(self, allocator, input, options);
    }

    /// Updates the content of a related item associated with a case. The following
    /// related item types are supported:
    ///
    /// * **Comment** - Update the text content of an existing comment
    /// * **Custom** - Update the fields of a custom related item. You can add,
    ///   modify, and remove fields from a custom related item. There's a quota for
    ///   the number of fields allowed in a Custom type related item. See [Amazon
    ///   Connect Cases
    ///   quotas](https://docs.aws.amazon.com/connect/latest/adminguide/amazon-connect-service-limits.html#cases-quotas).
    ///
    /// **Important things to know**
    ///
    /// * When updating a Custom related item, all existing and new fields, and
    ///   their associated values should be included in the request. Fields not
    ///   included as part of this request will be removed.
    /// * If you provide a value for `performedBy.userArn` you must also have
    ///   [DescribeUser](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeUser.html) permission on the ARN of the user that you provide.
    /// * [System case
    ///   fields](https://docs.aws.amazon.com/connect/latest/adminguide/case-fields.html#system-case-fields) cannot be used in a custom related item.
    ///
    /// **Endpoints**: See [Amazon Connect endpoints and
    /// quotas](https://docs.aws.amazon.com/general/latest/gr/connect_region.html).
    pub fn updateRelatedItem(self: *Self, allocator: std.mem.Allocator, input: update_related_item.UpdateRelatedItemInput, options: CallOptions) !update_related_item.UpdateRelatedItemOutput {
        return update_related_item.execute(self, allocator, input, options);
    }

    /// Updates the attributes of an existing template. The template attributes that
    /// can be modified include `name`, `description`, `layoutConfiguration`,
    /// `requiredFields`, and `status`. At least one of these attributes must not be
    /// null. If a null value is provided for a given attribute, that attribute is
    /// ignored and its current value is preserved.
    ///
    /// Other template APIs are:
    ///
    /// *
    ///   [CreateTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_CreateTemplate.html)
    /// *
    ///   [DeleteTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_DeleteTemplate.html)
    /// *
    ///   [GetTemplate](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_GetTemplate.html)
    /// *
    ///   [ListTemplates](https://docs.aws.amazon.com/connect/latest/APIReference/API_connect-cases_ListTemplates.html)
    pub fn updateTemplate(self: *Self, allocator: std.mem.Allocator, input: update_template.UpdateTemplateInput, options: CallOptions) !update_template.UpdateTemplateOutput {
        return update_template.execute(self, allocator, input, options);
    }

    pub fn getCasePaginator(self: *Self, params: get_case.GetCaseInput) paginator.GetCasePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getCaseAuditEventsPaginator(self: *Self, params: get_case_audit_events.GetCaseAuditEventsInput) paginator.GetCaseAuditEventsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCaseRulesPaginator(self: *Self, params: list_case_rules.ListCaseRulesInput) paginator.ListCaseRulesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCasesForContactPaginator(self: *Self, params: list_cases_for_contact.ListCasesForContactInput) paginator.ListCasesForContactPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFieldOptionsPaginator(self: *Self, params: list_field_options.ListFieldOptionsInput) paginator.ListFieldOptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFieldsPaginator(self: *Self, params: list_fields.ListFieldsInput) paginator.ListFieldsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLayoutsPaginator(self: *Self, params: list_layouts.ListLayoutsInput) paginator.ListLayoutsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplatesPaginator(self: *Self, params: list_templates.ListTemplatesInput) paginator.ListTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchAllRelatedItemsPaginator(self: *Self, params: search_all_related_items.SearchAllRelatedItemsInput) paginator.SearchAllRelatedItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchCasesPaginator(self: *Self, params: search_cases.SearchCasesInput) paginator.SearchCasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn searchRelatedItemsPaginator(self: *Self, params: search_related_items.SearchRelatedItemsInput) paginator.SearchRelatedItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
