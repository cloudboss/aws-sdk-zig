const aws = @import("aws");
const std = @import("std");

const associate_whats_app_business_account = @import("associate_whats_app_business_account.zig");
const create_whats_app_message_template = @import("create_whats_app_message_template.zig");
const create_whats_app_message_template_from_library = @import("create_whats_app_message_template_from_library.zig");
const create_whats_app_message_template_media = @import("create_whats_app_message_template_media.zig");
const delete_whats_app_message_media = @import("delete_whats_app_message_media.zig");
const delete_whats_app_message_template = @import("delete_whats_app_message_template.zig");
const disassociate_whats_app_business_account = @import("disassociate_whats_app_business_account.zig");
const get_linked_whats_app_business_account = @import("get_linked_whats_app_business_account.zig");
const get_linked_whats_app_business_account_phone_number = @import("get_linked_whats_app_business_account_phone_number.zig");
const get_whats_app_message_media = @import("get_whats_app_message_media.zig");
const get_whats_app_message_template = @import("get_whats_app_message_template.zig");
const list_linked_whats_app_business_accounts = @import("list_linked_whats_app_business_accounts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_whats_app_message_templates = @import("list_whats_app_message_templates.zig");
const list_whats_app_template_library = @import("list_whats_app_template_library.zig");
const post_whats_app_message_media = @import("post_whats_app_message_media.zig");
const put_whats_app_business_account_event_destinations = @import("put_whats_app_business_account_event_destinations.zig");
const send_whats_app_message = @import("send_whats_app_message.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_whats_app_message_template = @import("update_whats_app_message_template.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "SocialMessaging";

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

    /// This is only used through the Amazon Web Services console during sign-up to
    /// associate your WhatsApp Business Account to your Amazon Web Services
    /// account.
    pub fn associateWhatsAppBusinessAccount(self: *Self, allocator: std.mem.Allocator, input: associate_whats_app_business_account.AssociateWhatsAppBusinessAccountInput, options: CallOptions) !associate_whats_app_business_account.AssociateWhatsAppBusinessAccountOutput {
        return associate_whats_app_business_account.execute(self, allocator, input, options);
    }

    /// Creates a new WhatsApp message template from a custom definition.
    ///
    /// Amazon Web Services End User Messaging Social does not store any WhatsApp
    /// message template content.
    pub fn createWhatsAppMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: create_whats_app_message_template.CreateWhatsAppMessageTemplateInput, options: CallOptions) !create_whats_app_message_template.CreateWhatsAppMessageTemplateOutput {
        return create_whats_app_message_template.execute(self, allocator, input, options);
    }

    /// Creates a new WhatsApp message template using a template from Meta's
    /// template library.
    pub fn createWhatsAppMessageTemplateFromLibrary(self: *Self, allocator: std.mem.Allocator, input: create_whats_app_message_template_from_library.CreateWhatsAppMessageTemplateFromLibraryInput, options: CallOptions) !create_whats_app_message_template_from_library.CreateWhatsAppMessageTemplateFromLibraryOutput {
        return create_whats_app_message_template_from_library.execute(self, allocator, input, options);
    }

    /// Uploads media for use in a WhatsApp message template.
    pub fn createWhatsAppMessageTemplateMedia(self: *Self, allocator: std.mem.Allocator, input: create_whats_app_message_template_media.CreateWhatsAppMessageTemplateMediaInput, options: CallOptions) !create_whats_app_message_template_media.CreateWhatsAppMessageTemplateMediaOutput {
        return create_whats_app_message_template_media.execute(self, allocator, input, options);
    }

    /// Delete a media object from the WhatsApp service. If the object is still in
    /// an Amazon S3 bucket you should delete it from there too.
    pub fn deleteWhatsAppMessageMedia(self: *Self, allocator: std.mem.Allocator, input: delete_whats_app_message_media.DeleteWhatsAppMessageMediaInput, options: CallOptions) !delete_whats_app_message_media.DeleteWhatsAppMessageMediaOutput {
        return delete_whats_app_message_media.execute(self, allocator, input, options);
    }

    /// Deletes a WhatsApp message template.
    pub fn deleteWhatsAppMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_whats_app_message_template.DeleteWhatsAppMessageTemplateInput, options: CallOptions) !delete_whats_app_message_template.DeleteWhatsAppMessageTemplateOutput {
        return delete_whats_app_message_template.execute(self, allocator, input, options);
    }

    /// Disassociate a WhatsApp Business Account (WABA) from your Amazon Web
    /// Services account.
    pub fn disassociateWhatsAppBusinessAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_whats_app_business_account.DisassociateWhatsAppBusinessAccountInput, options: CallOptions) !disassociate_whats_app_business_account.DisassociateWhatsAppBusinessAccountOutput {
        return disassociate_whats_app_business_account.execute(self, allocator, input, options);
    }

    /// Get the details of your linked WhatsApp Business Account.
    pub fn getLinkedWhatsAppBusinessAccount(self: *Self, allocator: std.mem.Allocator, input: get_linked_whats_app_business_account.GetLinkedWhatsAppBusinessAccountInput, options: CallOptions) !get_linked_whats_app_business_account.GetLinkedWhatsAppBusinessAccountOutput {
        return get_linked_whats_app_business_account.execute(self, allocator, input, options);
    }

    /// Retrieve the WABA account id and phone number details of a WhatsApp business
    /// account phone number.
    pub fn getLinkedWhatsAppBusinessAccountPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: get_linked_whats_app_business_account_phone_number.GetLinkedWhatsAppBusinessAccountPhoneNumberInput, options: CallOptions) !get_linked_whats_app_business_account_phone_number.GetLinkedWhatsAppBusinessAccountPhoneNumberOutput {
        return get_linked_whats_app_business_account_phone_number.execute(self, allocator, input, options);
    }

    /// Get a media file from the WhatsApp service. On successful completion the
    /// media file is
    /// retrieved from Meta and stored in the specified Amazon S3 bucket. Use either
    /// `destinationS3File` or `destinationS3PresignedUrl` for the
    /// destination. If both are used then an `InvalidParameterException` is
    /// returned.
    pub fn getWhatsAppMessageMedia(self: *Self, allocator: std.mem.Allocator, input: get_whats_app_message_media.GetWhatsAppMessageMediaInput, options: CallOptions) !get_whats_app_message_media.GetWhatsAppMessageMediaOutput {
        return get_whats_app_message_media.execute(self, allocator, input, options);
    }

    /// Retrieves a specific WhatsApp message template.
    pub fn getWhatsAppMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: get_whats_app_message_template.GetWhatsAppMessageTemplateInput, options: CallOptions) !get_whats_app_message_template.GetWhatsAppMessageTemplateOutput {
        return get_whats_app_message_template.execute(self, allocator, input, options);
    }

    /// List all WhatsApp Business Accounts linked to your Amazon Web Services
    /// account.
    pub fn listLinkedWhatsAppBusinessAccounts(self: *Self, allocator: std.mem.Allocator, input: list_linked_whats_app_business_accounts.ListLinkedWhatsAppBusinessAccountsInput, options: CallOptions) !list_linked_whats_app_business_accounts.ListLinkedWhatsAppBusinessAccountsOutput {
        return list_linked_whats_app_business_accounts.execute(self, allocator, input, options);
    }

    /// List all tags associated with a resource, such as a phone number or WABA.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists WhatsApp message templates for a specific WhatsApp Business Account.
    pub fn listWhatsAppMessageTemplates(self: *Self, allocator: std.mem.Allocator, input: list_whats_app_message_templates.ListWhatsAppMessageTemplatesInput, options: CallOptions) !list_whats_app_message_templates.ListWhatsAppMessageTemplatesOutput {
        return list_whats_app_message_templates.execute(self, allocator, input, options);
    }

    /// Lists templates available in Meta's template library for WhatsApp messaging.
    pub fn listWhatsAppTemplateLibrary(self: *Self, allocator: std.mem.Allocator, input: list_whats_app_template_library.ListWhatsAppTemplateLibraryInput, options: CallOptions) !list_whats_app_template_library.ListWhatsAppTemplateLibraryOutput {
        return list_whats_app_template_library.execute(self, allocator, input, options);
    }

    /// Upload a media file to the WhatsApp service. Only the specified
    /// `originationPhoneNumberId` has the permissions to send the media file when
    /// using
    /// [SendWhatsAppMessage](https://docs.aws.amazon.com/social-messaging/latest/APIReference/API_SendWhatsAppMessage.html). You must use either `sourceS3File`
    /// or `sourceS3PresignedUrl` for the source. If both or neither are specified
    /// then an
    /// `InvalidParameterException` is returned.
    pub fn postWhatsAppMessageMedia(self: *Self, allocator: std.mem.Allocator, input: post_whats_app_message_media.PostWhatsAppMessageMediaInput, options: CallOptions) !post_whats_app_message_media.PostWhatsAppMessageMediaOutput {
        return post_whats_app_message_media.execute(self, allocator, input, options);
    }

    /// Add an event destination to log event data from WhatsApp for a WhatsApp
    /// Business Account (WABA). A WABA can only have one event destination at a
    /// time. All resources associated with the WABA use the same event destination.
    pub fn putWhatsAppBusinessAccountEventDestinations(self: *Self, allocator: std.mem.Allocator, input: put_whats_app_business_account_event_destinations.PutWhatsAppBusinessAccountEventDestinationsInput, options: CallOptions) !put_whats_app_business_account_event_destinations.PutWhatsAppBusinessAccountEventDestinationsOutput {
        return put_whats_app_business_account_event_destinations.execute(self, allocator, input, options);
    }

    /// Send a WhatsApp message. For examples of sending a message using the Amazon
    /// Web Services
    /// CLI, see [Sending
    /// messages](https://docs.aws.amazon.com/social-messaging/latest/userguide/send-message.html) in the
    /// *
    /// Amazon Web Services End User Messaging Social User Guide*
    /// .
    pub fn sendWhatsAppMessage(self: *Self, allocator: std.mem.Allocator, input: send_whats_app_message.SendWhatsAppMessageInput, options: CallOptions) !send_whats_app_message.SendWhatsAppMessageOutput {
        return send_whats_app_message.execute(self, allocator, input, options);
    }

    /// Adds or overwrites only the specified tags for the specified resource. When
    /// you specify
    /// an existing tag key, the value is overwritten with the new value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing WhatsApp message template.
    pub fn updateWhatsAppMessageTemplate(self: *Self, allocator: std.mem.Allocator, input: update_whats_app_message_template.UpdateWhatsAppMessageTemplateInput, options: CallOptions) !update_whats_app_message_template.UpdateWhatsAppMessageTemplateOutput {
        return update_whats_app_message_template.execute(self, allocator, input, options);
    }

    pub fn listLinkedWhatsAppBusinessAccountsPaginator(self: *Self, params: list_linked_whats_app_business_accounts.ListLinkedWhatsAppBusinessAccountsInput) paginator.ListLinkedWhatsAppBusinessAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWhatsAppMessageTemplatesPaginator(self: *Self, params: list_whats_app_message_templates.ListWhatsAppMessageTemplatesInput) paginator.ListWhatsAppMessageTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWhatsAppTemplateLibraryPaginator(self: *Self, params: list_whats_app_template_library.ListWhatsAppTemplateLibraryInput) paginator.ListWhatsAppTemplateLibraryPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
