const aws = @import("aws");
const std = @import("std");

const accept_marketplace_registration = @import("accept_marketplace_registration.zig");
const associate_iam_role_to_resource = @import("associate_iam_role_to_resource.zig");
const create_cloud_autonomous_vm_cluster = @import("create_cloud_autonomous_vm_cluster.zig");
const create_cloud_exadata_infrastructure = @import("create_cloud_exadata_infrastructure.zig");
const create_cloud_vm_cluster = @import("create_cloud_vm_cluster.zig");
const create_odb_network = @import("create_odb_network.zig");
const create_odb_peering_connection = @import("create_odb_peering_connection.zig");
const delete_cloud_autonomous_vm_cluster = @import("delete_cloud_autonomous_vm_cluster.zig");
const delete_cloud_exadata_infrastructure = @import("delete_cloud_exadata_infrastructure.zig");
const delete_cloud_vm_cluster = @import("delete_cloud_vm_cluster.zig");
const delete_odb_network = @import("delete_odb_network.zig");
const delete_odb_peering_connection = @import("delete_odb_peering_connection.zig");
const disassociate_iam_role_from_resource = @import("disassociate_iam_role_from_resource.zig");
const get_cloud_autonomous_vm_cluster = @import("get_cloud_autonomous_vm_cluster.zig");
const get_cloud_exadata_infrastructure = @import("get_cloud_exadata_infrastructure.zig");
const get_cloud_exadata_infrastructure_unallocated_resources = @import("get_cloud_exadata_infrastructure_unallocated_resources.zig");
const get_cloud_vm_cluster = @import("get_cloud_vm_cluster.zig");
const get_db_node = @import("get_db_node.zig");
const get_db_server = @import("get_db_server.zig");
const get_oci_onboarding_status = @import("get_oci_onboarding_status.zig");
const get_odb_network = @import("get_odb_network.zig");
const get_odb_peering_connection = @import("get_odb_peering_connection.zig");
const initialize_service = @import("initialize_service.zig");
const list_autonomous_virtual_machines = @import("list_autonomous_virtual_machines.zig");
const list_cloud_autonomous_vm_clusters = @import("list_cloud_autonomous_vm_clusters.zig");
const list_cloud_exadata_infrastructures = @import("list_cloud_exadata_infrastructures.zig");
const list_cloud_vm_clusters = @import("list_cloud_vm_clusters.zig");
const list_db_nodes = @import("list_db_nodes.zig");
const list_db_servers = @import("list_db_servers.zig");
const list_db_system_shapes = @import("list_db_system_shapes.zig");
const list_gi_versions = @import("list_gi_versions.zig");
const list_odb_networks = @import("list_odb_networks.zig");
const list_odb_peering_connections = @import("list_odb_peering_connections.zig");
const list_system_versions = @import("list_system_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reboot_db_node = @import("reboot_db_node.zig");
const start_db_node = @import("start_db_node.zig");
const stop_db_node = @import("stop_db_node.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_cloud_exadata_infrastructure = @import("update_cloud_exadata_infrastructure.zig");
const update_odb_network = @import("update_odb_network.zig");
const update_odb_peering_connection = @import("update_odb_peering_connection.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "odb";

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

    /// Registers the Amazon Web Services Marketplace token for your Amazon Web
    /// Services account to activate your Oracle Database@Amazon Web Services
    /// subscription.
    pub fn acceptMarketplaceRegistration(self: *Self, allocator: std.mem.Allocator, input: accept_marketplace_registration.AcceptMarketplaceRegistrationInput, options: accept_marketplace_registration.Options) !accept_marketplace_registration.AcceptMarketplaceRegistrationOutput {
        return accept_marketplace_registration.execute(self, allocator, input, options);
    }

    /// Associates an Amazon Web Services Identity and Access Management (IAM)
    /// service role with a specified resource to enable Amazon Web Services service
    /// integration.
    pub fn associateIamRoleToResource(self: *Self, allocator: std.mem.Allocator, input: associate_iam_role_to_resource.AssociateIamRoleToResourceInput, options: associate_iam_role_to_resource.Options) !associate_iam_role_to_resource.AssociateIamRoleToResourceOutput {
        return associate_iam_role_to_resource.execute(self, allocator, input, options);
    }

    /// Creates a new Autonomous VM cluster in the specified Exadata infrastructure.
    pub fn createCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: create_cloud_autonomous_vm_cluster.CreateCloudAutonomousVmClusterInput, options: create_cloud_autonomous_vm_cluster.Options) !create_cloud_autonomous_vm_cluster.CreateCloudAutonomousVmClusterOutput {
        return create_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Exadata infrastructure.
    pub fn createCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: create_cloud_exadata_infrastructure.CreateCloudExadataInfrastructureInput, options: create_cloud_exadata_infrastructure.Options) !create_cloud_exadata_infrastructure.CreateCloudExadataInfrastructureOutput {
        return create_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Creates a VM cluster on the specified Exadata infrastructure.
    pub fn createCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: create_cloud_vm_cluster.CreateCloudVmClusterInput, options: create_cloud_vm_cluster.Options) !create_cloud_vm_cluster.CreateCloudVmClusterOutput {
        return create_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates an ODB network.
    pub fn createOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: create_odb_network.CreateOdbNetworkInput, options: create_odb_network.Options) !create_odb_network.CreateOdbNetworkOutput {
        return create_odb_network.execute(self, allocator, input, options);
    }

    /// Creates a peering connection between an ODB network and a VPC.
    ///
    /// A peering connection enables private connectivity between the networks for
    /// application-tier communication.
    pub fn createOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: create_odb_peering_connection.CreateOdbPeeringConnectionInput, options: create_odb_peering_connection.Options) !create_odb_peering_connection.CreateOdbPeeringConnectionOutput {
        return create_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Deletes an Autonomous VM cluster.
    pub fn deleteCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_autonomous_vm_cluster.DeleteCloudAutonomousVmClusterInput, options: delete_cloud_autonomous_vm_cluster.Options) !delete_cloud_autonomous_vm_cluster.DeleteCloudAutonomousVmClusterOutput {
        return delete_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified Exadata infrastructure. Before you use this operation,
    /// make sure to delete all of the VM clusters that are hosted on this Exadata
    /// infrastructure.
    pub fn deleteCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_exadata_infrastructure.DeleteCloudExadataInfrastructureInput, options: delete_cloud_exadata_infrastructure.Options) !delete_cloud_exadata_infrastructure.DeleteCloudExadataInfrastructureOutput {
        return delete_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Deletes the specified VM cluster.
    pub fn deleteCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_vm_cluster.DeleteCloudVmClusterInput, options: delete_cloud_vm_cluster.Options) !delete_cloud_vm_cluster.DeleteCloudVmClusterOutput {
        return delete_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified ODB network.
    pub fn deleteOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_odb_network.DeleteOdbNetworkInput, options: delete_odb_network.Options) !delete_odb_network.DeleteOdbNetworkOutput {
        return delete_odb_network.execute(self, allocator, input, options);
    }

    /// Deletes an ODB peering connection.
    ///
    /// When you delete an ODB peering connection, the underlying VPC peering
    /// connection is also deleted.
    pub fn deleteOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: delete_odb_peering_connection.DeleteOdbPeeringConnectionInput, options: delete_odb_peering_connection.Options) !delete_odb_peering_connection.DeleteOdbPeeringConnectionOutput {
        return delete_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon Web Services Identity and Access Management (IAM)
    /// service role from a specified resource to disable Amazon Web Services
    /// service integration.
    pub fn disassociateIamRoleFromResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_iam_role_from_resource.DisassociateIamRoleFromResourceInput, options: disassociate_iam_role_from_resource.Options) !disassociate_iam_role_from_resource.DisassociateIamRoleFromResourceOutput {
        return disassociate_iam_role_from_resource.execute(self, allocator, input, options);
    }

    /// Gets information about a specific Autonomous VM cluster.
    pub fn getCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: get_cloud_autonomous_vm_cluster.GetCloudAutonomousVmClusterInput, options: get_cloud_autonomous_vm_cluster.Options) !get_cloud_autonomous_vm_cluster.GetCloudAutonomousVmClusterOutput {
        return get_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Exadata infrastructure.
    pub fn getCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: get_cloud_exadata_infrastructure.GetCloudExadataInfrastructureInput, options: get_cloud_exadata_infrastructure.Options) !get_cloud_exadata_infrastructure.GetCloudExadataInfrastructureOutput {
        return get_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Retrieves information about unallocated resources in a specified Cloud
    /// Exadata Infrastructure.
    pub fn getCloudExadataInfrastructureUnallocatedResources(self: *Self, allocator: std.mem.Allocator, input: get_cloud_exadata_infrastructure_unallocated_resources.GetCloudExadataInfrastructureUnallocatedResourcesInput, options: get_cloud_exadata_infrastructure_unallocated_resources.Options) !get_cloud_exadata_infrastructure_unallocated_resources.GetCloudExadataInfrastructureUnallocatedResourcesOutput {
        return get_cloud_exadata_infrastructure_unallocated_resources.execute(self, allocator, input, options);
    }

    /// Returns information about the specified VM cluster.
    pub fn getCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: get_cloud_vm_cluster.GetCloudVmClusterInput, options: get_cloud_vm_cluster.Options) !get_cloud_vm_cluster.GetCloudVmClusterOutput {
        return get_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about the specified DB node.
    pub fn getDbNode(self: *Self, allocator: std.mem.Allocator, input: get_db_node.GetDbNodeInput, options: get_db_node.Options) !get_db_node.GetDbNodeOutput {
        return get_db_node.execute(self, allocator, input, options);
    }

    /// Returns information about the specified database server.
    pub fn getDbServer(self: *Self, allocator: std.mem.Allocator, input: get_db_server.GetDbServerInput, options: get_db_server.Options) !get_db_server.GetDbServerOutput {
        return get_db_server.execute(self, allocator, input, options);
    }

    /// Returns the tenancy activation link and onboarding status for your Amazon
    /// Web Services account.
    pub fn getOciOnboardingStatus(self: *Self, allocator: std.mem.Allocator, input: get_oci_onboarding_status.GetOciOnboardingStatusInput, options: get_oci_onboarding_status.Options) !get_oci_onboarding_status.GetOciOnboardingStatusOutput {
        return get_oci_onboarding_status.execute(self, allocator, input, options);
    }

    /// Returns information about the specified ODB network.
    pub fn getOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: get_odb_network.GetOdbNetworkInput, options: get_odb_network.Options) !get_odb_network.GetOdbNetworkOutput {
        return get_odb_network.execute(self, allocator, input, options);
    }

    /// Retrieves information about an ODB peering connection.
    pub fn getOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: get_odb_peering_connection.GetOdbPeeringConnectionInput, options: get_odb_peering_connection.Options) !get_odb_peering_connection.GetOdbPeeringConnectionOutput {
        return get_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Initializes the ODB service for the first time in an account.
    pub fn initializeService(self: *Self, allocator: std.mem.Allocator, input: initialize_service.InitializeServiceInput, options: initialize_service.Options) !initialize_service.InitializeServiceOutput {
        return initialize_service.execute(self, allocator, input, options);
    }

    /// Lists all Autonomous VMs in an Autonomous VM cluster.
    pub fn listAutonomousVirtualMachines(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_virtual_machines.ListAutonomousVirtualMachinesInput, options: list_autonomous_virtual_machines.Options) !list_autonomous_virtual_machines.ListAutonomousVirtualMachinesOutput {
        return list_autonomous_virtual_machines.execute(self, allocator, input, options);
    }

    /// Lists all Autonomous VM clusters in a specified Cloud Exadata
    /// infrastructure.
    pub fn listCloudAutonomousVmClusters(self: *Self, allocator: std.mem.Allocator, input: list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersInput, options: list_cloud_autonomous_vm_clusters.Options) !list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersOutput {
        return list_cloud_autonomous_vm_clusters.execute(self, allocator, input, options);
    }

    /// Returns information about the Exadata infrastructures owned by your Amazon
    /// Web Services account.
    pub fn listCloudExadataInfrastructures(self: *Self, allocator: std.mem.Allocator, input: list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresInput, options: list_cloud_exadata_infrastructures.Options) !list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresOutput {
        return list_cloud_exadata_infrastructures.execute(self, allocator, input, options);
    }

    /// Returns information about the VM clusters owned by your Amazon Web Services
    /// account or only the ones on the specified Exadata infrastructure.
    pub fn listCloudVmClusters(self: *Self, allocator: std.mem.Allocator, input: list_cloud_vm_clusters.ListCloudVmClustersInput, options: list_cloud_vm_clusters.Options) !list_cloud_vm_clusters.ListCloudVmClustersOutput {
        return list_cloud_vm_clusters.execute(self, allocator, input, options);
    }

    /// Returns information about the DB nodes for the specified VM cluster.
    pub fn listDbNodes(self: *Self, allocator: std.mem.Allocator, input: list_db_nodes.ListDbNodesInput, options: list_db_nodes.Options) !list_db_nodes.ListDbNodesOutput {
        return list_db_nodes.execute(self, allocator, input, options);
    }

    /// Returns information about the database servers that belong to the specified
    /// Exadata infrastructure.
    pub fn listDbServers(self: *Self, allocator: std.mem.Allocator, input: list_db_servers.ListDbServersInput, options: list_db_servers.Options) !list_db_servers.ListDbServersOutput {
        return list_db_servers.execute(self, allocator, input, options);
    }

    /// Returns information about the shapes that are available for an Exadata
    /// infrastructure.
    pub fn listDbSystemShapes(self: *Self, allocator: std.mem.Allocator, input: list_db_system_shapes.ListDbSystemShapesInput, options: list_db_system_shapes.Options) !list_db_system_shapes.ListDbSystemShapesOutput {
        return list_db_system_shapes.execute(self, allocator, input, options);
    }

    /// Returns information about Oracle Grid Infrastructure (GI) software versions
    /// that are available for a VM cluster for the specified shape.
    pub fn listGiVersions(self: *Self, allocator: std.mem.Allocator, input: list_gi_versions.ListGiVersionsInput, options: list_gi_versions.Options) !list_gi_versions.ListGiVersionsOutput {
        return list_gi_versions.execute(self, allocator, input, options);
    }

    /// Returns information about the ODB networks owned by your Amazon Web Services
    /// account.
    pub fn listOdbNetworks(self: *Self, allocator: std.mem.Allocator, input: list_odb_networks.ListOdbNetworksInput, options: list_odb_networks.Options) !list_odb_networks.ListOdbNetworksOutput {
        return list_odb_networks.execute(self, allocator, input, options);
    }

    /// Lists all ODB peering connections or those associated with a specific ODB
    /// network.
    pub fn listOdbPeeringConnections(self: *Self, allocator: std.mem.Allocator, input: list_odb_peering_connections.ListOdbPeeringConnectionsInput, options: list_odb_peering_connections.Options) !list_odb_peering_connections.ListOdbPeeringConnectionsOutput {
        return list_odb_peering_connections.execute(self, allocator, input, options);
    }

    /// Returns information about the system versions that are available for a VM
    /// cluster for the specified `giVersion` and `shape`.
    pub fn listSystemVersions(self: *Self, allocator: std.mem.Allocator, input: list_system_versions.ListSystemVersionsInput, options: list_system_versions.Options) !list_system_versions.ListSystemVersionsOutput {
        return list_system_versions.execute(self, allocator, input, options);
    }

    /// Returns information about the tags applied to this resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Reboots the specified DB node in a VM cluster.
    pub fn rebootDbNode(self: *Self, allocator: std.mem.Allocator, input: reboot_db_node.RebootDbNodeInput, options: reboot_db_node.Options) !reboot_db_node.RebootDbNodeOutput {
        return reboot_db_node.execute(self, allocator, input, options);
    }

    /// Starts the specified DB node in a VM cluster.
    pub fn startDbNode(self: *Self, allocator: std.mem.Allocator, input: start_db_node.StartDbNodeInput, options: start_db_node.Options) !start_db_node.StartDbNodeOutput {
        return start_db_node.execute(self, allocator, input, options);
    }

    /// Stops the specified DB node in a VM cluster.
    pub fn stopDbNode(self: *Self, allocator: std.mem.Allocator, input: stop_db_node.StopDbNodeInput, options: stop_db_node.Options) !stop_db_node.StopDbNodeOutput {
        return stop_db_node.execute(self, allocator, input, options);
    }

    /// Applies tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the properties of an Exadata infrastructure resource.
    pub fn updateCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: update_cloud_exadata_infrastructure.UpdateCloudExadataInfrastructureInput, options: update_cloud_exadata_infrastructure.Options) !update_cloud_exadata_infrastructure.UpdateCloudExadataInfrastructureOutput {
        return update_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Updates properties of a specified ODB network.
    pub fn updateOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: update_odb_network.UpdateOdbNetworkInput, options: update_odb_network.Options) !update_odb_network.UpdateOdbNetworkOutput {
        return update_odb_network.execute(self, allocator, input, options);
    }

    /// Modifies the settings of an Oracle Database@Amazon Web Services peering
    /// connection. You can update the display name and add or remove CIDR blocks
    /// from the peering connection.
    pub fn updateOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: update_odb_peering_connection.UpdateOdbPeeringConnectionInput, options: update_odb_peering_connection.Options) !update_odb_peering_connection.UpdateOdbPeeringConnectionOutput {
        return update_odb_peering_connection.execute(self, allocator, input, options);
    }

    pub fn listAutonomousVirtualMachinesPaginator(self: *Self, params: list_autonomous_virtual_machines.ListAutonomousVirtualMachinesInput) paginator.ListAutonomousVirtualMachinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudAutonomousVmClustersPaginator(self: *Self, params: list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersInput) paginator.ListCloudAutonomousVmClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudExadataInfrastructuresPaginator(self: *Self, params: list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresInput) paginator.ListCloudExadataInfrastructuresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCloudVmClustersPaginator(self: *Self, params: list_cloud_vm_clusters.ListCloudVmClustersInput) paginator.ListCloudVmClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbNodesPaginator(self: *Self, params: list_db_nodes.ListDbNodesInput) paginator.ListDbNodesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbServersPaginator(self: *Self, params: list_db_servers.ListDbServersInput) paginator.ListDbServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDbSystemShapesPaginator(self: *Self, params: list_db_system_shapes.ListDbSystemShapesInput) paginator.ListDbSystemShapesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listGiVersionsPaginator(self: *Self, params: list_gi_versions.ListGiVersionsInput) paginator.ListGiVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOdbNetworksPaginator(self: *Self, params: list_odb_networks.ListOdbNetworksInput) paginator.ListOdbNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listOdbPeeringConnectionsPaginator(self: *Self, params: list_odb_peering_connections.ListOdbPeeringConnectionsInput) paginator.ListOdbPeeringConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSystemVersionsPaginator(self: *Self, params: list_system_versions.ListSystemVersionsInput) paginator.ListSystemVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
