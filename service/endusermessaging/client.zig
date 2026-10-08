const aws = @import("aws");
const std = @import("std");

const create_brand_profile = @import("create_brand_profile.zig");
const create_brand_profile_attributes = @import("create_brand_profile_attributes.zig");
const create_brand_profile_from_registration = @import("create_brand_profile_from_registration.zig");
const create_notify_code_configuration = @import("create_notify_code_configuration.zig");
const create_registrations_from_brand_profile = @import("create_registrations_from_brand_profile.zig");
const delete_brand_profile = @import("delete_brand_profile.zig");
const delete_brand_profile_attribute = @import("delete_brand_profile_attribute.zig");
const delete_notify_code_configuration = @import("delete_notify_code_configuration.zig");
const get_brand_profile = @import("get_brand_profile.zig");
const get_brand_profile_attribute = @import("get_brand_profile_attribute.zig");
const get_job = @import("get_job.zig");
const get_notify_code_configuration = @import("get_notify_code_configuration.zig");
const list_brand_profile_attributes = @import("list_brand_profile_attributes.zig");
const list_brand_profiles = @import("list_brand_profiles.zig");
const list_jobs = @import("list_jobs.zig");
const list_notify_code_configurations = @import("list_notify_code_configurations.zig");
const list_registrations_from_brand_profile = @import("list_registrations_from_brand_profile.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const send_notify_code_verification = @import("send_notify_code_verification.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_brand_profile = @import("update_brand_profile.zig");
const update_brand_profile_attribute = @import("update_brand_profile_attribute.zig");
const update_brand_profile_from_registration = @import("update_brand_profile_from_registration.zig");
const update_notify_code_configuration = @import("update_notify_code_configuration.zig");
const update_registrations_from_brand_profile = @import("update_registrations_from_brand_profile.zig");
const validate_notify_code_verification = @import("validate_notify_code_verification.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "EndUserMessaging";

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

    /// Creates a brand profile. A brand profile is a lightweight container that
    /// holds your brand identity information as flexible attributes. After you
    /// create a brand profile, use the CreateBrandProfileAttributes operation to
    /// add company information, addresses, compliance documents, and logos.
    pub fn createBrandProfile(self: *Self, allocator: std.mem.Allocator, input: create_brand_profile.CreateBrandProfileInput, options: CallOptions) !create_brand_profile.CreateBrandProfileOutput {
        return create_brand_profile.execute(self, allocator, input, options);
    }

    /// Creates up to 10 attributes for a brand profile in a single request. For
    /// attributes of type IMAGE or DOCUMENT, the response includes a presigned
    /// Amazon S3 URL that you use to upload the media. This operation is atomic:
    /// either all of the attributes are created, or none of them are.
    pub fn createBrandProfileAttributes(self: *Self, allocator: std.mem.Allocator, input: create_brand_profile_attributes.CreateBrandProfileAttributesInput, options: CallOptions) !create_brand_profile_attributes.CreateBrandProfileAttributesOutput {
        return create_brand_profile_attributes.execute(self, allocator, input, options);
    }

    /// Creates a brand profile and populates its attributes from an existing
    /// registration. This operation runs asynchronously. Use the GetJob operation
    /// to track its progress.
    pub fn createBrandProfileFromRegistration(self: *Self, allocator: std.mem.Allocator, input: create_brand_profile_from_registration.CreateBrandProfileFromRegistrationInput, options: CallOptions) !create_brand_profile_from_registration.CreateBrandProfileFromRegistrationOutput {
        return create_brand_profile_from_registration.execute(self, allocator, input, options);
    }

    /// Creates a notify code configuration. A notify code configuration is a
    /// reusable policy that defines how one-time passcodes are generated and
    /// rendered, including the code type, length, validity period, maximum number
    /// of attempts, and channel templates.
    pub fn createNotifyCodeConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_notify_code_configuration.CreateNotifyCodeConfigurationInput, options: CallOptions) !create_notify_code_configuration.CreateNotifyCodeConfigurationOutput {
        return create_notify_code_configuration.execute(self, allocator, input, options);
    }

    /// Creates one or more registrations in the DRAFT state and prefills their
    /// fields from the attributes of a brand profile. This operation runs
    /// asynchronously. Use the GetJob operation to track its progress.
    pub fn createRegistrationsFromBrandProfile(self: *Self, allocator: std.mem.Allocator, input: create_registrations_from_brand_profile.CreateRegistrationsFromBrandProfileInput, options: CallOptions) !create_registrations_from_brand_profile.CreateRegistrationsFromBrandProfileOutput {
        return create_registrations_from_brand_profile.execute(self, allocator, input, options);
    }

    /// Deletes a brand profile. This operation also deletes the attributes of the
    /// profile and any associated media. The request fails if deletion protection
    /// is enabled for the profile.
    pub fn deleteBrandProfile(self: *Self, allocator: std.mem.Allocator, input: delete_brand_profile.DeleteBrandProfileInput, options: CallOptions) !delete_brand_profile.DeleteBrandProfileOutput {
        return delete_brand_profile.execute(self, allocator, input, options);
    }

    /// Deletes a brand profile attribute. If the attribute stores media, this
    /// operation also deletes the associated media.
    pub fn deleteBrandProfileAttribute(self: *Self, allocator: std.mem.Allocator, input: delete_brand_profile_attribute.DeleteBrandProfileAttributeInput, options: CallOptions) !delete_brand_profile_attribute.DeleteBrandProfileAttributeOutput {
        return delete_brand_profile_attribute.execute(self, allocator, input, options);
    }

    /// Deletes a notify code configuration. Verifications that are already in
    /// progress are not affected, because they capture the policy at the time that
    /// the passcode was sent.
    pub fn deleteNotifyCodeConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_notify_code_configuration.DeleteNotifyCodeConfigurationInput, options: CallOptions) !delete_notify_code_configuration.DeleteNotifyCodeConfigurationOutput {
        return delete_notify_code_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the metadata for a brand profile, including its name, status,
    /// deletion protection setting, and timestamps. To retrieve the attributes of
    /// the profile, use the ListBrandProfileAttributes operation.
    pub fn getBrandProfile(self: *Self, allocator: std.mem.Allocator, input: get_brand_profile.GetBrandProfileInput, options: CallOptions) !get_brand_profile.GetBrandProfileOutput {
        return get_brand_profile.execute(self, allocator, input, options);
    }

    /// Retrieves a single brand profile attribute.
    pub fn getBrandProfileAttribute(self: *Self, allocator: std.mem.Allocator, input: get_brand_profile_attribute.GetBrandProfileAttributeInput, options: CallOptions) !get_brand_profile_attribute.GetBrandProfileAttributeOutput {
        return get_brand_profile_attribute.execute(self, allocator, input, options);
    }

    /// Retrieves the current state of an asynchronous job, including its status and
    /// any resources that it created or updated.
    pub fn getJob(self: *Self, allocator: std.mem.Allocator, input: get_job.GetJobInput, options: CallOptions) !get_job.GetJobOutput {
        return get_job.execute(self, allocator, input, options);
    }

    /// Retrieves a notify code configuration.
    pub fn getNotifyCodeConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_notify_code_configuration.GetNotifyCodeConfigurationInput, options: CallOptions) !get_notify_code_configuration.GetNotifyCodeConfigurationOutput {
        return get_notify_code_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the attributes for a brand profile.
    pub fn listBrandProfileAttributes(self: *Self, allocator: std.mem.Allocator, input: list_brand_profile_attributes.ListBrandProfileAttributesInput, options: CallOptions) !list_brand_profile_attributes.ListBrandProfileAttributesOutput {
        return list_brand_profile_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the brand profiles in your account. Use the
    /// nextToken parameter to retrieve additional results.
    pub fn listBrandProfiles(self: *Self, allocator: std.mem.Allocator, input: list_brand_profiles.ListBrandProfilesInput, options: CallOptions) !list_brand_profiles.ListBrandProfilesOutput {
        return list_brand_profiles.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the asynchronous jobs in your account. You can
    /// filter the results by status, brand profile, or operation type.
    pub fn listJobs(self: *Self, allocator: std.mem.Allocator, input: list_jobs.ListJobsInput, options: CallOptions) !list_jobs.ListJobsOutput {
        return list_jobs.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the notify code configurations in your
    /// account.
    pub fn listNotifyCodeConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_notify_code_configurations.ListNotifyCodeConfigurationsInput, options: CallOptions) !list_notify_code_configurations.ListNotifyCodeConfigurationsOutput {
        return list_notify_code_configurations.execute(self, allocator, input, options);
    }

    /// Retrieves a paginated list of the registrations that were created from a
    /// brand profile through the synchronization operations.
    pub fn listRegistrationsFromBrandProfile(self: *Self, allocator: std.mem.Allocator, input: list_registrations_from_brand_profile.ListRegistrationsFromBrandProfileInput, options: CallOptions) !list_registrations_from_brand_profile.ListRegistrationsFromBrandProfileOutput {
        return list_registrations_from_brand_profile.execute(self, allocator, input, options);
    }

    /// Retrieves the tags that are associated with a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Generates a one-time passcode and delivers it to a recipient over the
    /// requested channel. The passcode policy is captured from the referenced
    /// notify code configuration at the time of the request, so later updates to
    /// the configuration do not affect verifications that are already in progress.
    pub fn sendNotifyCodeVerification(self: *Self, allocator: std.mem.Allocator, input: send_notify_code_verification.SendNotifyCodeVerificationInput, options: CallOptions) !send_notify_code_verification.SendNotifyCodeVerificationOutput {
        return send_notify_code_verification.execute(self, allocator, input, options);
    }

    /// Adds or overwrites the tags on a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the name or the deletion protection setting of a brand profile. To
    /// change the information that is stored in the profile, use the brand profile
    /// attribute operations.
    pub fn updateBrandProfile(self: *Self, allocator: std.mem.Allocator, input: update_brand_profile.UpdateBrandProfileInput, options: CallOptions) !update_brand_profile.UpdateBrandProfileOutput {
        return update_brand_profile.execute(self, allocator, input, options);
    }

    /// Updates the value, description, or category of an existing brand profile
    /// attribute.
    pub fn updateBrandProfileAttribute(self: *Self, allocator: std.mem.Allocator, input: update_brand_profile_attribute.UpdateBrandProfileAttributeInput, options: CallOptions) !update_brand_profile_attribute.UpdateBrandProfileAttributeOutput {
        return update_brand_profile_attribute.execute(self, allocator, input, options);
    }

    /// Imports or refreshes the attributes of an existing brand profile from an
    /// existing registration. This operation runs asynchronously. Use the GetJob
    /// operation to track its progress.
    pub fn updateBrandProfileFromRegistration(self: *Self, allocator: std.mem.Allocator, input: update_brand_profile_from_registration.UpdateBrandProfileFromRegistrationInput, options: CallOptions) !update_brand_profile_from_registration.UpdateBrandProfileFromRegistrationOutput {
        return update_brand_profile_from_registration.execute(self, allocator, input, options);
    }

    /// Updates the mutable fields of a notify code configuration. Only the fields
    /// that you supply are changed. For the template and language fields, supplying
    /// an empty value clears the currently stored value.
    pub fn updateNotifyCodeConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_notify_code_configuration.UpdateNotifyCodeConfigurationInput, options: CallOptions) !update_notify_code_configuration.UpdateNotifyCodeConfigurationOutput {
        return update_notify_code_configuration.execute(self, allocator, input, options);
    }

    /// Repushes the attributes of a brand profile into existing DRAFT
    /// registrations. This operation runs asynchronously. Use the GetJob operation
    /// to track its progress.
    pub fn updateRegistrationsFromBrandProfile(self: *Self, allocator: std.mem.Allocator, input: update_registrations_from_brand_profile.UpdateRegistrationsFromBrandProfileInput, options: CallOptions) !update_registrations_from_brand_profile.UpdateRegistrationsFromBrandProfileOutput {
        return update_registrations_from_brand_profile.execute(self, allocator, input, options);
    }

    /// Validates a one-time passcode that a recipient submitted. Validation
    /// succeeds when the passcode matches, the validity period has not elapsed, and
    /// the maximum number of attempts has not been exceeded.
    pub fn validateNotifyCodeVerification(self: *Self, allocator: std.mem.Allocator, input: validate_notify_code_verification.ValidateNotifyCodeVerificationInput, options: CallOptions) !validate_notify_code_verification.ValidateNotifyCodeVerificationOutput {
        return validate_notify_code_verification.execute(self, allocator, input, options);
    }

    pub fn listBrandProfileAttributesPaginator(self: *Self, params: list_brand_profile_attributes.ListBrandProfileAttributesInput) paginator.ListBrandProfileAttributesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listBrandProfilesPaginator(self: *Self, params: list_brand_profiles.ListBrandProfilesInput) paginator.ListBrandProfilesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listJobsPaginator(self: *Self, params: list_jobs.ListJobsInput) paginator.ListJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listNotifyCodeConfigurationsPaginator(self: *Self, params: list_notify_code_configurations.ListNotifyCodeConfigurationsInput) paginator.ListNotifyCodeConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listRegistrationsFromBrandProfilePaginator(self: *Self, params: list_registrations_from_brand_profile.ListRegistrationsFromBrandProfileInput) paginator.ListRegistrationsFromBrandProfilePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn waitUntilBrandProfileActive(self: *Self, params: get_brand_profile.GetBrandProfileInput) aws.waiter.WaiterError!void {
        var w = waiters.BrandProfileActiveWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilJobSuccess(self: *Self, params: get_job.GetJobInput) aws.waiter.WaiterError!void {
        var w = waiters.JobSuccessWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
