const aws = @import("aws");
const std = @import("std");

const accept_marketplace_registration = @import("accept_marketplace_registration.zig");
const associate_iam_role_to_resource = @import("associate_iam_role_to_resource.zig");
const associate_virtual_machines_to_exadb_vm_cluster = @import("associate_virtual_machines_to_exadb_vm_cluster.zig");
const create_autonomous_database = @import("create_autonomous_database.zig");
const create_autonomous_database_backup = @import("create_autonomous_database_backup.zig");
const create_autonomous_database_wallet = @import("create_autonomous_database_wallet.zig");
const create_cloud_autonomous_vm_cluster = @import("create_cloud_autonomous_vm_cluster.zig");
const create_cloud_exadata_infrastructure = @import("create_cloud_exadata_infrastructure.zig");
const create_cloud_vm_cluster = @import("create_cloud_vm_cluster.zig");
const create_exadb_vm_cluster = @import("create_exadb_vm_cluster.zig");
const create_exascale_db_storage_vault = @import("create_exascale_db_storage_vault.zig");
const create_odb_network = @import("create_odb_network.zig");
const create_odb_peering_connection = @import("create_odb_peering_connection.zig");
const delete_autonomous_database = @import("delete_autonomous_database.zig");
const delete_autonomous_database_backup = @import("delete_autonomous_database_backup.zig");
const delete_cloud_autonomous_vm_cluster = @import("delete_cloud_autonomous_vm_cluster.zig");
const delete_cloud_exadata_infrastructure = @import("delete_cloud_exadata_infrastructure.zig");
const delete_cloud_vm_cluster = @import("delete_cloud_vm_cluster.zig");
const delete_exadb_vm_cluster = @import("delete_exadb_vm_cluster.zig");
const delete_exascale_db_storage_vault = @import("delete_exascale_db_storage_vault.zig");
const delete_odb_network = @import("delete_odb_network.zig");
const delete_odb_peering_connection = @import("delete_odb_peering_connection.zig");
const disassociate_iam_role_from_resource = @import("disassociate_iam_role_from_resource.zig");
const disassociate_virtual_machines_from_exadb_vm_cluster = @import("disassociate_virtual_machines_from_exadb_vm_cluster.zig");
const failover_autonomous_database = @import("failover_autonomous_database.zig");
const get_autonomous_database = @import("get_autonomous_database.zig");
const get_autonomous_database_backup = @import("get_autonomous_database_backup.zig");
const get_autonomous_database_wallet_details = @import("get_autonomous_database_wallet_details.zig");
const get_cloud_autonomous_vm_cluster = @import("get_cloud_autonomous_vm_cluster.zig");
const get_cloud_exadata_infrastructure = @import("get_cloud_exadata_infrastructure.zig");
const get_cloud_exadata_infrastructure_unallocated_resources = @import("get_cloud_exadata_infrastructure_unallocated_resources.zig");
const get_cloud_vm_cluster = @import("get_cloud_vm_cluster.zig");
const get_db_node = @import("get_db_node.zig");
const get_db_server = @import("get_db_server.zig");
const get_exadb_vm_cluster = @import("get_exadb_vm_cluster.zig");
const get_exascale_db_storage_vault = @import("get_exascale_db_storage_vault.zig");
const get_oci_onboarding_status = @import("get_oci_onboarding_status.zig");
const get_odb_network = @import("get_odb_network.zig");
const get_odb_peering_connection = @import("get_odb_peering_connection.zig");
const initialize_service = @import("initialize_service.zig");
const list_autonomous_database_backups = @import("list_autonomous_database_backups.zig");
const list_autonomous_database_character_sets = @import("list_autonomous_database_character_sets.zig");
const list_autonomous_database_clones = @import("list_autonomous_database_clones.zig");
const list_autonomous_database_peers = @import("list_autonomous_database_peers.zig");
const list_autonomous_database_versions = @import("list_autonomous_database_versions.zig");
const list_autonomous_databases = @import("list_autonomous_databases.zig");
const list_autonomous_virtual_machines = @import("list_autonomous_virtual_machines.zig");
const list_cloud_autonomous_vm_clusters = @import("list_cloud_autonomous_vm_clusters.zig");
const list_cloud_exadata_infrastructures = @import("list_cloud_exadata_infrastructures.zig");
const list_cloud_vm_clusters = @import("list_cloud_vm_clusters.zig");
const list_db_nodes = @import("list_db_nodes.zig");
const list_db_servers = @import("list_db_servers.zig");
const list_db_system_shapes = @import("list_db_system_shapes.zig");
const list_exadb_vm_clusters = @import("list_exadb_vm_clusters.zig");
const list_exascale_db_storage_vaults = @import("list_exascale_db_storage_vaults.zig");
const list_flex_components = @import("list_flex_components.zig");
const list_gi_minor_versions = @import("list_gi_minor_versions.zig");
const list_gi_versions = @import("list_gi_versions.zig");
const list_odb_networks = @import("list_odb_networks.zig");
const list_odb_peering_connections = @import("list_odb_peering_connections.zig");
const list_system_versions = @import("list_system_versions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const reboot_autonomous_database = @import("reboot_autonomous_database.zig");
const reboot_db_node = @import("reboot_db_node.zig");
const restore_autonomous_database = @import("restore_autonomous_database.zig");
const shrink_autonomous_database = @import("shrink_autonomous_database.zig");
const start_autonomous_database = @import("start_autonomous_database.zig");
const start_db_node = @import("start_db_node.zig");
const stop_autonomous_database = @import("stop_autonomous_database.zig");
const stop_db_node = @import("stop_db_node.zig");
const switchover_autonomous_database = @import("switchover_autonomous_database.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_autonomous_database = @import("update_autonomous_database.zig");
const update_autonomous_database_backup = @import("update_autonomous_database_backup.zig");
const update_cloud_exadata_infrastructure = @import("update_cloud_exadata_infrastructure.zig");
const update_exadb_vm_cluster = @import("update_exadb_vm_cluster.zig");
const update_exascale_db_storage_vault = @import("update_exascale_db_storage_vault.zig");
const update_odb_network = @import("update_odb_network.zig");
const update_odb_peering_connection = @import("update_odb_peering_connection.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    options: aws.http.RequestOptions = .{},

    const Self = @This();
    pub const sdk_id = "odb";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .options = options,
        };
    }

    pub fn deinit(self: *Self) void {
        _ = self;
    }

    /// Registers the Amazon Web Services Marketplace token for your Amazon Web
    /// Services account to activate your Oracle Database@Amazon Web Services
    /// subscription.
    pub fn acceptMarketplaceRegistration(self: *Self, allocator: std.mem.Allocator, input: accept_marketplace_registration.AcceptMarketplaceRegistrationInput, options: CallOptions) !accept_marketplace_registration.AcceptMarketplaceRegistrationOutput {
        return accept_marketplace_registration.execute(self, allocator, input, options);
    }

    /// Associates an Amazon Web Services Identity and Access Management (IAM)
    /// service role with a specified resource to enable Amazon Web Services service
    /// integration.
    pub fn associateIamRoleToResource(self: *Self, allocator: std.mem.Allocator, input: associate_iam_role_to_resource.AssociateIamRoleToResourceInput, options: CallOptions) !associate_iam_role_to_resource.AssociateIamRoleToResourceOutput {
        return associate_iam_role_to_resource.execute(self, allocator, input, options);
    }

    /// Adds virtual machines to the specified Exascale VM cluster.
    pub fn associateVirtualMachinesToExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: associate_virtual_machines_to_exadb_vm_cluster.AssociateVirtualMachinesToExadbVmClusterInput, options: CallOptions) !associate_virtual_machines_to_exadb_vm_cluster.AssociateVirtualMachinesToExadbVmClusterOutput {
        return associate_virtual_machines_to_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates a new Autonomous Database.
    pub fn createAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: create_autonomous_database.CreateAutonomousDatabaseInput, options: CallOptions) !create_autonomous_database.CreateAutonomousDatabaseOutput {
        return create_autonomous_database.execute(self, allocator, input, options);
    }

    /// Creates a new backup of the specified Autonomous Database.
    pub fn createAutonomousDatabaseBackup(self: *Self, allocator: std.mem.Allocator, input: create_autonomous_database_backup.CreateAutonomousDatabaseBackupInput, options: CallOptions) !create_autonomous_database_backup.CreateAutonomousDatabaseBackupOutput {
        return create_autonomous_database_backup.execute(self, allocator, input, options);
    }

    /// Creates a new wallet for the specified Autonomous Database.
    pub fn createAutonomousDatabaseWallet(self: *Self, allocator: std.mem.Allocator, input: create_autonomous_database_wallet.CreateAutonomousDatabaseWalletInput, options: CallOptions) !create_autonomous_database_wallet.CreateAutonomousDatabaseWalletOutput {
        return create_autonomous_database_wallet.execute(self, allocator, input, options);
    }

    /// Creates a new Autonomous VM cluster in the specified Exadata infrastructure.
    pub fn createCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: create_cloud_autonomous_vm_cluster.CreateCloudAutonomousVmClusterInput, options: CallOptions) !create_cloud_autonomous_vm_cluster.CreateCloudAutonomousVmClusterOutput {
        return create_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Exadata infrastructure.
    pub fn createCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: create_cloud_exadata_infrastructure.CreateCloudExadataInfrastructureInput, options: CallOptions) !create_cloud_exadata_infrastructure.CreateCloudExadataInfrastructureOutput {
        return create_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Creates a VM cluster on the specified Exadata infrastructure.
    pub fn createCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: create_cloud_vm_cluster.CreateCloudVmClusterInput, options: CallOptions) !create_cloud_vm_cluster.CreateCloudVmClusterOutput {
        return create_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Exascale VM cluster.
    pub fn createExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: create_exadb_vm_cluster.CreateExadbVmClusterInput, options: CallOptions) !create_exadb_vm_cluster.CreateExadbVmClusterOutput {
        return create_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Creates an Exascale storage vault.
    pub fn createExascaleDbStorageVault(self: *Self, allocator: std.mem.Allocator, input: create_exascale_db_storage_vault.CreateExascaleDbStorageVaultInput, options: CallOptions) !create_exascale_db_storage_vault.CreateExascaleDbStorageVaultOutput {
        return create_exascale_db_storage_vault.execute(self, allocator, input, options);
    }

    /// Creates an ODB network.
    pub fn createOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: create_odb_network.CreateOdbNetworkInput, options: CallOptions) !create_odb_network.CreateOdbNetworkOutput {
        return create_odb_network.execute(self, allocator, input, options);
    }

    /// Creates a peering connection between an ODB network and a VPC.
    ///
    /// A peering connection enables private connectivity between the networks for
    /// application-tier communication.
    pub fn createOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: create_odb_peering_connection.CreateOdbPeeringConnectionInput, options: CallOptions) !create_odb_peering_connection.CreateOdbPeeringConnectionOutput {
        return create_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified Autonomous Database.
    pub fn deleteAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_autonomous_database.DeleteAutonomousDatabaseInput, options: CallOptions) !delete_autonomous_database.DeleteAutonomousDatabaseOutput {
        return delete_autonomous_database.execute(self, allocator, input, options);
    }

    /// Deletes the specified Autonomous Database backup.
    pub fn deleteAutonomousDatabaseBackup(self: *Self, allocator: std.mem.Allocator, input: delete_autonomous_database_backup.DeleteAutonomousDatabaseBackupInput, options: CallOptions) !delete_autonomous_database_backup.DeleteAutonomousDatabaseBackupOutput {
        return delete_autonomous_database_backup.execute(self, allocator, input, options);
    }

    /// Deletes an Autonomous VM cluster.
    pub fn deleteCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_autonomous_vm_cluster.DeleteCloudAutonomousVmClusterInput, options: CallOptions) !delete_cloud_autonomous_vm_cluster.DeleteCloudAutonomousVmClusterOutput {
        return delete_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified Exadata infrastructure. Before you use this operation,
    /// make sure to delete all of the VM clusters that are hosted on this Exadata
    /// infrastructure.
    pub fn deleteCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_exadata_infrastructure.DeleteCloudExadataInfrastructureInput, options: CallOptions) !delete_cloud_exadata_infrastructure.DeleteCloudExadataInfrastructureOutput {
        return delete_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Deletes the specified VM cluster.
    pub fn deleteCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: delete_cloud_vm_cluster.DeleteCloudVmClusterInput, options: CallOptions) !delete_cloud_vm_cluster.DeleteCloudVmClusterOutput {
        return delete_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified Exascale VM cluster.
    pub fn deleteExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: delete_exadb_vm_cluster.DeleteExadbVmClusterInput, options: CallOptions) !delete_exadb_vm_cluster.DeleteExadbVmClusterOutput {
        return delete_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Deletes the specified Exascale storage vault.
    pub fn deleteExascaleDbStorageVault(self: *Self, allocator: std.mem.Allocator, input: delete_exascale_db_storage_vault.DeleteExascaleDbStorageVaultInput, options: CallOptions) !delete_exascale_db_storage_vault.DeleteExascaleDbStorageVaultOutput {
        return delete_exascale_db_storage_vault.execute(self, allocator, input, options);
    }

    /// Deletes the specified ODB network.
    pub fn deleteOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_odb_network.DeleteOdbNetworkInput, options: CallOptions) !delete_odb_network.DeleteOdbNetworkOutput {
        return delete_odb_network.execute(self, allocator, input, options);
    }

    /// Deletes an ODB peering connection.
    ///
    /// When you delete an ODB peering connection, the underlying VPC peering
    /// connection is also deleted.
    pub fn deleteOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: delete_odb_peering_connection.DeleteOdbPeeringConnectionInput, options: CallOptions) !delete_odb_peering_connection.DeleteOdbPeeringConnectionOutput {
        return delete_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Disassociates an Amazon Web Services Identity and Access Management (IAM)
    /// service role from a specified resource to disable Amazon Web Services
    /// service integration.
    pub fn disassociateIamRoleFromResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_iam_role_from_resource.DisassociateIamRoleFromResourceInput, options: CallOptions) !disassociate_iam_role_from_resource.DisassociateIamRoleFromResourceOutput {
        return disassociate_iam_role_from_resource.execute(self, allocator, input, options);
    }

    /// Removes virtual machines from the specified Exascale VM cluster.
    pub fn disassociateVirtualMachinesFromExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: disassociate_virtual_machines_from_exadb_vm_cluster.DisassociateVirtualMachinesFromExadbVmClusterInput, options: CallOptions) !disassociate_virtual_machines_from_exadb_vm_cluster.DisassociateVirtualMachinesFromExadbVmClusterOutput {
        return disassociate_virtual_machines_from_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Initiates a failover of the specified Autonomous Database to a standby peer
    /// database.
    pub fn failoverAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: failover_autonomous_database.FailoverAutonomousDatabaseInput, options: CallOptions) !failover_autonomous_database.FailoverAutonomousDatabaseOutput {
        return failover_autonomous_database.execute(self, allocator, input, options);
    }

    /// Gets information about a specific Autonomous Database.
    pub fn getAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: get_autonomous_database.GetAutonomousDatabaseInput, options: CallOptions) !get_autonomous_database.GetAutonomousDatabaseOutput {
        return get_autonomous_database.execute(self, allocator, input, options);
    }

    /// Gets information about a specific Autonomous Database backup.
    pub fn getAutonomousDatabaseBackup(self: *Self, allocator: std.mem.Allocator, input: get_autonomous_database_backup.GetAutonomousDatabaseBackupInput, options: CallOptions) !get_autonomous_database_backup.GetAutonomousDatabaseBackupOutput {
        return get_autonomous_database_backup.execute(self, allocator, input, options);
    }

    /// Gets the wallet details for the specified Autonomous Database.
    pub fn getAutonomousDatabaseWalletDetails(self: *Self, allocator: std.mem.Allocator, input: get_autonomous_database_wallet_details.GetAutonomousDatabaseWalletDetailsInput, options: CallOptions) !get_autonomous_database_wallet_details.GetAutonomousDatabaseWalletDetailsOutput {
        return get_autonomous_database_wallet_details.execute(self, allocator, input, options);
    }

    /// Gets information about a specific Autonomous VM cluster.
    pub fn getCloudAutonomousVmCluster(self: *Self, allocator: std.mem.Allocator, input: get_cloud_autonomous_vm_cluster.GetCloudAutonomousVmClusterInput, options: CallOptions) !get_cloud_autonomous_vm_cluster.GetCloudAutonomousVmClusterOutput {
        return get_cloud_autonomous_vm_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Exadata infrastructure.
    pub fn getCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: get_cloud_exadata_infrastructure.GetCloudExadataInfrastructureInput, options: CallOptions) !get_cloud_exadata_infrastructure.GetCloudExadataInfrastructureOutput {
        return get_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Retrieves information about unallocated resources in a specified Cloud
    /// Exadata Infrastructure.
    pub fn getCloudExadataInfrastructureUnallocatedResources(self: *Self, allocator: std.mem.Allocator, input: get_cloud_exadata_infrastructure_unallocated_resources.GetCloudExadataInfrastructureUnallocatedResourcesInput, options: CallOptions) !get_cloud_exadata_infrastructure_unallocated_resources.GetCloudExadataInfrastructureUnallocatedResourcesOutput {
        return get_cloud_exadata_infrastructure_unallocated_resources.execute(self, allocator, input, options);
    }

    /// Returns information about the specified VM cluster.
    pub fn getCloudVmCluster(self: *Self, allocator: std.mem.Allocator, input: get_cloud_vm_cluster.GetCloudVmClusterInput, options: CallOptions) !get_cloud_vm_cluster.GetCloudVmClusterOutput {
        return get_cloud_vm_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about the specified DB node.
    pub fn getDbNode(self: *Self, allocator: std.mem.Allocator, input: get_db_node.GetDbNodeInput, options: CallOptions) !get_db_node.GetDbNodeOutput {
        return get_db_node.execute(self, allocator, input, options);
    }

    /// Returns information about the specified database server.
    pub fn getDbServer(self: *Self, allocator: std.mem.Allocator, input: get_db_server.GetDbServerInput, options: CallOptions) !get_db_server.GetDbServerOutput {
        return get_db_server.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Exascale VM cluster.
    pub fn getExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: get_exadb_vm_cluster.GetExadbVmClusterInput, options: CallOptions) !get_exadb_vm_cluster.GetExadbVmClusterOutput {
        return get_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Returns information about the specified Exascale storage vault.
    pub fn getExascaleDbStorageVault(self: *Self, allocator: std.mem.Allocator, input: get_exascale_db_storage_vault.GetExascaleDbStorageVaultInput, options: CallOptions) !get_exascale_db_storage_vault.GetExascaleDbStorageVaultOutput {
        return get_exascale_db_storage_vault.execute(self, allocator, input, options);
    }

    /// Returns the tenancy activation link and onboarding status for your Amazon
    /// Web Services account.
    pub fn getOciOnboardingStatus(self: *Self, allocator: std.mem.Allocator, input: get_oci_onboarding_status.GetOciOnboardingStatusInput, options: CallOptions) !get_oci_onboarding_status.GetOciOnboardingStatusOutput {
        return get_oci_onboarding_status.execute(self, allocator, input, options);
    }

    /// Returns information about the specified ODB network.
    pub fn getOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: get_odb_network.GetOdbNetworkInput, options: CallOptions) !get_odb_network.GetOdbNetworkOutput {
        return get_odb_network.execute(self, allocator, input, options);
    }

    /// Retrieves information about an ODB peering connection.
    pub fn getOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: get_odb_peering_connection.GetOdbPeeringConnectionInput, options: CallOptions) !get_odb_peering_connection.GetOdbPeeringConnectionOutput {
        return get_odb_peering_connection.execute(self, allocator, input, options);
    }

    /// Initializes the ODB service for the first time in an account.
    pub fn initializeService(self: *Self, allocator: std.mem.Allocator, input: initialize_service.InitializeServiceInput, options: CallOptions) !initialize_service.InitializeServiceOutput {
        return initialize_service.execute(self, allocator, input, options);
    }

    /// Lists the backups of the specified Autonomous Database.
    pub fn listAutonomousDatabaseBackups(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_database_backups.ListAutonomousDatabaseBackupsInput, options: CallOptions) !list_autonomous_database_backups.ListAutonomousDatabaseBackupsOutput {
        return list_autonomous_database_backups.execute(self, allocator, input, options);
    }

    /// Lists the available character sets for Autonomous Databases.
    pub fn listAutonomousDatabaseCharacterSets(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_database_character_sets.ListAutonomousDatabaseCharacterSetsInput, options: CallOptions) !list_autonomous_database_character_sets.ListAutonomousDatabaseCharacterSetsOutput {
        return list_autonomous_database_character_sets.execute(self, allocator, input, options);
    }

    /// Lists the clones of the specified Autonomous Database.
    pub fn listAutonomousDatabaseClones(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_database_clones.ListAutonomousDatabaseClonesInput, options: CallOptions) !list_autonomous_database_clones.ListAutonomousDatabaseClonesOutput {
        return list_autonomous_database_clones.execute(self, allocator, input, options);
    }

    /// Lists the peer databases of the specified Autonomous Database.
    pub fn listAutonomousDatabasePeers(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_database_peers.ListAutonomousDatabasePeersInput, options: CallOptions) !list_autonomous_database_peers.ListAutonomousDatabasePeersOutput {
        return list_autonomous_database_peers.execute(self, allocator, input, options);
    }

    /// Lists the available Oracle Database software versions for Autonomous
    /// Databases.
    pub fn listAutonomousDatabaseVersions(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_database_versions.ListAutonomousDatabaseVersionsInput, options: CallOptions) !list_autonomous_database_versions.ListAutonomousDatabaseVersionsOutput {
        return list_autonomous_database_versions.execute(self, allocator, input, options);
    }

    /// Returns information about the Autonomous Databases owned by your Amazon Web
    /// Services account in the current Amazon Web Services Region.
    pub fn listAutonomousDatabases(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_databases.ListAutonomousDatabasesInput, options: CallOptions) !list_autonomous_databases.ListAutonomousDatabasesOutput {
        return list_autonomous_databases.execute(self, allocator, input, options);
    }

    /// Lists all Autonomous VMs in an Autonomous VM cluster.
    pub fn listAutonomousVirtualMachines(self: *Self, allocator: std.mem.Allocator, input: list_autonomous_virtual_machines.ListAutonomousVirtualMachinesInput, options: CallOptions) !list_autonomous_virtual_machines.ListAutonomousVirtualMachinesOutput {
        return list_autonomous_virtual_machines.execute(self, allocator, input, options);
    }

    /// Lists all Autonomous VM clusters in a specified Cloud Exadata
    /// infrastructure.
    pub fn listCloudAutonomousVmClusters(self: *Self, allocator: std.mem.Allocator, input: list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersInput, options: CallOptions) !list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersOutput {
        return list_cloud_autonomous_vm_clusters.execute(self, allocator, input, options);
    }

    /// Returns information about the Exadata infrastructures owned by your Amazon
    /// Web Services account.
    pub fn listCloudExadataInfrastructures(self: *Self, allocator: std.mem.Allocator, input: list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresInput, options: CallOptions) !list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresOutput {
        return list_cloud_exadata_infrastructures.execute(self, allocator, input, options);
    }

    /// Returns information about the VM clusters owned by your Amazon Web Services
    /// account or only the ones on the specified Exadata infrastructure.
    pub fn listCloudVmClusters(self: *Self, allocator: std.mem.Allocator, input: list_cloud_vm_clusters.ListCloudVmClustersInput, options: CallOptions) !list_cloud_vm_clusters.ListCloudVmClustersOutput {
        return list_cloud_vm_clusters.execute(self, allocator, input, options);
    }

    /// Returns information about the DB nodes for the specified VM cluster.
    pub fn listDbNodes(self: *Self, allocator: std.mem.Allocator, input: list_db_nodes.ListDbNodesInput, options: CallOptions) !list_db_nodes.ListDbNodesOutput {
        return list_db_nodes.execute(self, allocator, input, options);
    }

    /// Returns information about the database servers that belong to the specified
    /// Exadata infrastructure.
    pub fn listDbServers(self: *Self, allocator: std.mem.Allocator, input: list_db_servers.ListDbServersInput, options: CallOptions) !list_db_servers.ListDbServersOutput {
        return list_db_servers.execute(self, allocator, input, options);
    }

    /// Returns information about the shapes that are available for an Exadata
    /// infrastructure.
    pub fn listDbSystemShapes(self: *Self, allocator: std.mem.Allocator, input: list_db_system_shapes.ListDbSystemShapesInput, options: CallOptions) !list_db_system_shapes.ListDbSystemShapesOutput {
        return list_db_system_shapes.execute(self, allocator, input, options);
    }

    /// Returns information about the Exascale VM clusters owned by your Amazon Web
    /// Services account.
    pub fn listExadbVmClusters(self: *Self, allocator: std.mem.Allocator, input: list_exadb_vm_clusters.ListExadbVmClustersInput, options: CallOptions) !list_exadb_vm_clusters.ListExadbVmClustersOutput {
        return list_exadb_vm_clusters.execute(self, allocator, input, options);
    }

    /// Returns information about the Exascale storage vaults owned by your Amazon
    /// Web Services account.
    pub fn listExascaleDbStorageVaults(self: *Self, allocator: std.mem.Allocator, input: list_exascale_db_storage_vaults.ListExascaleDbStorageVaultsInput, options: CallOptions) !list_exascale_db_storage_vaults.ListExascaleDbStorageVaultsOutput {
        return list_exascale_db_storage_vaults.execute(self, allocator, input, options);
    }

    /// Returns information about the flex components that are available for an
    /// Exadata infrastructure.
    pub fn listFlexComponents(self: *Self, allocator: std.mem.Allocator, input: list_flex_components.ListFlexComponentsInput, options: CallOptions) !list_flex_components.ListFlexComponentsOutput {
        return list_flex_components.execute(self, allocator, input, options);
    }

    /// Returns a list of the Oracle Grid Infrastructure (GI) minor versions for the
    /// specified major version.
    pub fn listGiMinorVersions(self: *Self, allocator: std.mem.Allocator, input: list_gi_minor_versions.ListGiMinorVersionsInput, options: CallOptions) !list_gi_minor_versions.ListGiMinorVersionsOutput {
        return list_gi_minor_versions.execute(self, allocator, input, options);
    }

    /// Returns information about Oracle Grid Infrastructure (GI) software versions
    /// that are available for a VM cluster for the specified shape.
    pub fn listGiVersions(self: *Self, allocator: std.mem.Allocator, input: list_gi_versions.ListGiVersionsInput, options: CallOptions) !list_gi_versions.ListGiVersionsOutput {
        return list_gi_versions.execute(self, allocator, input, options);
    }

    /// Returns information about the ODB networks owned by your Amazon Web Services
    /// account.
    pub fn listOdbNetworks(self: *Self, allocator: std.mem.Allocator, input: list_odb_networks.ListOdbNetworksInput, options: CallOptions) !list_odb_networks.ListOdbNetworksOutput {
        return list_odb_networks.execute(self, allocator, input, options);
    }

    /// Lists all ODB peering connections or those associated with a specific ODB
    /// network.
    pub fn listOdbPeeringConnections(self: *Self, allocator: std.mem.Allocator, input: list_odb_peering_connections.ListOdbPeeringConnectionsInput, options: CallOptions) !list_odb_peering_connections.ListOdbPeeringConnectionsOutput {
        return list_odb_peering_connections.execute(self, allocator, input, options);
    }

    /// Returns information about the system versions that are available for a VM
    /// cluster for the specified `giVersion` and `shape`.
    pub fn listSystemVersions(self: *Self, allocator: std.mem.Allocator, input: list_system_versions.ListSystemVersionsInput, options: CallOptions) !list_system_versions.ListSystemVersionsOutput {
        return list_system_versions.execute(self, allocator, input, options);
    }

    /// Returns information about the tags applied to this resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Reboots the specified Autonomous Database.
    pub fn rebootAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: reboot_autonomous_database.RebootAutonomousDatabaseInput, options: CallOptions) !reboot_autonomous_database.RebootAutonomousDatabaseOutput {
        return reboot_autonomous_database.execute(self, allocator, input, options);
    }

    /// Reboots the specified DB node in a VM cluster.
    pub fn rebootDbNode(self: *Self, allocator: std.mem.Allocator, input: reboot_db_node.RebootDbNodeInput, options: CallOptions) !reboot_db_node.RebootDbNodeOutput {
        return reboot_db_node.execute(self, allocator, input, options);
    }

    /// Restores the specified Autonomous Database to a point in time.
    pub fn restoreAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: restore_autonomous_database.RestoreAutonomousDatabaseInput, options: CallOptions) !restore_autonomous_database.RestoreAutonomousDatabaseOutput {
        return restore_autonomous_database.execute(self, allocator, input, options);
    }

    /// Shrinks the storage of the specified Autonomous Database to reclaim unused
    /// space.
    pub fn shrinkAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: shrink_autonomous_database.ShrinkAutonomousDatabaseInput, options: CallOptions) !shrink_autonomous_database.ShrinkAutonomousDatabaseOutput {
        return shrink_autonomous_database.execute(self, allocator, input, options);
    }

    /// Starts the specified Autonomous Database.
    pub fn startAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: start_autonomous_database.StartAutonomousDatabaseInput, options: CallOptions) !start_autonomous_database.StartAutonomousDatabaseOutput {
        return start_autonomous_database.execute(self, allocator, input, options);
    }

    /// Starts the specified DB node in a VM cluster.
    pub fn startDbNode(self: *Self, allocator: std.mem.Allocator, input: start_db_node.StartDbNodeInput, options: CallOptions) !start_db_node.StartDbNodeOutput {
        return start_db_node.execute(self, allocator, input, options);
    }

    /// Stops the specified Autonomous Database.
    pub fn stopAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: stop_autonomous_database.StopAutonomousDatabaseInput, options: CallOptions) !stop_autonomous_database.StopAutonomousDatabaseOutput {
        return stop_autonomous_database.execute(self, allocator, input, options);
    }

    /// Stops the specified DB node in a VM cluster.
    pub fn stopDbNode(self: *Self, allocator: std.mem.Allocator, input: stop_db_node.StopDbNodeInput, options: CallOptions) !stop_db_node.StopDbNodeOutput {
        return stop_db_node.execute(self, allocator, input, options);
    }

    /// Performs a switchover of the specified Autonomous Database to a standby peer
    /// database.
    pub fn switchoverAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: switchover_autonomous_database.SwitchoverAutonomousDatabaseInput, options: CallOptions) !switchover_autonomous_database.SwitchoverAutonomousDatabaseOutput {
        return switchover_autonomous_database.execute(self, allocator, input, options);
    }

    /// Applies tags to the specified resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the specified resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the properties of an Autonomous Database.
    pub fn updateAutonomousDatabase(self: *Self, allocator: std.mem.Allocator, input: update_autonomous_database.UpdateAutonomousDatabaseInput, options: CallOptions) !update_autonomous_database.UpdateAutonomousDatabaseOutput {
        return update_autonomous_database.execute(self, allocator, input, options);
    }

    /// Updates the properties of an Autonomous Database backup.
    pub fn updateAutonomousDatabaseBackup(self: *Self, allocator: std.mem.Allocator, input: update_autonomous_database_backup.UpdateAutonomousDatabaseBackupInput, options: CallOptions) !update_autonomous_database_backup.UpdateAutonomousDatabaseBackupOutput {
        return update_autonomous_database_backup.execute(self, allocator, input, options);
    }

    /// Updates the properties of an Exadata infrastructure resource.
    pub fn updateCloudExadataInfrastructure(self: *Self, allocator: std.mem.Allocator, input: update_cloud_exadata_infrastructure.UpdateCloudExadataInfrastructureInput, options: CallOptions) !update_cloud_exadata_infrastructure.UpdateCloudExadataInfrastructureOutput {
        return update_cloud_exadata_infrastructure.execute(self, allocator, input, options);
    }

    /// Updates the specified Exascale VM cluster.
    pub fn updateExadbVmCluster(self: *Self, allocator: std.mem.Allocator, input: update_exadb_vm_cluster.UpdateExadbVmClusterInput, options: CallOptions) !update_exadb_vm_cluster.UpdateExadbVmClusterOutput {
        return update_exadb_vm_cluster.execute(self, allocator, input, options);
    }

    /// Updates the specified Exascale storage vault.
    pub fn updateExascaleDbStorageVault(self: *Self, allocator: std.mem.Allocator, input: update_exascale_db_storage_vault.UpdateExascaleDbStorageVaultInput, options: CallOptions) !update_exascale_db_storage_vault.UpdateExascaleDbStorageVaultOutput {
        return update_exascale_db_storage_vault.execute(self, allocator, input, options);
    }

    /// Updates properties of a specified ODB network.
    pub fn updateOdbNetwork(self: *Self, allocator: std.mem.Allocator, input: update_odb_network.UpdateOdbNetworkInput, options: CallOptions) !update_odb_network.UpdateOdbNetworkOutput {
        return update_odb_network.execute(self, allocator, input, options);
    }

    /// Modifies the settings of an Oracle Database@Amazon Web Services peering
    /// connection. You can update the display name and add or remove CIDR blocks
    /// from the peering connection.
    pub fn updateOdbPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: update_odb_peering_connection.UpdateOdbPeeringConnectionInput, options: CallOptions) !update_odb_peering_connection.UpdateOdbPeeringConnectionOutput {
        return update_odb_peering_connection.execute(self, allocator, input, options);
    }

    pub fn listAutonomousDatabaseBackupsPaginator(self: *Self, params: list_autonomous_database_backups.ListAutonomousDatabaseBackupsInput) paginator.ListAutonomousDatabaseBackupsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousDatabaseCharacterSetsPaginator(self: *Self, params: list_autonomous_database_character_sets.ListAutonomousDatabaseCharacterSetsInput) paginator.ListAutonomousDatabaseCharacterSetsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousDatabaseClonesPaginator(self: *Self, params: list_autonomous_database_clones.ListAutonomousDatabaseClonesInput) paginator.ListAutonomousDatabaseClonesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousDatabasePeersPaginator(self: *Self, params: list_autonomous_database_peers.ListAutonomousDatabasePeersInput) paginator.ListAutonomousDatabasePeersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousDatabaseVersionsPaginator(self: *Self, params: list_autonomous_database_versions.ListAutonomousDatabaseVersionsInput) paginator.ListAutonomousDatabaseVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousDatabasesPaginator(self: *Self, params: list_autonomous_databases.ListAutonomousDatabasesInput) paginator.ListAutonomousDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listAutonomousVirtualMachinesPaginator(self: *Self, params: list_autonomous_virtual_machines.ListAutonomousVirtualMachinesInput) paginator.ListAutonomousVirtualMachinesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCloudAutonomousVmClustersPaginator(self: *Self, params: list_cloud_autonomous_vm_clusters.ListCloudAutonomousVmClustersInput) paginator.ListCloudAutonomousVmClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCloudExadataInfrastructuresPaginator(self: *Self, params: list_cloud_exadata_infrastructures.ListCloudExadataInfrastructuresInput) paginator.ListCloudExadataInfrastructuresPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listCloudVmClustersPaginator(self: *Self, params: list_cloud_vm_clusters.ListCloudVmClustersInput) paginator.ListCloudVmClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDbNodesPaginator(self: *Self, params: list_db_nodes.ListDbNodesInput) paginator.ListDbNodesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDbServersPaginator(self: *Self, params: list_db_servers.ListDbServersInput) paginator.ListDbServersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDbSystemShapesPaginator(self: *Self, params: list_db_system_shapes.ListDbSystemShapesInput) paginator.ListDbSystemShapesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExadbVmClustersPaginator(self: *Self, params: list_exadb_vm_clusters.ListExadbVmClustersInput) paginator.ListExadbVmClustersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExascaleDbStorageVaultsPaginator(self: *Self, params: list_exascale_db_storage_vaults.ListExascaleDbStorageVaultsInput) paginator.ListExascaleDbStorageVaultsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listFlexComponentsPaginator(self: *Self, params: list_flex_components.ListFlexComponentsInput) paginator.ListFlexComponentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGiMinorVersionsPaginator(self: *Self, params: list_gi_minor_versions.ListGiMinorVersionsInput) paginator.ListGiMinorVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listGiVersionsPaginator(self: *Self, params: list_gi_versions.ListGiVersionsInput) paginator.ListGiVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOdbNetworksPaginator(self: *Self, params: list_odb_networks.ListOdbNetworksInput) paginator.ListOdbNetworksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listOdbPeeringConnectionsPaginator(self: *Self, params: list_odb_peering_connections.ListOdbPeeringConnectionsInput) paginator.ListOdbPeeringConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSystemVersionsPaginator(self: *Self, params: list_system_versions.ListSystemVersionsInput) paginator.ListSystemVersionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
