const aws = @import("aws");
const std = @import("std");

const accept_page = @import("accept_page.zig");
const activate_contact_channel = @import("activate_contact_channel.zig");
const create_contact = @import("create_contact.zig");
const create_contact_channel = @import("create_contact_channel.zig");
const create_rotation = @import("create_rotation.zig");
const create_rotation_override = @import("create_rotation_override.zig");
const deactivate_contact_channel = @import("deactivate_contact_channel.zig");
const delete_contact = @import("delete_contact.zig");
const delete_contact_channel = @import("delete_contact_channel.zig");
const delete_rotation = @import("delete_rotation.zig");
const delete_rotation_override = @import("delete_rotation_override.zig");
const describe_engagement = @import("describe_engagement.zig");
const describe_page = @import("describe_page.zig");
const get_contact = @import("get_contact.zig");
const get_contact_channel = @import("get_contact_channel.zig");
const get_contact_policy = @import("get_contact_policy.zig");
const get_rotation = @import("get_rotation.zig");
const get_rotation_override = @import("get_rotation_override.zig");
const list_contact_channels = @import("list_contact_channels.zig");
const list_contacts = @import("list_contacts.zig");
const list_engagements = @import("list_engagements.zig");
const list_page_receipts = @import("list_page_receipts.zig");
const list_page_resolutions = @import("list_page_resolutions.zig");
const list_pages_by_contact = @import("list_pages_by_contact.zig");
const list_pages_by_engagement = @import("list_pages_by_engagement.zig");
const list_preview_rotation_shifts = @import("list_preview_rotation_shifts.zig");
const list_rotation_overrides = @import("list_rotation_overrides.zig");
const list_rotation_shifts = @import("list_rotation_shifts.zig");
const list_rotations = @import("list_rotations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_contact_policy = @import("put_contact_policy.zig");
const send_activation_code = @import("send_activation_code.zig");
const start_engagement = @import("start_engagement.zig");
const stop_engagement = @import("stop_engagement.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_contact = @import("update_contact.zig");
const update_contact_channel = @import("update_contact_channel.zig");
const update_rotation = @import("update_rotation.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SSM Contacts";

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

    /// Used to acknowledge an engagement to a contact channel during an incident.
    pub fn acceptPage(self: *Self, allocator: std.mem.Allocator, input: accept_page.AcceptPageInput, options: CallOptions) !accept_page.AcceptPageOutput {
        return accept_page.execute(self, allocator, input, options);
    }

    /// Activates a contact's contact channel. Incident Manager can't engage a
    /// contact until the
    /// contact channel has been activated.
    pub fn activateContactChannel(self: *Self, allocator: std.mem.Allocator, input: activate_contact_channel.ActivateContactChannelInput, options: CallOptions) !activate_contact_channel.ActivateContactChannelOutput {
        return activate_contact_channel.execute(self, allocator, input, options);
    }

    /// Contacts are either the contacts that Incident Manager engages during an
    /// incident or the
    /// escalation plans that Incident Manager uses to engage contacts in phases
    /// during an
    /// incident.
    pub fn createContact(self: *Self, allocator: std.mem.Allocator, input: create_contact.CreateContactInput, options: CallOptions) !create_contact.CreateContactOutput {
        return create_contact.execute(self, allocator, input, options);
    }

    /// A contact channel is the method that Incident Manager uses to engage your
    /// contact.
    pub fn createContactChannel(self: *Self, allocator: std.mem.Allocator, input: create_contact_channel.CreateContactChannelInput, options: CallOptions) !create_contact_channel.CreateContactChannelOutput {
        return create_contact_channel.execute(self, allocator, input, options);
    }

    /// Creates a rotation in an on-call schedule.
    pub fn createRotation(self: *Self, allocator: std.mem.Allocator, input: create_rotation.CreateRotationInput, options: CallOptions) !create_rotation.CreateRotationOutput {
        return create_rotation.execute(self, allocator, input, options);
    }

    /// Creates an override for a rotation in an on-call schedule.
    pub fn createRotationOverride(self: *Self, allocator: std.mem.Allocator, input: create_rotation_override.CreateRotationOverrideInput, options: CallOptions) !create_rotation_override.CreateRotationOverrideOutput {
        return create_rotation_override.execute(self, allocator, input, options);
    }

    /// To no longer receive Incident Manager engagements to a contact channel, you
    /// can deactivate
    /// the channel.
    pub fn deactivateContactChannel(self: *Self, allocator: std.mem.Allocator, input: deactivate_contact_channel.DeactivateContactChannelInput, options: CallOptions) !deactivate_contact_channel.DeactivateContactChannelOutput {
        return deactivate_contact_channel.execute(self, allocator, input, options);
    }

    /// To remove a contact from Incident Manager, you can delete the contact.
    /// However, deleting a
    /// contact does not remove it from escalation plans and related response plans.
    /// Deleting an
    /// escalation plan also does not remove it from all related response plans. To
    /// modify an
    /// escalation plan, we recommend using the UpdateContact action to specify a
    /// different existing contact.
    pub fn deleteContact(self: *Self, allocator: std.mem.Allocator, input: delete_contact.DeleteContactInput, options: CallOptions) !delete_contact.DeleteContactOutput {
        return delete_contact.execute(self, allocator, input, options);
    }

    /// To stop receiving engagements on a contact channel, you can delete the
    /// channel from a
    /// contact. Deleting the contact channel does not remove it from the contact's
    /// engagement
    /// plan, but the stage that includes the channel will be ignored. If you delete
    /// the only
    /// contact channel for a contact, you'll no longer be able to engage that
    /// contact during an
    /// incident.
    pub fn deleteContactChannel(self: *Self, allocator: std.mem.Allocator, input: delete_contact_channel.DeleteContactChannelInput, options: CallOptions) !delete_contact_channel.DeleteContactChannelOutput {
        return delete_contact_channel.execute(self, allocator, input, options);
    }

    /// Deletes a rotation from the system. If a rotation belongs to more than one
    /// on-call
    /// schedule, this operation deletes it from all of them.
    pub fn deleteRotation(self: *Self, allocator: std.mem.Allocator, input: delete_rotation.DeleteRotationInput, options: CallOptions) !delete_rotation.DeleteRotationOutput {
        return delete_rotation.execute(self, allocator, input, options);
    }

    /// Deletes an existing override for an on-call rotation.
    pub fn deleteRotationOverride(self: *Self, allocator: std.mem.Allocator, input: delete_rotation_override.DeleteRotationOverrideInput, options: CallOptions) !delete_rotation_override.DeleteRotationOverrideOutput {
        return delete_rotation_override.execute(self, allocator, input, options);
    }

    /// Incident Manager uses engagements to engage contacts and escalation plans
    /// during an incident.
    /// Use this command to describe the engagement that occurred during an
    /// incident.
    pub fn describeEngagement(self: *Self, allocator: std.mem.Allocator, input: describe_engagement.DescribeEngagementInput, options: CallOptions) !describe_engagement.DescribeEngagementOutput {
        return describe_engagement.execute(self, allocator, input, options);
    }

    /// Lists details of the engagement to a contact channel.
    pub fn describePage(self: *Self, allocator: std.mem.Allocator, input: describe_page.DescribePageInput, options: CallOptions) !describe_page.DescribePageOutput {
        return describe_page.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified contact or escalation plan.
    pub fn getContact(self: *Self, allocator: std.mem.Allocator, input: get_contact.GetContactInput, options: CallOptions) !get_contact.GetContactOutput {
        return get_contact.execute(self, allocator, input, options);
    }

    /// List details about a specific contact channel.
    pub fn getContactChannel(self: *Self, allocator: std.mem.Allocator, input: get_contact_channel.GetContactChannelInput, options: CallOptions) !get_contact_channel.GetContactChannelOutput {
        return get_contact_channel.execute(self, allocator, input, options);
    }

    /// Retrieves the resource policies attached to the specified contact or
    /// escalation
    /// plan.
    pub fn getContactPolicy(self: *Self, allocator: std.mem.Allocator, input: get_contact_policy.GetContactPolicyInput, options: CallOptions) !get_contact_policy.GetContactPolicyOutput {
        return get_contact_policy.execute(self, allocator, input, options);
    }

    /// Retrieves information about an on-call rotation.
    pub fn getRotation(self: *Self, allocator: std.mem.Allocator, input: get_rotation.GetRotationInput, options: CallOptions) !get_rotation.GetRotationOutput {
        return get_rotation.execute(self, allocator, input, options);
    }

    /// Retrieves information about an override to an on-call rotation.
    pub fn getRotationOverride(self: *Self, allocator: std.mem.Allocator, input: get_rotation_override.GetRotationOverrideInput, options: CallOptions) !get_rotation_override.GetRotationOverrideOutput {
        return get_rotation_override.execute(self, allocator, input, options);
    }

    /// Lists all contact channels for the specified contact.
    pub fn listContactChannels(self: *Self, allocator: std.mem.Allocator, input: list_contact_channels.ListContactChannelsInput, options: CallOptions) !list_contact_channels.ListContactChannelsOutput {
        return list_contact_channels.execute(self, allocator, input, options);
    }

    /// Lists all contacts and escalation plans in Incident Manager.
    pub fn listContacts(self: *Self, allocator: std.mem.Allocator, input: list_contacts.ListContactsInput, options: CallOptions) !list_contacts.ListContactsOutput {
        return list_contacts.execute(self, allocator, input, options);
    }

    /// Lists all engagements that have happened in an incident.
    pub fn listEngagements(self: *Self, allocator: std.mem.Allocator, input: list_engagements.ListEngagementsInput, options: CallOptions) !list_engagements.ListEngagementsOutput {
        return list_engagements.execute(self, allocator, input, options);
    }

    /// Lists all of the engagements to contact channels that have been
    /// acknowledged.
    pub fn listPageReceipts(self: *Self, allocator: std.mem.Allocator, input: list_page_receipts.ListPageReceiptsInput, options: CallOptions) !list_page_receipts.ListPageReceiptsOutput {
        return list_page_receipts.execute(self, allocator, input, options);
    }

    /// Returns the resolution path of an engagement. For example, the escalation
    /// plan engaged
    /// in an incident might target an on-call schedule that includes several
    /// contacts in a
    /// rotation, but just one contact on-call when the incident starts. The
    /// resolution path
    /// indicates the hierarchy of *escalation plan > on-call schedule >
    /// contact*.
    pub fn listPageResolutions(self: *Self, allocator: std.mem.Allocator, input: list_page_resolutions.ListPageResolutionsInput, options: CallOptions) !list_page_resolutions.ListPageResolutionsOutput {
        return list_page_resolutions.execute(self, allocator, input, options);
    }

    /// Lists the engagements to a contact's contact channels.
    pub fn listPagesByContact(self: *Self, allocator: std.mem.Allocator, input: list_pages_by_contact.ListPagesByContactInput, options: CallOptions) !list_pages_by_contact.ListPagesByContactOutput {
        return list_pages_by_contact.execute(self, allocator, input, options);
    }

    /// Lists the engagements to contact channels that occurred by engaging a
    /// contact.
    pub fn listPagesByEngagement(self: *Self, allocator: std.mem.Allocator, input: list_pages_by_engagement.ListPagesByEngagementInput, options: CallOptions) !list_pages_by_engagement.ListPagesByEngagementOutput {
        return list_pages_by_engagement.execute(self, allocator, input, options);
    }

    /// Returns a list of shifts based on rotation configuration parameters.
    ///
    /// The Incident Manager primarily uses this operation to populate the
    /// **Preview** calendar. It is not typically run by end users.
    pub fn listPreviewRotationShifts(self: *Self, allocator: std.mem.Allocator, input: list_preview_rotation_shifts.ListPreviewRotationShiftsInput, options: CallOptions) !list_preview_rotation_shifts.ListPreviewRotationShiftsOutput {
        return list_preview_rotation_shifts.execute(self, allocator, input, options);
    }

    /// Retrieves a list of overrides currently specified for an on-call rotation.
    pub fn listRotationOverrides(self: *Self, allocator: std.mem.Allocator, input: list_rotation_overrides.ListRotationOverridesInput, options: CallOptions) !list_rotation_overrides.ListRotationOverridesOutput {
        return list_rotation_overrides.execute(self, allocator, input, options);
    }

    /// Returns a list of shifts generated by an existing rotation in the system.
    pub fn listRotationShifts(self: *Self, allocator: std.mem.Allocator, input: list_rotation_shifts.ListRotationShiftsInput, options: CallOptions) !list_rotation_shifts.ListRotationShiftsOutput {
        return list_rotation_shifts.execute(self, allocator, input, options);
    }

    /// Retrieves a list of on-call rotations.
    pub fn listRotations(self: *Self, allocator: std.mem.Allocator, input: list_rotations.ListRotationsInput, options: CallOptions) !list_rotations.ListRotationsOutput {
        return list_rotations.execute(self, allocator, input, options);
    }

    /// Lists the tags of a contact, escalation plan, rotation, or on-call schedule.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds a resource policy to the specified contact or escalation plan. The
    /// resource policy
    /// is used to share the contact or escalation plan using Resource Access
    /// Manager (RAM). For more information about cross-account sharing, see
    /// [Setting up
    /// cross-account
    /// functionality](https://docs.aws.amazon.com/incident-manager/latest/userguide/xa.html).
    pub fn putContactPolicy(self: *Self, allocator: std.mem.Allocator, input: put_contact_policy.PutContactPolicyInput, options: CallOptions) !put_contact_policy.PutContactPolicyOutput {
        return put_contact_policy.execute(self, allocator, input, options);
    }

    /// Sends an activation code to a contact channel. The contact can use this code
    /// to activate
    /// the contact channel in the console or with the `ActivateChannel` operation.
    /// Incident Manager can't engage a contact channel until it has been activated.
    pub fn sendActivationCode(self: *Self, allocator: std.mem.Allocator, input: send_activation_code.SendActivationCodeInput, options: CallOptions) !send_activation_code.SendActivationCodeOutput {
        return send_activation_code.execute(self, allocator, input, options);
    }

    /// Starts an engagement to a contact or escalation plan. The engagement engages
    /// each
    /// contact specified in the incident.
    pub fn startEngagement(self: *Self, allocator: std.mem.Allocator, input: start_engagement.StartEngagementInput, options: CallOptions) !start_engagement.StartEngagementOutput {
        return start_engagement.execute(self, allocator, input, options);
    }

    /// Stops an engagement before it finishes the final stage of the escalation
    /// plan or
    /// engagement plan. Further contacts aren't engaged.
    pub fn stopEngagement(self: *Self, allocator: std.mem.Allocator, input: stop_engagement.StopEngagementInput, options: CallOptions) !stop_engagement.StopEngagementOutput {
        return stop_engagement.execute(self, allocator, input, options);
    }

    /// Tags a contact or escalation plan. You can tag only contacts and escalation
    /// plans in the
    /// first region of your replication set.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the contact or escalation plan specified.
    pub fn updateContact(self: *Self, allocator: std.mem.Allocator, input: update_contact.UpdateContactInput, options: CallOptions) !update_contact.UpdateContactOutput {
        return update_contact.execute(self, allocator, input, options);
    }

    /// Updates a contact's contact channel.
    pub fn updateContactChannel(self: *Self, allocator: std.mem.Allocator, input: update_contact_channel.UpdateContactChannelInput, options: CallOptions) !update_contact_channel.UpdateContactChannelOutput {
        return update_contact_channel.execute(self, allocator, input, options);
    }

    /// Updates the information specified for an on-call rotation.
    pub fn updateRotation(self: *Self, allocator: std.mem.Allocator, input: update_rotation.UpdateRotationInput, options: CallOptions) !update_rotation.UpdateRotationOutput {
        return update_rotation.execute(self, allocator, input, options);
    }

    pub fn listContactChannelsPaginator(self: *Self, params: list_contact_channels.ListContactChannelsInput) paginator.ListContactChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listContactsPaginator(self: *Self, params: list_contacts.ListContactsInput) paginator.ListContactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEngagementsPaginator(self: *Self, params: list_engagements.ListEngagementsInput) paginator.ListEngagementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPageReceiptsPaginator(self: *Self, params: list_page_receipts.ListPageReceiptsInput) paginator.ListPageReceiptsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPageResolutionsPaginator(self: *Self, params: list_page_resolutions.ListPageResolutionsInput) paginator.ListPageResolutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPagesByContactPaginator(self: *Self, params: list_pages_by_contact.ListPagesByContactInput) paginator.ListPagesByContactPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPagesByEngagementPaginator(self: *Self, params: list_pages_by_engagement.ListPagesByEngagementInput) paginator.ListPagesByEngagementPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPreviewRotationShiftsPaginator(self: *Self, params: list_preview_rotation_shifts.ListPreviewRotationShiftsInput) paginator.ListPreviewRotationShiftsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRotationOverridesPaginator(self: *Self, params: list_rotation_overrides.ListRotationOverridesInput) paginator.ListRotationOverridesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRotationShiftsPaginator(self: *Self, params: list_rotation_shifts.ListRotationShiftsInput) paginator.ListRotationShiftsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRotationsPaginator(self: *Self, params: list_rotations.ListRotationsInput) paginator.ListRotationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
