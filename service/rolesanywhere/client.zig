const aws = @import("aws");
const std = @import("std");

const create_profile = @import("create_profile.zig");
const create_trust_anchor = @import("create_trust_anchor.zig");
const delete_attribute_mapping = @import("delete_attribute_mapping.zig");
const delete_crl = @import("delete_crl.zig");
const delete_profile = @import("delete_profile.zig");
const delete_trust_anchor = @import("delete_trust_anchor.zig");
const disable_crl = @import("disable_crl.zig");
const disable_profile = @import("disable_profile.zig");
const disable_trust_anchor = @import("disable_trust_anchor.zig");
const enable_crl = @import("enable_crl.zig");
const enable_profile = @import("enable_profile.zig");
const enable_trust_anchor = @import("enable_trust_anchor.zig");
const get_crl = @import("get_crl.zig");
const get_profile = @import("get_profile.zig");
const get_subject = @import("get_subject.zig");
const get_trust_anchor = @import("get_trust_anchor.zig");
const import_crl = @import("import_crl.zig");
const list_crls = @import("list_crls.zig");
const list_profiles = @import("list_profiles.zig");
const list_subjects = @import("list_subjects.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_trust_anchors = @import("list_trust_anchors.zig");
const put_attribute_mapping = @import("put_attribute_mapping.zig");
const put_notification_settings = @import("put_notification_settings.zig");
const reset_notification_settings = @import("reset_notification_settings.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_crl = @import("update_crl.zig");
const update_profile = @import("update_profile.zig");
const update_trust_anchor = @import("update_trust_anchor.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RolesAnywhere";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a *profile*, a list of the roles that Roles Anywhere service is
    /// trusted to assume. You use profiles to intersect permissions with IAM
    /// managed policies.
    ///
    /// **Required permissions: ** `rolesanywhere:CreateProfile`.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: create_profile.Options) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Creates a trust anchor to establish trust between IAM Roles Anywhere and
    /// your certificate authority (CA). You can define a trust anchor as a
    /// reference to an Private Certificate Authority (Private CA) or by uploading a
    /// CA certificate. Your Amazon Web Services workloads can authenticate with the
    /// trust anchor using certificates issued by the CA in exchange for temporary
    /// Amazon Web Services credentials.
    ///
    /// **Required permissions: ** `rolesanywhere:CreateTrustAnchor`.
    pub fn createTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: create_trust_anchor.CreateTrustAnchorInput, options: create_trust_anchor.Options) !create_trust_anchor.CreateTrustAnchorOutput {
        return create_trust_anchor.execute(self, allocator, input, options);
    }

    /// Delete an entry from the attribute mapping rules enforced by a given
    /// profile.
    pub fn deleteAttributeMapping(self: *Self, allocator: std.mem.Allocator, input: delete_attribute_mapping.DeleteAttributeMappingInput, options: delete_attribute_mapping.Options) !delete_attribute_mapping.DeleteAttributeMappingOutput {
        return delete_attribute_mapping.execute(self, allocator, input, options);
    }

    /// Deletes a certificate revocation list (CRL).
    ///
    /// **Required permissions: ** `rolesanywhere:DeleteCrl`.
    pub fn deleteCrl(self: *Self, allocator: std.mem.Allocator, input: delete_crl.DeleteCrlInput, options: delete_crl.Options) !delete_crl.DeleteCrlOutput {
        return delete_crl.execute(self, allocator, input, options);
    }

    /// Deletes a profile.
    ///
    /// **Required permissions: ** `rolesanywhere:DeleteProfile`.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: delete_profile.Options) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Deletes a trust anchor.
    ///
    /// **Required permissions: ** `rolesanywhere:DeleteTrustAnchor`.
    pub fn deleteTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: delete_trust_anchor.DeleteTrustAnchorInput, options: delete_trust_anchor.Options) !delete_trust_anchor.DeleteTrustAnchorOutput {
        return delete_trust_anchor.execute(self, allocator, input, options);
    }

    /// Disables a certificate revocation list (CRL).
    ///
    /// **Required permissions: ** `rolesanywhere:DisableCrl`.
    pub fn disableCrl(self: *Self, allocator: std.mem.Allocator, input: disable_crl.DisableCrlInput, options: disable_crl.Options) !disable_crl.DisableCrlOutput {
        return disable_crl.execute(self, allocator, input, options);
    }

    /// Disables a profile. When disabled, temporary credential requests with this
    /// profile fail.
    ///
    /// **Required permissions: ** `rolesanywhere:DisableProfile`.
    pub fn disableProfile(self: *Self, allocator: std.mem.Allocator, input: disable_profile.DisableProfileInput, options: disable_profile.Options) !disable_profile.DisableProfileOutput {
        return disable_profile.execute(self, allocator, input, options);
    }

    /// Disables a trust anchor. When disabled, temporary credential requests
    /// specifying this trust anchor are unauthorized.
    ///
    /// **Required permissions: ** `rolesanywhere:DisableTrustAnchor`.
    pub fn disableTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: disable_trust_anchor.DisableTrustAnchorInput, options: disable_trust_anchor.Options) !disable_trust_anchor.DisableTrustAnchorOutput {
        return disable_trust_anchor.execute(self, allocator, input, options);
    }

    /// Enables a certificate revocation list (CRL). When enabled, certificates
    /// stored in the CRL are unauthorized to receive session credentials.
    ///
    /// **Required permissions: ** `rolesanywhere:EnableCrl`.
    pub fn enableCrl(self: *Self, allocator: std.mem.Allocator, input: enable_crl.EnableCrlInput, options: enable_crl.Options) !enable_crl.EnableCrlOutput {
        return enable_crl.execute(self, allocator, input, options);
    }

    /// Enables temporary credential requests for a profile.
    ///
    /// **Required permissions: ** `rolesanywhere:EnableProfile`.
    pub fn enableProfile(self: *Self, allocator: std.mem.Allocator, input: enable_profile.EnableProfileInput, options: enable_profile.Options) !enable_profile.EnableProfileOutput {
        return enable_profile.execute(self, allocator, input, options);
    }

    /// Enables a trust anchor. When enabled, certificates in the trust anchor chain
    /// are authorized for trust validation.
    ///
    /// **Required permissions: ** `rolesanywhere:EnableTrustAnchor`.
    pub fn enableTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: enable_trust_anchor.EnableTrustAnchorInput, options: enable_trust_anchor.Options) !enable_trust_anchor.EnableTrustAnchorOutput {
        return enable_trust_anchor.execute(self, allocator, input, options);
    }

    /// Gets a certificate revocation list (CRL).
    ///
    /// **Required permissions: ** `rolesanywhere:GetCrl`.
    pub fn getCrl(self: *Self, allocator: std.mem.Allocator, input: get_crl.GetCrlInput, options: get_crl.Options) !get_crl.GetCrlOutput {
        return get_crl.execute(self, allocator, input, options);
    }

    /// Gets a profile.
    ///
    /// **Required permissions: ** `rolesanywhere:GetProfile`.
    pub fn getProfile(self: *Self, allocator: std.mem.Allocator, input: get_profile.GetProfileInput, options: get_profile.Options) !get_profile.GetProfileOutput {
        return get_profile.execute(self, allocator, input, options);
    }

    /// Gets a *subject*, which associates a certificate identity with
    /// authentication attempts. The subject stores auditing information such as the
    /// status of the last authentication attempt, the certificate data used in the
    /// attempt, and the last time the associated identity attempted authentication.
    ///
    /// **Required permissions: ** `rolesanywhere:GetSubject`.
    pub fn getSubject(self: *Self, allocator: std.mem.Allocator, input: get_subject.GetSubjectInput, options: get_subject.Options) !get_subject.GetSubjectOutput {
        return get_subject.execute(self, allocator, input, options);
    }

    /// Gets a trust anchor.
    ///
    /// **Required permissions: ** `rolesanywhere:GetTrustAnchor`.
    pub fn getTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: get_trust_anchor.GetTrustAnchorInput, options: get_trust_anchor.Options) !get_trust_anchor.GetTrustAnchorOutput {
        return get_trust_anchor.execute(self, allocator, input, options);
    }

    /// Imports the certificate revocation list (CRL). A CRL is a list of
    /// certificates that have been revoked by the issuing certificate Authority
    /// (CA).In order to be properly imported, a CRL must be in PEM format. IAM
    /// Roles Anywhere validates against the CRL before issuing credentials.
    ///
    /// **Required permissions: ** `rolesanywhere:ImportCrl`.
    pub fn importCrl(self: *Self, allocator: std.mem.Allocator, input: import_crl.ImportCrlInput, options: import_crl.Options) !import_crl.ImportCrlOutput {
        return import_crl.execute(self, allocator, input, options);
    }

    /// Lists all certificate revocation lists (CRL) in the authenticated account
    /// and Amazon Web Services Region.
    ///
    /// **Required permissions: ** `rolesanywhere:ListCrls`.
    pub fn listCrls(self: *Self, allocator: std.mem.Allocator, input: list_crls.ListCrlsInput, options: list_crls.Options) !list_crls.ListCrlsOutput {
        return list_crls.execute(self, allocator, input, options);
    }

    /// Lists all profiles in the authenticated account and Amazon Web Services
    /// Region.
    ///
    /// **Required permissions: ** `rolesanywhere:ListProfiles`.
    pub fn listProfiles(self: *Self, allocator: std.mem.Allocator, input: list_profiles.ListProfilesInput, options: list_profiles.Options) !list_profiles.ListProfilesOutput {
        return list_profiles.execute(self, allocator, input, options);
    }

    /// Lists the subjects in the authenticated account and Amazon Web Services
    /// Region.
    ///
    /// **Required permissions: ** `rolesanywhere:ListSubjects`.
    pub fn listSubjects(self: *Self, allocator: std.mem.Allocator, input: list_subjects.ListSubjectsInput, options: list_subjects.Options) !list_subjects.ListSubjectsOutput {
        return list_subjects.execute(self, allocator, input, options);
    }

    /// Lists the tags attached to the resource.
    ///
    /// **Required permissions: ** `rolesanywhere:ListTagsForResource`.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists the trust anchors in the authenticated account and Amazon Web Services
    /// Region.
    ///
    /// **Required permissions: ** `rolesanywhere:ListTrustAnchors`.
    pub fn listTrustAnchors(self: *Self, allocator: std.mem.Allocator, input: list_trust_anchors.ListTrustAnchorsInput, options: list_trust_anchors.Options) !list_trust_anchors.ListTrustAnchorsOutput {
        return list_trust_anchors.execute(self, allocator, input, options);
    }

    /// Put an entry in the attribute mapping rules that will be enforced by a given
    /// profile. A mapping specifies a certificate field and one or more specifiers
    /// that have contextual meanings.
    pub fn putAttributeMapping(self: *Self, allocator: std.mem.Allocator, input: put_attribute_mapping.PutAttributeMappingInput, options: put_attribute_mapping.Options) !put_attribute_mapping.PutAttributeMappingOutput {
        return put_attribute_mapping.execute(self, allocator, input, options);
    }

    /// Attaches a list of *notification settings* to a trust anchor.
    ///
    /// A notification setting includes information such as event name, threshold,
    /// status of the notification setting, and the channel to notify.
    ///
    /// **Required permissions: ** `rolesanywhere:PutNotificationSettings`.
    pub fn putNotificationSettings(self: *Self, allocator: std.mem.Allocator, input: put_notification_settings.PutNotificationSettingsInput, options: put_notification_settings.Options) !put_notification_settings.PutNotificationSettingsOutput {
        return put_notification_settings.execute(self, allocator, input, options);
    }

    /// Resets the *custom notification setting* to IAM Roles Anywhere default
    /// setting.
    ///
    /// **Required permissions: ** `rolesanywhere:ResetNotificationSettings`.
    pub fn resetNotificationSettings(self: *Self, allocator: std.mem.Allocator, input: reset_notification_settings.ResetNotificationSettingsInput, options: reset_notification_settings.Options) !reset_notification_settings.ResetNotificationSettingsOutput {
        return reset_notification_settings.execute(self, allocator, input, options);
    }

    /// Attaches tags to a resource.
    ///
    /// **Required permissions: ** `rolesanywhere:TagResource`.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the resource.
    ///
    /// **Required permissions: ** `rolesanywhere:UntagResource`.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the certificate revocation list (CRL). A CRL is a list of
    /// certificates that have been revoked by the issuing certificate authority
    /// (CA). IAM Roles Anywhere validates against the CRL before issuing
    /// credentials.
    ///
    /// **Required permissions: ** `rolesanywhere:UpdateCrl`.
    pub fn updateCrl(self: *Self, allocator: std.mem.Allocator, input: update_crl.UpdateCrlInput, options: update_crl.Options) !update_crl.UpdateCrlOutput {
        return update_crl.execute(self, allocator, input, options);
    }

    /// Updates a *profile*, a list of the roles that IAM Roles Anywhere service is
    /// trusted to assume. You use profiles to intersect permissions with IAM
    /// managed policies.
    ///
    /// **Required permissions: ** `rolesanywhere:UpdateProfile`.
    pub fn updateProfile(self: *Self, allocator: std.mem.Allocator, input: update_profile.UpdateProfileInput, options: update_profile.Options) !update_profile.UpdateProfileOutput {
        return update_profile.execute(self, allocator, input, options);
    }

    /// Updates a trust anchor. You establish trust between IAM Roles Anywhere and
    /// your certificate authority (CA) by configuring a trust anchor. You can
    /// define a trust anchor as a reference to an Private Certificate Authority
    /// (Private CA) or by uploading a CA certificate. Your Amazon Web Services
    /// workloads can authenticate with the trust anchor using certificates issued
    /// by the CA in exchange for temporary Amazon Web Services credentials.
    ///
    /// **Required permissions: ** `rolesanywhere:UpdateTrustAnchor`.
    pub fn updateTrustAnchor(self: *Self, allocator: std.mem.Allocator, input: update_trust_anchor.UpdateTrustAnchorInput, options: update_trust_anchor.Options) !update_trust_anchor.UpdateTrustAnchorOutput {
        return update_trust_anchor.execute(self, allocator, input, options);
    }

    pub fn listCrlsPaginator(self: *Self, params: list_crls.ListCrlsInput) paginator.ListCrlsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfilesPaginator(self: *Self, params: list_profiles.ListProfilesInput) paginator.ListProfilesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubjectsPaginator(self: *Self, params: list_subjects.ListSubjectsInput) paginator.ListSubjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTrustAnchorsPaginator(self: *Self, params: list_trust_anchors.ListTrustAnchorsInput) paginator.ListTrustAnchorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
