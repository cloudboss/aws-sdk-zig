const aws = @import("aws");
const std = @import("std");

const AccessDetail = @import("access_detail.zig").AccessDetail;
const AccessKey = @import("access_key.zig").AccessKey;
const AccessKeyLastUsed = @import("access_key_last_used.zig").AccessKeyLastUsed;
const AccessKeyMetadata = @import("access_key_metadata.zig").AccessKeyMetadata;
const AttachedPermissionsBoundary = @import("attached_permissions_boundary.zig").AttachedPermissionsBoundary;
const AttachedPolicy = @import("attached_policy.zig").AttachedPolicy;
const ContextEntry = @import("context_entry.zig").ContextEntry;
const ContextKeyTypeEnum = @import("context_key_type_enum.zig").ContextKeyTypeEnum;
const DelegationPermission = @import("delegation_permission.zig").DelegationPermission;
const DelegationRequest = @import("delegation_request.zig").DelegationRequest;
const DeletionTaskFailureReasonType = @import("deletion_task_failure_reason_type.zig").DeletionTaskFailureReasonType;
const EntityDetails = @import("entity_details.zig").EntityDetails;
const EntityInfo = @import("entity_info.zig").EntityInfo;
const EntityType = @import("entity_type.zig").EntityType;
const ErrorDetails = @import("error_details.zig").ErrorDetails;
const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;
const FeatureType = @import("feature_type.zig").FeatureType;
const Group = @import("group.zig").Group;
const GroupDetail = @import("group_detail.zig").GroupDetail;
const InstanceProfile = @import("instance_profile.zig").InstanceProfile;
const ListPoliciesGrantingServiceAccessEntry = @import("list_policies_granting_service_access_entry.zig").ListPoliciesGrantingServiceAccessEntry;
const LoginProfile = @import("login_profile.zig").LoginProfile;
const MFADevice = @import("mfa_device.zig").MFADevice;
const ManagedPolicyDetail = @import("managed_policy_detail.zig").ManagedPolicyDetail;
const OpenIDConnectProviderListEntry = @import("open_id_connect_provider_list_entry.zig").OpenIDConnectProviderListEntry;
const OrganizationsDecisionDetail = @import("organizations_decision_detail.zig").OrganizationsDecisionDetail;
const PasswordPolicy = @import("password_policy.zig").PasswordPolicy;
const PermissionsBoundaryAttachmentType = @import("permissions_boundary_attachment_type.zig").PermissionsBoundaryAttachmentType;
const PermissionsBoundaryDecisionDetail = @import("permissions_boundary_decision_detail.zig").PermissionsBoundaryDecisionDetail;
const Policy = @import("policy.zig").Policy;
const PolicyDetail = @import("policy_detail.zig").PolicyDetail;
const PolicyEvaluationDecisionType = @import("policy_evaluation_decision_type.zig").PolicyEvaluationDecisionType;
const PolicyGrantingServiceAccess = @import("policy_granting_service_access.zig").PolicyGrantingServiceAccess;
const PolicyGroup = @import("policy_group.zig").PolicyGroup;
const PolicyParameter = @import("policy_parameter.zig").PolicyParameter;
const PolicyParameterTypeEnum = @import("policy_parameter_type_enum.zig").PolicyParameterTypeEnum;
const PolicyRole = @import("policy_role.zig").PolicyRole;
const PolicySourceType = @import("policy_source_type.zig").PolicySourceType;
const PolicyUser = @import("policy_user.zig").PolicyUser;
const PolicyVersion = @import("policy_version.zig").PolicyVersion;
const Position = @import("position.zig").Position;
const ResourceSpecificResult = @import("resource_specific_result.zig").ResourceSpecificResult;
const Role = @import("role.zig").Role;
const RoleDetail = @import("role_detail.zig").RoleDetail;
const RoleLastUsed = @import("role_last_used.zig").RoleLastUsed;
const RoleUsageType = @import("role_usage_type.zig").RoleUsageType;
const SAMLPrivateKey = @import("saml_private_key.zig").SAMLPrivateKey;
const SAMLProviderListEntry = @import("saml_provider_list_entry.zig").SAMLProviderListEntry;
const SSHPublicKey = @import("ssh_public_key.zig").SSHPublicKey;
const SSHPublicKeyMetadata = @import("ssh_public_key_metadata.zig").SSHPublicKeyMetadata;
const ServerCertificate = @import("server_certificate.zig").ServerCertificate;
const ServerCertificateMetadata = @import("server_certificate_metadata.zig").ServerCertificateMetadata;
const ServiceLastAccessed = @import("service_last_accessed.zig").ServiceLastAccessed;
const ServiceSpecificCredential = @import("service_specific_credential.zig").ServiceSpecificCredential;
const ServiceSpecificCredentialMetadata = @import("service_specific_credential_metadata.zig").ServiceSpecificCredentialMetadata;
const SigningCertificate = @import("signing_certificate.zig").SigningCertificate;
const Statement = @import("statement.zig").Statement;
const Tag = @import("tag.zig").Tag;
const TrackedActionLastAccessed = @import("tracked_action_last_accessed.zig").TrackedActionLastAccessed;
const User = @import("user.zig").User;
const UserDetail = @import("user_detail.zig").UserDetail;
const VirtualMFADevice = @import("virtual_mfa_device.zig").VirtualMFADevice;
const policyOwnerEntityType = @import("policy_owner_entity_type.zig").policyOwnerEntityType;
const policyType = @import("policy_type.zig").policyType;
const stateType = @import("state_type.zig").stateType;
const statusType = @import("status_type.zig").statusType;

pub fn deserializeAccessDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccessDetail {
    var list: std.ArrayList(AccessDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccessDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeArnListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeContextKeyNamesResultListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEvaluationResultsListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EvaluationResult {
    var list: std.ArrayList(EvaluationResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEvaluationResult(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeFeaturesListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const FeatureType {
    var list: std.ArrayList(FeatureType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (FeatureType.fromWireName(try reader.readElementText())) |v| try list.append(allocator, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeManagedPolicyDetailListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ManagedPolicyDetail {
    var list: std.ArrayList(ManagedPolicyDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeManagedPolicyDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeOpenIDConnectProviderListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const OpenIDConnectProviderListEntry {
    var list: std.ArrayList(OpenIDConnectProviderListEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeOpenIDConnectProviderListEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePolicyGroupListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyGroup {
    var list: std.ArrayList(PolicyGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePolicyRoleListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyRole {
    var list: std.ArrayList(PolicyRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyRole(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializePolicyUserListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyUser {
    var list: std.ArrayList(PolicyUser) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyUser(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeResourceSpecificResultListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ResourceSpecificResult {
    var list: std.ArrayList(ResourceSpecificResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeResourceSpecificResult(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeRoleUsageListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RoleUsageType {
    var list: std.ArrayList(RoleUsageType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRoleUsageType(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSAMLProviderListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SAMLProviderListEntry {
    var list: std.ArrayList(SAMLProviderListEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSAMLProviderListEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeSSHPublicKeyListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SSHPublicKeyMetadata {
    var list: std.ArrayList(SSHPublicKeyMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSSHPublicKeyMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeServiceSpecificCredentialsListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServiceSpecificCredentialMetadata {
    var list: std.ArrayList(ServiceSpecificCredentialMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServiceSpecificCredentialMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeServicesLastAccessed(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServiceLastAccessed {
    var list: std.ArrayList(ServiceLastAccessed) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServiceLastAccessed(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeStatementListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Statement {
    var list: std.ArrayList(Statement) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeStatement(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeTrackedActionsLastAccessed(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const TrackedActionLastAccessed {
    var list: std.ArrayList(TrackedActionLastAccessed) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTrackedActionLastAccessed(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeaccessKeyMetadataListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AccessKeyMetadata {
    var list: std.ArrayList(AccessKeyMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAccessKeyMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeaccountAliasListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeattachedPoliciesListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const AttachedPolicy {
    var list: std.ArrayList(AttachedPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeAttachedPolicy(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializecertificateListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SigningCertificate {
    var list: std.ArrayList(SigningCertificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSigningCertificate(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeclientIDListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializedelegationRequestsListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const DelegationRequest {
    var list: std.ArrayList(DelegationRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeDelegationRequest(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeentityDetailsListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const EntityDetails {
    var list: std.ArrayList(EntityDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeEntityDetails(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializegroupDetailListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const GroupDetail {
    var list: std.ArrayList(GroupDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGroupDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializegroupListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Group {
    var list: std.ArrayList(Group) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeGroup(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializegroupNameListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeinstanceProfileListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const InstanceProfile {
    var list: std.ArrayList(InstanceProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeInstanceProfile(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializelistPolicyGrantingServiceAccessResponseListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ListPoliciesGrantingServiceAccessEntry {
    var list: std.ArrayList(ListPoliciesGrantingServiceAccessEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeListPoliciesGrantingServiceAccessEntry(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializemfaDeviceListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const MFADevice {
    var list: std.ArrayList(MFADevice) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeMFADevice(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyDetailListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyDetail {
    var list: std.ArrayList(PolicyDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyDocumentVersionListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyVersion {
    var list: std.ArrayList(PolicyVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyVersion(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyGrantingServiceAccessListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyGrantingServiceAccess {
    var list: std.ArrayList(PolicyGrantingServiceAccess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyGrantingServiceAccess(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Policy {
    var list: std.ArrayList(Policy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicy(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyNameListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyParameterListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const PolicyParameter {
    var list: std.ArrayList(PolicyParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializePolicyParameter(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializepolicyParameterValuesListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeprivateKeyList(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const SAMLPrivateKey {
    var list: std.ArrayList(SAMLPrivateKey) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeSAMLPrivateKey(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeroleDetailListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const RoleDetail {
    var list: std.ArrayList(RoleDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRoleDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeroleListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Role {
    var list: std.ArrayList(Role) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeRole(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializerolePermissionRestrictionArnListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeserverCertificateMetadataListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const ServerCertificateMetadata {
    var list: std.ArrayList(ServerCertificateMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeServerCertificateMetadata(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializetagListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeTag(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializethumbprintListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try allocator.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeuserDetailListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const UserDetail {
    var list: std.ArrayList(UserDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUserDetail(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeuserListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const User {
    var list: std.ArrayList(User) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeUser(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializevirtualMFADeviceListType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime item_tag: []const u8) ![]const VirtualMFADevice {
    var list: std.ArrayList(VirtualMFADevice) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(allocator, try deserializeVirtualMFADevice(allocator, reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeCertificationMapType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.StringMapEntry {
    var list: std.ArrayList(aws.map.StringMapEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: []const u8 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = try allocator.dupe(u8, try reader.readElementText());
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeEvalDecisionDetailsType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(PolicyEvaluationDecisionType) {
    var list: std.ArrayList(aws.map.MapEntry(PolicyEvaluationDecisionType)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: PolicyEvaluationDecisionType = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    if (PolicyEvaluationDecisionType.fromWireName(try reader.readElementText())) |v| { entry_value = v; }
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializesummaryMapType(allocator: std.mem.Allocator, reader: *aws.xml.Reader, comptime entry_tag: []const u8) ![]const aws.map.MapEntry(i32) {
    var list: std.ArrayList(aws.map.MapEntry(i32)) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, entry_tag)) {
                    var entry_key: []const u8 = "";
                    var entry_value: i32 = undefined;
                    while (try reader.next()) |inner| {
                        switch (inner) {
                            .element_start => |ie| {
                                if (std.mem.eql(u8, ie.local, "key")) {
                                    entry_key = try allocator.dupe(u8, try reader.readElementText());
                                } else if (std.mem.eql(u8, ie.local, "value")) {
                                    entry_value = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch 0;
                                } else {
                                    try reader.skipElement();
                                }
                            },
                            .element_end => break,
                            else => {},
                        }
                    }
                    try list.append(allocator, .{ .key = entry_key, .value = entry_value });
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(allocator);
}

pub fn deserializeAccessDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessDetail {
    var result: AccessDetail = undefined;
    result.entity_path = null;
    result.last_authenticated_time = null;
    result.region = null;
    result.total_authenticated_entities = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityPath")) {
                    result.entity_path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedTime")) {
                    result.last_authenticated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalAuthenticatedEntities")) {
                    result.total_authenticated_entities = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccessKey(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessKey {
    var result: AccessKey = undefined;
    result.create_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccessKeyLastUsed(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessKeyLastUsed {
    var result: AccessKeyLastUsed = undefined;
    result.last_used_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastUsedDate")) {
                    result.last_used_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAccessKeyMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AccessKeyMetadata {
    var result: AccessKeyMetadata = undefined;
    result.access_key_id = null;
    result.create_date = null;
    result.status = null;
    result.user_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAttachedPermissionsBoundary(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AttachedPermissionsBoundary {
    var result: AttachedPermissionsBoundary = undefined;
    result.permissions_boundary_arn = null;
    result.permissions_boundary_type = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PermissionsBoundaryArn")) {
                    result.permissions_boundary_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryType")) {
                    result.permissions_boundary_type = PermissionsBoundaryAttachmentType.fromWireName(try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeAttachedPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !AttachedPolicy {
    var result: AttachedPolicy = undefined;
    result.policy_arn = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyArn")) {
                    result.policy_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDelegationPermission(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DelegationPermission {
    var result: DelegationPermission = undefined;
    result.parameters = null;
    result.policy_template_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializepolicyParameterListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyTemplateArn")) {
                    result.policy_template_arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDelegationRequest(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DelegationRequest {
    var result: DelegationRequest = undefined;
    result.approver_id = null;
    result.create_date = null;
    result.delegation_request_id = null;
    result.description = null;
    result.expiration_time = null;
    result.notes = null;
    result.only_send_by_owner = false;
    result.owner_account_id = null;
    result.owner_id = null;
    result.permission_policy = null;
    result.permissions = null;
    result.redirect_url = null;
    result.rejection_reason = null;
    result.request_message = null;
    result.requestor_id = null;
    result.requestor_name = null;
    result.role_permission_restriction_arns = null;
    result.session_duration = null;
    result.state = null;
    result.updated_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproverId")) {
                    result.approver_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DelegationRequestId")) {
                    result.delegation_request_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpirationTime")) {
                    result.expiration_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Notes")) {
                    result.notes = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnlySendByOwner")) {
                    result.only_send_by_owner = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OwnerAccountId")) {
                    result.owner_account_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionPolicy")) {
                    result.permission_policy = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permissions")) {
                    result.permissions = try deserializeDelegationPermission(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RedirectUrl")) {
                    result.redirect_url = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RejectionReason")) {
                    result.rejection_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestMessage")) {
                    result.request_message = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestorId")) {
                    result.requestor_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestorName")) {
                    result.requestor_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RolePermissionRestrictionArns")) {
                    result.role_permission_restriction_arns = try deserializerolePermissionRestrictionArnListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "SessionDuration")) {
                    result.session_duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = stateType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedTime")) {
                    result.updated_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeDeletionTaskFailureReasonType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !DeletionTaskFailureReasonType {
    var result: DeletionTaskFailureReasonType = undefined;
    result.reason = null;
    result.role_usage_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleUsageList")) {
                    result.role_usage_list = try deserializeRoleUsageListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEntityDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EntityDetails {
    var result: EntityDetails = undefined;
    result.last_authenticated = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityInfo")) {
                    result.entity_info = try deserializeEntityInfo(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "LastAuthenticated")) {
                    result.last_authenticated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEntityInfo(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EntityInfo {
    var result: EntityInfo = undefined;
    result.path = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = policyOwnerEntityType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeErrorDetails(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ErrorDetails {
    var result: ErrorDetails = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeEvaluationResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !EvaluationResult {
    var result: EvaluationResult = undefined;
    result.eval_decision_details = null;
    result.eval_resource_name = null;
    result.matched_statements = null;
    result.missing_context_values = null;
    result.organizations_decision_detail = null;
    result.permissions_boundary_decision_detail = null;
    result.resource_specific_results = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EvalActionName")) {
                    result.eval_action_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalDecision")) {
                    result.eval_decision = PolicyEvaluationDecisionType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "EvalDecisionDetails")) {
                    result.eval_decision_details = try deserializeEvalDecisionDetailsType(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "EvalResourceName")) {
                    result.eval_resource_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MatchedStatements")) {
                    result.matched_statements = try deserializeStatementListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MissingContextValues")) {
                    result.missing_context_values = try deserializeContextKeyNamesResultListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "OrganizationsDecisionDetail")) {
                    result.organizations_decision_detail = try deserializeOrganizationsDecisionDetail(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryDecisionDetail")) {
                    result.permissions_boundary_decision_detail = try deserializePermissionsBoundaryDecisionDetail(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "ResourceSpecificResults")) {
                    result.resource_specific_results = try deserializeResourceSpecificResultListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Group {
    var result: Group = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeGroupDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !GroupDetail {
    var result: GroupDetail = undefined;
    result.arn = null;
    result.attached_managed_policies = null;
    result.create_date = null;
    result.group_id = null;
    result.group_name = null;
    result.group_policy_list = null;
    result.path = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupPolicyList")) {
                    result.group_policy_list = try deserializepolicyDetailListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeInstanceProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !InstanceProfile {
    var result: InstanceProfile = undefined;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceProfileId")) {
                    result.instance_profile_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceProfileName")) {
                    result.instance_profile_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Roles")) {
                    result.roles = try deserializeroleListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeListPoliciesGrantingServiceAccessEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ListPoliciesGrantingServiceAccessEntry {
    var result: ListPoliciesGrantingServiceAccessEntry = undefined;
    result.policies = null;
    result.service_namespace = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policies")) {
                    result.policies = try deserializepolicyGrantingServiceAccessListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeLoginProfile(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !LoginProfile {
    var result: LoginProfile = undefined;
    result.password_reset_required = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PasswordResetRequired")) {
                    result.password_reset_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeMFADevice(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !MFADevice {
    var result: MFADevice = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnableDate")) {
                    result.enable_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SerialNumber")) {
                    result.serial_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeManagedPolicyDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ManagedPolicyDetail {
    var result: ManagedPolicyDetail = undefined;
    result.arn = null;
    result.attachment_count = null;
    result.create_date = null;
    result.default_version_id = null;
    result.description = null;
    result.is_attachable = false;
    result.path = null;
    result.permissions_boundary_usage_count = null;
    result.policy_id = null;
    result.policy_name = null;
    result.policy_version_list = null;
    result.update_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachmentCount")) {
                    result.attachment_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsAttachable")) {
                    result.is_attachable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryUsageCount")) {
                    result.permissions_boundary_usage_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyId")) {
                    result.policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyVersionList")) {
                    result.policy_version_list = try deserializepolicyDocumentVersionListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UpdateDate")) {
                    result.update_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOpenIDConnectProviderListEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OpenIDConnectProviderListEntry {
    var result: OpenIDConnectProviderListEntry = undefined;
    result.arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeOrganizationsDecisionDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !OrganizationsDecisionDetail {
    _ = allocator;
    var result: OrganizationsDecisionDetail = undefined;
    result.allowed_by_organizations = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedByOrganizations")) {
                    result.allowed_by_organizations = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePasswordPolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PasswordPolicy {
    _ = allocator;
    var result: PasswordPolicy = undefined;
    result.allow_users_to_change_password = false;
    result.expire_passwords = false;
    result.hard_expiry = null;
    result.max_password_age = null;
    result.minimum_password_length = null;
    result.password_reuse_prevention = null;
    result.require_lowercase_characters = false;
    result.require_numbers = false;
    result.require_symbols = false;
    result.require_uppercase_characters = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowUsersToChangePassword")) {
                    result.allow_users_to_change_password = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "ExpirePasswords")) {
                    result.expire_passwords = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "HardExpiry")) {
                    result.hard_expiry = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "MaxPasswordAge")) {
                    result.max_password_age = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "MinimumPasswordLength")) {
                    result.minimum_password_length = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PasswordReusePrevention")) {
                    result.password_reuse_prevention = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "RequireLowercaseCharacters")) {
                    result.require_lowercase_characters = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequireNumbers")) {
                    result.require_numbers = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequireSymbols")) {
                    result.require_symbols = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "RequireUppercaseCharacters")) {
                    result.require_uppercase_characters = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePermissionsBoundaryDecisionDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PermissionsBoundaryDecisionDetail {
    _ = allocator;
    var result: PermissionsBoundaryDecisionDetail = undefined;
    result.allowed_by_permissions_boundary = false;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AllowedByPermissionsBoundary")) {
                    result.allowed_by_permissions_boundary = std.mem.eql(u8, try reader.readElementText(), "true");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicy(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Policy {
    var result: Policy = undefined;
    result.arn = null;
    result.attachment_count = null;
    result.create_date = null;
    result.default_version_id = null;
    result.description = null;
    result.is_attachable = false;
    result.path = null;
    result.permissions_boundary_usage_count = null;
    result.policy_id = null;
    result.policy_name = null;
    result.tags = null;
    result.update_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachmentCount")) {
                    result.attachment_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsAttachable")) {
                    result.is_attachable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryUsageCount")) {
                    result.permissions_boundary_usage_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyId")) {
                    result.policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UpdateDate")) {
                    result.update_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyDetail {
    var result: PolicyDetail = undefined;
    result.policy_document = null;
    result.policy_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyDocument")) {
                    result.policy_document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyGrantingServiceAccess(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyGrantingServiceAccess {
    var result: PolicyGrantingServiceAccess = undefined;
    result.entity_name = null;
    result.entity_type = null;
    result.policy_arn = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityName")) {
                    result.entity_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EntityType")) {
                    result.entity_type = policyOwnerEntityType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyArn")) {
                    result.policy_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyType")) {
                    result.policy_type = policyType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyGroup(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyGroup {
    var result: PolicyGroup = undefined;
    result.group_id = null;
    result.group_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyParameter(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyParameter {
    var result: PolicyParameter = undefined;
    result.name = null;
    result.@"type" = null;
    result.values = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = PolicyParameterTypeEnum.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializepolicyParameterValuesListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyRole(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyRole {
    var result: PolicyRole = undefined;
    result.role_id = null;
    result.role_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyUser(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyUser {
    var result: PolicyUser = undefined;
    result.user_id = null;
    result.user_name = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePolicyVersion(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !PolicyVersion {
    var result: PolicyVersion = undefined;
    result.create_date = null;
    result.document = null;
    result.is_default_version = false;
    result.version_id = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Document")) {
                    result.document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultVersion")) {
                    result.is_default_version = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializePosition(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Position {
    _ = allocator;
    var result: Position = undefined;
    result.column = 0;
    result.line = 0;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Column")) {
                    result.column = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Line")) {
                    result.line = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeResourceSpecificResult(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ResourceSpecificResult {
    var result: ResourceSpecificResult = undefined;
    result.eval_decision_details = null;
    result.matched_statements = null;
    result.missing_context_values = null;
    result.permissions_boundary_decision_detail = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EvalDecisionDetails")) {
                    result.eval_decision_details = try deserializeEvalDecisionDetailsType(allocator, reader, "entry");
                } else if (std.mem.eql(u8, e.local, "EvalResourceDecision")) {
                    result.eval_resource_decision = PolicyEvaluationDecisionType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "EvalResourceName")) {
                    result.eval_resource_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MatchedStatements")) {
                    result.matched_statements = try deserializeStatementListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "MissingContextValues")) {
                    result.missing_context_values = try deserializeContextKeyNamesResultListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryDecisionDetail")) {
                    result.permissions_boundary_decision_detail = try deserializePermissionsBoundaryDecisionDetail(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRole(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Role {
    var result: Role = undefined;
    result.assume_role_policy_document = null;
    result.description = null;
    result.max_session_duration = null;
    result.permissions_boundary = null;
    result.role_last_used = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumeRolePolicyDocument")) {
                    result.assume_role_policy_document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxSessionDuration")) {
                    result.max_session_duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleLastUsed")) {
                    result.role_last_used = try deserializeRoleLastUsed(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRoleDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RoleDetail {
    var result: RoleDetail = undefined;
    result.arn = null;
    result.assume_role_policy_document = null;
    result.attached_managed_policies = null;
    result.create_date = null;
    result.instance_profile_list = null;
    result.path = null;
    result.permissions_boundary = null;
    result.role_id = null;
    result.role_last_used = null;
    result.role_name = null;
    result.role_policy_list = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumeRolePolicyDocument")) {
                    result.assume_role_policy_document = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "InstanceProfileList")) {
                    result.instance_profile_list = try deserializeinstanceProfileListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleLastUsed")) {
                    result.role_last_used = try deserializeRoleLastUsed(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RolePolicyList")) {
                    result.role_policy_list = try deserializepolicyDetailListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRoleLastUsed(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RoleLastUsed {
    var result: RoleLastUsed = undefined;
    result.last_used_date = null;
    result.region = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastUsedDate")) {
                    result.last_used_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeRoleUsageType(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !RoleUsageType {
    var result: RoleUsageType = undefined;
    result.region = null;
    result.resources = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try deserializeArnListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSAMLPrivateKey(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SAMLPrivateKey {
    var result: SAMLPrivateKey = undefined;
    result.key_id = null;
    result.timestamp = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyId")) {
                    result.key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSAMLProviderListEntry(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SAMLProviderListEntry {
    var result: SAMLProviderListEntry = undefined;
    result.arn = null;
    result.create_date = null;
    result.valid_until = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ValidUntil")) {
                    result.valid_until = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSSHPublicKey(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SSHPublicKey {
    var result: SSHPublicKey = undefined;
    result.upload_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Fingerprint")) {
                    result.fingerprint = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSHPublicKeyBody")) {
                    result.ssh_public_key_body = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSHPublicKeyId")) {
                    result.ssh_public_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSSHPublicKeyMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SSHPublicKeyMetadata {
    var result: SSHPublicKeyMetadata = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSHPublicKeyId")) {
                    result.ssh_public_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerCertificate {
    var result: ServerCertificate = undefined;
    result.certificate_chain = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateBody")) {
                    result.certificate_body = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateChain")) {
                    result.certificate_chain = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateMetadata")) {
                    result.server_certificate_metadata = try deserializeServerCertificateMetadata(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServerCertificateMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServerCertificateMetadata {
    var result: ServerCertificateMetadata = undefined;
    result.expiration = null;
    result.upload_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateId")) {
                    result.server_certificate_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateName")) {
                    result.server_certificate_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServiceLastAccessed(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServiceLastAccessed {
    var result: ServiceLastAccessed = undefined;
    result.last_authenticated = null;
    result.last_authenticated_entity = null;
    result.last_authenticated_region = null;
    result.total_authenticated_entities = null;
    result.tracked_actions_last_accessed = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastAuthenticated")) {
                    result.last_authenticated = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedEntity")) {
                    result.last_authenticated_entity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedRegion")) {
                    result.last_authenticated_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalAuthenticatedEntities")) {
                    result.total_authenticated_entities = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TrackedActionsLastAccessed")) {
                    result.tracked_actions_last_accessed = try deserializeTrackedActionsLastAccessed(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServiceSpecificCredential(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServiceSpecificCredential {
    var result: ServiceSpecificCredential = undefined;
    result.expiration_date = null;
    result.service_credential_alias = null;
    result.service_credential_secret = null;
    result.service_password = "";
    result.service_user_name = "";
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpirationDate")) {
                    result.expiration_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialAlias")) {
                    result.service_credential_alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialSecret")) {
                    result.service_credential_secret = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServicePassword")) {
                    result.service_password = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceSpecificCredentialId")) {
                    result.service_specific_credential_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUserName")) {
                    result.service_user_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeServiceSpecificCredentialMetadata(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !ServiceSpecificCredentialMetadata {
    var result: ServiceSpecificCredentialMetadata = undefined;
    result.expiration_date = null;
    result.service_credential_alias = null;
    result.service_user_name = "";
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpirationDate")) {
                    result.expiration_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialAlias")) {
                    result.service_credential_alias = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceSpecificCredentialId")) {
                    result.service_specific_credential_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUserName")) {
                    result.service_user_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeSigningCertificate(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !SigningCertificate {
    var result: SigningCertificate = undefined;
    result.upload_date = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateBody")) {
                    result.certificate_body = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateId")) {
                    result.certificate_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = statusType.fromWireName(try reader.readElementText()) orelse return error.InvalidResponse;
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeStatement(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Statement {
    var result: Statement = undefined;
    result.end_position = null;
    result.source_policy_id = null;
    result.source_policy_type = null;
    result.start_position = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndPosition")) {
                    result.end_position = try deserializePosition(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "SourcePolicyId")) {
                    result.source_policy_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourcePolicyType")) {
                    result.source_policy_type = PolicySourceType.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartPosition")) {
                    result.start_position = try deserializePosition(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTag(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !Tag {
    var result: Tag = undefined;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeTrackedActionLastAccessed(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !TrackedActionLastAccessed {
    var result: TrackedActionLastAccessed = undefined;
    result.action_name = null;
    result.last_accessed_entity = null;
    result.last_accessed_region = null;
    result.last_accessed_time = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionName")) {
                    result.action_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedEntity")) {
                    result.last_accessed_entity = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedRegion")) {
                    result.last_accessed_region = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedTime")) {
                    result.last_accessed_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUser(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !User {
    var result: User = undefined;
    result.password_last_used = null;
    result.permissions_boundary = null;
    result.tags = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = try aws.date.parseIso8601(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PasswordLastUsed")) {
                    result.password_last_used = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeUserDetail(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !UserDetail {
    var result: UserDetail = undefined;
    result.arn = null;
    result.attached_managed_policies = null;
    result.create_date = null;
    result.group_list = null;
    result.path = null;
    result.permissions_boundary = null;
    result.tags = null;
    result.user_id = null;
    result.user_name = null;
    result.user_policy_list = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "GroupList")) {
                    result.group_list = try deserializegroupNameListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(allocator, reader);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPolicyList")) {
                    result.user_policy_list = try deserializepolicyDetailListType(allocator, reader, "member");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn deserializeVirtualMFADevice(allocator: std.mem.Allocator, reader: *aws.xml.Reader) !VirtualMFADevice {
    var result: VirtualMFADevice = undefined;
    result.base_32_string_seed = null;
    result.enable_date = null;
    result.qr_code_png = null;
    result.tags = null;
    result.user = null;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Base32StringSeed")) {
                    result.base_32_string_seed = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnableDate")) {
                    result.enable_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "QRCodePNG")) {
                    result.qr_code_png = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SerialNumber")) {
                    result.serial_number = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(allocator, reader, "member");
                } else if (std.mem.eql(u8, e.local, "User")) {
                    result.user = try deserializeUser(allocator, reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return result;
}

pub fn serializeActionNameListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeContextEntryListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const ContextEntry, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeContextEntry(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeContextKeyValueListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeResourceNameListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeSimulationPolicyListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeclientIDListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeentityListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const EntityType, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try buf.appendSlice(allocator, item.wireName());
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializepolicyParameterListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const PolicyParameter, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializePolicyParameter(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializepolicyParameterValuesListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeserviceNamespaceListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializetagKeyListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializetagListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const Tag, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try serializeTag(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializethumbprintListType(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const []const u8, comptime item_tag: []const u8) !void {
    for (value) |item| {
        try buf.appendSlice(allocator, "<");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
        try aws.xml.appendXmlEscaped(allocator, buf, item);
        try buf.appendSlice(allocator, "</");
        try buf.appendSlice(allocator, item_tag);
        try buf.appendSlice(allocator, ">");
    }
}

pub fn serializeContextEntry(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: ContextEntry) !void {
    if (value.context_key_name) |v| {
        try buf.appendSlice(allocator, "<ContextKeyName>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</ContextKeyName>");
    }
    if (value.context_key_type) |v| {
        try buf.appendSlice(allocator, "<ContextKeyType>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</ContextKeyType>");
    }
    if (value.context_key_values) |v| {
        try buf.appendSlice(allocator, "<ContextKeyValues>");
        try serializeContextKeyValueListType(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</ContextKeyValues>");
    }
}

pub fn serializeDelegationPermission(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: DelegationPermission) !void {
    if (value.parameters) |v| {
        try buf.appendSlice(allocator, "<Parameters>");
        try serializepolicyParameterListType(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Parameters>");
    }
    if (value.policy_template_arn) |v| {
        try buf.appendSlice(allocator, "<PolicyTemplateArn>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</PolicyTemplateArn>");
    }
}

pub fn serializePolicyParameter(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: PolicyParameter) !void {
    if (value.name) |v| {
        try buf.appendSlice(allocator, "<Name>");
        try aws.xml.appendXmlEscaped(allocator, buf, v);
        try buf.appendSlice(allocator, "</Name>");
    }
    if (value.@"type") |v| {
        try buf.appendSlice(allocator, "<Type>");
        try buf.appendSlice(allocator, v.wireName());
        try buf.appendSlice(allocator, "</Type>");
    }
    if (value.values) |v| {
        try buf.appendSlice(allocator, "<Values>");
        try serializepolicyParameterValuesListType(allocator, buf, v, "member");
        try buf.appendSlice(allocator, "</Values>");
    }
}

pub fn serializeTag(allocator: std.mem.Allocator, buf: *std.ArrayList(u8), value: Tag) !void {
    try buf.appendSlice(allocator, "<Key>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.key);
    try buf.appendSlice(allocator, "</Key>");
    try buf.appendSlice(allocator, "<Value>");
    try aws.xml.appendXmlEscaped(allocator, buf, value.value);
    try buf.appendSlice(allocator, "</Value>");
}

