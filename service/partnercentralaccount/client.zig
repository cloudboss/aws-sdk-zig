const aws = @import("aws");
const std = @import("std");

const accept_connection_invitation = @import("accept_connection_invitation.zig");
const associate_aws_training_certification_email_domain = @import("associate_aws_training_certification_email_domain.zig");
const cancel_connection = @import("cancel_connection.zig");
const cancel_connection_invitation = @import("cancel_connection_invitation.zig");
const cancel_profile_update_task = @import("cancel_profile_update_task.zig");
const create_connection_invitation = @import("create_connection_invitation.zig");
const create_partner = @import("create_partner.zig");
const disassociate_aws_training_certification_email_domain = @import("disassociate_aws_training_certification_email_domain.zig");
const get_alliance_lead_contact = @import("get_alliance_lead_contact.zig");
const get_connection = @import("get_connection.zig");
const get_connection_invitation = @import("get_connection_invitation.zig");
const get_connection_preferences = @import("get_connection_preferences.zig");
const get_partner = @import("get_partner.zig");
const get_profile_update_task = @import("get_profile_update_task.zig");
const get_profile_visibility = @import("get_profile_visibility.zig");
const get_verification = @import("get_verification.zig");
const list_connection_invitations = @import("list_connection_invitations.zig");
const list_connections = @import("list_connections.zig");
const list_partners = @import("list_partners.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_alliance_lead_contact = @import("put_alliance_lead_contact.zig");
const put_profile_visibility = @import("put_profile_visibility.zig");
const reject_connection_invitation = @import("reject_connection_invitation.zig");
const send_email_verification_code = @import("send_email_verification_code.zig");
const start_profile_update_task = @import("start_profile_update_task.zig");
const start_verification = @import("start_verification.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_connection_preferences = @import("update_connection_preferences.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PartnerCentral Account";

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

    /// Accepts a connection invitation from another partner, establishing a formal
    /// partnership connection between the two parties.
    pub fn acceptConnectionInvitation(self: *Self, allocator: std.mem.Allocator, input: accept_connection_invitation.AcceptConnectionInvitationInput, options: CallOptions) !accept_connection_invitation.AcceptConnectionInvitationOutput {
        return accept_connection_invitation.execute(self, allocator, input, options);
    }

    /// Associates an email domain with AWS training and certification for the
    /// partner account, enabling automatic verification of employee certifications.
    pub fn associateAwsTrainingCertificationEmailDomain(self: *Self, allocator: std.mem.Allocator, input: associate_aws_training_certification_email_domain.AssociateAwsTrainingCertificationEmailDomainInput, options: CallOptions) !associate_aws_training_certification_email_domain.AssociateAwsTrainingCertificationEmailDomainOutput {
        return associate_aws_training_certification_email_domain.execute(self, allocator, input, options);
    }

    /// Cancels an existing connection between partners, terminating the partnership
    /// relationship.
    pub fn cancelConnection(self: *Self, allocator: std.mem.Allocator, input: cancel_connection.CancelConnectionInput, options: CallOptions) !cancel_connection.CancelConnectionOutput {
        return cancel_connection.execute(self, allocator, input, options);
    }

    /// Cancels a pending connection invitation before it has been accepted or
    /// rejected.
    pub fn cancelConnectionInvitation(self: *Self, allocator: std.mem.Allocator, input: cancel_connection_invitation.CancelConnectionInvitationInput, options: CallOptions) !cancel_connection_invitation.CancelConnectionInvitationOutput {
        return cancel_connection_invitation.execute(self, allocator, input, options);
    }

    /// Cancels an in-progress profile update task, stopping any pending changes to
    /// the partner profile.
    pub fn cancelProfileUpdateTask(self: *Self, allocator: std.mem.Allocator, input: cancel_profile_update_task.CancelProfileUpdateTaskInput, options: CallOptions) !cancel_profile_update_task.CancelProfileUpdateTaskOutput {
        return cancel_profile_update_task.execute(self, allocator, input, options);
    }

    /// Creates a new connection invitation to establish a partnership with another
    /// organization.
    pub fn createConnectionInvitation(self: *Self, allocator: std.mem.Allocator, input: create_connection_invitation.CreateConnectionInvitationInput, options: CallOptions) !create_connection_invitation.CreateConnectionInvitationOutput {
        return create_connection_invitation.execute(self, allocator, input, options);
    }

    /// Creates a new partner account in the AWS Partner Network with the specified
    /// details and configuration.
    pub fn createPartner(self: *Self, allocator: std.mem.Allocator, input: create_partner.CreatePartnerInput, options: CallOptions) !create_partner.CreatePartnerOutput {
        return create_partner.execute(self, allocator, input, options);
    }

    /// Removes the association between an email domain and AWS training and
    /// certification for the partner account.
    pub fn disassociateAwsTrainingCertificationEmailDomain(self: *Self, allocator: std.mem.Allocator, input: disassociate_aws_training_certification_email_domain.DisassociateAwsTrainingCertificationEmailDomainInput, options: CallOptions) !disassociate_aws_training_certification_email_domain.DisassociateAwsTrainingCertificationEmailDomainOutput {
        return disassociate_aws_training_certification_email_domain.execute(self, allocator, input, options);
    }

    /// Retrieves the alliance lead contact information for a partner account.
    pub fn getAllianceLeadContact(self: *Self, allocator: std.mem.Allocator, input: get_alliance_lead_contact.GetAllianceLeadContactInput, options: CallOptions) !get_alliance_lead_contact.GetAllianceLeadContactOutput {
        return get_alliance_lead_contact.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific connection between partners.
    pub fn getConnection(self: *Self, allocator: std.mem.Allocator, input: get_connection.GetConnectionInput, options: CallOptions) !get_connection.GetConnectionOutput {
        return get_connection.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific connection invitation.
    pub fn getConnectionInvitation(self: *Self, allocator: std.mem.Allocator, input: get_connection_invitation.GetConnectionInvitationInput, options: CallOptions) !get_connection_invitation.GetConnectionInvitationOutput {
        return get_connection_invitation.execute(self, allocator, input, options);
    }

    /// Retrieves the connection preferences for a partner account, including access
    /// settings and exclusions.
    pub fn getConnectionPreferences(self: *Self, allocator: std.mem.Allocator, input: get_connection_preferences.GetConnectionPreferencesInput, options: CallOptions) !get_connection_preferences.GetConnectionPreferencesOutput {
        return get_connection_preferences.execute(self, allocator, input, options);
    }

    /// Retrieves detailed information about a specific partner account.
    pub fn getPartner(self: *Self, allocator: std.mem.Allocator, input: get_partner.GetPartnerInput, options: CallOptions) !get_partner.GetPartnerOutput {
        return get_partner.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specific profile update task.
    pub fn getProfileUpdateTask(self: *Self, allocator: std.mem.Allocator, input: get_profile_update_task.GetProfileUpdateTaskInput, options: CallOptions) !get_profile_update_task.GetProfileUpdateTaskOutput {
        return get_profile_update_task.execute(self, allocator, input, options);
    }

    /// Retrieves the visibility settings for a partner profile, determining who can
    /// see the profile information.
    pub fn getProfileVisibility(self: *Self, allocator: std.mem.Allocator, input: get_profile_visibility.GetProfileVisibilityInput, options: CallOptions) !get_profile_visibility.GetProfileVisibilityOutput {
        return get_profile_visibility.execute(self, allocator, input, options);
    }

    /// Retrieves the current status and details of a verification process for a
    /// partner account. This operation allows partners to check the progress and
    /// results of business or registrant verification processes.
    pub fn getVerification(self: *Self, allocator: std.mem.Allocator, input: get_verification.GetVerificationInput, options: CallOptions) !get_verification.GetVerificationOutput {
        return get_verification.execute(self, allocator, input, options);
    }

    /// Lists connection invitations for the partner account, with optional
    /// filtering by status, type, and other criteria.
    pub fn listConnectionInvitations(self: *Self, allocator: std.mem.Allocator, input: list_connection_invitations.ListConnectionInvitationsInput, options: CallOptions) !list_connection_invitations.ListConnectionInvitationsOutput {
        return list_connection_invitations.execute(self, allocator, input, options);
    }

    /// Lists active connections for the partner account, with optional filtering by
    /// connection type and participant.
    pub fn listConnections(self: *Self, allocator: std.mem.Allocator, input: list_connections.ListConnectionsInput, options: CallOptions) !list_connections.ListConnectionsOutput {
        return list_connections.execute(self, allocator, input, options);
    }

    /// Lists partner accounts in the catalog, providing a summary view of all
    /// partners.
    pub fn listPartners(self: *Self, allocator: std.mem.Allocator, input: list_partners.ListPartnersInput, options: CallOptions) !list_partners.ListPartnersOutput {
        return list_partners.execute(self, allocator, input, options);
    }

    /// Lists all tags associated with a specific AWS Partner Central Account
    /// resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Creates or updates the alliance lead contact information for a partner
    /// account.
    pub fn putAllianceLeadContact(self: *Self, allocator: std.mem.Allocator, input: put_alliance_lead_contact.PutAllianceLeadContactInput, options: CallOptions) !put_alliance_lead_contact.PutAllianceLeadContactOutput {
        return put_alliance_lead_contact.execute(self, allocator, input, options);
    }

    /// Sets the visibility level for a partner profile, controlling who can view
    /// the profile information.
    pub fn putProfileVisibility(self: *Self, allocator: std.mem.Allocator, input: put_profile_visibility.PutProfileVisibilityInput, options: CallOptions) !put_profile_visibility.PutProfileVisibilityOutput {
        return put_profile_visibility.execute(self, allocator, input, options);
    }

    /// Rejects a connection invitation from another partner, declining the
    /// partnership request.
    pub fn rejectConnectionInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_connection_invitation.RejectConnectionInvitationInput, options: CallOptions) !reject_connection_invitation.RejectConnectionInvitationOutput {
        return reject_connection_invitation.execute(self, allocator, input, options);
    }

    /// Sends an email verification code to the specified email address for account
    /// verification purposes.
    pub fn sendEmailVerificationCode(self: *Self, allocator: std.mem.Allocator, input: send_email_verification_code.SendEmailVerificationCodeInput, options: CallOptions) !send_email_verification_code.SendEmailVerificationCodeOutput {
        return send_email_verification_code.execute(self, allocator, input, options);
    }

    /// Initiates a profile update task to modify partner profile information
    /// asynchronously.
    pub fn startProfileUpdateTask(self: *Self, allocator: std.mem.Allocator, input: start_profile_update_task.StartProfileUpdateTaskInput, options: CallOptions) !start_profile_update_task.StartProfileUpdateTaskOutput {
        return start_profile_update_task.execute(self, allocator, input, options);
    }

    /// Initiates a new verification process for a partner account. This operation
    /// begins the verification workflow for either business registration or
    /// individual registrant identity verification as required by AWS Partner
    /// Central.
    pub fn startVerification(self: *Self, allocator: std.mem.Allocator, input: start_verification.StartVerificationInput, options: CallOptions) !start_verification.StartVerificationOutput {
        return start_verification.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a specified AWS Partner Central Account resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes specified tags from an AWS Partner Central Account resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the connection preferences for a partner account, modifying access
    /// settings and exclusions.
    pub fn updateConnectionPreferences(self: *Self, allocator: std.mem.Allocator, input: update_connection_preferences.UpdateConnectionPreferencesInput, options: CallOptions) !update_connection_preferences.UpdateConnectionPreferencesOutput {
        return update_connection_preferences.execute(self, allocator, input, options);
    }

    pub fn listConnectionInvitationsPaginator(self: *Self, params: list_connection_invitations.ListConnectionInvitationsInput) paginator.ListConnectionInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectionsPaginator(self: *Self, params: list_connections.ListConnectionsInput) paginator.ListConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listPartnersPaginator(self: *Self, params: list_partners.ListPartnersInput) paginator.ListPartnersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
