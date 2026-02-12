const aws = @import("aws");
const std = @import("std");

const AccessDetail = @import("access_detail.zig").AccessDetail;
const AccessKey = @import("access_key.zig").AccessKey;
const AccessKeyLastUsed = @import("access_key_last_used.zig").AccessKeyLastUsed;
const AccessKeyMetadata = @import("access_key_metadata.zig").AccessKeyMetadata;
const AttachedPermissionsBoundary = @import("attached_permissions_boundary.zig").AttachedPermissionsBoundary;
const AttachedPolicy = @import("attached_policy.zig").AttachedPolicy;
const DelegationPermission = @import("delegation_permission.zig").DelegationPermission;
const DelegationRequest = @import("delegation_request.zig").DelegationRequest;
const DeletionTaskFailureReasonType = @import("deletion_task_failure_reason_type.zig").DeletionTaskFailureReasonType;
const EntityDetails = @import("entity_details.zig").EntityDetails;
const EntityInfo = @import("entity_info.zig").EntityInfo;
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

pub fn deserializeAccessDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AccessDetail {
    var list: std.ArrayList(AccessDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAccessDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeArnListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeContextKeyNamesResultListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeEvaluationResultsListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EvaluationResult {
    var list: std.ArrayList(EvaluationResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEvaluationResult(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeFeaturesListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const FeatureType {
    var list: std.ArrayList(FeatureType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    if (std.meta.stringToEnum(FeatureType, try reader.readElementText())) |v| try list.append(alloc, v);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeManagedPolicyDetailListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ManagedPolicyDetail {
    var list: std.ArrayList(ManagedPolicyDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeManagedPolicyDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeOpenIDConnectProviderListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const OpenIDConnectProviderListEntry {
    var list: std.ArrayList(OpenIDConnectProviderListEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeOpenIDConnectProviderListEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePolicyGroupListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyGroup {
    var list: std.ArrayList(PolicyGroup) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePolicyRoleListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyRole {
    var list: std.ArrayList(PolicyRole) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyRole(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializePolicyUserListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyUser {
    var list: std.ArrayList(PolicyUser) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyUser(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeResourceSpecificResultListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ResourceSpecificResult {
    var list: std.ArrayList(ResourceSpecificResult) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeResourceSpecificResult(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeRoleUsageListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RoleUsageType {
    var list: std.ArrayList(RoleUsageType) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRoleUsageType(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSAMLProviderListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SAMLProviderListEntry {
    var list: std.ArrayList(SAMLProviderListEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSAMLProviderListEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeSSHPublicKeyListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SSHPublicKeyMetadata {
    var list: std.ArrayList(SSHPublicKeyMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSSHPublicKeyMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeServiceSpecificCredentialsListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServiceSpecificCredentialMetadata {
    var list: std.ArrayList(ServiceSpecificCredentialMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServiceSpecificCredentialMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeServicesLastAccessed(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServiceLastAccessed {
    var list: std.ArrayList(ServiceLastAccessed) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServiceLastAccessed(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeStatementListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Statement {
    var list: std.ArrayList(Statement) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeStatement(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeTrackedActionsLastAccessed(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const TrackedActionLastAccessed {
    var list: std.ArrayList(TrackedActionLastAccessed) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTrackedActionLastAccessed(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeaccessKeyMetadataListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AccessKeyMetadata {
    var list: std.ArrayList(AccessKeyMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAccessKeyMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeaccountAliasListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeattachedPoliciesListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const AttachedPolicy {
    var list: std.ArrayList(AttachedPolicy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeAttachedPolicy(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializecertificateListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SigningCertificate {
    var list: std.ArrayList(SigningCertificate) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSigningCertificate(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeclientIDListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializedelegationRequestsListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const DelegationRequest {
    var list: std.ArrayList(DelegationRequest) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeDelegationRequest(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeentityDetailsListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const EntityDetails {
    var list: std.ArrayList(EntityDetails) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeEntityDetails(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializegroupDetailListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const GroupDetail {
    var list: std.ArrayList(GroupDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGroupDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializegroupListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Group {
    var list: std.ArrayList(Group) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeGroup(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializegroupNameListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeinstanceProfileListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const InstanceProfile {
    var list: std.ArrayList(InstanceProfile) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeInstanceProfile(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializelistPolicyGrantingServiceAccessResponseListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ListPoliciesGrantingServiceAccessEntry {
    var list: std.ArrayList(ListPoliciesGrantingServiceAccessEntry) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeListPoliciesGrantingServiceAccessEntry(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializemfaDeviceListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const MFADevice {
    var list: std.ArrayList(MFADevice) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeMFADevice(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyDetailListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyDetail {
    var list: std.ArrayList(PolicyDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyDocumentVersionListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyVersion {
    var list: std.ArrayList(PolicyVersion) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyVersion(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyGrantingServiceAccessListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyGrantingServiceAccess {
    var list: std.ArrayList(PolicyGrantingServiceAccess) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyGrantingServiceAccess(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Policy {
    var list: std.ArrayList(Policy) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicy(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyNameListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyParameterListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const PolicyParameter {
    var list: std.ArrayList(PolicyParameter) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializePolicyParameter(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializepolicyParameterValuesListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeprivateKeyList(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const SAMLPrivateKey {
    var list: std.ArrayList(SAMLPrivateKey) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeSAMLPrivateKey(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeroleDetailListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const RoleDetail {
    var list: std.ArrayList(RoleDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRoleDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeroleListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Role {
    var list: std.ArrayList(Role) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeRole(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializerolePermissionRestrictionArnListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeserverCertificateMetadataListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const ServerCertificateMetadata {
    var list: std.ArrayList(ServerCertificateMetadata) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeServerCertificateMetadata(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializetagListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const Tag {
    var list: std.ArrayList(Tag) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeTag(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializethumbprintListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const []const u8 {
    var list: std.ArrayList([]const u8) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try alloc.dupe(u8, try reader.readElementText()));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeuserDetailListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const UserDetail {
    var list: std.ArrayList(UserDetail) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUserDetail(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeuserListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const User {
    var list: std.ArrayList(User) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeUser(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializevirtualMFADeviceListType(reader: *aws.xml.Reader, alloc: std.mem.Allocator, comptime item_tag: []const u8) ![]const VirtualMFADevice {
    var list: std.ArrayList(VirtualMFADevice) = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, item_tag)) {
                    try list.append(alloc, try deserializeVirtualMFADevice(reader, alloc));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    return list.toOwnedSlice(alloc);
}

pub fn deserializeAccessDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessDetail {
    var result: AccessDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityPath")) {
                    result.entity_path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedTime")) {
                    result.last_authenticated_time = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccessKey(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessKey {
    var result: AccessKey = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SecretAccessKey")) {
                    result.secret_access_key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccessKeyLastUsed(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessKeyLastUsed {
    var result: AccessKeyLastUsed = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastUsedDate")) {
                    result.last_used_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAccessKeyMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AccessKeyMetadata {
    var result: AccessKeyMetadata = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AccessKeyId")) {
                    result.access_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeAttachedPermissionsBoundary(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AttachedPermissionsBoundary {
    var result: AttachedPermissionsBoundary = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PermissionsBoundaryArn")) {
                    result.permissions_boundary_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryType")) {
                    result.permissions_boundary_type = std.meta.stringToEnum(PermissionsBoundaryAttachmentType, try reader.readElementText());
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

pub fn deserializeAttachedPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !AttachedPolicy {
    var result: AttachedPolicy = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyArn")) {
                    result.policy_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDelegationPermission(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DelegationPermission {
    var result: DelegationPermission = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Parameters")) {
                    result.parameters = try deserializepolicyParameterListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PolicyTemplateArn")) {
                    result.policy_template_arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeDelegationRequest(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DelegationRequest {
    var result: DelegationRequest = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApproverId")) {
                    result.approver_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DelegationRequestId")) {
                    result.delegation_request_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExpirationTime")) {
                    result.expiration_time = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Notes")) {
                    result.notes = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OnlySendByOwner")) {
                    result.only_send_by_owner = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "OwnerAccountId")) {
                    result.owner_account_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OwnerId")) {
                    result.owner_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionPolicy")) {
                    result.permission_policy = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Permissions")) {
                    result.permissions = try deserializeDelegationPermission(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RedirectUrl")) {
                    result.redirect_url = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RejectionReason")) {
                    result.rejection_reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestMessage")) {
                    result.request_message = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestorId")) {
                    result.requestor_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RequestorName")) {
                    result.requestor_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RolePermissionRestrictionArns")) {
                    result.role_permission_restriction_arns = try deserializerolePermissionRestrictionArnListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "SessionDuration")) {
                    result.session_duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = std.meta.stringToEnum(stateType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UpdatedTime")) {
                    result.updated_time = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeDeletionTaskFailureReasonType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !DeletionTaskFailureReasonType {
    var result: DeletionTaskFailureReasonType = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Reason")) {
                    result.reason = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleUsageList")) {
                    result.role_usage_list = try deserializeRoleUsageListType(reader, alloc, "member");
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

pub fn deserializeEntityDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EntityDetails {
    var result: EntityDetails = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityInfo")) {
                    result.entity_info = try deserializeEntityInfo(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "LastAuthenticated")) {
                    result.last_authenticated = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeEntityInfo(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EntityInfo {
    var result: EntityInfo = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Id")) {
                    result.id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(policyOwnerEntityType, try reader.readElementText());
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

pub fn deserializeErrorDetails(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ErrorDetails {
    var result: ErrorDetails = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Code")) {
                    result.code = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Message")) {
                    result.message = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeEvaluationResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !EvaluationResult {
    var result: EvaluationResult = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EvalActionName")) {
                    result.eval_action_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalDecision")) {
                    result.eval_decision = std.meta.stringToEnum(PolicyEvaluationDecisionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalDecisionDetails")) {
                    result.eval_decision_details = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalResourceName")) {
                    result.eval_resource_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MatchedStatements")) {
                    result.matched_statements = try deserializeStatementListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MissingContextValues")) {
                    result.missing_context_values = try deserializeContextKeyNamesResultListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "OrganizationsDecisionDetail")) {
                    result.organizations_decision_detail = try deserializeOrganizationsDecisionDetail(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryDecisionDetail")) {
                    result.permissions_boundary_decision_detail = try deserializePermissionsBoundaryDecisionDetail(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "ResourceSpecificResults")) {
                    result.resource_specific_results = try deserializeResourceSpecificResultListType(reader, alloc, "member");
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

pub fn deserializeGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Group {
    var result: Group = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeGroupDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !GroupDetail {
    var result: GroupDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupPolicyList")) {
                    result.group_policy_list = try deserializepolicyDetailListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeInstanceProfile(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !InstanceProfile {
    var result: InstanceProfile = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InstanceProfileId")) {
                    result.instance_profile_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "InstanceProfileName")) {
                    result.instance_profile_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Roles")) {
                    result.roles = try deserializeroleListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
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

pub fn deserializeListPoliciesGrantingServiceAccessEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ListPoliciesGrantingServiceAccessEntry {
    var result: ListPoliciesGrantingServiceAccessEntry = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Policies")) {
                    result.policies = try deserializepolicyGrantingServiceAccessListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeLoginProfile(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !LoginProfile {
    var result: LoginProfile = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PasswordResetRequired")) {
                    result.password_reset_required = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeMFADevice(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !MFADevice {
    var result: MFADevice = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EnableDate")) {
                    result.enable_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "SerialNumber")) {
                    result.serial_number = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeManagedPolicyDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ManagedPolicyDetail {
    var result: ManagedPolicyDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachmentCount")) {
                    result.attachment_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsAttachable")) {
                    result.is_attachable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryUsageCount")) {
                    result.permissions_boundary_usage_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyId")) {
                    result.policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyVersionList")) {
                    result.policy_version_list = try deserializepolicyDocumentVersionListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UpdateDate")) {
                    result.update_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeOpenIDConnectProviderListEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OpenIDConnectProviderListEntry {
    var result: OpenIDConnectProviderListEntry = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeOrganizationsDecisionDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !OrganizationsDecisionDetail {
    _ = alloc;
    var result: OrganizationsDecisionDetail = .{};
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

pub fn deserializePasswordPolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PasswordPolicy {
    _ = alloc;
    var result: PasswordPolicy = .{};
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

pub fn deserializePermissionsBoundaryDecisionDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PermissionsBoundaryDecisionDetail {
    _ = alloc;
    var result: PermissionsBoundaryDecisionDetail = .{};
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

pub fn deserializePolicy(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Policy {
    var result: Policy = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachmentCount")) {
                    result.attachment_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "DefaultVersionId")) {
                    result.default_version_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsAttachable")) {
                    result.is_attachable = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryUsageCount")) {
                    result.permissions_boundary_usage_count = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PolicyId")) {
                    result.policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UpdateDate")) {
                    result.update_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializePolicyDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyDetail {
    var result: PolicyDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PolicyDocument")) {
                    result.policy_document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyGrantingServiceAccess(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyGrantingServiceAccess {
    var result: PolicyGrantingServiceAccess = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EntityName")) {
                    result.entity_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EntityType")) {
                    result.entity_type = std.meta.stringToEnum(policyOwnerEntityType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyArn")) {
                    result.policy_arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyName")) {
                    result.policy_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PolicyType")) {
                    result.policy_type = std.meta.stringToEnum(policyType, try reader.readElementText());
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

pub fn deserializePolicyGroup(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyGroup {
    var result: PolicyGroup = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GroupId")) {
                    result.group_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "GroupName")) {
                    result.group_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyParameter(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyParameter {
    var result: PolicyParameter = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Type")) {
                    result.@"type" = std.meta.stringToEnum(PolicyParameterTypeEnum, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Values")) {
                    result.values = try deserializepolicyParameterValuesListType(reader, alloc, "member");
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

pub fn deserializePolicyRole(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyRole {
    var result: PolicyRole = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyUser {
    var result: PolicyUser = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePolicyVersion(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !PolicyVersion {
    var result: PolicyVersion = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Document")) {
                    result.document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IsDefaultVersion")) {
                    result.is_default_version = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "VersionId")) {
                    result.version_id = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializePosition(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Position {
    _ = alloc;
    var result: Position = .{};
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

pub fn deserializeResourceSpecificResult(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ResourceSpecificResult {
    var result: ResourceSpecificResult = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EvalDecisionDetails")) {
                    result.eval_decision_details = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalResourceDecision")) {
                    result.eval_resource_decision = std.meta.stringToEnum(PolicyEvaluationDecisionType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EvalResourceName")) {
                    result.eval_resource_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MatchedStatements")) {
                    result.matched_statements = try deserializeStatementListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "MissingContextValues")) {
                    result.missing_context_values = try deserializeContextKeyNamesResultListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundaryDecisionDetail")) {
                    result.permissions_boundary_decision_detail = try deserializePermissionsBoundaryDecisionDetail(reader, alloc);
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

pub fn deserializeRole(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Role {
    var result: Role = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumeRolePolicyDocument")) {
                    result.assume_role_policy_document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Description")) {
                    result.description = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MaxSessionDuration")) {
                    result.max_session_duration = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleLastUsed")) {
                    result.role_last_used = try deserializeRoleLastUsed(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
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

pub fn deserializeRoleDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RoleDetail {
    var result: RoleDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AssumeRolePolicyDocument")) {
                    result.assume_role_policy_document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "InstanceProfileList")) {
                    result.instance_profile_list = try deserializeinstanceProfileListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RoleId")) {
                    result.role_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleLastUsed")) {
                    result.role_last_used = try deserializeRoleLastUsed(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "RoleName")) {
                    result.role_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RolePolicyList")) {
                    result.role_policy_list = try deserializepolicyDetailListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
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

pub fn deserializeRoleLastUsed(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RoleLastUsed {
    var result: RoleLastUsed = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastUsedDate")) {
                    result.last_used_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeRoleUsageType(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !RoleUsageType {
    var result: RoleUsageType = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Region")) {
                    result.region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Resources")) {
                    result.resources = try deserializeArnListType(reader, alloc, "member");
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

pub fn deserializeSAMLPrivateKey(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SAMLPrivateKey {
    var result: SAMLPrivateKey = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "KeyId")) {
                    result.key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Timestamp")) {
                    result.timestamp = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeSAMLProviderListEntry(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SAMLProviderListEntry {
    var result: SAMLProviderListEntry = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ValidUntil")) {
                    result.valid_until = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeSSHPublicKey(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SSHPublicKey {
    var result: SSHPublicKey = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Fingerprint")) {
                    result.fingerprint = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSHPublicKeyBody")) {
                    result.ssh_public_key_body = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SSHPublicKeyId")) {
                    result.ssh_public_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSSHPublicKeyMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SSHPublicKeyMetadata {
    var result: SSHPublicKeyMetadata = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "SSHPublicKeyId")) {
                    result.ssh_public_key_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeServerCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerCertificate {
    var result: ServerCertificate = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateBody")) {
                    result.certificate_body = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateChain")) {
                    result.certificate_chain = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateMetadata")) {
                    result.server_certificate_metadata = try deserializeServerCertificateMetadata(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
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

pub fn deserializeServerCertificateMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServerCertificateMetadata {
    var result: ServerCertificateMetadata = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Expiration")) {
                    result.expiration = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateId")) {
                    result.server_certificate_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerCertificateName")) {
                    result.server_certificate_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeServiceLastAccessed(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServiceLastAccessed {
    var result: ServiceLastAccessed = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "LastAuthenticated")) {
                    result.last_authenticated = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedEntity")) {
                    result.last_authenticated_entity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAuthenticatedRegion")) {
                    result.last_authenticated_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceNamespace")) {
                    result.service_namespace = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "TotalAuthenticatedEntities")) {
                    result.total_authenticated_entities = std.fmt.parseInt(i32, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "TrackedActionsLastAccessed")) {
                    result.tracked_actions_last_accessed = try deserializeTrackedActionsLastAccessed(reader, alloc, "member");
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

pub fn deserializeServiceSpecificCredential(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServiceSpecificCredential {
    var result: ServiceSpecificCredential = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpirationDate")) {
                    result.expiration_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialAlias")) {
                    result.service_credential_alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialSecret")) {
                    result.service_credential_secret = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServicePassword")) {
                    result.service_password = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceSpecificCredentialId")) {
                    result.service_specific_credential_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUserName")) {
                    result.service_user_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeServiceSpecificCredentialMetadata(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !ServiceSpecificCredentialMetadata {
    var result: ServiceSpecificCredentialMetadata = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ExpirationDate")) {
                    result.expiration_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "ServiceCredentialAlias")) {
                    result.service_credential_alias = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceName")) {
                    result.service_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceSpecificCredentialId")) {
                    result.service_specific_credential_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServiceUserName")) {
                    result.service_user_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeSigningCertificate(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !SigningCertificate {
    var result: SigningCertificate = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CertificateBody")) {
                    result.certificate_body = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CertificateId")) {
                    result.certificate_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = std.meta.stringToEnum(statusType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UploadDate")) {
                    result.upload_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeStatement(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Statement {
    var result: Statement = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "EndPosition")) {
                    result.end_position = try deserializePosition(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "SourcePolicyId")) {
                    result.source_policy_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SourcePolicyType")) {
                    result.source_policy_type = std.meta.stringToEnum(PolicySourceType, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StartPosition")) {
                    result.start_position = try deserializePosition(reader, alloc);
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

pub fn deserializeTag(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !Tag {
    var result: Tag = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Key")) {
                    result.key = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Value")) {
                    result.value = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeTrackedActionLastAccessed(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !TrackedActionLastAccessed {
    var result: TrackedActionLastAccessed = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ActionName")) {
                    result.action_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedEntity")) {
                    result.last_accessed_entity = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedRegion")) {
                    result.last_accessed_region = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LastAccessedTime")) {
                    result.last_accessed_time = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
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

pub fn deserializeUser(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !User {
    var result: User = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "PasswordLastUsed")) {
                    result.password_last_used = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
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

pub fn deserializeUserDetail(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !UserDetail {
    var result: UserDetail = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "AttachedManagedPolicies")) {
                    result.attached_managed_policies = try deserializeattachedPoliciesListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "CreateDate")) {
                    result.create_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "GroupList")) {
                    result.group_list = try deserializegroupNameListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Path")) {
                    result.path = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "PermissionsBoundary")) {
                    result.permissions_boundary = try deserializeAttachedPermissionsBoundary(reader, alloc);
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "UserId")) {
                    result.user_id = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserName")) {
                    result.user_name = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "UserPolicyList")) {
                    result.user_policy_list = try deserializepolicyDetailListType(reader, alloc, "member");
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

pub fn deserializeVirtualMFADevice(reader: *aws.xml.Reader, alloc: std.mem.Allocator) !VirtualMFADevice {
    var result: VirtualMFADevice = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Base32StringSeed")) {
                    result.base_32_string_seed = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EnableDate")) {
                    result.enable_date = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "QRCodePNG")) {
                    result.qr_code_png = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SerialNumber")) {
                    result.serial_number = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Tags")) {
                    result.tags = try deserializetagListType(reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "User")) {
                    result.user = try deserializeUser(reader, alloc);
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

