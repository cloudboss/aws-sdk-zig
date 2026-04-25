const aws = @import("aws");
const std = @import("std");

const add_profile_key = @import("add_profile_key.zig");
const batch_get_calculated_attribute_for_profile = @import("batch_get_calculated_attribute_for_profile.zig");
const batch_get_profile = @import("batch_get_profile.zig");
const create_calculated_attribute_definition = @import("create_calculated_attribute_definition.zig");
const create_domain = @import("create_domain.zig");
const create_domain_layout = @import("create_domain_layout.zig");
const create_event_stream = @import("create_event_stream.zig");
const create_event_trigger = @import("create_event_trigger.zig");
const create_integration_workflow = @import("create_integration_workflow.zig");
const create_profile = @import("create_profile.zig");
const create_recommender = @import("create_recommender.zig");
const create_recommender_filter = @import("create_recommender_filter.zig");
const create_recommender_schema = @import("create_recommender_schema.zig");
const create_segment_definition = @import("create_segment_definition.zig");
const create_segment_estimate = @import("create_segment_estimate.zig");
const create_segment_snapshot = @import("create_segment_snapshot.zig");
const create_upload_job = @import("create_upload_job.zig");
const delete_calculated_attribute_definition = @import("delete_calculated_attribute_definition.zig");
const delete_domain = @import("delete_domain.zig");
const delete_domain_layout = @import("delete_domain_layout.zig");
const delete_domain_object_type = @import("delete_domain_object_type.zig");
const delete_event_stream = @import("delete_event_stream.zig");
const delete_event_trigger = @import("delete_event_trigger.zig");
const delete_integration = @import("delete_integration.zig");
const delete_profile = @import("delete_profile.zig");
const delete_profile_key = @import("delete_profile_key.zig");
const delete_profile_object = @import("delete_profile_object.zig");
const delete_profile_object_type = @import("delete_profile_object_type.zig");
const delete_recommender = @import("delete_recommender.zig");
const delete_recommender_filter = @import("delete_recommender_filter.zig");
const delete_recommender_schema = @import("delete_recommender_schema.zig");
const delete_segment_definition = @import("delete_segment_definition.zig");
const delete_workflow = @import("delete_workflow.zig");
const detect_profile_object_type = @import("detect_profile_object_type.zig");
const get_auto_merging_preview = @import("get_auto_merging_preview.zig");
const get_calculated_attribute_definition = @import("get_calculated_attribute_definition.zig");
const get_calculated_attribute_for_profile = @import("get_calculated_attribute_for_profile.zig");
const get_domain = @import("get_domain.zig");
const get_domain_layout = @import("get_domain_layout.zig");
const get_domain_object_type = @import("get_domain_object_type.zig");
const get_event_stream = @import("get_event_stream.zig");
const get_event_trigger = @import("get_event_trigger.zig");
const get_identity_resolution_job = @import("get_identity_resolution_job.zig");
const get_integration = @import("get_integration.zig");
const get_matches = @import("get_matches.zig");
const get_object_type_attribute_statistics = @import("get_object_type_attribute_statistics.zig");
const get_profile_history_record = @import("get_profile_history_record.zig");
const get_profile_object_type = @import("get_profile_object_type.zig");
const get_profile_object_type_template = @import("get_profile_object_type_template.zig");
const get_profile_recommendations = @import("get_profile_recommendations.zig");
const get_recommender = @import("get_recommender.zig");
const get_recommender_filter = @import("get_recommender_filter.zig");
const get_recommender_schema = @import("get_recommender_schema.zig");
const get_segment_definition = @import("get_segment_definition.zig");
const get_segment_estimate = @import("get_segment_estimate.zig");
const get_segment_membership = @import("get_segment_membership.zig");
const get_segment_snapshot = @import("get_segment_snapshot.zig");
const get_similar_profiles = @import("get_similar_profiles.zig");
const get_upload_job = @import("get_upload_job.zig");
const get_upload_job_path = @import("get_upload_job_path.zig");
const get_workflow = @import("get_workflow.zig");
const get_workflow_steps = @import("get_workflow_steps.zig");
const list_account_integrations = @import("list_account_integrations.zig");
const list_calculated_attribute_definitions = @import("list_calculated_attribute_definitions.zig");
const list_calculated_attributes_for_profile = @import("list_calculated_attributes_for_profile.zig");
const list_domain_layouts = @import("list_domain_layouts.zig");
const list_domain_object_types = @import("list_domain_object_types.zig");
const list_domains = @import("list_domains.zig");
const list_event_streams = @import("list_event_streams.zig");
const list_event_triggers = @import("list_event_triggers.zig");
const list_identity_resolution_jobs = @import("list_identity_resolution_jobs.zig");
const list_integrations = @import("list_integrations.zig");
const list_object_type_attribute_values = @import("list_object_type_attribute_values.zig");
const list_object_type_attributes = @import("list_object_type_attributes.zig");
const list_profile_attribute_values = @import("list_profile_attribute_values.zig");
const list_profile_history_records = @import("list_profile_history_records.zig");
const list_profile_object_type_templates = @import("list_profile_object_type_templates.zig");
const list_profile_object_types = @import("list_profile_object_types.zig");
const list_profile_objects = @import("list_profile_objects.zig");
const list_recommender_filters = @import("list_recommender_filters.zig");
const list_recommender_recipes = @import("list_recommender_recipes.zig");
const list_recommender_schemas = @import("list_recommender_schemas.zig");
const list_recommenders = @import("list_recommenders.zig");
const list_rule_based_matches = @import("list_rule_based_matches.zig");
const list_segment_definitions = @import("list_segment_definitions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_upload_jobs = @import("list_upload_jobs.zig");
const list_workflows = @import("list_workflows.zig");
const merge_profiles = @import("merge_profiles.zig");
const put_domain_object_type = @import("put_domain_object_type.zig");
const put_integration = @import("put_integration.zig");
const put_profile_object = @import("put_profile_object.zig");
const put_profile_object_type = @import("put_profile_object_type.zig");
const search_profiles = @import("search_profiles.zig");
const start_recommender = @import("start_recommender.zig");
const start_upload_job = @import("start_upload_job.zig");
const stop_recommender = @import("stop_recommender.zig");
const stop_upload_job = @import("stop_upload_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_calculated_attribute_definition = @import("update_calculated_attribute_definition.zig");
const update_domain = @import("update_domain.zig");
const update_domain_layout = @import("update_domain_layout.zig");
const update_event_trigger = @import("update_event_trigger.zig");
const update_profile = @import("update_profile.zig");
const update_recommender = @import("update_recommender.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Customer Profiles";

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

    /// Associates a new key value with a specific profile, such as a Contact Record
    /// ContactId.
    ///
    /// A profile object can have a single unique key and any number of additional
    /// keys that can
    /// be used to identify the profile that it belongs to.
    pub fn addProfileKey(self: *Self, allocator: std.mem.Allocator, input: add_profile_key.AddProfileKeyInput, options: CallOptions) !add_profile_key.AddProfileKeyOutput {
        return add_profile_key.execute(self, allocator, input, options);
    }

    /// Fetch the possible attribute values given the attribute name.
    pub fn batchGetCalculatedAttributeForProfile(self: *Self, allocator: std.mem.Allocator, input: batch_get_calculated_attribute_for_profile.BatchGetCalculatedAttributeForProfileInput, options: CallOptions) !batch_get_calculated_attribute_for_profile.BatchGetCalculatedAttributeForProfileOutput {
        return batch_get_calculated_attribute_for_profile.execute(self, allocator, input, options);
    }

    /// Get a batch of profiles.
    pub fn batchGetProfile(self: *Self, allocator: std.mem.Allocator, input: batch_get_profile.BatchGetProfileInput, options: CallOptions) !batch_get_profile.BatchGetProfileOutput {
        return batch_get_profile.execute(self, allocator, input, options);
    }

    /// Creates a new calculated attribute definition. After creation, new object
    /// data ingested
    /// into Customer Profiles will be included in the calculated attribute, which
    /// can be retrieved
    /// for a profile using the
    /// [GetCalculatedAttributeForProfile](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetCalculatedAttributeForProfile.html) API. Defining a calculated attribute makes it
    /// available for all profiles within a domain. Each calculated attribute can
    /// only reference
    /// one `ObjectType` and at most, two fields from that
    /// `ObjectType`.
    pub fn createCalculatedAttributeDefinition(self: *Self, allocator: std.mem.Allocator, input: create_calculated_attribute_definition.CreateCalculatedAttributeDefinitionInput, options: CallOptions) !create_calculated_attribute_definition.CreateCalculatedAttributeDefinitionOutput {
        return create_calculated_attribute_definition.execute(self, allocator, input, options);
    }

    /// Creates a domain, which is a container for all customer data, such as
    /// customer profile
    /// attributes, object types, profile keys, and encryption keys. You can create
    /// multiple
    /// domains, and each domain can have multiple third-party integrations.
    ///
    /// Each Amazon Connect instance can be associated with only one domain.
    /// Multiple
    /// Amazon Connect instances can be associated with one domain.
    ///
    /// Use this API or
    /// [UpdateDomain](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_UpdateDomain.html) to
    /// enable [identity
    /// resolution](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html): set `Matching` to true.
    ///
    /// To prevent cross-service impersonation when you call this API, see
    /// [Cross-service confused deputy
    /// prevention](https://docs.aws.amazon.com/connect/latest/adminguide/cross-service-confused-deputy-prevention.html) for sample policies that you should
    /// apply.
    ///
    /// It is not possible to associate a Customer Profiles domain with an Amazon
    /// Connect Instance directly from
    /// the API. If you would like to create a domain and associate a Customer
    /// Profiles domain, use the Amazon Connect
    /// admin website. For more information, see [Enable Customer
    /// Profiles](https://docs.aws.amazon.com/connect/latest/adminguide/enable-customer-profiles.html#enable-customer-profiles-step1).
    ///
    /// Each Amazon Connect instance can be associated with only one domain.
    /// Multiple Amazon Connect instances
    /// can be associated with one domain.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: CallOptions) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates the layout to view data for a specific domain. This API can only be
    /// invoked from
    /// the Amazon Connect admin website.
    pub fn createDomainLayout(self: *Self, allocator: std.mem.Allocator, input: create_domain_layout.CreateDomainLayoutInput, options: CallOptions) !create_domain_layout.CreateDomainLayoutOutput {
        return create_domain_layout.execute(self, allocator, input, options);
    }

    /// Creates an event stream, which is a subscription to real-time events, such
    /// as when
    /// profiles are created and updated through Amazon Connect Customer Profiles.
    ///
    /// Each event stream can be associated with only one Kinesis Data Stream
    /// destination in the
    /// same region and Amazon Web Services account as the customer profiles domain
    pub fn createEventStream(self: *Self, allocator: std.mem.Allocator, input: create_event_stream.CreateEventStreamInput, options: CallOptions) !create_event_stream.CreateEventStreamOutput {
        return create_event_stream.execute(self, allocator, input, options);
    }

    /// Creates an event trigger, which specifies the rules when to perform action
    /// based on
    /// customer's ingested data.
    ///
    /// Each event stream can be associated with only one integration in the same
    /// region and AWS
    /// account as the event stream.
    pub fn createEventTrigger(self: *Self, allocator: std.mem.Allocator, input: create_event_trigger.CreateEventTriggerInput, options: CallOptions) !create_event_trigger.CreateEventTriggerOutput {
        return create_event_trigger.execute(self, allocator, input, options);
    }

    /// Creates an integration workflow. An integration workflow is an async process
    /// which
    /// ingests historic data and sets up an integration for ongoing updates. The
    /// supported Amazon AppFlow sources are Salesforce, ServiceNow, and Marketo.
    pub fn createIntegrationWorkflow(self: *Self, allocator: std.mem.Allocator, input: create_integration_workflow.CreateIntegrationWorkflowInput, options: CallOptions) !create_integration_workflow.CreateIntegrationWorkflowOutput {
        return create_integration_workflow.execute(self, allocator, input, options);
    }

    /// Creates a standard profile.
    ///
    /// A standard profile represents the following attributes for a customer
    /// profile in a
    /// domain.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: CallOptions) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Creates a recommender
    pub fn createRecommender(self: *Self, allocator: std.mem.Allocator, input: create_recommender.CreateRecommenderInput, options: CallOptions) !create_recommender.CreateRecommenderOutput {
        return create_recommender.execute(self, allocator, input, options);
    }

    /// Creates a recommender filter. A recommender filter specifies which items to
    /// include or exclude from recommendations.
    pub fn createRecommenderFilter(self: *Self, allocator: std.mem.Allocator, input: create_recommender_filter.CreateRecommenderFilterInput, options: CallOptions) !create_recommender_filter.CreateRecommenderFilterOutput {
        return create_recommender_filter.execute(self, allocator, input, options);
    }

    /// Creates a recommender schema. A recommender schema defines the set of data
    /// columns available for training recommenders and filters under a domain.
    pub fn createRecommenderSchema(self: *Self, allocator: std.mem.Allocator, input: create_recommender_schema.CreateRecommenderSchemaInput, options: CallOptions) !create_recommender_schema.CreateRecommenderSchemaOutput {
        return create_recommender_schema.execute(self, allocator, input, options);
    }

    /// Creates a segment definition associated to the given domain.
    pub fn createSegmentDefinition(self: *Self, allocator: std.mem.Allocator, input: create_segment_definition.CreateSegmentDefinitionInput, options: CallOptions) !create_segment_definition.CreateSegmentDefinitionOutput {
        return create_segment_definition.execute(self, allocator, input, options);
    }

    /// Creates a segment estimate query.
    pub fn createSegmentEstimate(self: *Self, allocator: std.mem.Allocator, input: create_segment_estimate.CreateSegmentEstimateInput, options: CallOptions) !create_segment_estimate.CreateSegmentEstimateOutput {
        return create_segment_estimate.execute(self, allocator, input, options);
    }

    /// Triggers a job to export a segment to a specified destination.
    pub fn createSegmentSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_segment_snapshot.CreateSegmentSnapshotInput, options: CallOptions) !create_segment_snapshot.CreateSegmentSnapshotOutput {
        return create_segment_snapshot.execute(self, allocator, input, options);
    }

    /// Creates an Upload job to ingest data for segment imports. The metadata is
    /// created for
    /// the job with the provided field mapping and unique key.
    pub fn createUploadJob(self: *Self, allocator: std.mem.Allocator, input: create_upload_job.CreateUploadJobInput, options: CallOptions) !create_upload_job.CreateUploadJobOutput {
        return create_upload_job.execute(self, allocator, input, options);
    }

    /// Deletes an existing calculated attribute definition. Note that deleting a
    /// default
    /// calculated attribute is possible, however once deleted, you will be unable
    /// to undo that
    /// action and will need to recreate it on your own using the
    /// CreateCalculatedAttributeDefinition API if you want it back.
    pub fn deleteCalculatedAttributeDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_calculated_attribute_definition.DeleteCalculatedAttributeDefinitionInput, options: CallOptions) !delete_calculated_attribute_definition.DeleteCalculatedAttributeDefinitionOutput {
        return delete_calculated_attribute_definition.execute(self, allocator, input, options);
    }

    /// Deletes a specific domain and all of its customer data, such as customer
    /// profile
    /// attributes and their related objects.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Deletes the layout used to view data for a specific domain. This API can
    /// only be invoked
    /// from the Amazon Connect admin website.
    pub fn deleteDomainLayout(self: *Self, allocator: std.mem.Allocator, input: delete_domain_layout.DeleteDomainLayoutInput, options: CallOptions) !delete_domain_layout.DeleteDomainLayoutOutput {
        return delete_domain_layout.execute(self, allocator, input, options);
    }

    /// Delete a DomainObjectType for the given Domain and ObjectType name.
    pub fn deleteDomainObjectType(self: *Self, allocator: std.mem.Allocator, input: delete_domain_object_type.DeleteDomainObjectTypeInput, options: CallOptions) !delete_domain_object_type.DeleteDomainObjectTypeOutput {
        return delete_domain_object_type.execute(self, allocator, input, options);
    }

    /// Disables and deletes the specified event stream.
    pub fn deleteEventStream(self: *Self, allocator: std.mem.Allocator, input: delete_event_stream.DeleteEventStreamInput, options: CallOptions) !delete_event_stream.DeleteEventStreamOutput {
        return delete_event_stream.execute(self, allocator, input, options);
    }

    /// Disable and deletes the Event Trigger.
    ///
    /// You cannot delete an Event Trigger with an active Integration associated.
    pub fn deleteEventTrigger(self: *Self, allocator: std.mem.Allocator, input: delete_event_trigger.DeleteEventTriggerInput, options: CallOptions) !delete_event_trigger.DeleteEventTriggerOutput {
        return delete_event_trigger.execute(self, allocator, input, options);
    }

    /// Removes an integration from a specific domain.
    pub fn deleteIntegration(self: *Self, allocator: std.mem.Allocator, input: delete_integration.DeleteIntegrationInput, options: CallOptions) !delete_integration.DeleteIntegrationOutput {
        return delete_integration.execute(self, allocator, input, options);
    }

    /// Deletes the standard customer profile and all data pertaining to the
    /// profile.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: CallOptions) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Removes a searchable key from a customer profile.
    pub fn deleteProfileKey(self: *Self, allocator: std.mem.Allocator, input: delete_profile_key.DeleteProfileKeyInput, options: CallOptions) !delete_profile_key.DeleteProfileKeyOutput {
        return delete_profile_key.execute(self, allocator, input, options);
    }

    /// Removes an object associated with a profile of a given ProfileObjectType.
    pub fn deleteProfileObject(self: *Self, allocator: std.mem.Allocator, input: delete_profile_object.DeleteProfileObjectInput, options: CallOptions) !delete_profile_object.DeleteProfileObjectOutput {
        return delete_profile_object.execute(self, allocator, input, options);
    }

    /// Removes a ProfileObjectType from a specific domain as well as removes all
    /// the
    /// ProfileObjects of that type. It also disables integrations from this
    /// specific
    /// ProfileObjectType. In addition, it scrubs all of the fields of the standard
    /// profile that
    /// were populated from this ProfileObjectType.
    pub fn deleteProfileObjectType(self: *Self, allocator: std.mem.Allocator, input: delete_profile_object_type.DeleteProfileObjectTypeInput, options: CallOptions) !delete_profile_object_type.DeleteProfileObjectTypeOutput {
        return delete_profile_object_type.execute(self, allocator, input, options);
    }

    /// Deletes a recommender.
    pub fn deleteRecommender(self: *Self, allocator: std.mem.Allocator, input: delete_recommender.DeleteRecommenderInput, options: CallOptions) !delete_recommender.DeleteRecommenderOutput {
        return delete_recommender.execute(self, allocator, input, options);
    }

    /// Deletes a recommender filter from a domain.
    pub fn deleteRecommenderFilter(self: *Self, allocator: std.mem.Allocator, input: delete_recommender_filter.DeleteRecommenderFilterInput, options: CallOptions) !delete_recommender_filter.DeleteRecommenderFilterOutput {
        return delete_recommender_filter.execute(self, allocator, input, options);
    }

    /// Deletes a recommender schema from a domain.
    pub fn deleteRecommenderSchema(self: *Self, allocator: std.mem.Allocator, input: delete_recommender_schema.DeleteRecommenderSchemaInput, options: CallOptions) !delete_recommender_schema.DeleteRecommenderSchemaOutput {
        return delete_recommender_schema.execute(self, allocator, input, options);
    }

    /// Deletes a segment definition from the domain.
    pub fn deleteSegmentDefinition(self: *Self, allocator: std.mem.Allocator, input: delete_segment_definition.DeleteSegmentDefinitionInput, options: CallOptions) !delete_segment_definition.DeleteSegmentDefinitionOutput {
        return delete_segment_definition.execute(self, allocator, input, options);
    }

    /// Deletes the specified workflow and all its corresponding resources. This is
    /// an async
    /// process.
    pub fn deleteWorkflow(self: *Self, allocator: std.mem.Allocator, input: delete_workflow.DeleteWorkflowInput, options: CallOptions) !delete_workflow.DeleteWorkflowOutput {
        return delete_workflow.execute(self, allocator, input, options);
    }

    /// The process of detecting profile object type mapping by using given objects.
    pub fn detectProfileObjectType(self: *Self, allocator: std.mem.Allocator, input: detect_profile_object_type.DetectProfileObjectTypeInput, options: CallOptions) !detect_profile_object_type.DetectProfileObjectTypeOutput {
        return detect_profile_object_type.execute(self, allocator, input, options);
    }

    /// Tests the auto-merging settings of your Identity Resolution Job without
    /// merging your data. It randomly
    /// selects a sample of matching groups from the existing matching results, and
    /// applies the
    /// automerging settings that you provided. You can then view the number of
    /// profiles in the
    /// sample, the number of matches, and the number of profiles identified to be
    /// merged. This
    /// enables you to evaluate the accuracy of the attributes in your matching
    /// list.
    ///
    /// You can't view which profiles are matched and would be merged.
    ///
    /// We strongly recommend you use this API to do a dry run of the automerging
    /// process
    /// before running the Identity Resolution Job. Include **at least** two
    /// matching
    /// attributes. If your matching list includes too few attributes (such as only
    /// `FirstName` or only `LastName`), there may be a large number of
    /// matches. This increases the chances of erroneous merges.
    pub fn getAutoMergingPreview(self: *Self, allocator: std.mem.Allocator, input: get_auto_merging_preview.GetAutoMergingPreviewInput, options: CallOptions) !get_auto_merging_preview.GetAutoMergingPreviewOutput {
        return get_auto_merging_preview.execute(self, allocator, input, options);
    }

    /// Provides more information on a calculated attribute definition for Customer
    /// Profiles.
    pub fn getCalculatedAttributeDefinition(self: *Self, allocator: std.mem.Allocator, input: get_calculated_attribute_definition.GetCalculatedAttributeDefinitionInput, options: CallOptions) !get_calculated_attribute_definition.GetCalculatedAttributeDefinitionOutput {
        return get_calculated_attribute_definition.execute(self, allocator, input, options);
    }

    /// Retrieve a calculated attribute for a customer profile.
    pub fn getCalculatedAttributeForProfile(self: *Self, allocator: std.mem.Allocator, input: get_calculated_attribute_for_profile.GetCalculatedAttributeForProfileInput, options: CallOptions) !get_calculated_attribute_for_profile.GetCalculatedAttributeForProfileOutput {
        return get_calculated_attribute_for_profile.execute(self, allocator, input, options);
    }

    /// Returns information about a specific domain.
    pub fn getDomain(self: *Self, allocator: std.mem.Allocator, input: get_domain.GetDomainInput, options: CallOptions) !get_domain.GetDomainOutput {
        return get_domain.execute(self, allocator, input, options);
    }

    /// Gets the layout to view data for a specific domain. This API can only be
    /// invoked from
    /// the Amazon Connect admin website.
    pub fn getDomainLayout(self: *Self, allocator: std.mem.Allocator, input: get_domain_layout.GetDomainLayoutInput, options: CallOptions) !get_domain_layout.GetDomainLayoutOutput {
        return get_domain_layout.execute(self, allocator, input, options);
    }

    /// Return a DomainObjectType for the input Domain and ObjectType names.
    pub fn getDomainObjectType(self: *Self, allocator: std.mem.Allocator, input: get_domain_object_type.GetDomainObjectTypeInput, options: CallOptions) !get_domain_object_type.GetDomainObjectTypeOutput {
        return get_domain_object_type.execute(self, allocator, input, options);
    }

    /// Returns information about the specified event stream in a specific domain.
    pub fn getEventStream(self: *Self, allocator: std.mem.Allocator, input: get_event_stream.GetEventStreamInput, options: CallOptions) !get_event_stream.GetEventStreamOutput {
        return get_event_stream.execute(self, allocator, input, options);
    }

    /// Get a specific Event Trigger from the domain.
    pub fn getEventTrigger(self: *Self, allocator: std.mem.Allocator, input: get_event_trigger.GetEventTriggerInput, options: CallOptions) !get_event_trigger.GetEventTriggerOutput {
        return get_event_trigger.execute(self, allocator, input, options);
    }

    /// Returns information about an Identity Resolution Job in a specific domain.
    ///
    /// Identity Resolution Jobs are set up using the Amazon Connect admin console.
    /// For more information, see [Use
    /// Identity Resolution to consolidate similar
    /// profiles](https://docs.aws.amazon.com/connect/latest/adminguide/use-identity-resolution.html).
    pub fn getIdentityResolutionJob(self: *Self, allocator: std.mem.Allocator, input: get_identity_resolution_job.GetIdentityResolutionJobInput, options: CallOptions) !get_identity_resolution_job.GetIdentityResolutionJobOutput {
        return get_identity_resolution_job.execute(self, allocator, input, options);
    }

    /// Returns an integration for a domain.
    pub fn getIntegration(self: *Self, allocator: std.mem.Allocator, input: get_integration.GetIntegrationInput, options: CallOptions) !get_integration.GetIntegrationOutput {
        return get_integration.execute(self, allocator, input, options);
    }

    /// Before calling this API, use
    /// [CreateDomain](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_CreateDomain.html) or
    /// [UpdateDomain](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_UpdateDomain.html) to
    /// enable identity resolution: set `Matching` to true.
    ///
    /// GetMatches returns potentially matching profiles, based on the results of
    /// the latest run
    /// of a machine learning process.
    ///
    /// The process of matching duplicate profiles. If `Matching` = `true`, Amazon
    /// Connect Customer Profiles starts a weekly
    /// batch process called Identity Resolution Job. If you do not specify a date
    /// and time for Identity Resolution Job to run, by default it runs every
    /// Saturday at 12AM UTC to detect duplicate profiles in your domains.
    ///
    /// After the Identity Resolution Job completes, use the
    /// [GetMatches](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html)
    /// API to return and review the results. Or, if you have configured
    /// `ExportingConfig` in the `MatchingRequest`, you can download the results
    /// from
    /// S3.
    ///
    /// Amazon Connect uses the following profile attributes to identify matches:
    ///
    /// * PhoneNumber
    ///
    /// * HomePhoneNumber
    ///
    /// * BusinessPhoneNumber
    ///
    /// * MobilePhoneNumber
    ///
    /// * EmailAddress
    ///
    /// * PersonalEmailAddress
    ///
    /// * BusinessEmailAddress
    ///
    /// * FullName
    ///
    /// For example, two or more profiles—with spelling mistakes such as **John
    /// Doe** and **Jhn Doe**, or different casing
    /// email addresses such as **JOHN_DOE@ANYCOMPANY.COM** and
    /// **johndoe@anycompany.com**, or different phone number
    /// formats such as **555-010-0000** and **+1-555-010-0000**—can be detected as
    /// belonging to the same customer **John Doe** and merged into a unified
    /// profile.
    pub fn getMatches(self: *Self, allocator: std.mem.Allocator, input: get_matches.GetMatchesInput, options: CallOptions) !get_matches.GetMatchesOutput {
        return get_matches.execute(self, allocator, input, options);
    }

    /// The GetObjectTypeAttributeValues API delivers statistical insights about
    /// attributes within a specific object type, but is exclusively available for
    /// domains with data store enabled. This API performs daily calculations to
    /// provide statistical information about your attribute values, helping you
    /// understand patterns and trends in your data. The statistical calculations
    /// are performed once per day, providing a consistent snapshot of your
    /// attribute data characteristics.
    ///
    /// You'll receive null values in two scenarios:
    ///
    /// During the first period after enabling data vault (unless a calculation
    /// cycle occurs, which happens once daily).
    ///
    /// For attributes that don't contain numeric values.
    pub fn getObjectTypeAttributeStatistics(self: *Self, allocator: std.mem.Allocator, input: get_object_type_attribute_statistics.GetObjectTypeAttributeStatisticsInput, options: CallOptions) !get_object_type_attribute_statistics.GetObjectTypeAttributeStatisticsOutput {
        return get_object_type_attribute_statistics.execute(self, allocator, input, options);
    }

    /// Returns a history record for a specific profile, for a specific domain.
    pub fn getProfileHistoryRecord(self: *Self, allocator: std.mem.Allocator, input: get_profile_history_record.GetProfileHistoryRecordInput, options: CallOptions) !get_profile_history_record.GetProfileHistoryRecordOutput {
        return get_profile_history_record.execute(self, allocator, input, options);
    }

    /// Returns the object types for a specific domain.
    pub fn getProfileObjectType(self: *Self, allocator: std.mem.Allocator, input: get_profile_object_type.GetProfileObjectTypeInput, options: CallOptions) !get_profile_object_type.GetProfileObjectTypeOutput {
        return get_profile_object_type.execute(self, allocator, input, options);
    }

    /// Returns the template information for a specific object type.
    ///
    /// A template is a predefined ProfileObjectType, such as “Salesforce-Account”
    /// or
    /// “Salesforce-Contact.” When a user sends a ProfileObject, using the
    /// PutProfileObject API,
    /// with an ObjectTypeName that matches one of the TemplateIds, it uses the
    /// mappings from the
    /// template.
    pub fn getProfileObjectTypeTemplate(self: *Self, allocator: std.mem.Allocator, input: get_profile_object_type_template.GetProfileObjectTypeTemplateInput, options: CallOptions) !get_profile_object_type_template.GetProfileObjectTypeTemplateOutput {
        return get_profile_object_type_template.execute(self, allocator, input, options);
    }

    /// Fetches the recommendations for a profile in the input Customer Profiles
    /// domain. Fetches all the profile recommendations
    pub fn getProfileRecommendations(self: *Self, allocator: std.mem.Allocator, input: get_profile_recommendations.GetProfileRecommendationsInput, options: CallOptions) !get_profile_recommendations.GetProfileRecommendationsOutput {
        return get_profile_recommendations.execute(self, allocator, input, options);
    }

    /// Retrieves a recommender.
    pub fn getRecommender(self: *Self, allocator: std.mem.Allocator, input: get_recommender.GetRecommenderInput, options: CallOptions) !get_recommender.GetRecommenderOutput {
        return get_recommender.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific recommender filter in a domain.
    pub fn getRecommenderFilter(self: *Self, allocator: std.mem.Allocator, input: get_recommender_filter.GetRecommenderFilterInput, options: CallOptions) !get_recommender_filter.GetRecommenderFilterOutput {
        return get_recommender_filter.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific recommender schema in a domain.
    pub fn getRecommenderSchema(self: *Self, allocator: std.mem.Allocator, input: get_recommender_schema.GetRecommenderSchemaInput, options: CallOptions) !get_recommender_schema.GetRecommenderSchemaOutput {
        return get_recommender_schema.execute(self, allocator, input, options);
    }

    /// Gets a segment definition from the domain.
    pub fn getSegmentDefinition(self: *Self, allocator: std.mem.Allocator, input: get_segment_definition.GetSegmentDefinitionInput, options: CallOptions) !get_segment_definition.GetSegmentDefinitionOutput {
        return get_segment_definition.execute(self, allocator, input, options);
    }

    /// Gets the result of a segment estimate query.
    pub fn getSegmentEstimate(self: *Self, allocator: std.mem.Allocator, input: get_segment_estimate.GetSegmentEstimateInput, options: CallOptions) !get_segment_estimate.GetSegmentEstimateOutput {
        return get_segment_estimate.execute(self, allocator, input, options);
    }

    /// Determines if the given profiles are within a segment.
    pub fn getSegmentMembership(self: *Self, allocator: std.mem.Allocator, input: get_segment_membership.GetSegmentMembershipInput, options: CallOptions) !get_segment_membership.GetSegmentMembershipOutput {
        return get_segment_membership.execute(self, allocator, input, options);
    }

    /// Retrieve the latest status of a segment snapshot.
    pub fn getSegmentSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_segment_snapshot.GetSegmentSnapshotInput, options: CallOptions) !get_segment_snapshot.GetSegmentSnapshotOutput {
        return get_segment_snapshot.execute(self, allocator, input, options);
    }

    /// Returns a set of profiles that belong to the same matching group using the
    /// `matchId` or `profileId`. You can also specify the type of
    /// matching that you want for finding similar profiles using either
    /// `RULE_BASED_MATCHING` or `ML_BASED_MATCHING`.
    pub fn getSimilarProfiles(self: *Self, allocator: std.mem.Allocator, input: get_similar_profiles.GetSimilarProfilesInput, options: CallOptions) !get_similar_profiles.GetSimilarProfilesOutput {
        return get_similar_profiles.execute(self, allocator, input, options);
    }

    /// This API retrieves the details of a specific upload job.
    pub fn getUploadJob(self: *Self, allocator: std.mem.Allocator, input: get_upload_job.GetUploadJobInput, options: CallOptions) !get_upload_job.GetUploadJobOutput {
        return get_upload_job.execute(self, allocator, input, options);
    }

    /// This API retrieves the pre-signed URL and client token for uploading the
    /// file associated
    /// with the upload job.
    pub fn getUploadJobPath(self: *Self, allocator: std.mem.Allocator, input: get_upload_job_path.GetUploadJobPathInput, options: CallOptions) !get_upload_job_path.GetUploadJobPathOutput {
        return get_upload_job_path.execute(self, allocator, input, options);
    }

    /// Get details of specified workflow.
    pub fn getWorkflow(self: *Self, allocator: std.mem.Allocator, input: get_workflow.GetWorkflowInput, options: CallOptions) !get_workflow.GetWorkflowOutput {
        return get_workflow.execute(self, allocator, input, options);
    }

    /// Get granular list of steps in workflow.
    pub fn getWorkflowSteps(self: *Self, allocator: std.mem.Allocator, input: get_workflow_steps.GetWorkflowStepsInput, options: CallOptions) !get_workflow_steps.GetWorkflowStepsOutput {
        return get_workflow_steps.execute(self, allocator, input, options);
    }

    /// Lists all of the integrations associated to a specific URI in the AWS
    /// account.
    pub fn listAccountIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_account_integrations.ListAccountIntegrationsInput, options: CallOptions) !list_account_integrations.ListAccountIntegrationsOutput {
        return list_account_integrations.execute(self, allocator, input, options);
    }

    /// Lists calculated attribute definitions for Customer Profiles
    pub fn listCalculatedAttributeDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_calculated_attribute_definitions.ListCalculatedAttributeDefinitionsInput, options: CallOptions) !list_calculated_attribute_definitions.ListCalculatedAttributeDefinitionsOutput {
        return list_calculated_attribute_definitions.execute(self, allocator, input, options);
    }

    /// Retrieve a list of calculated attributes for a customer profile.
    pub fn listCalculatedAttributesForProfile(self: *Self, allocator: std.mem.Allocator, input: list_calculated_attributes_for_profile.ListCalculatedAttributesForProfileInput, options: CallOptions) !list_calculated_attributes_for_profile.ListCalculatedAttributesForProfileOutput {
        return list_calculated_attributes_for_profile.execute(self, allocator, input, options);
    }

    /// Lists the existing layouts that can be used to view data for a specific
    /// domain. This API
    /// can only be invoked from the Amazon Connect admin website.
    pub fn listDomainLayouts(self: *Self, allocator: std.mem.Allocator, input: list_domain_layouts.ListDomainLayoutsInput, options: CallOptions) !list_domain_layouts.ListDomainLayoutsOutput {
        return list_domain_layouts.execute(self, allocator, input, options);
    }

    /// List all DomainObjectType(s) in a Customer Profiles domain.
    pub fn listDomainObjectTypes(self: *Self, allocator: std.mem.Allocator, input: list_domain_object_types.ListDomainObjectTypesInput, options: CallOptions) !list_domain_object_types.ListDomainObjectTypesOutput {
        return list_domain_object_types.execute(self, allocator, input, options);
    }

    /// Returns a list of all the domains for an AWS account that have been created.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: CallOptions) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Returns a list of all the event streams in a specific domain.
    pub fn listEventStreams(self: *Self, allocator: std.mem.Allocator, input: list_event_streams.ListEventStreamsInput, options: CallOptions) !list_event_streams.ListEventStreamsOutput {
        return list_event_streams.execute(self, allocator, input, options);
    }

    /// List all Event Triggers under a domain.
    pub fn listEventTriggers(self: *Self, allocator: std.mem.Allocator, input: list_event_triggers.ListEventTriggersInput, options: CallOptions) !list_event_triggers.ListEventTriggersOutput {
        return list_event_triggers.execute(self, allocator, input, options);
    }

    /// Lists all of the Identity Resolution Jobs in your domain. The response sorts
    /// the list by
    /// `JobStartTime`.
    pub fn listIdentityResolutionJobs(self: *Self, allocator: std.mem.Allocator, input: list_identity_resolution_jobs.ListIdentityResolutionJobsInput, options: CallOptions) !list_identity_resolution_jobs.ListIdentityResolutionJobsOutput {
        return list_identity_resolution_jobs.execute(self, allocator, input, options);
    }

    /// Lists all of the integrations in your domain.
    pub fn listIntegrations(self: *Self, allocator: std.mem.Allocator, input: list_integrations.ListIntegrationsInput, options: CallOptions) !list_integrations.ListIntegrationsOutput {
        return list_integrations.execute(self, allocator, input, options);
    }

    /// The ListObjectTypeAttributeValues API provides access to the most recent
    /// distinct values for any specified attribute, making it valuable for
    /// real-time data validation and consistency checks within your object types.
    /// This API works across domain, supporting both custom and standard object
    /// types. The API accepts the object type name, attribute name, and domain name
    /// as input parameters and returns values up to the storage limit of
    /// approximately 350KB.
    pub fn listObjectTypeAttributeValues(self: *Self, allocator: std.mem.Allocator, input: list_object_type_attribute_values.ListObjectTypeAttributeValuesInput, options: CallOptions) !list_object_type_attribute_values.ListObjectTypeAttributeValuesOutput {
        return list_object_type_attribute_values.execute(self, allocator, input, options);
    }

    /// Fetch the possible attribute values given the attribute name.
    pub fn listObjectTypeAttributes(self: *Self, allocator: std.mem.Allocator, input: list_object_type_attributes.ListObjectTypeAttributesInput, options: CallOptions) !list_object_type_attributes.ListObjectTypeAttributesOutput {
        return list_object_type_attributes.execute(self, allocator, input, options);
    }

    /// Fetch the possible attribute values given the attribute name.
    pub fn listProfileAttributeValues(self: *Self, allocator: std.mem.Allocator, input: list_profile_attribute_values.ListProfileAttributeValuesInput, options: CallOptions) !list_profile_attribute_values.ListProfileAttributeValuesOutput {
        return list_profile_attribute_values.execute(self, allocator, input, options);
    }

    /// Returns a list of history records for a specific profile, for a specific
    /// domain.
    pub fn listProfileHistoryRecords(self: *Self, allocator: std.mem.Allocator, input: list_profile_history_records.ListProfileHistoryRecordsInput, options: CallOptions) !list_profile_history_records.ListProfileHistoryRecordsOutput {
        return list_profile_history_records.execute(self, allocator, input, options);
    }

    /// Lists all of the template information for object types.
    pub fn listProfileObjectTypeTemplates(self: *Self, allocator: std.mem.Allocator, input: list_profile_object_type_templates.ListProfileObjectTypeTemplatesInput, options: CallOptions) !list_profile_object_type_templates.ListProfileObjectTypeTemplatesOutput {
        return list_profile_object_type_templates.execute(self, allocator, input, options);
    }

    /// Lists all of the templates available within the service.
    pub fn listProfileObjectTypes(self: *Self, allocator: std.mem.Allocator, input: list_profile_object_types.ListProfileObjectTypesInput, options: CallOptions) !list_profile_object_types.ListProfileObjectTypesOutput {
        return list_profile_object_types.execute(self, allocator, input, options);
    }

    /// Returns a list of objects associated with a profile of a given
    /// ProfileObjectType.
    pub fn listProfileObjects(self: *Self, allocator: std.mem.Allocator, input: list_profile_objects.ListProfileObjectsInput, options: CallOptions) !list_profile_objects.ListProfileObjectsOutput {
        return list_profile_objects.execute(self, allocator, input, options);
    }

    /// Returns a list of recommender filters in the specified domain.
    pub fn listRecommenderFilters(self: *Self, allocator: std.mem.Allocator, input: list_recommender_filters.ListRecommenderFiltersInput, options: CallOptions) !list_recommender_filters.ListRecommenderFiltersOutput {
        return list_recommender_filters.execute(self, allocator, input, options);
    }

    /// Returns a list of available recommender recipes that can be used to create
    /// recommenders.
    pub fn listRecommenderRecipes(self: *Self, allocator: std.mem.Allocator, input: list_recommender_recipes.ListRecommenderRecipesInput, options: CallOptions) !list_recommender_recipes.ListRecommenderRecipesOutput {
        return list_recommender_recipes.execute(self, allocator, input, options);
    }

    /// Returns a list of recommender schemas in the specified domain.
    pub fn listRecommenderSchemas(self: *Self, allocator: std.mem.Allocator, input: list_recommender_schemas.ListRecommenderSchemasInput, options: CallOptions) !list_recommender_schemas.ListRecommenderSchemasOutput {
        return list_recommender_schemas.execute(self, allocator, input, options);
    }

    /// Returns a list of recommenders in the specified domain.
    pub fn listRecommenders(self: *Self, allocator: std.mem.Allocator, input: list_recommenders.ListRecommendersInput, options: CallOptions) !list_recommenders.ListRecommendersOutput {
        return list_recommenders.execute(self, allocator, input, options);
    }

    /// Returns a set of `MatchIds` that belong to the given domain.
    pub fn listRuleBasedMatches(self: *Self, allocator: std.mem.Allocator, input: list_rule_based_matches.ListRuleBasedMatchesInput, options: CallOptions) !list_rule_based_matches.ListRuleBasedMatchesOutput {
        return list_rule_based_matches.execute(self, allocator, input, options);
    }

    /// Lists all segment definitions under a domain.
    pub fn listSegmentDefinitions(self: *Self, allocator: std.mem.Allocator, input: list_segment_definitions.ListSegmentDefinitionsInput, options: CallOptions) !list_segment_definitions.ListSegmentDefinitionsOutput {
        return list_segment_definitions.execute(self, allocator, input, options);
    }

    /// Displays the tags associated with an Amazon Connect Customer Profiles
    /// resource. In Connect
    /// Customer Profiles, domains, profile object types, and integrations can be
    /// tagged.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// This API retrieves a list of upload jobs for the specified domain.
    pub fn listUploadJobs(self: *Self, allocator: std.mem.Allocator, input: list_upload_jobs.ListUploadJobsInput, options: CallOptions) !list_upload_jobs.ListUploadJobsOutput {
        return list_upload_jobs.execute(self, allocator, input, options);
    }

    /// Query to list all workflows.
    pub fn listWorkflows(self: *Self, allocator: std.mem.Allocator, input: list_workflows.ListWorkflowsInput, options: CallOptions) !list_workflows.ListWorkflowsOutput {
        return list_workflows.execute(self, allocator, input, options);
    }

    /// Runs an AWS Lambda job that does the following:
    ///
    /// * All the profileKeys in the `ProfileToBeMerged` will be moved to the
    /// main profile.
    ///
    /// * All the objects in the `ProfileToBeMerged` will be moved to the main
    /// profile.
    ///
    /// * All the `ProfileToBeMerged` will be deleted at the end.
    ///
    /// * All the profileKeys in the `ProfileIdsToBeMerged` will be moved to the
    /// main profile.
    ///
    /// * Standard fields are merged as follows:
    ///
    /// * Fields are always "union"-ed if there are no conflicts in standard fields
    ///   or
    /// attributeKeys.
    ///
    /// * When there are conflicting fields:
    ///
    /// * If no `SourceProfileIds` entry is specified, the main
    /// Profile value is always taken.
    ///
    /// * If a `SourceProfileIds` entry is specified, the specified
    /// profileId is always taken, even if it is a NULL value.
    ///
    /// You can use MergeProfiles together with
    /// [GetMatches](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html), which
    /// returns potentially matching profiles, or use it with the results of another
    /// matching
    /// system. After profiles have been merged, they cannot be separated
    /// (unmerged).
    pub fn mergeProfiles(self: *Self, allocator: std.mem.Allocator, input: merge_profiles.MergeProfilesInput, options: CallOptions) !merge_profiles.MergeProfilesOutput {
        return merge_profiles.execute(self, allocator, input, options);
    }

    /// Create/Update a DomainObjectType in a Customer Profiles domain. To create a
    /// new DomainObjectType, Data Store needs to be enabled on the Domain.
    pub fn putDomainObjectType(self: *Self, allocator: std.mem.Allocator, input: put_domain_object_type.PutDomainObjectTypeInput, options: CallOptions) !put_domain_object_type.PutDomainObjectTypeOutput {
        return put_domain_object_type.execute(self, allocator, input, options);
    }

    /// Adds an integration between the service and a third-party service, which
    /// includes
    /// Amazon AppFlow and Amazon Connect.
    ///
    /// An integration can belong to only one domain.
    ///
    /// To add or remove tags on an existing Integration, see [ TagResource
    /// ](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_TagResource.html)/[
    /// UntagResource](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_UntagResource.html).
    pub fn putIntegration(self: *Self, allocator: std.mem.Allocator, input: put_integration.PutIntegrationInput, options: CallOptions) !put_integration.PutIntegrationOutput {
        return put_integration.execute(self, allocator, input, options);
    }

    /// Adds additional objects to customer profiles of a given ObjectType.
    ///
    /// When adding a specific profile object, like a Contact Record, an inferred
    /// profile can
    /// get created if it is not mapped to an existing profile. The resulting
    /// profile will only
    /// have a phone number populated in the standard ProfileObject. Any additional
    /// Contact Records
    /// with the same phone number will be mapped to the same inferred profile.
    ///
    /// When a ProfileObject is created and if a ProfileObjectType already exists
    /// for the
    /// ProfileObject, it will provide data to a standard profile depending on the
    /// ProfileObjectType definition.
    ///
    /// PutProfileObject needs an ObjectType, which can be created using
    /// PutProfileObjectType.
    pub fn putProfileObject(self: *Self, allocator: std.mem.Allocator, input: put_profile_object.PutProfileObjectInput, options: CallOptions) !put_profile_object.PutProfileObjectOutput {
        return put_profile_object.execute(self, allocator, input, options);
    }

    /// Defines a ProfileObjectType.
    ///
    /// To add or remove tags on an existing ObjectType, see [
    /// TagResource](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_TagResource.html)/[UntagResource](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_UntagResource.html).
    pub fn putProfileObjectType(self: *Self, allocator: std.mem.Allocator, input: put_profile_object_type.PutProfileObjectTypeInput, options: CallOptions) !put_profile_object_type.PutProfileObjectTypeOutput {
        return put_profile_object_type.execute(self, allocator, input, options);
    }

    /// Searches for profiles within a specific domain using one or more predefined
    /// search keys
    /// (e.g., _fullName, _phone, _email, _account, etc.) and/or custom-defined
    /// search keys. A
    /// search key is a data type pair that consists of a `KeyName` and
    /// `Values` list.
    ///
    /// This operation supports searching for profiles with a minimum of 1
    /// key-value(s) pair and
    /// up to 5 key-value(s) pairs using either `AND` or `OR` logic.
    pub fn searchProfiles(self: *Self, allocator: std.mem.Allocator, input: search_profiles.SearchProfilesInput, options: CallOptions) !search_profiles.SearchProfilesOutput {
        return search_profiles.execute(self, allocator, input, options);
    }

    /// Starts a recommender that was previously stopped. Starting a recommender
    /// resumes its ability to generate recommendations.
    pub fn startRecommender(self: *Self, allocator: std.mem.Allocator, input: start_recommender.StartRecommenderInput, options: CallOptions) !start_recommender.StartRecommenderOutput {
        return start_recommender.execute(self, allocator, input, options);
    }

    /// This API starts the processing of an upload job to ingest profile data.
    pub fn startUploadJob(self: *Self, allocator: std.mem.Allocator, input: start_upload_job.StartUploadJobInput, options: CallOptions) !start_upload_job.StartUploadJobOutput {
        return start_upload_job.execute(self, allocator, input, options);
    }

    /// Stops a recommender, suspending its ability to generate recommendations. The
    /// recommender can be restarted later using StartRecommender.
    pub fn stopRecommender(self: *Self, allocator: std.mem.Allocator, input: stop_recommender.StopRecommenderInput, options: CallOptions) !stop_recommender.StopRecommenderOutput {
        return stop_recommender.execute(self, allocator, input, options);
    }

    /// This API stops the processing of an upload job.
    pub fn stopUploadJob(self: *Self, allocator: std.mem.Allocator, input: stop_upload_job.StopUploadJobInput, options: CallOptions) !stop_upload_job.StopUploadJobOutput {
        return stop_upload_job.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags (key-value pairs) to the specified Amazon Connect
    /// Customer Profiles
    /// resource. Tags can help you organize and categorize your resources. You can
    /// also use them
    /// to scope user permissions by granting a user permission to access or change
    /// only resources
    /// with certain tag values. In Connect Customer Profiles, domains, profile
    /// object types, and
    /// integrations can be tagged.
    ///
    /// Tags don't have any semantic meaning to AWS and are interpreted strictly as
    /// strings of
    /// characters.
    ///
    /// You can use the TagResource action with a resource that already has tags. If
    /// you specify
    /// a new tag key, this tag is appended to the list of tags associated with the
    /// resource. If
    /// you specify a tag key that is already associated with the resource, the new
    /// tag value that
    /// you specify replaces the previous value for that tag.
    ///
    /// You can associate as many as 50 tags with a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from the specified Amazon Connect Customer Profiles
    /// resource. In Connect
    /// Customer Profiles, domains, profile object types, and integrations can be
    /// tagged.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing calculated attribute definition. When updating the
    /// Conditions, note
    /// that increasing the date range of a calculated attribute will not trigger
    /// inclusion of
    /// historical data greater than the current date range.
    pub fn updateCalculatedAttributeDefinition(self: *Self, allocator: std.mem.Allocator, input: update_calculated_attribute_definition.UpdateCalculatedAttributeDefinitionInput, options: CallOptions) !update_calculated_attribute_definition.UpdateCalculatedAttributeDefinitionOutput {
        return update_calculated_attribute_definition.execute(self, allocator, input, options);
    }

    /// Updates the properties of a domain, including creating or selecting a dead
    /// letter queue
    /// or an encryption key.
    ///
    /// After a domain is created, the name can’t be changed.
    ///
    /// Use this API or
    /// [CreateDomain](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_CreateDomain.html) to
    /// enable [identity
    /// resolution](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_GetMatches.html): set `Matching` to true.
    ///
    /// To prevent cross-service impersonation when you call this API, see
    /// [Cross-service confused deputy
    /// prevention](https://docs.aws.amazon.com/connect/latest/adminguide/cross-service-confused-deputy-prevention.html) for sample policies that you should
    /// apply.
    ///
    /// To add or remove tags on an existing Domain, see
    /// [TagResource](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_TagResource.html)/[UntagResource](https://docs.aws.amazon.com/customerprofiles/latest/APIReference/API_UntagResource.html).
    pub fn updateDomain(self: *Self, allocator: std.mem.Allocator, input: update_domain.UpdateDomainInput, options: CallOptions) !update_domain.UpdateDomainOutput {
        return update_domain.execute(self, allocator, input, options);
    }

    /// Updates the layout used to view data for a specific domain. This API can
    /// only be invoked
    /// from the Amazon Connect admin website.
    pub fn updateDomainLayout(self: *Self, allocator: std.mem.Allocator, input: update_domain_layout.UpdateDomainLayoutInput, options: CallOptions) !update_domain_layout.UpdateDomainLayoutOutput {
        return update_domain_layout.execute(self, allocator, input, options);
    }

    /// Update the properties of an Event Trigger.
    pub fn updateEventTrigger(self: *Self, allocator: std.mem.Allocator, input: update_event_trigger.UpdateEventTriggerInput, options: CallOptions) !update_event_trigger.UpdateEventTriggerOutput {
        return update_event_trigger.execute(self, allocator, input, options);
    }

    /// Updates the properties of a profile. The ProfileId is required for updating
    /// a customer
    /// profile.
    ///
    /// When calling the UpdateProfile API, specifying an empty string value means
    /// that any
    /// existing value will be removed. Not specifying a string value means that any
    /// value already
    /// there will be kept.
    pub fn updateProfile(self: *Self, allocator: std.mem.Allocator, input: update_profile.UpdateProfileInput, options: CallOptions) !update_profile.UpdateProfileOutput {
        return update_profile.execute(self, allocator, input, options);
    }

    /// Updates the properties of an existing recommender, allowing you to modify
    /// its configuration and description.
    pub fn updateRecommender(self: *Self, allocator: std.mem.Allocator, input: update_recommender.UpdateRecommenderInput, options: CallOptions) !update_recommender.UpdateRecommenderOutput {
        return update_recommender.execute(self, allocator, input, options);
    }

    pub fn getSimilarProfilesPaginator(self: *Self, params: get_similar_profiles.GetSimilarProfilesInput) paginator.GetSimilarProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDomainLayoutsPaginator(self: *Self, params: list_domain_layouts.ListDomainLayoutsInput) paginator.ListDomainLayoutsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDomainObjectTypesPaginator(self: *Self, params: list_domain_object_types.ListDomainObjectTypesInput) paginator.ListDomainObjectTypesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEventStreamsPaginator(self: *Self, params: list_event_streams.ListEventStreamsInput) paginator.ListEventStreamsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listEventTriggersPaginator(self: *Self, params: list_event_triggers.ListEventTriggersInput) paginator.ListEventTriggersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listObjectTypeAttributesPaginator(self: *Self, params: list_object_type_attributes.ListObjectTypeAttributesInput) paginator.ListObjectTypeAttributesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommenderFiltersPaginator(self: *Self, params: list_recommender_filters.ListRecommenderFiltersInput) paginator.ListRecommenderFiltersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommenderRecipesPaginator(self: *Self, params: list_recommender_recipes.ListRecommenderRecipesInput) paginator.ListRecommenderRecipesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommenderSchemasPaginator(self: *Self, params: list_recommender_schemas.ListRecommenderSchemasInput) paginator.ListRecommenderSchemasPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRecommendersPaginator(self: *Self, params: list_recommenders.ListRecommendersInput) paginator.ListRecommendersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRuleBasedMatchesPaginator(self: *Self, params: list_rule_based_matches.ListRuleBasedMatchesInput) paginator.ListRuleBasedMatchesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSegmentDefinitionsPaginator(self: *Self, params: list_segment_definitions.ListSegmentDefinitionsInput) paginator.ListSegmentDefinitionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listUploadJobsPaginator(self: *Self, params: list_upload_jobs.ListUploadJobsInput) paginator.ListUploadJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
