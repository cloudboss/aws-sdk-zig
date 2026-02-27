const aws = @import("aws");
const std = @import("std");

const accept_channel_handshake = @import("accept_channel_handshake.zig");
const cancel_channel_handshake = @import("cancel_channel_handshake.zig");
const create_channel_handshake = @import("create_channel_handshake.zig");
const create_program_management_account = @import("create_program_management_account.zig");
const create_relationship = @import("create_relationship.zig");
const delete_program_management_account = @import("delete_program_management_account.zig");
const delete_relationship = @import("delete_relationship.zig");
const get_relationship = @import("get_relationship.zig");
const list_channel_handshakes = @import("list_channel_handshakes.zig");
const list_program_management_accounts = @import("list_program_management_accounts.zig");
const list_relationships = @import("list_relationships.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reject_channel_handshake = @import("reject_channel_handshake.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_program_management_account = @import("update_program_management_account.zig");
const update_relationship = @import("update_relationship.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "PartnerCentral Channel";

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

    /// Accepts a pending channel handshake request from another AWS account.
    pub fn acceptChannelHandshake(self: *Self, allocator: std.mem.Allocator, input: accept_channel_handshake.AcceptChannelHandshakeInput, options: accept_channel_handshake.Options) !accept_channel_handshake.AcceptChannelHandshakeOutput {
        return accept_channel_handshake.execute(self, allocator, input, options);
    }

    /// Cancels a pending channel handshake request.
    pub fn cancelChannelHandshake(self: *Self, allocator: std.mem.Allocator, input: cancel_channel_handshake.CancelChannelHandshakeInput, options: cancel_channel_handshake.Options) !cancel_channel_handshake.CancelChannelHandshakeOutput {
        return cancel_channel_handshake.execute(self, allocator, input, options);
    }

    /// Creates a new channel handshake request to establish a partnership with
    /// another AWS account.
    pub fn createChannelHandshake(self: *Self, allocator: std.mem.Allocator, input: create_channel_handshake.CreateChannelHandshakeInput, options: create_channel_handshake.Options) !create_channel_handshake.CreateChannelHandshakeOutput {
        return create_channel_handshake.execute(self, allocator, input, options);
    }

    /// Creates a new program management account for managing partner relationships.
    pub fn createProgramManagementAccount(self: *Self, allocator: std.mem.Allocator, input: create_program_management_account.CreateProgramManagementAccountInput, options: create_program_management_account.Options) !create_program_management_account.CreateProgramManagementAccountOutput {
        return create_program_management_account.execute(self, allocator, input, options);
    }

    /// Creates a new partner relationship between accounts.
    pub fn createRelationship(self: *Self, allocator: std.mem.Allocator, input: create_relationship.CreateRelationshipInput, options: create_relationship.Options) !create_relationship.CreateRelationshipOutput {
        return create_relationship.execute(self, allocator, input, options);
    }

    /// Deletes a program management account.
    pub fn deleteProgramManagementAccount(self: *Self, allocator: std.mem.Allocator, input: delete_program_management_account.DeleteProgramManagementAccountInput, options: delete_program_management_account.Options) !delete_program_management_account.DeleteProgramManagementAccountOutput {
        return delete_program_management_account.execute(self, allocator, input, options);
    }

    /// Deletes a partner relationship.
    pub fn deleteRelationship(self: *Self, allocator: std.mem.Allocator, input: delete_relationship.DeleteRelationshipInput, options: delete_relationship.Options) !delete_relationship.DeleteRelationshipOutput {
        return delete_relationship.execute(self, allocator, input, options);
    }

    /// Retrieves details of a specific partner relationship.
    pub fn getRelationship(self: *Self, allocator: std.mem.Allocator, input: get_relationship.GetRelationshipInput, options: get_relationship.Options) !get_relationship.GetRelationshipOutput {
        return get_relationship.execute(self, allocator, input, options);
    }

    /// Lists channel handshakes based on specified criteria.
    pub fn listChannelHandshakes(self: *Self, allocator: std.mem.Allocator, input: list_channel_handshakes.ListChannelHandshakesInput, options: list_channel_handshakes.Options) !list_channel_handshakes.ListChannelHandshakesOutput {
        return list_channel_handshakes.execute(self, allocator, input, options);
    }

    /// Lists program management accounts based on specified criteria.
    pub fn listProgramManagementAccounts(self: *Self, allocator: std.mem.Allocator, input: list_program_management_accounts.ListProgramManagementAccountsInput, options: list_program_management_accounts.Options) !list_program_management_accounts.ListProgramManagementAccountsOutput {
        return list_program_management_accounts.execute(self, allocator, input, options);
    }

    /// Lists partner relationships based on specified criteria.
    pub fn listRelationships(self: *Self, allocator: std.mem.Allocator, input: list_relationships.ListRelationshipsInput, options: list_relationships.Options) !list_relationships.ListRelationshipsOutput {
        return list_relationships.execute(self, allocator, input, options);
    }

    /// Lists tags associated with a specific resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rejects a pending channel handshake request.
    pub fn rejectChannelHandshake(self: *Self, allocator: std.mem.Allocator, input: reject_channel_handshake.RejectChannelHandshakeInput, options: reject_channel_handshake.Options) !reject_channel_handshake.RejectChannelHandshakeOutput {
        return reject_channel_handshake.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the properties of a program management account.
    pub fn updateProgramManagementAccount(self: *Self, allocator: std.mem.Allocator, input: update_program_management_account.UpdateProgramManagementAccountInput, options: update_program_management_account.Options) !update_program_management_account.UpdateProgramManagementAccountOutput {
        return update_program_management_account.execute(self, allocator, input, options);
    }

    /// Updates the properties of a partner relationship.
    pub fn updateRelationship(self: *Self, allocator: std.mem.Allocator, input: update_relationship.UpdateRelationshipInput, options: update_relationship.Options) !update_relationship.UpdateRelationshipOutput {
        return update_relationship.execute(self, allocator, input, options);
    }

    pub fn listChannelHandshakesPaginator(self: *Self, params: list_channel_handshakes.ListChannelHandshakesInput) paginator.ListChannelHandshakesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProgramManagementAccountsPaginator(self: *Self, params: list_program_management_accounts.ListProgramManagementAccountsInput) paginator.ListProgramManagementAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRelationshipsPaginator(self: *Self, params: list_relationships.ListRelationshipsInput) paginator.ListRelationshipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
