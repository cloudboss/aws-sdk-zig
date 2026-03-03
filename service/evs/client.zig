const aws = @import("aws");
const std = @import("std");

const associate_eip_to_vlan = @import("associate_eip_to_vlan.zig");
const create_environment = @import("create_environment.zig");
const create_environment_host = @import("create_environment_host.zig");
const delete_environment = @import("delete_environment.zig");
const delete_environment_host = @import("delete_environment_host.zig");
const disassociate_eip_from_vlan = @import("disassociate_eip_from_vlan.zig");
const get_environment = @import("get_environment.zig");
const get_versions = @import("get_versions.zig");
const list_environment_hosts = @import("list_environment_hosts.zig");
const list_environment_vlans = @import("list_environment_vlans.zig");
const list_environments = @import("list_environments.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "evs";

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

    /// Associates an Elastic IP address with a public HCX VLAN. This operation is
    /// only allowed for public HCX VLANs at this time.
    pub fn associateEipToVlan(self: *Self, allocator: std.mem.Allocator, input: associate_eip_to_vlan.AssociateEipToVlanInput, options: CallOptions) !associate_eip_to_vlan.AssociateEipToVlanOutput {
        return associate_eip_to_vlan.execute(self, allocator, input, options);
    }

    /// Creates an Amazon EVS environment that runs VCF software, such as SDDC
    /// Manager, NSX Manager, and vCenter Server.
    ///
    /// During environment creation, Amazon EVS performs validations on DNS
    /// settings, provisions VLAN subnets and hosts, and deploys the supplied
    /// version of VCF.
    ///
    /// It can take several hours to create an environment. After the deployment
    /// completes, you can configure VCF in the vSphere user interface according to
    /// your needs.
    ///
    /// When creating a new environment, the default ESX version for the selected
    /// VCF version will be used, you cannot choose a specific ESX version in
    /// `CreateEnvironment` action. When a host has been added with a specific ESX
    /// version, it can only be upgraded using vCenter Lifecycle Manager.
    ///
    /// You cannot use the `dedicatedHostId` and `placementGroupId` parameters
    /// together in the same `CreateEnvironment` action. This results in a
    /// `ValidationException` response.
    pub fn createEnvironment(self: *Self, allocator: std.mem.Allocator, input: create_environment.CreateEnvironmentInput, options: CallOptions) !create_environment.CreateEnvironmentOutput {
        return create_environment.execute(self, allocator, input, options);
    }

    /// Creates an ESX host and adds it to an Amazon EVS environment. Amazon EVS
    /// supports 4-16 hosts per environment.
    ///
    /// This action can only be used after the Amazon EVS environment is deployed.
    ///
    /// You can use the `dedicatedHostId` parameter to specify an Amazon EC2
    /// Dedicated Host for ESX host creation.
    ///
    /// You can use the `placementGroupId` parameter to specify a cluster or
    /// partition placement group to launch EC2 instances into.
    ///
    /// If you don't specify an ESX version when adding hosts using
    /// `CreateEnvironmentHost` action, Amazon EVS automatically uses the default
    /// ESX version associated with your environment's VCF version. To find the
    /// default ESX version for a particular VCF version, use the `GetVersions`
    /// action.
    ///
    /// You cannot use the `dedicatedHostId` and `placementGroupId` parameters
    /// together in the same `CreateEnvironmentHost` action. This results in a
    /// `ValidationException` response.
    pub fn createEnvironmentHost(self: *Self, allocator: std.mem.Allocator, input: create_environment_host.CreateEnvironmentHostInput, options: CallOptions) !create_environment_host.CreateEnvironmentHostOutput {
        return create_environment_host.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon EVS environment.
    ///
    /// Amazon EVS environments will only be enabled for deletion once the hosts are
    /// deleted. You can delete hosts using the `DeleteEnvironmentHost` action.
    ///
    /// Environment deletion also deletes the associated Amazon EVS VLAN subnets and
    /// Amazon Web Services Secrets Manager secrets that Amazon EVS created. Amazon
    /// Web Services resources that you create are not deleted. These resources may
    /// continue to incur costs.
    pub fn deleteEnvironment(self: *Self, allocator: std.mem.Allocator, input: delete_environment.DeleteEnvironmentInput, options: CallOptions) !delete_environment.DeleteEnvironmentOutput {
        return delete_environment.execute(self, allocator, input, options);
    }

    /// Deletes a host from an Amazon EVS environment.
    ///
    /// Before deleting a host, you must unassign and decommission the host from
    /// within the SDDC Manager user interface. Not doing so could impact the
    /// availability of your virtual machines or result in data loss.
    pub fn deleteEnvironmentHost(self: *Self, allocator: std.mem.Allocator, input: delete_environment_host.DeleteEnvironmentHostInput, options: CallOptions) !delete_environment_host.DeleteEnvironmentHostOutput {
        return delete_environment_host.execute(self, allocator, input, options);
    }

    /// Disassociates an Elastic IP address from a public HCX VLAN. This operation
    /// is only allowed for public HCX VLANs at this time.
    pub fn disassociateEipFromVlan(self: *Self, allocator: std.mem.Allocator, input: disassociate_eip_from_vlan.DisassociateEipFromVlanInput, options: CallOptions) !disassociate_eip_from_vlan.DisassociateEipFromVlanOutput {
        return disassociate_eip_from_vlan.execute(self, allocator, input, options);
    }

    /// Returns a description of the specified environment.
    pub fn getEnvironment(self: *Self, allocator: std.mem.Allocator, input: get_environment.GetEnvironmentInput, options: CallOptions) !get_environment.GetEnvironmentOutput {
        return get_environment.execute(self, allocator, input, options);
    }

    /// Returns information about VCF versions, ESX versions and EC2 instance types
    /// provided by Amazon EVS. For each VCF version, the response also includes the
    /// default ESX version and provided EC2 instance types.
    pub fn getVersions(self: *Self, allocator: std.mem.Allocator, input: get_versions.GetVersionsInput, options: CallOptions) !get_versions.GetVersionsOutput {
        return get_versions.execute(self, allocator, input, options);
    }

    /// List the hosts within an environment.
    pub fn listEnvironmentHosts(self: *Self, allocator: std.mem.Allocator, input: list_environment_hosts.ListEnvironmentHostsInput, options: CallOptions) !list_environment_hosts.ListEnvironmentHostsOutput {
        return list_environment_hosts.execute(self, allocator, input, options);
    }

    /// Lists environment VLANs that are associated with the specified environment.
    pub fn listEnvironmentVlans(self: *Self, allocator: std.mem.Allocator, input: list_environment_vlans.ListEnvironmentVlansInput, options: CallOptions) !list_environment_vlans.ListEnvironmentVlansOutput {
        return list_environment_vlans.execute(self, allocator, input, options);
    }

    /// Lists the Amazon EVS environments in your Amazon Web Services account in the
    /// specified Amazon Web Services Region.
    pub fn listEnvironments(self: *Self, allocator: std.mem.Allocator, input: list_environments.ListEnvironmentsInput, options: CallOptions) !list_environments.ListEnvironmentsOutput {
        return list_environments.execute(self, allocator, input, options);
    }

    /// Lists the tags for an Amazon EVS resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Associates the specified tags to an Amazon EVS resource with the specified
    /// `resourceArn`. If existing tags on a resource are not specified in the
    /// request parameters, they aren't changed. When a resource is deleted, the
    /// tags associated with that resource are also deleted. Tags that you create
    /// for Amazon EVS resources don't propagate to any other resources associated
    /// with the environment. For example, if you tag an environment with this
    /// operation, that tag doesn't automatically propagate to the VLAN subnets and
    /// hosts associated with the environment.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes specified tags from an Amazon EVS resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    pub fn listEnvironmentHostsPaginator(self: *Self, params: list_environment_hosts.ListEnvironmentHostsInput) paginator.ListEnvironmentHostsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentVlansPaginator(self: *Self, params: list_environment_vlans.ListEnvironmentVlansInput) paginator.ListEnvironmentVlansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEnvironmentsPaginator(self: *Self, params: list_environments.ListEnvironmentsInput) paginator.ListEnvironmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
