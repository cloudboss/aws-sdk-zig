const aws = @import("aws");
const std = @import("std");

const accept_primary_email_update = @import("accept_primary_email_update.zig");
const delete_alternate_contact = @import("delete_alternate_contact.zig");
const disable_region = @import("disable_region.zig");
const enable_region = @import("enable_region.zig");
const get_account_information = @import("get_account_information.zig");
const get_alternate_contact = @import("get_alternate_contact.zig");
const get_contact_information = @import("get_contact_information.zig");
const get_gov_cloud_account_information = @import("get_gov_cloud_account_information.zig");
const get_primary_email = @import("get_primary_email.zig");
const get_region_opt_status = @import("get_region_opt_status.zig");
const list_regions = @import("list_regions.zig");
const put_account_name = @import("put_account_name.zig");
const put_alternate_contact = @import("put_alternate_contact.zig");
const put_contact_information = @import("put_contact_information.zig");
const start_primary_email_update = @import("start_primary_email_update.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Account";

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

    /// Accepts the request that originated from StartPrimaryEmailUpdate to update
    /// the primary email address (also known as the root user email address) for
    /// the specified account.
    pub fn acceptPrimaryEmailUpdate(self: *Self, allocator: std.mem.Allocator, input: accept_primary_email_update.AcceptPrimaryEmailUpdateInput, options: accept_primary_email_update.Options) !accept_primary_email_update.AcceptPrimaryEmailUpdateOutput {
        return accept_primary_email_update.execute(self, allocator, input, options);
    }

    /// Deletes the specified alternate contact from an Amazon Web Services account.
    ///
    /// For complete details about how to use the alternate contact operations, see
    /// [Update the alternate contacts for your Amazon Web Services
    /// account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-alternate.html).
    ///
    /// Before you can update the alternate contact information for an Amazon Web
    /// Services account that is managed by Organizations, you must first enable
    /// integration between Amazon Web Services Account Management and
    /// Organizations. For more information, see [Enable trusted access for Amazon
    /// Web Services Account
    /// Management](https://docs.aws.amazon.com/accounts/latest/reference/using-orgs-trusted-access.html).
    pub fn deleteAlternateContact(self: *Self, allocator: std.mem.Allocator, input: delete_alternate_contact.DeleteAlternateContactInput, options: delete_alternate_contact.Options) !delete_alternate_contact.DeleteAlternateContactOutput {
        return delete_alternate_contact.execute(self, allocator, input, options);
    }

    /// Disables (opts-out) a particular Region for an account.
    ///
    /// The act of disabling a Region will remove all IAM access to any resources
    /// that reside in that Region.
    pub fn disableRegion(self: *Self, allocator: std.mem.Allocator, input: disable_region.DisableRegionInput, options: disable_region.Options) !disable_region.DisableRegionOutput {
        return disable_region.execute(self, allocator, input, options);
    }

    /// Enables (opts-in) a particular Region for an account.
    pub fn enableRegion(self: *Self, allocator: std.mem.Allocator, input: enable_region.EnableRegionInput, options: enable_region.Options) !enable_region.EnableRegionOutput {
        return enable_region.execute(self, allocator, input, options);
    }

    /// Retrieves information about the specified account including its account
    /// name, account ID, and account creation date and time. To use this API, an
    /// IAM user or role must have the `account:GetAccountInformation` IAM
    /// permission.
    pub fn getAccountInformation(self: *Self, allocator: std.mem.Allocator, input: get_account_information.GetAccountInformationInput, options: get_account_information.Options) !get_account_information.GetAccountInformationOutput {
        return get_account_information.execute(self, allocator, input, options);
    }

    /// Retrieves the specified alternate contact attached to an Amazon Web Services
    /// account.
    ///
    /// For complete details about how to use the alternate contact operations, see
    /// [Update the alternate contacts for your Amazon Web Services
    /// account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-alternate.html).
    ///
    /// Before you can update the alternate contact information for an Amazon Web
    /// Services account that is managed by Organizations, you must first enable
    /// integration between Amazon Web Services Account Management and
    /// Organizations. For more information, see [Enable trusted access for Amazon
    /// Web Services Account
    /// Management](https://docs.aws.amazon.com/accounts/latest/reference/using-orgs-trusted-access.html).
    pub fn getAlternateContact(self: *Self, allocator: std.mem.Allocator, input: get_alternate_contact.GetAlternateContactInput, options: get_alternate_contact.Options) !get_alternate_contact.GetAlternateContactOutput {
        return get_alternate_contact.execute(self, allocator, input, options);
    }

    /// Retrieves the primary contact information of an Amazon Web Services account.
    ///
    /// For complete details about how to use the primary contact operations, see
    /// [Update the primary contact for your Amazon Web Services
    /// account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-primary.html).
    pub fn getContactInformation(self: *Self, allocator: std.mem.Allocator, input: get_contact_information.GetContactInformationInput, options: get_contact_information.Options) !get_contact_information.GetContactInformationOutput {
        return get_contact_information.execute(self, allocator, input, options);
    }

    /// Retrieves information about the GovCloud account linked to the specified
    /// standard account (if it exists) including the GovCloud account ID and state.
    /// To use this API, an IAM user or role must have the
    /// `account:GetGovCloudAccountInformation` IAM permission.
    pub fn getGovCloudAccountInformation(self: *Self, allocator: std.mem.Allocator, input: get_gov_cloud_account_information.GetGovCloudAccountInformationInput, options: get_gov_cloud_account_information.Options) !get_gov_cloud_account_information.GetGovCloudAccountInformationOutput {
        return get_gov_cloud_account_information.execute(self, allocator, input, options);
    }

    /// Retrieves the primary email address for the specified account.
    pub fn getPrimaryEmail(self: *Self, allocator: std.mem.Allocator, input: get_primary_email.GetPrimaryEmailInput, options: get_primary_email.Options) !get_primary_email.GetPrimaryEmailOutput {
        return get_primary_email.execute(self, allocator, input, options);
    }

    /// Retrieves the opt-in status of a particular Region.
    pub fn getRegionOptStatus(self: *Self, allocator: std.mem.Allocator, input: get_region_opt_status.GetRegionOptStatusInput, options: get_region_opt_status.Options) !get_region_opt_status.GetRegionOptStatusOutput {
        return get_region_opt_status.execute(self, allocator, input, options);
    }

    /// Lists all the Regions for a given account and their respective opt-in
    /// statuses. Optionally, this list can be filtered by the
    /// `region-opt-status-contains` parameter.
    pub fn listRegions(self: *Self, allocator: std.mem.Allocator, input: list_regions.ListRegionsInput, options: list_regions.Options) !list_regions.ListRegionsOutput {
        return list_regions.execute(self, allocator, input, options);
    }

    /// Updates the account name of the specified account. To use this API, IAM
    /// principals must have the `account:PutAccountName` IAM permission.
    pub fn putAccountName(self: *Self, allocator: std.mem.Allocator, input: put_account_name.PutAccountNameInput, options: put_account_name.Options) !put_account_name.PutAccountNameOutput {
        return put_account_name.execute(self, allocator, input, options);
    }

    /// Modifies the specified alternate contact attached to an Amazon Web Services
    /// account.
    ///
    /// For complete details about how to use the alternate contact operations, see
    /// [Update the alternate contacts for your Amazon Web Services
    /// account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-alternate.html).
    ///
    /// Before you can update the alternate contact information for an Amazon Web
    /// Services account that is managed by Organizations, you must first enable
    /// integration between Amazon Web Services Account Management and
    /// Organizations. For more information, see [Enable trusted access for Amazon
    /// Web Services Account
    /// Management](https://docs.aws.amazon.com/accounts/latest/reference/using-orgs-trusted-access.html).
    pub fn putAlternateContact(self: *Self, allocator: std.mem.Allocator, input: put_alternate_contact.PutAlternateContactInput, options: put_alternate_contact.Options) !put_alternate_contact.PutAlternateContactOutput {
        return put_alternate_contact.execute(self, allocator, input, options);
    }

    /// Updates the primary contact information of an Amazon Web Services account.
    ///
    /// For complete details about how to use the primary contact operations, see
    /// [Update the primary contact for your Amazon Web Services
    /// account](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-update-contact-primary.html).
    pub fn putContactInformation(self: *Self, allocator: std.mem.Allocator, input: put_contact_information.PutContactInformationInput, options: put_contact_information.Options) !put_contact_information.PutContactInformationOutput {
        return put_contact_information.execute(self, allocator, input, options);
    }

    /// Starts the process to update the primary email address for the specified
    /// account.
    pub fn startPrimaryEmailUpdate(self: *Self, allocator: std.mem.Allocator, input: start_primary_email_update.StartPrimaryEmailUpdateInput, options: start_primary_email_update.Options) !start_primary_email_update.StartPrimaryEmailUpdateOutput {
        return start_primary_email_update.execute(self, allocator, input, options);
    }

    pub fn listRegionsPaginator(self: *Self, params: list_regions.ListRegionsInput) paginator.ListRegionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
