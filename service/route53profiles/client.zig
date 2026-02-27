const aws = @import("aws");
const std = @import("std");

const associate_profile = @import("associate_profile.zig");
const associate_resource_to_profile = @import("associate_resource_to_profile.zig");
const create_profile = @import("create_profile.zig");
const delete_profile = @import("delete_profile.zig");
const disassociate_profile = @import("disassociate_profile.zig");
const disassociate_resource_from_profile = @import("disassociate_resource_from_profile.zig");
const get_profile = @import("get_profile.zig");
const get_profile_association = @import("get_profile_association.zig");
const get_profile_resource_association = @import("get_profile_resource_association.zig");
const list_profile_associations = @import("list_profile_associations.zig");
const list_profile_resource_associations = @import("list_profile_resource_associations.zig");
const list_profiles = @import("list_profiles.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_profile_resource_association = @import("update_profile_resource_association.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Route53Profiles";

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

    /// Associates a Route 53 Profiles profile with a VPC. A VPC can have only one
    /// Profile associated with it, but a Profile can be associated with 1000 of
    /// VPCs (and you can request a higher quota).
    /// For more information, see
    /// [https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html#limits-api-entities](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/DNSLimitations.html#limits-api-entities).
    pub fn associateProfile(self: *Self, allocator: std.mem.Allocator, input: associate_profile.AssociateProfileInput, options: associate_profile.Options) !associate_profile.AssociateProfileOutput {
        return associate_profile.execute(self, allocator, input, options);
    }

    /// Associates a DNS reource configuration to a Route 53 Profile.
    pub fn associateResourceToProfile(self: *Self, allocator: std.mem.Allocator, input: associate_resource_to_profile.AssociateResourceToProfileInput, options: associate_resource_to_profile.Options) !associate_resource_to_profile.AssociateResourceToProfileOutput {
        return associate_resource_to_profile.execute(self, allocator, input, options);
    }

    /// Creates an empty Route 53 Profile.
    pub fn createProfile(self: *Self, allocator: std.mem.Allocator, input: create_profile.CreateProfileInput, options: create_profile.Options) !create_profile.CreateProfileOutput {
        return create_profile.execute(self, allocator, input, options);
    }

    /// Deletes the specified Route 53 Profile. Before you can delete a profile, you
    /// must first disassociate it from all VPCs.
    pub fn deleteProfile(self: *Self, allocator: std.mem.Allocator, input: delete_profile.DeleteProfileInput, options: delete_profile.Options) !delete_profile.DeleteProfileOutput {
        return delete_profile.execute(self, allocator, input, options);
    }

    /// Dissociates a specified Route 53 Profile from the specified VPC.
    pub fn disassociateProfile(self: *Self, allocator: std.mem.Allocator, input: disassociate_profile.DisassociateProfileInput, options: disassociate_profile.Options) !disassociate_profile.DisassociateProfileOutput {
        return disassociate_profile.execute(self, allocator, input, options);
    }

    /// Dissoaciated a specified resource, from the Route 53 Profile.
    pub fn disassociateResourceFromProfile(self: *Self, allocator: std.mem.Allocator, input: disassociate_resource_from_profile.DisassociateResourceFromProfileInput, options: disassociate_resource_from_profile.Options) !disassociate_resource_from_profile.DisassociateResourceFromProfileOutput {
        return disassociate_resource_from_profile.execute(self, allocator, input, options);
    }

    /// Returns information about a specified Route 53 Profile, such as whether
    /// whether the Profile is shared, and the current status of the Profile.
    pub fn getProfile(self: *Self, allocator: std.mem.Allocator, input: get_profile.GetProfileInput, options: get_profile.Options) !get_profile.GetProfileOutput {
        return get_profile.execute(self, allocator, input, options);
    }

    /// Retrieves a Route 53 Profile association for a VPC. A VPC can have only one
    /// Profile association, but a Profile can be associated with up to 5000 VPCs.
    pub fn getProfileAssociation(self: *Self, allocator: std.mem.Allocator, input: get_profile_association.GetProfileAssociationInput, options: get_profile_association.Options) !get_profile_association.GetProfileAssociationOutput {
        return get_profile_association.execute(self, allocator, input, options);
    }

    /// Returns information about a specified Route 53 Profile resource association.
    pub fn getProfileResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: get_profile_resource_association.GetProfileResourceAssociationInput, options: get_profile_resource_association.Options) !get_profile_resource_association.GetProfileResourceAssociationOutput {
        return get_profile_resource_association.execute(self, allocator, input, options);
    }

    /// Lists all the VPCs that the specified Route 53 Profile is associated with.
    pub fn listProfileAssociations(self: *Self, allocator: std.mem.Allocator, input: list_profile_associations.ListProfileAssociationsInput, options: list_profile_associations.Options) !list_profile_associations.ListProfileAssociationsOutput {
        return list_profile_associations.execute(self, allocator, input, options);
    }

    /// Lists all the resource associations for the specified Route 53 Profile.
    pub fn listProfileResourceAssociations(self: *Self, allocator: std.mem.Allocator, input: list_profile_resource_associations.ListProfileResourceAssociationsInput, options: list_profile_resource_associations.Options) !list_profile_resource_associations.ListProfileResourceAssociationsOutput {
        return list_profile_resource_associations.execute(self, allocator, input, options);
    }

    /// Lists all the Route 53 Profiles associated with your Amazon Web Services
    /// account.
    pub fn listProfiles(self: *Self, allocator: std.mem.Allocator, input: list_profiles.ListProfilesInput, options: list_profiles.Options) !list_profiles.ListProfilesOutput {
        return list_profiles.execute(self, allocator, input, options);
    }

    /// Lists the tags that you associated with the specified resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the specified Route 53 Profile resourse association.
    pub fn updateProfileResourceAssociation(self: *Self, allocator: std.mem.Allocator, input: update_profile_resource_association.UpdateProfileResourceAssociationInput, options: update_profile_resource_association.Options) !update_profile_resource_association.UpdateProfileResourceAssociationOutput {
        return update_profile_resource_association.execute(self, allocator, input, options);
    }

    pub fn listProfileAssociationsPaginator(self: *Self, params: list_profile_associations.ListProfileAssociationsInput) paginator.ListProfileAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProfileResourceAssociationsPaginator(self: *Self, params: list_profile_resource_associations.ListProfileResourceAssociationsInput) paginator.ListProfileResourceAssociationsPaginator {
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
};
