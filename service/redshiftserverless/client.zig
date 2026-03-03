const aws = @import("aws");
const std = @import("std");

const convert_recovery_point_to_snapshot = @import("convert_recovery_point_to_snapshot.zig");
const create_custom_domain_association = @import("create_custom_domain_association.zig");
const create_endpoint_access = @import("create_endpoint_access.zig");
const create_namespace = @import("create_namespace.zig");
const create_reservation = @import("create_reservation.zig");
const create_scheduled_action = @import("create_scheduled_action.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_snapshot_copy_configuration = @import("create_snapshot_copy_configuration.zig");
const create_usage_limit = @import("create_usage_limit.zig");
const create_workgroup = @import("create_workgroup.zig");
const delete_custom_domain_association = @import("delete_custom_domain_association.zig");
const delete_endpoint_access = @import("delete_endpoint_access.zig");
const delete_namespace = @import("delete_namespace.zig");
const delete_resource_policy = @import("delete_resource_policy.zig");
const delete_scheduled_action = @import("delete_scheduled_action.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_snapshot_copy_configuration = @import("delete_snapshot_copy_configuration.zig");
const delete_usage_limit = @import("delete_usage_limit.zig");
const delete_workgroup = @import("delete_workgroup.zig");
const get_credentials = @import("get_credentials.zig");
const get_custom_domain_association = @import("get_custom_domain_association.zig");
const get_endpoint_access = @import("get_endpoint_access.zig");
const get_identity_center_auth_token = @import("get_identity_center_auth_token.zig");
const get_namespace = @import("get_namespace.zig");
const get_recovery_point = @import("get_recovery_point.zig");
const get_reservation = @import("get_reservation.zig");
const get_reservation_offering = @import("get_reservation_offering.zig");
const get_resource_policy = @import("get_resource_policy.zig");
const get_scheduled_action = @import("get_scheduled_action.zig");
const get_snapshot = @import("get_snapshot.zig");
const get_table_restore_status = @import("get_table_restore_status.zig");
const get_track = @import("get_track.zig");
const get_usage_limit = @import("get_usage_limit.zig");
const get_workgroup = @import("get_workgroup.zig");
const list_custom_domain_associations = @import("list_custom_domain_associations.zig");
const list_endpoint_access = @import("list_endpoint_access.zig");
const list_managed_workgroups = @import("list_managed_workgroups.zig");
const list_namespaces = @import("list_namespaces.zig");
const list_recovery_points = @import("list_recovery_points.zig");
const list_reservation_offerings = @import("list_reservation_offerings.zig");
const list_reservations = @import("list_reservations.zig");
const list_scheduled_actions = @import("list_scheduled_actions.zig");
const list_snapshot_copy_configurations = @import("list_snapshot_copy_configurations.zig");
const list_snapshots = @import("list_snapshots.zig");
const list_table_restore_status = @import("list_table_restore_status.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tracks = @import("list_tracks.zig");
const list_usage_limits = @import("list_usage_limits.zig");
const list_workgroups = @import("list_workgroups.zig");
const put_resource_policy = @import("put_resource_policy.zig");
const restore_from_recovery_point = @import("restore_from_recovery_point.zig");
const restore_from_snapshot = @import("restore_from_snapshot.zig");
const restore_table_from_recovery_point = @import("restore_table_from_recovery_point.zig");
const restore_table_from_snapshot = @import("restore_table_from_snapshot.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_custom_domain_association = @import("update_custom_domain_association.zig");
const update_endpoint_access = @import("update_endpoint_access.zig");
const update_lakehouse_configuration = @import("update_lakehouse_configuration.zig");
const update_namespace = @import("update_namespace.zig");
const update_scheduled_action = @import("update_scheduled_action.zig");
const update_snapshot = @import("update_snapshot.zig");
const update_snapshot_copy_configuration = @import("update_snapshot_copy_configuration.zig");
const update_usage_limit = @import("update_usage_limit.zig");
const update_workgroup = @import("update_workgroup.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Redshift Serverless";

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

    /// Converts a recovery point to a snapshot. For more information about recovery
    /// points and snapshots, see [Working with snapshots and recovery
    /// points](https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-snapshots-recovery-points.html).
    pub fn convertRecoveryPointToSnapshot(self: *Self, allocator: std.mem.Allocator, input: convert_recovery_point_to_snapshot.ConvertRecoveryPointToSnapshotInput, options: CallOptions) !convert_recovery_point_to_snapshot.ConvertRecoveryPointToSnapshotOutput {
        return convert_recovery_point_to_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a custom domain association for Amazon Redshift Serverless.
    pub fn createCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: create_custom_domain_association.CreateCustomDomainAssociationInput, options: CallOptions) !create_custom_domain_association.CreateCustomDomainAssociationOutput {
        return create_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Redshift Serverless managed VPC endpoint.
    pub fn createEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: create_endpoint_access.CreateEndpointAccessInput, options: CallOptions) !create_endpoint_access.CreateEndpointAccessOutput {
        return create_endpoint_access.execute(self, allocator, input, options);
    }

    /// Creates a namespace in Amazon Redshift Serverless.
    pub fn createNamespace(self: *Self, allocator: std.mem.Allocator, input: create_namespace.CreateNamespaceInput, options: CallOptions) !create_namespace.CreateNamespaceOutput {
        return create_namespace.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Redshift Serverless reservation, which gives you the
    /// option to commit to a specified number of Redshift Processing Units (RPUs)
    /// for a year at a discount from Serverless on-demand (OD) rates.
    pub fn createReservation(self: *Self, allocator: std.mem.Allocator, input: create_reservation.CreateReservationInput, options: CallOptions) !create_reservation.CreateReservationOutput {
        return create_reservation.execute(self, allocator, input, options);
    }

    /// Creates a scheduled action. A scheduled action contains a schedule and an
    /// Amazon Redshift API action. For example, you can create a schedule of when
    /// to run the `CreateSnapshot` API operation.
    pub fn createScheduledAction(self: *Self, allocator: std.mem.Allocator, input: create_scheduled_action.CreateScheduledActionInput, options: CallOptions) !create_scheduled_action.CreateScheduledActionOutput {
        return create_scheduled_action.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of all databases in a namespace. For more information
    /// about snapshots, see [ Working with snapshots and recovery
    /// points](https://docs.aws.amazon.com/redshift/latest/mgmt/serverless-snapshots-recovery-points.html).
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a snapshot copy configuration that lets you copy snapshots to
    /// another Amazon Web Services Region.
    pub fn createSnapshotCopyConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_snapshot_copy_configuration.CreateSnapshotCopyConfigurationInput, options: CallOptions) !create_snapshot_copy_configuration.CreateSnapshotCopyConfigurationOutput {
        return create_snapshot_copy_configuration.execute(self, allocator, input, options);
    }

    /// Creates a usage limit for a specified Amazon Redshift Serverless usage type.
    /// The usage limit is identified by the returned usage limit identifier.
    pub fn createUsageLimit(self: *Self, allocator: std.mem.Allocator, input: create_usage_limit.CreateUsageLimitInput, options: CallOptions) !create_usage_limit.CreateUsageLimitOutput {
        return create_usage_limit.execute(self, allocator, input, options);
    }

    /// Creates an workgroup in Amazon Redshift Serverless.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that you own in a Region from reaching or being reached from the
    /// internet through internet gateways and egress-only internet gateways. If a
    /// workgroup is in an account with VPC BPA turned on, the following
    /// capabilities are blocked:
    ///
    /// * Creating a public access workgroup
    /// * Modifying a private workgroup to public
    /// * Adding a subnet with VPC BPA turned on to the workgroup when the workgroup
    ///   is public
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn createWorkgroup(self: *Self, allocator: std.mem.Allocator, input: create_workgroup.CreateWorkgroupInput, options: CallOptions) !create_workgroup.CreateWorkgroupOutput {
        return create_workgroup.execute(self, allocator, input, options);
    }

    /// Deletes a custom domain association for Amazon Redshift Serverless.
    pub fn deleteCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_custom_domain_association.DeleteCustomDomainAssociationInput, options: CallOptions) !delete_custom_domain_association.DeleteCustomDomainAssociationOutput {
        return delete_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Redshift Serverless managed VPC endpoint.
    pub fn deleteEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: delete_endpoint_access.DeleteEndpointAccessInput, options: CallOptions) !delete_endpoint_access.DeleteEndpointAccessOutput {
        return delete_endpoint_access.execute(self, allocator, input, options);
    }

    /// Deletes a namespace from Amazon Redshift Serverless. Before you delete the
    /// namespace, you can create a final snapshot that has all of the data within
    /// the namespace.
    pub fn deleteNamespace(self: *Self, allocator: std.mem.Allocator, input: delete_namespace.DeleteNamespaceInput, options: CallOptions) !delete_namespace.DeleteNamespaceOutput {
        return delete_namespace.execute(self, allocator, input, options);
    }

    /// Deletes the specified resource policy.
    pub fn deleteResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: delete_resource_policy.DeleteResourcePolicyInput, options: CallOptions) !delete_resource_policy.DeleteResourcePolicyOutput {
        return delete_resource_policy.execute(self, allocator, input, options);
    }

    /// Deletes a scheduled action.
    pub fn deleteScheduledAction(self: *Self, allocator: std.mem.Allocator, input: delete_scheduled_action.DeleteScheduledActionInput, options: CallOptions) !delete_scheduled_action.DeleteScheduledActionOutput {
        return delete_scheduled_action.execute(self, allocator, input, options);
    }

    /// Deletes a snapshot from Amazon Redshift Serverless.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: CallOptions) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes a snapshot copy configuration
    pub fn deleteSnapshotCopyConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot_copy_configuration.DeleteSnapshotCopyConfigurationInput, options: CallOptions) !delete_snapshot_copy_configuration.DeleteSnapshotCopyConfigurationOutput {
        return delete_snapshot_copy_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a usage limit from Amazon Redshift Serverless.
    pub fn deleteUsageLimit(self: *Self, allocator: std.mem.Allocator, input: delete_usage_limit.DeleteUsageLimitInput, options: CallOptions) !delete_usage_limit.DeleteUsageLimitOutput {
        return delete_usage_limit.execute(self, allocator, input, options);
    }

    /// Deletes a workgroup.
    pub fn deleteWorkgroup(self: *Self, allocator: std.mem.Allocator, input: delete_workgroup.DeleteWorkgroupInput, options: CallOptions) !delete_workgroup.DeleteWorkgroupOutput {
        return delete_workgroup.execute(self, allocator, input, options);
    }

    /// Returns a database user name and temporary password with temporary
    /// authorization to log in to Amazon Redshift Serverless.
    ///
    /// By default, the temporary credentials expire in 900 seconds. You can
    /// optionally specify a duration between 900 seconds (15 minutes) and 3600
    /// seconds (60 minutes).
    ///
    /// The Identity and Access Management (IAM) user or role that runs
    /// GetCredentials must have an IAM policy attached that allows access to all
    /// necessary actions and resources.
    ///
    /// If the `DbName` parameter is specified, the IAM policy must allow access to
    /// the resource dbname for the specified database name.
    pub fn getCredentials(self: *Self, allocator: std.mem.Allocator, input: get_credentials.GetCredentialsInput, options: CallOptions) !get_credentials.GetCredentialsOutput {
        return get_credentials.execute(self, allocator, input, options);
    }

    /// Gets information about a specific custom domain association.
    pub fn getCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: get_custom_domain_association.GetCustomDomainAssociationInput, options: CallOptions) !get_custom_domain_association.GetCustomDomainAssociationOutput {
        return get_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Returns information, such as the name, about a VPC endpoint.
    pub fn getEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: get_endpoint_access.GetEndpointAccessInput, options: CallOptions) !get_endpoint_access.GetEndpointAccessOutput {
        return get_endpoint_access.execute(self, allocator, input, options);
    }

    /// Returns an Identity Center authentication token for accessing Amazon
    /// Redshift Serverless workgroups.
    ///
    /// The token provides secure access to data within the specified workgroups
    /// using Identity Center identity propagation. The token expires after a
    /// specified duration and must be refreshed for continued access.
    ///
    /// The Identity and Access Management (IAM) user or role that runs
    /// GetIdentityCenterAuthToken must have appropriate permissions to access the
    /// specified workgroups and Identity Center integration must be configured for
    /// the workgroups.
    pub fn getIdentityCenterAuthToken(self: *Self, allocator: std.mem.Allocator, input: get_identity_center_auth_token.GetIdentityCenterAuthTokenInput, options: CallOptions) !get_identity_center_auth_token.GetIdentityCenterAuthTokenOutput {
        return get_identity_center_auth_token.execute(self, allocator, input, options);
    }

    /// Returns information about a namespace in Amazon Redshift Serverless.
    pub fn getNamespace(self: *Self, allocator: std.mem.Allocator, input: get_namespace.GetNamespaceInput, options: CallOptions) !get_namespace.GetNamespaceOutput {
        return get_namespace.execute(self, allocator, input, options);
    }

    /// Returns information about a recovery point.
    pub fn getRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: get_recovery_point.GetRecoveryPointInput, options: CallOptions) !get_recovery_point.GetRecoveryPointOutput {
        return get_recovery_point.execute(self, allocator, input, options);
    }

    /// Gets an Amazon Redshift Serverless reservation. A reservation gives you the
    /// option to commit to a specified number of Redshift Processing Units (RPUs)
    /// for a year at a discount from Serverless on-demand (OD) rates.
    pub fn getReservation(self: *Self, allocator: std.mem.Allocator, input: get_reservation.GetReservationInput, options: CallOptions) !get_reservation.GetReservationOutput {
        return get_reservation.execute(self, allocator, input, options);
    }

    /// Returns the reservation offering. The offering determines the payment
    /// schedule for the reservation.
    pub fn getReservationOffering(self: *Self, allocator: std.mem.Allocator, input: get_reservation_offering.GetReservationOfferingInput, options: CallOptions) !get_reservation_offering.GetReservationOfferingOutput {
        return get_reservation_offering.execute(self, allocator, input, options);
    }

    /// Returns a resource policy.
    pub fn getResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: get_resource_policy.GetResourcePolicyInput, options: CallOptions) !get_resource_policy.GetResourcePolicyOutput {
        return get_resource_policy.execute(self, allocator, input, options);
    }

    /// Returns information about a scheduled action.
    pub fn getScheduledAction(self: *Self, allocator: std.mem.Allocator, input: get_scheduled_action.GetScheduledActionInput, options: CallOptions) !get_scheduled_action.GetScheduledActionOutput {
        return get_scheduled_action.execute(self, allocator, input, options);
    }

    /// Returns information about a specific snapshot.
    pub fn getSnapshot(self: *Self, allocator: std.mem.Allocator, input: get_snapshot.GetSnapshotInput, options: CallOptions) !get_snapshot.GetSnapshotOutput {
        return get_snapshot.execute(self, allocator, input, options);
    }

    /// Returns information about a `TableRestoreStatus` object.
    pub fn getTableRestoreStatus(self: *Self, allocator: std.mem.Allocator, input: get_table_restore_status.GetTableRestoreStatusInput, options: CallOptions) !get_table_restore_status.GetTableRestoreStatusOutput {
        return get_table_restore_status.execute(self, allocator, input, options);
    }

    /// Get the Redshift Serverless version for a specified track.
    pub fn getTrack(self: *Self, allocator: std.mem.Allocator, input: get_track.GetTrackInput, options: CallOptions) !get_track.GetTrackOutput {
        return get_track.execute(self, allocator, input, options);
    }

    /// Returns information about a usage limit.
    pub fn getUsageLimit(self: *Self, allocator: std.mem.Allocator, input: get_usage_limit.GetUsageLimitInput, options: CallOptions) !get_usage_limit.GetUsageLimitOutput {
        return get_usage_limit.execute(self, allocator, input, options);
    }

    /// Returns information about a specific workgroup.
    pub fn getWorkgroup(self: *Self, allocator: std.mem.Allocator, input: get_workgroup.GetWorkgroupInput, options: CallOptions) !get_workgroup.GetWorkgroupOutput {
        return get_workgroup.execute(self, allocator, input, options);
    }

    /// Lists custom domain associations for Amazon Redshift Serverless.
    pub fn listCustomDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: list_custom_domain_associations.ListCustomDomainAssociationsInput, options: CallOptions) !list_custom_domain_associations.ListCustomDomainAssociationsOutput {
        return list_custom_domain_associations.execute(self, allocator, input, options);
    }

    /// Returns an array of `EndpointAccess` objects and relevant information.
    pub fn listEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: list_endpoint_access.ListEndpointAccessInput, options: CallOptions) !list_endpoint_access.ListEndpointAccessOutput {
        return list_endpoint_access.execute(self, allocator, input, options);
    }

    /// Returns information about a list of specified managed workgroups in your
    /// account.
    pub fn listManagedWorkgroups(self: *Self, allocator: std.mem.Allocator, input: list_managed_workgroups.ListManagedWorkgroupsInput, options: CallOptions) !list_managed_workgroups.ListManagedWorkgroupsOutput {
        return list_managed_workgroups.execute(self, allocator, input, options);
    }

    /// Returns information about a list of specified namespaces.
    pub fn listNamespaces(self: *Self, allocator: std.mem.Allocator, input: list_namespaces.ListNamespacesInput, options: CallOptions) !list_namespaces.ListNamespacesOutput {
        return list_namespaces.execute(self, allocator, input, options);
    }

    /// Returns an array of recovery points.
    pub fn listRecoveryPoints(self: *Self, allocator: std.mem.Allocator, input: list_recovery_points.ListRecoveryPointsInput, options: CallOptions) !list_recovery_points.ListRecoveryPointsOutput {
        return list_recovery_points.execute(self, allocator, input, options);
    }

    /// Returns the current reservation offerings in your account.
    pub fn listReservationOfferings(self: *Self, allocator: std.mem.Allocator, input: list_reservation_offerings.ListReservationOfferingsInput, options: CallOptions) !list_reservation_offerings.ListReservationOfferingsOutput {
        return list_reservation_offerings.execute(self, allocator, input, options);
    }

    /// Returns a list of Reservation objects.
    pub fn listReservations(self: *Self, allocator: std.mem.Allocator, input: list_reservations.ListReservationsInput, options: CallOptions) !list_reservations.ListReservationsOutput {
        return list_reservations.execute(self, allocator, input, options);
    }

    /// Returns a list of scheduled actions. You can use the flags to filter the
    /// list of returned scheduled actions.
    pub fn listScheduledActions(self: *Self, allocator: std.mem.Allocator, input: list_scheduled_actions.ListScheduledActionsInput, options: CallOptions) !list_scheduled_actions.ListScheduledActionsOutput {
        return list_scheduled_actions.execute(self, allocator, input, options);
    }

    /// Returns a list of snapshot copy configurations.
    pub fn listSnapshotCopyConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_snapshot_copy_configurations.ListSnapshotCopyConfigurationsInput, options: CallOptions) !list_snapshot_copy_configurations.ListSnapshotCopyConfigurationsOutput {
        return list_snapshot_copy_configurations.execute(self, allocator, input, options);
    }

    /// Returns a list of snapshots.
    pub fn listSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_snapshots.ListSnapshotsInput, options: CallOptions) !list_snapshots.ListSnapshotsOutput {
        return list_snapshots.execute(self, allocator, input, options);
    }

    /// Returns information about an array of `TableRestoreStatus` objects.
    pub fn listTableRestoreStatus(self: *Self, allocator: std.mem.Allocator, input: list_table_restore_status.ListTableRestoreStatusInput, options: CallOptions) !list_table_restore_status.ListTableRestoreStatusOutput {
        return list_table_restore_status.execute(self, allocator, input, options);
    }

    /// Lists the tags assigned to a resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List the Amazon Redshift Serverless versions.
    pub fn listTracks(self: *Self, allocator: std.mem.Allocator, input: list_tracks.ListTracksInput, options: CallOptions) !list_tracks.ListTracksOutput {
        return list_tracks.execute(self, allocator, input, options);
    }

    /// Lists all usage limits within Amazon Redshift Serverless.
    pub fn listUsageLimits(self: *Self, allocator: std.mem.Allocator, input: list_usage_limits.ListUsageLimitsInput, options: CallOptions) !list_usage_limits.ListUsageLimitsOutput {
        return list_usage_limits.execute(self, allocator, input, options);
    }

    /// Returns information about a list of specified workgroups.
    pub fn listWorkgroups(self: *Self, allocator: std.mem.Allocator, input: list_workgroups.ListWorkgroupsInput, options: CallOptions) !list_workgroups.ListWorkgroupsOutput {
        return list_workgroups.execute(self, allocator, input, options);
    }

    /// Creates or updates a resource policy. Currently, you can use policies to
    /// share snapshots across Amazon Web Services accounts.
    pub fn putResourcePolicy(self: *Self, allocator: std.mem.Allocator, input: put_resource_policy.PutResourcePolicyInput, options: CallOptions) !put_resource_policy.PutResourcePolicyOutput {
        return put_resource_policy.execute(self, allocator, input, options);
    }

    /// Restore the data from a recovery point.
    pub fn restoreFromRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: restore_from_recovery_point.RestoreFromRecoveryPointInput, options: CallOptions) !restore_from_recovery_point.RestoreFromRecoveryPointOutput {
        return restore_from_recovery_point.execute(self, allocator, input, options);
    }

    /// Restores a namespace from a snapshot.
    pub fn restoreFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_from_snapshot.RestoreFromSnapshotInput, options: CallOptions) !restore_from_snapshot.RestoreFromSnapshotOutput {
        return restore_from_snapshot.execute(self, allocator, input, options);
    }

    /// Restores a table from a recovery point to your Amazon Redshift Serverless
    /// instance. You can't use this operation to restore tables with interleaved
    /// sort keys.
    pub fn restoreTableFromRecoveryPoint(self: *Self, allocator: std.mem.Allocator, input: restore_table_from_recovery_point.RestoreTableFromRecoveryPointInput, options: CallOptions) !restore_table_from_recovery_point.RestoreTableFromRecoveryPointOutput {
        return restore_table_from_recovery_point.execute(self, allocator, input, options);
    }

    /// Restores a table from a snapshot to your Amazon Redshift Serverless
    /// instance. You can't use this operation to restore tables with [interleaved
    /// sort
    /// keys](https://docs.aws.amazon.com/redshift/latest/dg/t_Sorting_data.html#t_Sorting_data-interleaved).
    pub fn restoreTableFromSnapshot(self: *Self, allocator: std.mem.Allocator, input: restore_table_from_snapshot.RestoreTableFromSnapshotInput, options: CallOptions) !restore_table_from_snapshot.RestoreTableFromSnapshotOutput {
        return restore_table_from_snapshot.execute(self, allocator, input, options);
    }

    /// Assigns one or more tags to a resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes a tag or set of tags from a resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Redshift Serverless certificate associated with a custom
    /// domain.
    pub fn updateCustomDomainAssociation(self: *Self, allocator: std.mem.Allocator, input: update_custom_domain_association.UpdateCustomDomainAssociationInput, options: CallOptions) !update_custom_domain_association.UpdateCustomDomainAssociationOutput {
        return update_custom_domain_association.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Redshift Serverless managed endpoint.
    pub fn updateEndpointAccess(self: *Self, allocator: std.mem.Allocator, input: update_endpoint_access.UpdateEndpointAccessInput, options: CallOptions) !update_endpoint_access.UpdateEndpointAccessOutput {
        return update_endpoint_access.execute(self, allocator, input, options);
    }

    /// Modifies the lakehouse configuration for a namespace. This operation allows
    /// you to manage Amazon Redshift federated permissions and Amazon Web Services
    /// IAM Identity Center trusted identity propagation.
    pub fn updateLakehouseConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_lakehouse_configuration.UpdateLakehouseConfigurationInput, options: CallOptions) !update_lakehouse_configuration.UpdateLakehouseConfigurationOutput {
        return update_lakehouse_configuration.execute(self, allocator, input, options);
    }

    /// Updates a namespace with the specified settings. Unless required, you can't
    /// update multiple parameters in one request. For example, you must specify
    /// both `adminUsername` and `adminUserPassword` to update either field, but you
    /// can't update both `kmsKeyId` and `logExports` in a single request.
    pub fn updateNamespace(self: *Self, allocator: std.mem.Allocator, input: update_namespace.UpdateNamespaceInput, options: CallOptions) !update_namespace.UpdateNamespaceOutput {
        return update_namespace.execute(self, allocator, input, options);
    }

    /// Updates a scheduled action.
    pub fn updateScheduledAction(self: *Self, allocator: std.mem.Allocator, input: update_scheduled_action.UpdateScheduledActionInput, options: CallOptions) !update_scheduled_action.UpdateScheduledActionOutput {
        return update_scheduled_action.execute(self, allocator, input, options);
    }

    /// Updates a snapshot.
    pub fn updateSnapshot(self: *Self, allocator: std.mem.Allocator, input: update_snapshot.UpdateSnapshotInput, options: CallOptions) !update_snapshot.UpdateSnapshotOutput {
        return update_snapshot.execute(self, allocator, input, options);
    }

    /// Updates a snapshot copy configuration.
    pub fn updateSnapshotCopyConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_snapshot_copy_configuration.UpdateSnapshotCopyConfigurationInput, options: CallOptions) !update_snapshot_copy_configuration.UpdateSnapshotCopyConfigurationOutput {
        return update_snapshot_copy_configuration.execute(self, allocator, input, options);
    }

    /// Update a usage limit in Amazon Redshift Serverless. You can't update the
    /// usage type or period of a usage limit.
    pub fn updateUsageLimit(self: *Self, allocator: std.mem.Allocator, input: update_usage_limit.UpdateUsageLimitInput, options: CallOptions) !update_usage_limit.UpdateUsageLimitOutput {
        return update_usage_limit.execute(self, allocator, input, options);
    }

    /// Updates a workgroup with the specified configuration settings. You can't
    /// update multiple parameters in one request. For example, you can update
    /// `baseCapacity` or `port` in a single request, but you can't update both in
    /// the same request.
    ///
    /// VPC Block Public Access (BPA) enables you to block resources in VPCs and
    /// subnets that you own in a Region from reaching or being reached from the
    /// internet through internet gateways and egress-only internet gateways. If a
    /// workgroup is in an account with VPC BPA turned on, the following
    /// capabilities are blocked:
    ///
    /// * Creating a public access workgroup
    /// * Modifying a private workgroup to public
    /// * Adding a subnet with VPC BPA turned on to the workgroup when the workgroup
    ///   is public
    ///
    /// For more information about VPC BPA, see [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn updateWorkgroup(self: *Self, allocator: std.mem.Allocator, input: update_workgroup.UpdateWorkgroupInput, options: CallOptions) !update_workgroup.UpdateWorkgroupOutput {
        return update_workgroup.execute(self, allocator, input, options);
    }

    pub fn listCustomDomainAssociationsPaginator(self: *Self, params: list_custom_domain_associations.ListCustomDomainAssociationsInput) paginator.ListCustomDomainAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEndpointAccessPaginator(self: *Self, params: list_endpoint_access.ListEndpointAccessInput) paginator.ListEndpointAccessPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listManagedWorkgroupsPaginator(self: *Self, params: list_managed_workgroups.ListManagedWorkgroupsInput) paginator.ListManagedWorkgroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNamespacesPaginator(self: *Self, params: list_namespaces.ListNamespacesInput) paginator.ListNamespacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecoveryPointsPaginator(self: *Self, params: list_recovery_points.ListRecoveryPointsInput) paginator.ListRecoveryPointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReservationOfferingsPaginator(self: *Self, params: list_reservation_offerings.ListReservationOfferingsInput) paginator.ListReservationOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReservationsPaginator(self: *Self, params: list_reservations.ListReservationsInput) paginator.ListReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listScheduledActionsPaginator(self: *Self, params: list_scheduled_actions.ListScheduledActionsInput) paginator.ListScheduledActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSnapshotCopyConfigurationsPaginator(self: *Self, params: list_snapshot_copy_configurations.ListSnapshotCopyConfigurationsInput) paginator.ListSnapshotCopyConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSnapshotsPaginator(self: *Self, params: list_snapshots.ListSnapshotsInput) paginator.ListSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTableRestoreStatusPaginator(self: *Self, params: list_table_restore_status.ListTableRestoreStatusInput) paginator.ListTableRestoreStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTracksPaginator(self: *Self, params: list_tracks.ListTracksInput) paginator.ListTracksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listUsageLimitsPaginator(self: *Self, params: list_usage_limits.ListUsageLimitsInput) paginator.ListUsageLimitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkgroupsPaginator(self: *Self, params: list_workgroups.ListWorkgroupsInput) paginator.ListWorkgroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
