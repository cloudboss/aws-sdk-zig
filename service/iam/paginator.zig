const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;

const get_account_authorization_details = @import("get_account_authorization_details.zig");
const get_group = @import("get_group.zig");
const list_access_keys = @import("list_access_keys.zig");
const list_account_aliases = @import("list_account_aliases.zig");
const list_attached_group_policies = @import("list_attached_group_policies.zig");
const list_attached_role_policies = @import("list_attached_role_policies.zig");
const list_attached_user_policies = @import("list_attached_user_policies.zig");
const list_entities_for_policy = @import("list_entities_for_policy.zig");
const list_group_policies = @import("list_group_policies.zig");
const list_groups = @import("list_groups.zig");
const list_groups_for_user = @import("list_groups_for_user.zig");
const list_instance_profile_tags = @import("list_instance_profile_tags.zig");
const list_instance_profiles = @import("list_instance_profiles.zig");
const list_instance_profiles_for_role = @import("list_instance_profiles_for_role.zig");
const list_mfa_device_tags = @import("list_mfa_device_tags.zig");
const list_mfa_devices = @import("list_mfa_devices.zig");
const list_open_id_connect_provider_tags = @import("list_open_id_connect_provider_tags.zig");
const list_policies = @import("list_policies.zig");
const list_policy_tags = @import("list_policy_tags.zig");
const list_policy_versions = @import("list_policy_versions.zig");
const list_role_policies = @import("list_role_policies.zig");
const list_role_tags = @import("list_role_tags.zig");
const list_roles = @import("list_roles.zig");
const list_saml_provider_tags = @import("list_saml_provider_tags.zig");
const list_server_certificate_tags = @import("list_server_certificate_tags.zig");
const list_server_certificates = @import("list_server_certificates.zig");
const list_signing_certificates = @import("list_signing_certificates.zig");
const list_ssh_public_keys = @import("list_ssh_public_keys.zig");
const list_user_policies = @import("list_user_policies.zig");
const list_user_tags = @import("list_user_tags.zig");
const list_users = @import("list_users.zig");
const list_virtual_mfa_devices = @import("list_virtual_mfa_devices.zig");
const simulate_custom_policy = @import("simulate_custom_policy.zig");
const simulate_principal_policy = @import("simulate_principal_policy.zig");

pub const GetAccountAuthorizationDetailsPaginator = struct {
    client: *Client,
    params: get_account_authorization_details.GetAccountAuthorizationDetailsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: get_account_authorization_details.Options) !get_account_authorization_details.GetAccountAuthorizationDetailsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try get_account_authorization_details.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const GetGroupPaginator = struct {
    client: *Client,
    params: get_group.GetGroupInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: get_group.Options) !get_group.GetGroupOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try get_group.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListAccessKeysPaginator = struct {
    client: *Client,
    params: list_access_keys.ListAccessKeysInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_access_keys.Options) !list_access_keys.ListAccessKeysOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_access_keys.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListAccountAliasesPaginator = struct {
    client: *Client,
    params: list_account_aliases.ListAccountAliasesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_account_aliases.Options) !list_account_aliases.ListAccountAliasesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_account_aliases.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListAttachedGroupPoliciesPaginator = struct {
    client: *Client,
    params: list_attached_group_policies.ListAttachedGroupPoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_attached_group_policies.Options) !list_attached_group_policies.ListAttachedGroupPoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_attached_group_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListAttachedRolePoliciesPaginator = struct {
    client: *Client,
    params: list_attached_role_policies.ListAttachedRolePoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_attached_role_policies.Options) !list_attached_role_policies.ListAttachedRolePoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_attached_role_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListAttachedUserPoliciesPaginator = struct {
    client: *Client,
    params: list_attached_user_policies.ListAttachedUserPoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_attached_user_policies.Options) !list_attached_user_policies.ListAttachedUserPoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_attached_user_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListEntitiesForPolicyPaginator = struct {
    client: *Client,
    params: list_entities_for_policy.ListEntitiesForPolicyInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_entities_for_policy.Options) !list_entities_for_policy.ListEntitiesForPolicyOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_entities_for_policy.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListGroupPoliciesPaginator = struct {
    client: *Client,
    params: list_group_policies.ListGroupPoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_group_policies.Options) !list_group_policies.ListGroupPoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_group_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListGroupsPaginator = struct {
    client: *Client,
    params: list_groups.ListGroupsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_groups.Options) !list_groups.ListGroupsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_groups.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListGroupsForUserPaginator = struct {
    client: *Client,
    params: list_groups_for_user.ListGroupsForUserInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_groups_for_user.Options) !list_groups_for_user.ListGroupsForUserOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_groups_for_user.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListInstanceProfileTagsPaginator = struct {
    client: *Client,
    params: list_instance_profile_tags.ListInstanceProfileTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_instance_profile_tags.Options) !list_instance_profile_tags.ListInstanceProfileTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_instance_profile_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListInstanceProfilesPaginator = struct {
    client: *Client,
    params: list_instance_profiles.ListInstanceProfilesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_instance_profiles.Options) !list_instance_profiles.ListInstanceProfilesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_instance_profiles.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListInstanceProfilesForRolePaginator = struct {
    client: *Client,
    params: list_instance_profiles_for_role.ListInstanceProfilesForRoleInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_instance_profiles_for_role.Options) !list_instance_profiles_for_role.ListInstanceProfilesForRoleOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_instance_profiles_for_role.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListMFADeviceTagsPaginator = struct {
    client: *Client,
    params: list_mfa_device_tags.ListMFADeviceTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_mfa_device_tags.Options) !list_mfa_device_tags.ListMFADeviceTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_mfa_device_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListMFADevicesPaginator = struct {
    client: *Client,
    params: list_mfa_devices.ListMFADevicesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_mfa_devices.Options) !list_mfa_devices.ListMFADevicesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_mfa_devices.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListOpenIDConnectProviderTagsPaginator = struct {
    client: *Client,
    params: list_open_id_connect_provider_tags.ListOpenIDConnectProviderTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_open_id_connect_provider_tags.Options) !list_open_id_connect_provider_tags.ListOpenIDConnectProviderTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_open_id_connect_provider_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListPoliciesPaginator = struct {
    client: *Client,
    params: list_policies.ListPoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_policies.Options) !list_policies.ListPoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListPolicyTagsPaginator = struct {
    client: *Client,
    params: list_policy_tags.ListPolicyTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_policy_tags.Options) !list_policy_tags.ListPolicyTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_policy_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListPolicyVersionsPaginator = struct {
    client: *Client,
    params: list_policy_versions.ListPolicyVersionsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_policy_versions.Options) !list_policy_versions.ListPolicyVersionsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_policy_versions.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListRolePoliciesPaginator = struct {
    client: *Client,
    params: list_role_policies.ListRolePoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_role_policies.Options) !list_role_policies.ListRolePoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_role_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListRoleTagsPaginator = struct {
    client: *Client,
    params: list_role_tags.ListRoleTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_role_tags.Options) !list_role_tags.ListRoleTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_role_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListRolesPaginator = struct {
    client: *Client,
    params: list_roles.ListRolesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_roles.Options) !list_roles.ListRolesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_roles.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListSAMLProviderTagsPaginator = struct {
    client: *Client,
    params: list_saml_provider_tags.ListSAMLProviderTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_saml_provider_tags.Options) !list_saml_provider_tags.ListSAMLProviderTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_saml_provider_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListServerCertificateTagsPaginator = struct {
    client: *Client,
    params: list_server_certificate_tags.ListServerCertificateTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_server_certificate_tags.Options) !list_server_certificate_tags.ListServerCertificateTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_server_certificate_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListServerCertificatesPaginator = struct {
    client: *Client,
    params: list_server_certificates.ListServerCertificatesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_server_certificates.Options) !list_server_certificates.ListServerCertificatesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_server_certificates.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListSigningCertificatesPaginator = struct {
    client: *Client,
    params: list_signing_certificates.ListSigningCertificatesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_signing_certificates.Options) !list_signing_certificates.ListSigningCertificatesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_signing_certificates.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListSSHPublicKeysPaginator = struct {
    client: *Client,
    params: list_ssh_public_keys.ListSSHPublicKeysInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_ssh_public_keys.Options) !list_ssh_public_keys.ListSSHPublicKeysOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_ssh_public_keys.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListUserPoliciesPaginator = struct {
    client: *Client,
    params: list_user_policies.ListUserPoliciesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_user_policies.Options) !list_user_policies.ListUserPoliciesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_user_policies.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListUserTagsPaginator = struct {
    client: *Client,
    params: list_user_tags.ListUserTagsInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_user_tags.Options) !list_user_tags.ListUserTagsOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_user_tags.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListUsersPaginator = struct {
    client: *Client,
    params: list_users.ListUsersInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_users.Options) !list_users.ListUsersOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_users.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const ListVirtualMFADevicesPaginator = struct {
    client: *Client,
    params: list_virtual_mfa_devices.ListVirtualMFADevicesInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: list_virtual_mfa_devices.Options) !list_virtual_mfa_devices.ListVirtualMFADevicesOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try list_virtual_mfa_devices.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const SimulateCustomPolicyPaginator = struct {
    client: *Client,
    params: simulate_custom_policy.SimulateCustomPolicyInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: simulate_custom_policy.Options) !simulate_custom_policy.SimulateCustomPolicyOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try simulate_custom_policy.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};

pub const SimulatePrincipalPolicyPaginator = struct {
    client: *Client,
    params: simulate_principal_policy.SimulatePrincipalPolicyInput,
    next_token: ?[]const u8 = null,
    done: bool = false,
    allocator: std.mem.Allocator,

    const Self = @This();

    pub fn next(self: *Self, options: simulate_principal_policy.Options) !simulate_principal_policy.SimulatePrincipalPolicyOutput {
        if (self.done) {
            return error.EndOfPagination;
        }

        self.params.marker = self.next_token;

        const output = try simulate_principal_policy.execute(self.client, self.params, options);

        if (output.marker) |token| {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = self.allocator.dupe(u8, token) catch null;
        } else {
            if (self.next_token) |old| {
                self.allocator.free(old);
            }
            self.next_token = null;
            self.done = true;
        }

        return output;
    }

    pub fn deinit(self: *Self) void {
        if (self.next_token) |token| {
            self.allocator.free(token);
        }
    }
};
