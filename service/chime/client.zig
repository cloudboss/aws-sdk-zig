const aws = @import("aws");
const std = @import("std");

const associate_phone_number_with_user = @import("associate_phone_number_with_user.zig");
const associate_signin_delegate_groups_with_account = @import("associate_signin_delegate_groups_with_account.zig");
const batch_create_room_membership = @import("batch_create_room_membership.zig");
const batch_delete_phone_number = @import("batch_delete_phone_number.zig");
const batch_suspend_user = @import("batch_suspend_user.zig");
const batch_unsuspend_user = @import("batch_unsuspend_user.zig");
const batch_update_phone_number = @import("batch_update_phone_number.zig");
const batch_update_user = @import("batch_update_user.zig");
const create_account = @import("create_account.zig");
const create_bot = @import("create_bot.zig");
const create_meeting_dial_out = @import("create_meeting_dial_out.zig");
const create_phone_number_order = @import("create_phone_number_order.zig");
const create_room = @import("create_room.zig");
const create_room_membership = @import("create_room_membership.zig");
const create_user = @import("create_user.zig");
const delete_account = @import("delete_account.zig");
const delete_events_configuration = @import("delete_events_configuration.zig");
const delete_phone_number = @import("delete_phone_number.zig");
const delete_room = @import("delete_room.zig");
const delete_room_membership = @import("delete_room_membership.zig");
const disassociate_phone_number_from_user = @import("disassociate_phone_number_from_user.zig");
const disassociate_signin_delegate_groups_from_account = @import("disassociate_signin_delegate_groups_from_account.zig");
const get_account = @import("get_account.zig");
const get_account_settings = @import("get_account_settings.zig");
const get_bot = @import("get_bot.zig");
const get_events_configuration = @import("get_events_configuration.zig");
const get_global_settings = @import("get_global_settings.zig");
const get_phone_number = @import("get_phone_number.zig");
const get_phone_number_order = @import("get_phone_number_order.zig");
const get_phone_number_settings = @import("get_phone_number_settings.zig");
const get_retention_settings = @import("get_retention_settings.zig");
const get_room = @import("get_room.zig");
const get_user = @import("get_user.zig");
const get_user_settings = @import("get_user_settings.zig");
const invite_users = @import("invite_users.zig");
const list_accounts = @import("list_accounts.zig");
const list_bots = @import("list_bots.zig");
const list_phone_number_orders = @import("list_phone_number_orders.zig");
const list_phone_numbers = @import("list_phone_numbers.zig");
const list_room_memberships = @import("list_room_memberships.zig");
const list_rooms = @import("list_rooms.zig");
const list_supported_phone_number_countries = @import("list_supported_phone_number_countries.zig");
const list_users = @import("list_users.zig");
const logout_user = @import("logout_user.zig");
const put_events_configuration = @import("put_events_configuration.zig");
const put_retention_settings = @import("put_retention_settings.zig");
const redact_conversation_message = @import("redact_conversation_message.zig");
const redact_room_message = @import("redact_room_message.zig");
const regenerate_security_token = @import("regenerate_security_token.zig");
const reset_personal_pin = @import("reset_personal_pin.zig");
const restore_phone_number = @import("restore_phone_number.zig");
const search_available_phone_numbers = @import("search_available_phone_numbers.zig");
const update_account = @import("update_account.zig");
const update_account_settings = @import("update_account_settings.zig");
const update_bot = @import("update_bot.zig");
const update_global_settings = @import("update_global_settings.zig");
const update_phone_number = @import("update_phone_number.zig");
const update_phone_number_settings = @import("update_phone_number_settings.zig");
const update_room = @import("update_room.zig");
const update_room_membership = @import("update_room_membership.zig");
const update_user = @import("update_user.zig");
const update_user_settings = @import("update_user_settings.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime";

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

    /// Associates a phone number with the specified Amazon Chime user.
    pub fn associatePhoneNumberWithUser(self: *Self, allocator: std.mem.Allocator, input: associate_phone_number_with_user.AssociatePhoneNumberWithUserInput, options: associate_phone_number_with_user.Options) !associate_phone_number_with_user.AssociatePhoneNumberWithUserOutput {
        return associate_phone_number_with_user.execute(self, allocator, input, options);
    }

    /// Associates the specified sign-in delegate groups with the specified Amazon
    /// Chime account.
    pub fn associateSigninDelegateGroupsWithAccount(self: *Self, allocator: std.mem.Allocator, input: associate_signin_delegate_groups_with_account.AssociateSigninDelegateGroupsWithAccountInput, options: associate_signin_delegate_groups_with_account.Options) !associate_signin_delegate_groups_with_account.AssociateSigninDelegateGroupsWithAccountOutput {
        return associate_signin_delegate_groups_with_account.execute(self, allocator, input, options);
    }

    /// Adds up to 50 members to a chat room in an Amazon Chime Enterprise account.
    /// Members can be users or bots. The member role designates whether the member
    /// is a
    /// chat room administrator or a general chat room member.
    pub fn batchCreateRoomMembership(self: *Self, allocator: std.mem.Allocator, input: batch_create_room_membership.BatchCreateRoomMembershipInput, options: batch_create_room_membership.Options) !batch_create_room_membership.BatchCreateRoomMembershipOutput {
        return batch_create_room_membership.execute(self, allocator, input, options);
    }

    /// Moves phone numbers into the
    /// **Deletion queue**. Phone numbers must be disassociated from any users or
    /// Amazon Chime Voice Connectors before they can be deleted.
    ///
    /// Phone numbers remain in the
    /// **Deletion queue** for 7 days before they are deleted permanently.
    pub fn batchDeletePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: batch_delete_phone_number.BatchDeletePhoneNumberInput, options: batch_delete_phone_number.Options) !batch_delete_phone_number.BatchDeletePhoneNumberOutput {
        return batch_delete_phone_number.execute(self, allocator, input, options);
    }

    /// Suspends up to 50 users from a `Team` or `EnterpriseLWA` Amazon Chime
    /// account. For more information about different account types, see [Managing
    /// Your Amazon Chime
    /// Accounts](https://docs.aws.amazon.com/chime/latest/ag/manage-chime-account.html) in the *Amazon Chime Administration
    /// Guide*.
    ///
    /// Users suspended from a `Team` account are disassociated from the account,but
    /// they
    /// can continue to use Amazon Chime as free users. To remove the suspension
    /// from suspended
    /// `Team` account users, invite them to the `Team` account again.
    /// You can use the InviteUsers action to do so.
    ///
    /// Users suspended from an `EnterpriseLWA` account are immediately signed out
    /// of
    /// Amazon Chime and can no longer sign in. To remove the suspension from
    /// suspended `EnterpriseLWA` account users, use the
    /// BatchUnsuspendUser action.
    ///
    /// To sign out users without suspending them, use the
    /// LogoutUser action.
    pub fn batchSuspendUser(self: *Self, allocator: std.mem.Allocator, input: batch_suspend_user.BatchSuspendUserInput, options: batch_suspend_user.Options) !batch_suspend_user.BatchSuspendUserOutput {
        return batch_suspend_user.execute(self, allocator, input, options);
    }

    /// Removes the suspension from up to 50 previously suspended users for the
    /// specified Amazon
    /// Chime `EnterpriseLWA` account. Only users on `EnterpriseLWA`
    /// accounts can be unsuspended using this action. For more information about
    /// different account types, see
    /// [
    /// Managing Your Amazon Chime Accounts
    /// ](https://docs.aws.amazon.com/chime/latest/ag/manage-chime-account.html) in
    /// the account types, in the *Amazon Chime Administration Guide*.
    ///
    /// Previously suspended users who are unsuspended using this action are
    /// returned to
    /// `Registered`
    /// status. Users who are not previously suspended are ignored.
    pub fn batchUnsuspendUser(self: *Self, allocator: std.mem.Allocator, input: batch_unsuspend_user.BatchUnsuspendUserInput, options: batch_unsuspend_user.Options) !batch_unsuspend_user.BatchUnsuspendUserOutput {
        return batch_unsuspend_user.execute(self, allocator, input, options);
    }

    /// Updates phone number product types or calling names. You can update one
    /// attribute at a time for each `UpdatePhoneNumberRequestItem`. For example,
    /// you can update the product type or the calling name.
    ///
    /// For toll-free numbers, you cannot use the Amazon Chime Business Calling
    /// product type. For numbers outside the U.S., you must use the Amazon Chime
    /// SIP Media Application Dial-In product type.
    ///
    /// Updates to outbound calling names can take up to 72 hours to complete.
    /// Pending updates to outbound calling names must be complete before you can
    /// request another update.
    pub fn batchUpdatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: batch_update_phone_number.BatchUpdatePhoneNumberInput, options: batch_update_phone_number.Options) !batch_update_phone_number.BatchUpdatePhoneNumberOutput {
        return batch_update_phone_number.execute(self, allocator, input, options);
    }

    /// Updates user details within the UpdateUserRequestItem object for up to 20
    /// users for the specified Amazon Chime account. Currently, only `LicenseType`
    /// updates are supported for this action.
    pub fn batchUpdateUser(self: *Self, allocator: std.mem.Allocator, input: batch_update_user.BatchUpdateUserInput, options: batch_update_user.Options) !batch_update_user.BatchUpdateUserOutput {
        return batch_update_user.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Chime account under the administrator's AWS account. Only
    /// `Team`
    /// account types are currently supported for this action. For more information
    /// about different account types, see
    /// [Managing Your Amazon Chime
    /// Accounts](https://docs.aws.amazon.com/chime/latest/ag/manage-chime-account.html) in the *Amazon Chime
    /// Administration Guide*.
    pub fn createAccount(self: *Self, allocator: std.mem.Allocator, input: create_account.CreateAccountInput, options: create_account.Options) !create_account.CreateAccountOutput {
        return create_account.execute(self, allocator, input, options);
    }

    /// Creates a bot for an Amazon Chime Enterprise account.
    pub fn createBot(self: *Self, allocator: std.mem.Allocator, input: create_bot.CreateBotInput, options: create_bot.Options) !create_bot.CreateBotOutput {
        return create_bot.execute(self, allocator, input, options);
    }

    /// Uses the join token and call metadata in a meeting request (From number, To
    /// number, and so forth) to initiate an outbound call to a public
    /// switched telephone network (PSTN) and join them into a Chime meeting. Also
    /// ensures that the From number belongs to the customer.
    ///
    /// To play welcome audio or implement an interactive voice response (IVR), use
    /// the
    /// `CreateSipMediaApplicationCall` action with the corresponding SIP media
    /// application ID.
    ///
    /// **This API is not available in a dedicated namespace.**
    pub fn createMeetingDialOut(self: *Self, allocator: std.mem.Allocator, input: create_meeting_dial_out.CreateMeetingDialOutInput, options: create_meeting_dial_out.Options) !create_meeting_dial_out.CreateMeetingDialOutOutput {
        return create_meeting_dial_out.execute(self, allocator, input, options);
    }

    /// Creates an order for phone numbers to be provisioned. For toll-free numbers,
    /// you cannot use the Amazon Chime Business Calling product type.
    /// For numbers outside the U.S., you must use the Amazon Chime SIP Media
    /// Application Dial-In product type.
    pub fn createPhoneNumberOrder(self: *Self, allocator: std.mem.Allocator, input: create_phone_number_order.CreatePhoneNumberOrderInput, options: create_phone_number_order.Options) !create_phone_number_order.CreatePhoneNumberOrderOutput {
        return create_phone_number_order.execute(self, allocator, input, options);
    }

    /// Creates a chat room for the specified Amazon Chime Enterprise account.
    pub fn createRoom(self: *Self, allocator: std.mem.Allocator, input: create_room.CreateRoomInput, options: create_room.Options) !create_room.CreateRoomOutput {
        return create_room.execute(self, allocator, input, options);
    }

    /// Adds a member to a chat room in an Amazon Chime Enterprise account. A member
    /// can be either a user or a bot. The member role designates whether the member
    /// is a chat room administrator or a general chat room member.
    pub fn createRoomMembership(self: *Self, allocator: std.mem.Allocator, input: create_room_membership.CreateRoomMembershipInput, options: create_room_membership.Options) !create_room_membership.CreateRoomMembershipOutput {
        return create_room_membership.execute(self, allocator, input, options);
    }

    /// Creates a user under the specified Amazon Chime account.
    pub fn createUser(self: *Self, allocator: std.mem.Allocator, input: create_user.CreateUserInput, options: create_user.Options) !create_user.CreateUserOutput {
        return create_user.execute(self, allocator, input, options);
    }

    /// Deletes the specified Amazon Chime account. You must suspend all users
    /// before deleting
    /// `Team` account. You can use the BatchSuspendUser action
    /// to dodo.
    ///
    /// For `EnterpriseLWA` and `EnterpriseAD` accounts, you must release the
    /// claimed domains for your Amazon Chime account before deletion. As soon as
    /// you release
    /// the domain, all users under that account are suspended.
    ///
    /// Deleted accounts appear in your `Disabled` accounts list for 90 days. To
    /// restore
    /// deleted account from your `Disabled` accounts list, you must contact AWS
    /// Support.
    ///
    /// After 90 days, deleted accounts are permanently removed from your
    /// `Disabled` accounts list.
    pub fn deleteAccount(self: *Self, allocator: std.mem.Allocator, input: delete_account.DeleteAccountInput, options: delete_account.Options) !delete_account.DeleteAccountOutput {
        return delete_account.execute(self, allocator, input, options);
    }

    /// Deletes the events configuration that allows a bot to receive outgoing
    /// events.
    pub fn deleteEventsConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_events_configuration.DeleteEventsConfigurationInput, options: delete_events_configuration.Options) !delete_events_configuration.DeleteEventsConfigurationOutput {
        return delete_events_configuration.execute(self, allocator, input, options);
    }

    /// Moves the specified phone number into the **Deletion queue**. A
    /// phone number must be disassociated from any users or Amazon Chime Voice
    /// Connectors
    /// before it can be deleted.
    ///
    /// Deleted phone numbers remain in the
    /// **Deletion queue**
    /// for 7 days before they are deleted permanently.
    pub fn deletePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: delete_phone_number.DeletePhoneNumberInput, options: delete_phone_number.Options) !delete_phone_number.DeletePhoneNumberOutput {
        return delete_phone_number.execute(self, allocator, input, options);
    }

    /// Deletes a chat room in an Amazon Chime Enterprise account.
    pub fn deleteRoom(self: *Self, allocator: std.mem.Allocator, input: delete_room.DeleteRoomInput, options: delete_room.Options) !delete_room.DeleteRoomOutput {
        return delete_room.execute(self, allocator, input, options);
    }

    /// Removes a member from a chat room in an Amazon Chime Enterprise account.
    pub fn deleteRoomMembership(self: *Self, allocator: std.mem.Allocator, input: delete_room_membership.DeleteRoomMembershipInput, options: delete_room_membership.Options) !delete_room_membership.DeleteRoomMembershipOutput {
        return delete_room_membership.execute(self, allocator, input, options);
    }

    /// Disassociates the primary provisioned phone number from the specified Amazon
    /// Chime user.
    pub fn disassociatePhoneNumberFromUser(self: *Self, allocator: std.mem.Allocator, input: disassociate_phone_number_from_user.DisassociatePhoneNumberFromUserInput, options: disassociate_phone_number_from_user.Options) !disassociate_phone_number_from_user.DisassociatePhoneNumberFromUserOutput {
        return disassociate_phone_number_from_user.execute(self, allocator, input, options);
    }

    /// Disassociates the specified sign-in delegate groups from the specified
    /// Amazon Chime account.
    pub fn disassociateSigninDelegateGroupsFromAccount(self: *Self, allocator: std.mem.Allocator, input: disassociate_signin_delegate_groups_from_account.DisassociateSigninDelegateGroupsFromAccountInput, options: disassociate_signin_delegate_groups_from_account.Options) !disassociate_signin_delegate_groups_from_account.DisassociateSigninDelegateGroupsFromAccountOutput {
        return disassociate_signin_delegate_groups_from_account.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified Amazon Chime account, such as account
    /// type and supported
    /// licenses.
    pub fn getAccount(self: *Self, allocator: std.mem.Allocator, input: get_account.GetAccountInput, options: get_account.Options) !get_account.GetAccountOutput {
        return get_account.execute(self, allocator, input, options);
    }

    /// Retrieves account settings for the specified Amazon Chime account ID, such
    /// as remote control
    /// and dialout settings. For more information about these settings, see
    /// [Use the Policies
    /// Page](https://docs.aws.amazon.com/chime/latest/ag/policies.html) in the
    /// *Amazon Chime Administration Guide*.
    pub fn getAccountSettings(self: *Self, allocator: std.mem.Allocator, input: get_account_settings.GetAccountSettingsInput, options: get_account_settings.Options) !get_account_settings.GetAccountSettingsOutput {
        return get_account_settings.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified bot, such as bot email address, bot
    /// type, status, and display name.
    pub fn getBot(self: *Self, allocator: std.mem.Allocator, input: get_bot.GetBotInput, options: get_bot.Options) !get_bot.GetBotOutput {
        return get_bot.execute(self, allocator, input, options);
    }

    /// Gets details for an events configuration that allows a bot to receive
    /// outgoing events, such as an HTTPS endpoint or Lambda function ARN.
    pub fn getEventsConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_events_configuration.GetEventsConfigurationInput, options: get_events_configuration.Options) !get_events_configuration.GetEventsConfigurationOutput {
        return get_events_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves global settings for the administrator's AWS account, such as
    /// Amazon Chime Business
    /// Calling and Amazon Chime Voice Connector settings.
    pub fn getGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: get_global_settings.GetGlobalSettingsInput, options: get_global_settings.Options) !get_global_settings.GetGlobalSettingsOutput {
        return get_global_settings.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified phone number ID, such as associations,
    /// capabilities, and product type.
    pub fn getPhoneNumber(self: *Self, allocator: std.mem.Allocator, input: get_phone_number.GetPhoneNumberInput, options: get_phone_number.Options) !get_phone_number.GetPhoneNumberOutput {
        return get_phone_number.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified phone number order, such as the order
    /// creation timestamp, phone
    /// numbers in E.164 format, product type, and order status.
    pub fn getPhoneNumberOrder(self: *Self, allocator: std.mem.Allocator, input: get_phone_number_order.GetPhoneNumberOrderInput, options: get_phone_number_order.Options) !get_phone_number_order.GetPhoneNumberOrderOutput {
        return get_phone_number_order.execute(self, allocator, input, options);
    }

    /// Retrieves the phone number settings for the administrator's AWS account,
    /// such as the default outbound calling name.
    pub fn getPhoneNumberSettings(self: *Self, allocator: std.mem.Allocator, input: get_phone_number_settings.GetPhoneNumberSettingsInput, options: get_phone_number_settings.Options) !get_phone_number_settings.GetPhoneNumberSettingsOutput {
        return get_phone_number_settings.execute(self, allocator, input, options);
    }

    /// Gets the retention settings for the specified Amazon Chime Enterprise
    /// account. For more information about retention settings, see
    /// [Managing Chat Retention
    /// Policies](https://docs.aws.amazon.com/chime/latest/ag/chat-retention.html)
    /// in the *Amazon Chime Administration Guide*.
    pub fn getRetentionSettings(self: *Self, allocator: std.mem.Allocator, input: get_retention_settings.GetRetentionSettingsInput, options: get_retention_settings.Options) !get_retention_settings.GetRetentionSettingsOutput {
        return get_retention_settings.execute(self, allocator, input, options);
    }

    /// Retrieves room details, such as the room name, for a room in an Amazon Chime
    /// Enterprise account.
    pub fn getRoom(self: *Self, allocator: std.mem.Allocator, input: get_room.GetRoomInput, options: get_room.Options) !get_room.GetRoomOutput {
        return get_room.execute(self, allocator, input, options);
    }

    /// Retrieves details for the specified user ID, such as primary email address,
    /// license type,and personal meeting PIN.
    ///
    /// To retrieve user details with an email address instead of a user ID, use the
    /// ListUsers action, and then filter by email address.
    pub fn getUser(self: *Self, allocator: std.mem.Allocator, input: get_user.GetUserInput, options: get_user.Options) !get_user.GetUserOutput {
        return get_user.execute(self, allocator, input, options);
    }

    /// Retrieves settings for the specified user ID, such as any associated phone
    /// number settings.
    pub fn getUserSettings(self: *Self, allocator: std.mem.Allocator, input: get_user_settings.GetUserSettingsInput, options: get_user_settings.Options) !get_user_settings.GetUserSettingsOutput {
        return get_user_settings.execute(self, allocator, input, options);
    }

    /// Sends email to a maximum of 50 users, inviting them to the specified Amazon
    /// Chime
    /// `Team` account. Only `Team` account types are currently
    /// supported for this action.
    pub fn inviteUsers(self: *Self, allocator: std.mem.Allocator, input: invite_users.InviteUsersInput, options: invite_users.Options) !invite_users.InviteUsersOutput {
        return invite_users.execute(self, allocator, input, options);
    }

    /// Lists the Amazon Chime accounts under the administrator's AWS account. You
    /// can filter accounts
    /// by account name prefix. To find out which Amazon Chime account a user
    /// belongs to, you can
    /// filter by the user's email address, which returns one account result.
    pub fn listAccounts(self: *Self, allocator: std.mem.Allocator, input: list_accounts.ListAccountsInput, options: list_accounts.Options) !list_accounts.ListAccountsOutput {
        return list_accounts.execute(self, allocator, input, options);
    }

    /// Lists the bots associated with the administrator's Amazon Chime Enterprise
    /// account ID.
    pub fn listBots(self: *Self, allocator: std.mem.Allocator, input: list_bots.ListBotsInput, options: list_bots.Options) !list_bots.ListBotsOutput {
        return list_bots.execute(self, allocator, input, options);
    }

    /// Lists the phone number orders for the administrator's Amazon Chime account.
    pub fn listPhoneNumberOrders(self: *Self, allocator: std.mem.Allocator, input: list_phone_number_orders.ListPhoneNumberOrdersInput, options: list_phone_number_orders.Options) !list_phone_number_orders.ListPhoneNumberOrdersOutput {
        return list_phone_number_orders.execute(self, allocator, input, options);
    }

    /// Lists the phone numbers for the specified Amazon Chime account, Amazon Chime
    /// user, Amazon Chime Voice Connector, or Amazon Chime Voice Connector group.
    pub fn listPhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: list_phone_numbers.ListPhoneNumbersInput, options: list_phone_numbers.Options) !list_phone_numbers.ListPhoneNumbersOutput {
        return list_phone_numbers.execute(self, allocator, input, options);
    }

    /// Lists the membership details for the specified room in an Amazon Chime
    /// Enterprise account,
    /// such as the members' IDs, email addresses, and names.
    pub fn listRoomMemberships(self: *Self, allocator: std.mem.Allocator, input: list_room_memberships.ListRoomMembershipsInput, options: list_room_memberships.Options) !list_room_memberships.ListRoomMembershipsOutput {
        return list_room_memberships.execute(self, allocator, input, options);
    }

    /// Lists the room details for the specified Amazon Chime Enterprise account.
    /// Optionally, filter the results by a member ID (user ID or bot ID) to see a
    /// list of rooms that the member belongs to.
    pub fn listRooms(self: *Self, allocator: std.mem.Allocator, input: list_rooms.ListRoomsInput, options: list_rooms.Options) !list_rooms.ListRoomsOutput {
        return list_rooms.execute(self, allocator, input, options);
    }

    /// Lists supported phone number countries.
    pub fn listSupportedPhoneNumberCountries(self: *Self, allocator: std.mem.Allocator, input: list_supported_phone_number_countries.ListSupportedPhoneNumberCountriesInput, options: list_supported_phone_number_countries.Options) !list_supported_phone_number_countries.ListSupportedPhoneNumberCountriesOutput {
        return list_supported_phone_number_countries.execute(self, allocator, input, options);
    }

    /// Lists the users that belong to the specified Amazon Chime account. You can
    /// specify an email
    /// address to list only the user that the email address belongs to.
    pub fn listUsers(self: *Self, allocator: std.mem.Allocator, input: list_users.ListUsersInput, options: list_users.Options) !list_users.ListUsersOutput {
        return list_users.execute(self, allocator, input, options);
    }

    /// Logs out the specified user from all of the devices they are currently
    /// logged into.
    pub fn logoutUser(self: *Self, allocator: std.mem.Allocator, input: logout_user.LogoutUserInput, options: logout_user.Options) !logout_user.LogoutUserOutput {
        return logout_user.execute(self, allocator, input, options);
    }

    /// Creates an events configuration that allows a bot to receive outgoing events
    /// sent by Amazon
    /// Chime. Choose either an HTTPS endpoint or a Lambda function ARN. For more
    /// information,
    /// see Bot.
    pub fn putEventsConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_events_configuration.PutEventsConfigurationInput, options: put_events_configuration.Options) !put_events_configuration.PutEventsConfigurationOutput {
        return put_events_configuration.execute(self, allocator, input, options);
    }

    /// Puts retention settings for the specified Amazon Chime Enterprise account.
    /// We recommend using AWS CloudTrail to monitor usage of this API for your
    /// account. For more information, see
    /// [Logging Amazon Chime API Calls with AWS
    /// CloudTrail](https://docs.aws.amazon.com/chime/latest/ag/cloudtrail.html)
    /// in the *Amazon Chime Administration Guide*.
    ///
    /// To turn off existing retention settings, remove the number of days from the
    /// corresponding
    /// **RetentionDays**
    /// field in the
    /// **RetentionSettings**
    /// object. For more information about retention settings, see
    /// [Managing Chat Retention
    /// Policies](https://docs.aws.amazon.com/chime/latest/ag/chat-retention.html)
    /// in the *Amazon Chime Administration Guide*.
    pub fn putRetentionSettings(self: *Self, allocator: std.mem.Allocator, input: put_retention_settings.PutRetentionSettingsInput, options: put_retention_settings.Options) !put_retention_settings.PutRetentionSettingsOutput {
        return put_retention_settings.execute(self, allocator, input, options);
    }

    /// Redacts the specified message from the specified Amazon Chime conversation.
    pub fn redactConversationMessage(self: *Self, allocator: std.mem.Allocator, input: redact_conversation_message.RedactConversationMessageInput, options: redact_conversation_message.Options) !redact_conversation_message.RedactConversationMessageOutput {
        return redact_conversation_message.execute(self, allocator, input, options);
    }

    /// Redacts the specified message from the specified Amazon Chime channel.
    pub fn redactRoomMessage(self: *Self, allocator: std.mem.Allocator, input: redact_room_message.RedactRoomMessageInput, options: redact_room_message.Options) !redact_room_message.RedactRoomMessageOutput {
        return redact_room_message.execute(self, allocator, input, options);
    }

    /// Regenerates the security token for a bot.
    pub fn regenerateSecurityToken(self: *Self, allocator: std.mem.Allocator, input: regenerate_security_token.RegenerateSecurityTokenInput, options: regenerate_security_token.Options) !regenerate_security_token.RegenerateSecurityTokenOutput {
        return regenerate_security_token.execute(self, allocator, input, options);
    }

    /// Resets the personal meeting PIN for the specified user on an Amazon Chime
    /// account. Returns
    /// the User object with the updated personal meeting PIN.
    pub fn resetPersonalPin(self: *Self, allocator: std.mem.Allocator, input: reset_personal_pin.ResetPersonalPINInput, options: reset_personal_pin.Options) !reset_personal_pin.ResetPersonalPINOutput {
        return reset_personal_pin.execute(self, allocator, input, options);
    }

    /// Moves a phone number from the **Deletion queue** back into the
    /// phone number **Inventory**.
    pub fn restorePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: restore_phone_number.RestorePhoneNumberInput, options: restore_phone_number.Options) !restore_phone_number.RestorePhoneNumberOutput {
        return restore_phone_number.execute(self, allocator, input, options);
    }

    /// Searches for phone numbers that can be ordered. For US numbers, provide at
    /// least one of
    /// the following search filters: `AreaCode`, `City`,
    /// `State`, or `TollFreePrefix`. If you provide
    /// `City`, you must also provide `State`. Numbers outside the US only
    /// support the `PhoneNumberType` filter, which you must use.
    pub fn searchAvailablePhoneNumbers(self: *Self, allocator: std.mem.Allocator, input: search_available_phone_numbers.SearchAvailablePhoneNumbersInput, options: search_available_phone_numbers.Options) !search_available_phone_numbers.SearchAvailablePhoneNumbersOutput {
        return search_available_phone_numbers.execute(self, allocator, input, options);
    }

    /// Updates account details for the specified Amazon Chime account. Currently,
    /// only account name and default license updates are supported for this action.
    pub fn updateAccount(self: *Self, allocator: std.mem.Allocator, input: update_account.UpdateAccountInput, options: update_account.Options) !update_account.UpdateAccountOutput {
        return update_account.execute(self, allocator, input, options);
    }

    /// Updates the settings for the specified Amazon Chime account. You can update
    /// settings for
    /// remote control of shared screens, or for the dial-out option. For more
    /// information about
    /// these settings, see [Use
    /// the Policies
    /// Page](https://docs.aws.amazon.com/chime/latest/ag/policies.html) in the
    /// *Amazon Chime Administration
    /// Guide*.
    pub fn updateAccountSettings(self: *Self, allocator: std.mem.Allocator, input: update_account_settings.UpdateAccountSettingsInput, options: update_account_settings.Options) !update_account_settings.UpdateAccountSettingsOutput {
        return update_account_settings.execute(self, allocator, input, options);
    }

    /// Updates the status of the specified bot, such as starting or stopping the
    /// bot from running in your Amazon Chime Enterprise account.
    pub fn updateBot(self: *Self, allocator: std.mem.Allocator, input: update_bot.UpdateBotInput, options: update_bot.Options) !update_bot.UpdateBotOutput {
        return update_bot.execute(self, allocator, input, options);
    }

    /// Updates global settings for the administrator's AWS account, such as Amazon
    /// Chime Business Calling and Amazon Chime Voice Connector settings.
    pub fn updateGlobalSettings(self: *Self, allocator: std.mem.Allocator, input: update_global_settings.UpdateGlobalSettingsInput, options: update_global_settings.Options) !update_global_settings.UpdateGlobalSettingsOutput {
        return update_global_settings.execute(self, allocator, input, options);
    }

    /// Updates phone number details, such as product type or calling name, for the
    /// specified phone number ID. You can update one phone number detail at a time.
    /// For example, you can update either the product type or the calling name in
    /// one action.
    ///
    /// For toll-free numbers, you cannot use the Amazon Chime Business Calling
    /// product type. For numbers outside the U.S., you must use the Amazon Chime
    /// SIP Media Application Dial-In product type.
    ///
    /// Updates to outbound calling names can take 72 hours to complete. Pending
    /// updates to outbound calling names must be complete before you can request
    /// another update.
    pub fn updatePhoneNumber(self: *Self, allocator: std.mem.Allocator, input: update_phone_number.UpdatePhoneNumberInput, options: update_phone_number.Options) !update_phone_number.UpdatePhoneNumberOutput {
        return update_phone_number.execute(self, allocator, input, options);
    }

    /// Updates the phone number settings for the administrator's AWS account, such
    /// as the default
    /// outbound calling name. You can update the default outbound calling name once
    /// every seven
    /// days. Outbound calling names can take up to 72 hours to update.
    pub fn updatePhoneNumberSettings(self: *Self, allocator: std.mem.Allocator, input: update_phone_number_settings.UpdatePhoneNumberSettingsInput, options: update_phone_number_settings.Options) !update_phone_number_settings.UpdatePhoneNumberSettingsOutput {
        return update_phone_number_settings.execute(self, allocator, input, options);
    }

    /// Updates room details, such as the room name, for a room in an Amazon Chime
    /// Enterprise account.
    pub fn updateRoom(self: *Self, allocator: std.mem.Allocator, input: update_room.UpdateRoomInput, options: update_room.Options) !update_room.UpdateRoomOutput {
        return update_room.execute(self, allocator, input, options);
    }

    /// Updates room membership details, such as the member role, for a room in an
    /// Amazon Chime
    /// Enterprise account. The member role designates whether the member is a chat
    /// room
    /// administrator or a general chat room member. The member role can be updated
    /// only for
    /// user IDs.
    pub fn updateRoomMembership(self: *Self, allocator: std.mem.Allocator, input: update_room_membership.UpdateRoomMembershipInput, options: update_room_membership.Options) !update_room_membership.UpdateRoomMembershipOutput {
        return update_room_membership.execute(self, allocator, input, options);
    }

    /// Updates user details for a specified user ID. Currently, only `LicenseType`
    /// updates are supported for this action.
    pub fn updateUser(self: *Self, allocator: std.mem.Allocator, input: update_user.UpdateUserInput, options: update_user.Options) !update_user.UpdateUserOutput {
        return update_user.execute(self, allocator, input, options);
    }

    /// Updates the settings for the specified user, such as phone number settings.
    pub fn updateUserSettings(self: *Self, allocator: std.mem.Allocator, input: update_user_settings.UpdateUserSettingsInput, options: update_user_settings.Options) !update_user_settings.UpdateUserSettingsOutput {
        return update_user_settings.execute(self, allocator, input, options);
    }

    pub fn listAccountsPaginator(self: *Self, params: list_accounts.ListAccountsInput) paginator.ListAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listBotsPaginator(self: *Self, params: list_bots.ListBotsInput) paginator.ListBotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPhoneNumberOrdersPaginator(self: *Self, params: list_phone_number_orders.ListPhoneNumberOrdersInput) paginator.ListPhoneNumberOrdersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPhoneNumbersPaginator(self: *Self, params: list_phone_numbers.ListPhoneNumbersInput) paginator.ListPhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoomMembershipsPaginator(self: *Self, params: list_room_memberships.ListRoomMembershipsInput) paginator.ListRoomMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoomsPaginator(self: *Self, params: list_rooms.ListRoomsInput) paginator.ListRoomsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsersPaginator(self: *Self, params: list_users.ListUsersInput) paginator.ListUsersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchAvailablePhoneNumbersPaginator(self: *Self, params: search_available_phone_numbers.SearchAvailablePhoneNumbersInput) paginator.SearchAvailablePhoneNumbersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
