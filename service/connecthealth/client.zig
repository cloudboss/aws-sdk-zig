const aws = @import("aws");
const std = @import("std");

const activate_subscription = @import("activate_subscription.zig");
const create_domain = @import("create_domain.zig");
const create_subscription = @import("create_subscription.zig");
const deactivate_subscription = @import("deactivate_subscription.zig");
const delete_domain = @import("delete_domain.zig");
const get_domain = @import("get_domain.zig");
const get_medical_scribe_listening_session = @import("get_medical_scribe_listening_session.zig");
const get_patient_insights_job = @import("get_patient_insights_job.zig");
const get_subscription = @import("get_subscription.zig");
const list_domains = @import("list_domains.zig");
const list_subscriptions = @import("list_subscriptions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_medical_scribe_listening_session = @import("start_medical_scribe_listening_session.zig");
const start_patient_insights_job = @import("start_patient_insights_job.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "ConnectHealth";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Activates a Subscription to enable billing for a user.
    pub fn activateSubscription(self: *Self, allocator: std.mem.Allocator, input: activate_subscription.ActivateSubscriptionInput, options: CallOptions) !activate_subscription.ActivateSubscriptionOutput {
        return activate_subscription.execute(self, allocator, input, options);
    }

    /// Creates a new Domain for managing HealthAgent resources.
    pub fn createDomain(self: *Self, allocator: std.mem.Allocator, input: create_domain.CreateDomainInput, options: CallOptions) !create_domain.CreateDomainOutput {
        return create_domain.execute(self, allocator, input, options);
    }

    /// Creates a new Subscription within a Domain for billing and user management.
    pub fn createSubscription(self: *Self, allocator: std.mem.Allocator, input: create_subscription.CreateSubscriptionInput, options: CallOptions) !create_subscription.CreateSubscriptionOutput {
        return create_subscription.execute(self, allocator, input, options);
    }

    /// Deactivates a Subscription to stop billing for a user.
    pub fn deactivateSubscription(self: *Self, allocator: std.mem.Allocator, input: deactivate_subscription.DeactivateSubscriptionInput, options: CallOptions) !deactivate_subscription.DeactivateSubscriptionOutput {
        return deactivate_subscription.execute(self, allocator, input, options);
    }

    /// Deletes a Domain and all associated resources.
    pub fn deleteDomain(self: *Self, allocator: std.mem.Allocator, input: delete_domain.DeleteDomainInput, options: CallOptions) !delete_domain.DeleteDomainOutput {
        return delete_domain.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Domain.
    pub fn getDomain(self: *Self, allocator: std.mem.Allocator, input: get_domain.GetDomainInput, options: CallOptions) !get_domain.GetDomainOutput {
        return get_domain.execute(self, allocator, input, options);
    }

    /// Retrieves details about an existing Medical Scribe listening session
    pub fn getMedicalScribeListeningSession(self: *Self, allocator: std.mem.Allocator, input: get_medical_scribe_listening_session.GetMedicalScribeListeningSessionInput, options: CallOptions) !get_medical_scribe_listening_session.GetMedicalScribeListeningSessionOutput {
        return get_medical_scribe_listening_session.execute(self, allocator, input, options);
    }

    /// Get details of a started patient insights job.
    pub fn getPatientInsightsJob(self: *Self, allocator: std.mem.Allocator, input: get_patient_insights_job.GetPatientInsightsJobInput, options: CallOptions) !get_patient_insights_job.GetPatientInsightsJobOutput {
        return get_patient_insights_job.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Subscription.
    pub fn getSubscription(self: *Self, allocator: std.mem.Allocator, input: get_subscription.GetSubscriptionInput, options: CallOptions) !get_subscription.GetSubscriptionOutput {
        return get_subscription.execute(self, allocator, input, options);
    }

    /// Lists Domains for a given account.
    pub fn listDomains(self: *Self, allocator: std.mem.Allocator, input: list_domains.ListDomainsInput, options: CallOptions) !list_domains.ListDomainsOutput {
        return list_domains.execute(self, allocator, input, options);
    }

    /// Lists all Subscriptions within a Domain.
    pub fn listSubscriptions(self: *Self, allocator: std.mem.Allocator, input: list_subscriptions.ListSubscriptionsInput, options: CallOptions) !list_subscriptions.ListSubscriptionsOutput {
        return list_subscriptions.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with the specified resource
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a new Medical Scribe listening session for real-time audio
    /// transcription
    pub fn startMedicalScribeListeningSession(self: *Self, allocator: std.mem.Allocator, input: start_medical_scribe_listening_session.StartMedicalScribeListeningSessionInput, options: CallOptions) !start_medical_scribe_listening_session.StartMedicalScribeListeningSessionOutput {
        return start_medical_scribe_listening_session.execute(self, allocator, input, options);
    }

    /// Starts a new patient insights job.
    pub fn startPatientInsightsJob(self: *Self, allocator: std.mem.Allocator, input: start_patient_insights_job.StartPatientInsightsJobInput, options: CallOptions) !start_patient_insights_job.StartPatientInsightsJobOutput {
        return start_patient_insights_job.execute(self, allocator, input, options);
    }

    /// Associates the specified tags with the specified resource
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified resource
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listDomainsPaginator(self: *Self, params: list_domains.ListDomainsInput) paginator.ListDomainsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSubscriptionsPaginator(self: *Self, params: list_subscriptions.ListSubscriptionsInput) paginator.ListSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
