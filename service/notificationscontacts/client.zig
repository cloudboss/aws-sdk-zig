const aws = @import("aws");
const std = @import("std");

const activate_email_contact = @import("activate_email_contact.zig");
const create_email_contact = @import("create_email_contact.zig");
const delete_email_contact = @import("delete_email_contact.zig");
const get_email_contact = @import("get_email_contact.zig");
const list_email_contacts = @import("list_email_contacts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const send_activation_code = @import("send_activation_code.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "NotificationsContacts";

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

    /// Activates an email contact using an activation code. This code is in the
    /// activation email sent to the email address associated with this email
    /// contact.
    pub fn activateEmailContact(self: *Self, allocator: std.mem.Allocator, input: activate_email_contact.ActivateEmailContactInput, options: CallOptions) !activate_email_contact.ActivateEmailContactOutput {
        return activate_email_contact.execute(self, allocator, input, options);
    }

    /// Creates an email contact for the provided email address.
    pub fn createEmailContact(self: *Self, allocator: std.mem.Allocator, input: create_email_contact.CreateEmailContactInput, options: CallOptions) !create_email_contact.CreateEmailContactOutput {
        return create_email_contact.execute(self, allocator, input, options);
    }

    /// Deletes an email contact.
    ///
    /// Deleting an email contact removes it from all associated notification
    /// configurations.
    pub fn deleteEmailContact(self: *Self, allocator: std.mem.Allocator, input: delete_email_contact.DeleteEmailContactInput, options: CallOptions) !delete_email_contact.DeleteEmailContactOutput {
        return delete_email_contact.execute(self, allocator, input, options);
    }

    /// Returns an email contact.
    pub fn getEmailContact(self: *Self, allocator: std.mem.Allocator, input: get_email_contact.GetEmailContactInput, options: CallOptions) !get_email_contact.GetEmailContactOutput {
        return get_email_contact.execute(self, allocator, input, options);
    }

    /// Lists all email contacts created under the Account.
    pub fn listEmailContacts(self: *Self, allocator: std.mem.Allocator, input: list_email_contacts.ListEmailContactsInput, options: CallOptions) !list_email_contacts.ListEmailContactsOutput {
        return list_email_contacts.execute(self, allocator, input, options);
    }

    /// Lists all of the tags associated with the Amazon Resource Name (ARN) that
    /// you specify. The resource can be a user, server, or role.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sends an activation email to the email address associated with the specified
    /// email contact.
    ///
    /// It might take a few minutes for the activation email to arrive. If it
    /// doesn't arrive, check in your spam folder or try sending another activation
    /// email.
    pub fn sendActivationCode(self: *Self, allocator: std.mem.Allocator, input: send_activation_code.SendActivationCodeInput, options: CallOptions) !send_activation_code.SendActivationCodeOutput {
        return send_activation_code.execute(self, allocator, input, options);
    }

    /// Attaches a key-value pair to a resource, as identified by its Amazon
    /// Resource Name (ARN). Taggable resources in AWS User Notifications Contacts
    /// include email contacts.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Detaches a key-value pair from a resource, as identified by its Amazon
    /// Resource Name (ARN). Taggable resources in AWS User Notifications Contacts
    /// include email contacts..
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listEmailContactsPaginator(self: *Self, params: list_email_contacts.ListEmailContactsInput) paginator.ListEmailContactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
