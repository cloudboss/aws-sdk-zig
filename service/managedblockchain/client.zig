const aws = @import("aws");
const std = @import("std");

const create_accessor = @import("create_accessor.zig");
const create_member = @import("create_member.zig");
const create_network = @import("create_network.zig");
const create_node = @import("create_node.zig");
const create_proposal = @import("create_proposal.zig");
const delete_accessor = @import("delete_accessor.zig");
const delete_member = @import("delete_member.zig");
const delete_node = @import("delete_node.zig");
const get_accessor = @import("get_accessor.zig");
const get_member = @import("get_member.zig");
const get_network = @import("get_network.zig");
const get_node = @import("get_node.zig");
const get_proposal = @import("get_proposal.zig");
const list_accessors = @import("list_accessors.zig");
const list_invitations = @import("list_invitations.zig");
const list_members = @import("list_members.zig");
const list_networks = @import("list_networks.zig");
const list_nodes = @import("list_nodes.zig");
const list_proposal_votes = @import("list_proposal_votes.zig");
const list_proposals = @import("list_proposals.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reject_invitation = @import("reject_invitation.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_member = @import("update_member.zig");
const update_node = @import("update_node.zig");
const vote_on_proposal = @import("vote_on_proposal.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ManagedBlockchain";

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

    /// Creates a new accessor for use with Amazon Managed Blockchain service that
    /// supports token based access.
    /// The accessor contains information required for token based access.
    pub fn createAccessor(self: *Self, allocator: std.mem.Allocator, input: create_accessor.CreateAccessorInput, options: create_accessor.Options) !create_accessor.CreateAccessorOutput {
        return create_accessor.execute(self, allocator, input, options);
    }

    /// Creates a member within a Managed Blockchain network.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn createMember(self: *Self, allocator: std.mem.Allocator, input: create_member.CreateMemberInput, options: create_member.Options) !create_member.CreateMemberOutput {
        return create_member.execute(self, allocator, input, options);
    }

    /// Creates a new blockchain network using Amazon Managed Blockchain.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn createNetwork(self: *Self, allocator: std.mem.Allocator, input: create_network.CreateNetworkInput, options: create_network.Options) !create_network.CreateNetworkOutput {
        return create_network.execute(self, allocator, input, options);
    }

    /// Creates a node on the specified blockchain network.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn createNode(self: *Self, allocator: std.mem.Allocator, input: create_node.CreateNodeInput, options: create_node.Options) !create_node.CreateNodeOutput {
        return create_node.execute(self, allocator, input, options);
    }

    /// Creates a proposal for a change to the network that other members of the
    /// network can vote on, for example, a proposal to add a new member to the
    /// network. Any member can create a proposal.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn createProposal(self: *Self, allocator: std.mem.Allocator, input: create_proposal.CreateProposalInput, options: create_proposal.Options) !create_proposal.CreateProposalOutput {
        return create_proposal.execute(self, allocator, input, options);
    }

    /// Deletes an accessor that your Amazon Web Services account owns. An accessor
    /// object is a container that has the
    /// information required for token based access to your Ethereum nodes
    /// including, the
    /// `BILLING_TOKEN`. After an accessor is deleted, the status of the accessor
    /// changes
    /// from `AVAILABLE` to `PENDING_DELETION`. An accessor in the
    /// `PENDING_DELETION` state can’t be used for new WebSocket requests or
    /// HTTP requests. However, WebSocket connections that were initiated while the
    /// accessor was in the
    /// `AVAILABLE` state remain open until they expire (up to 2 hours).
    pub fn deleteAccessor(self: *Self, allocator: std.mem.Allocator, input: delete_accessor.DeleteAccessorInput, options: delete_accessor.Options) !delete_accessor.DeleteAccessorOutput {
        return delete_accessor.execute(self, allocator, input, options);
    }

    /// Deletes a member. Deleting a member removes the member and all associated
    /// resources from the network. `DeleteMember` can only be called for a
    /// specified `MemberId` if the principal performing the action is associated
    /// with the Amazon Web Services account that owns the member. In all other
    /// cases, the `DeleteMember` action is carried out as the result of an approved
    /// proposal to remove a member. If `MemberId` is the last member in a network
    /// specified by the last Amazon Web Services account, the network is deleted
    /// also.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn deleteMember(self: *Self, allocator: std.mem.Allocator, input: delete_member.DeleteMemberInput, options: delete_member.Options) !delete_member.DeleteMemberOutput {
        return delete_member.execute(self, allocator, input, options);
    }

    /// Deletes a node that your Amazon Web Services account owns. All data on the
    /// node is lost and cannot be recovered.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn deleteNode(self: *Self, allocator: std.mem.Allocator, input: delete_node.DeleteNodeInput, options: delete_node.Options) !delete_node.DeleteNodeOutput {
        return delete_node.execute(self, allocator, input, options);
    }

    /// Returns detailed information about an accessor. An accessor object is a
    /// container that has the
    /// information required for token based access to your Ethereum nodes.
    pub fn getAccessor(self: *Self, allocator: std.mem.Allocator, input: get_accessor.GetAccessorInput, options: get_accessor.Options) !get_accessor.GetAccessorOutput {
        return get_accessor.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a member.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn getMember(self: *Self, allocator: std.mem.Allocator, input: get_member.GetMemberInput, options: get_member.Options) !get_member.GetMemberOutput {
        return get_member.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a network.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn getNetwork(self: *Self, allocator: std.mem.Allocator, input: get_network.GetNetworkInput, options: get_network.Options) !get_network.GetNetworkOutput {
        return get_network.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a node.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn getNode(self: *Self, allocator: std.mem.Allocator, input: get_node.GetNodeInput, options: get_node.Options) !get_node.GetNodeOutput {
        return get_node.execute(self, allocator, input, options);
    }

    /// Returns detailed information about a proposal.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn getProposal(self: *Self, allocator: std.mem.Allocator, input: get_proposal.GetProposalInput, options: get_proposal.Options) !get_proposal.GetProposalOutput {
        return get_proposal.execute(self, allocator, input, options);
    }

    /// Returns a list of the accessors and their properties. Accessor objects are
    /// containers that have the
    /// information required for token based access to your Ethereum nodes.
    pub fn listAccessors(self: *Self, allocator: std.mem.Allocator, input: list_accessors.ListAccessorsInput, options: list_accessors.Options) !list_accessors.ListAccessorsOutput {
        return list_accessors.execute(self, allocator, input, options);
    }

    /// Returns a list of all invitations for the current Amazon Web Services
    /// account.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn listInvitations(self: *Self, allocator: std.mem.Allocator, input: list_invitations.ListInvitationsInput, options: list_invitations.Options) !list_invitations.ListInvitationsOutput {
        return list_invitations.execute(self, allocator, input, options);
    }

    /// Returns a list of the members in a network and properties of their
    /// configurations.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn listMembers(self: *Self, allocator: std.mem.Allocator, input: list_members.ListMembersInput, options: list_members.Options) !list_members.ListMembersOutput {
        return list_members.execute(self, allocator, input, options);
    }

    /// Returns information about the networks in which the current Amazon Web
    /// Services account participates.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn listNetworks(self: *Self, allocator: std.mem.Allocator, input: list_networks.ListNetworksInput, options: list_networks.Options) !list_networks.ListNetworksOutput {
        return list_networks.execute(self, allocator, input, options);
    }

    /// Returns information about the nodes within a network.
    ///
    /// Applies to Hyperledger Fabric and Ethereum.
    pub fn listNodes(self: *Self, allocator: std.mem.Allocator, input: list_nodes.ListNodesInput, options: list_nodes.Options) !list_nodes.ListNodesOutput {
        return list_nodes.execute(self, allocator, input, options);
    }

    /// Returns the list of votes for a specified proposal, including the value of
    /// each vote and the unique identifier of the member that cast the vote.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn listProposalVotes(self: *Self, allocator: std.mem.Allocator, input: list_proposal_votes.ListProposalVotesInput, options: list_proposal_votes.Options) !list_proposal_votes.ListProposalVotesOutput {
        return list_proposal_votes.execute(self, allocator, input, options);
    }

    /// Returns a list of proposals for the network.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn listProposals(self: *Self, allocator: std.mem.Allocator, input: list_proposals.ListProposalsInput, options: list_proposals.Options) !list_proposals.ListProposalsOutput {
        return list_proposals.execute(self, allocator, input, options);
    }

    /// Returns a list of tags for the specified resource. Each tag consists of a
    /// key and optional value.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Rejects an invitation to join a network. This action can be called by a
    /// principal in an Amazon Web Services account that has received an invitation
    /// to create a member and join a network.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn rejectInvitation(self: *Self, allocator: std.mem.Allocator, input: reject_invitation.RejectInvitationInput, options: reject_invitation.Options) !reject_invitation.RejectInvitationOutput {
        return reject_invitation.execute(self, allocator, input, options);
    }

    /// Adds or overwrites the specified tags for the specified Amazon Managed
    /// Blockchain resource. Each tag consists of a key and optional value.
    ///
    /// When you specify a tag key that already exists, the tag value is overwritten
    /// with the new value. Use `UntagResource` to remove tag keys.
    ///
    /// A resource can have up to 50 tags. If you try to create more than 50 tags
    /// for a resource, your request fails and returns an error.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the Amazon Managed Blockchain resource.
    ///
    /// For more information about tags, see [Tagging
    /// Resources](https://docs.aws.amazon.com/managed-blockchain/latest/ethereum-dev/tagging-resources.html) in the *Amazon Managed Blockchain Ethereum Developer Guide*, or [Tagging Resources](https://docs.aws.amazon.com/managed-blockchain/latest/hyperledger-fabric-dev/tagging-resources.html) in the *Amazon Managed Blockchain Hyperledger Fabric Developer Guide*.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a member configuration with new parameters.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn updateMember(self: *Self, allocator: std.mem.Allocator, input: update_member.UpdateMemberInput, options: update_member.Options) !update_member.UpdateMemberOutput {
        return update_member.execute(self, allocator, input, options);
    }

    /// Updates a node configuration with new parameters.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn updateNode(self: *Self, allocator: std.mem.Allocator, input: update_node.UpdateNodeInput, options: update_node.Options) !update_node.UpdateNodeOutput {
        return update_node.execute(self, allocator, input, options);
    }

    /// Casts a vote for a specified `ProposalId` on behalf of a member. The member
    /// to vote as, specified by `VoterMemberId`, must be in the same Amazon Web
    /// Services account as the principal that calls the action.
    ///
    /// Applies only to Hyperledger Fabric.
    pub fn voteOnProposal(self: *Self, allocator: std.mem.Allocator, input: vote_on_proposal.VoteOnProposalInput, options: vote_on_proposal.Options) !vote_on_proposal.VoteOnProposalOutput {
        return vote_on_proposal.execute(self, allocator, input, options);
    }

    pub fn listAccessorsPaginator(self: *Self, params: list_accessors.ListAccessorsInput) paginator.ListAccessorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInvitationsPaginator(self: *Self, params: list_invitations.ListInvitationsInput) paginator.ListInvitationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMembersPaginator(self: *Self, params: list_members.ListMembersInput) paginator.ListMembersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNetworksPaginator(self: *Self, params: list_networks.ListNetworksInput) paginator.ListNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNodesPaginator(self: *Self, params: list_nodes.ListNodesInput) paginator.ListNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProposalVotesPaginator(self: *Self, params: list_proposal_votes.ListProposalVotesInput) paginator.ListProposalVotesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProposalsPaginator(self: *Self, params: list_proposals.ListProposalsInput) paginator.ListProposalsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
