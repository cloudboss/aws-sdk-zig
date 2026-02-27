const aws = @import("aws");
const std = @import("std");

const add_lf_tags_to_resource = @import("add_lf_tags_to_resource.zig");
const assume_decorated_role_with_saml = @import("assume_decorated_role_with_saml.zig");
const batch_grant_permissions = @import("batch_grant_permissions.zig");
const batch_revoke_permissions = @import("batch_revoke_permissions.zig");
const cancel_transaction = @import("cancel_transaction.zig");
const commit_transaction = @import("commit_transaction.zig");
const create_data_cells_filter = @import("create_data_cells_filter.zig");
const create_lake_formation_identity_center_configuration = @import("create_lake_formation_identity_center_configuration.zig");
const create_lake_formation_opt_in = @import("create_lake_formation_opt_in.zig");
const create_lf_tag = @import("create_lf_tag.zig");
const create_lf_tag_expression = @import("create_lf_tag_expression.zig");
const delete_data_cells_filter = @import("delete_data_cells_filter.zig");
const delete_lake_formation_identity_center_configuration = @import("delete_lake_formation_identity_center_configuration.zig");
const delete_lake_formation_opt_in = @import("delete_lake_formation_opt_in.zig");
const delete_lf_tag = @import("delete_lf_tag.zig");
const delete_lf_tag_expression = @import("delete_lf_tag_expression.zig");
const delete_objects_on_cancel = @import("delete_objects_on_cancel.zig");
const deregister_resource = @import("deregister_resource.zig");
const describe_lake_formation_identity_center_configuration = @import("describe_lake_formation_identity_center_configuration.zig");
const describe_resource = @import("describe_resource.zig");
const describe_transaction = @import("describe_transaction.zig");
const extend_transaction = @import("extend_transaction.zig");
const get_data_cells_filter = @import("get_data_cells_filter.zig");
const get_data_lake_principal = @import("get_data_lake_principal.zig");
const get_data_lake_settings = @import("get_data_lake_settings.zig");
const get_effective_permissions_for_path = @import("get_effective_permissions_for_path.zig");
const get_lf_tag = @import("get_lf_tag.zig");
const get_lf_tag_expression = @import("get_lf_tag_expression.zig");
const get_query_state = @import("get_query_state.zig");
const get_query_statistics = @import("get_query_statistics.zig");
const get_resource_lf_tags = @import("get_resource_lf_tags.zig");
const get_table_objects = @import("get_table_objects.zig");
const get_temporary_data_location_credentials = @import("get_temporary_data_location_credentials.zig");
const get_temporary_glue_partition_credentials = @import("get_temporary_glue_partition_credentials.zig");
const get_temporary_glue_table_credentials = @import("get_temporary_glue_table_credentials.zig");
const get_work_unit_results = @import("get_work_unit_results.zig");
const get_work_units = @import("get_work_units.zig");
const grant_permissions = @import("grant_permissions.zig");
const list_data_cells_filter = @import("list_data_cells_filter.zig");
const list_lake_formation_opt_ins = @import("list_lake_formation_opt_ins.zig");
const list_lf_tag_expressions = @import("list_lf_tag_expressions.zig");
const list_lf_tags = @import("list_lf_tags.zig");
const list_permissions = @import("list_permissions.zig");
const list_resources = @import("list_resources.zig");
const list_table_storage_optimizers = @import("list_table_storage_optimizers.zig");
const list_transactions = @import("list_transactions.zig");
const put_data_lake_settings = @import("put_data_lake_settings.zig");
const register_resource = @import("register_resource.zig");
const remove_lf_tags_from_resource = @import("remove_lf_tags_from_resource.zig");
const revoke_permissions = @import("revoke_permissions.zig");
const search_databases_by_lf_tags = @import("search_databases_by_lf_tags.zig");
const search_tables_by_lf_tags = @import("search_tables_by_lf_tags.zig");
const start_query_planning = @import("start_query_planning.zig");
const start_transaction = @import("start_transaction.zig");
const update_data_cells_filter = @import("update_data_cells_filter.zig");
const update_lake_formation_identity_center_configuration = @import("update_lake_formation_identity_center_configuration.zig");
const update_lf_tag = @import("update_lf_tag.zig");
const update_lf_tag_expression = @import("update_lf_tag_expression.zig");
const update_resource = @import("update_resource.zig");
const update_table_objects = @import("update_table_objects.zig");
const update_table_storage_optimizer = @import("update_table_storage_optimizer.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "LakeFormation";

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

    /// Attaches one or more LF-tags to an existing resource.
    pub fn addLfTagsToResource(self: *Self, allocator: std.mem.Allocator, input: add_lf_tags_to_resource.AddLFTagsToResourceInput, options: add_lf_tags_to_resource.Options) !add_lf_tags_to_resource.AddLFTagsToResourceOutput {
        return add_lf_tags_to_resource.execute(self, allocator, input, options);
    }

    /// Allows a caller to assume an IAM role decorated as the SAML user specified
    /// in the SAML assertion included in the request. This decoration allows Lake
    /// Formation to enforce access policies against the SAML users and groups. This
    /// API operation requires SAML federation setup in the caller’s account as it
    /// can only be called with valid SAML assertions.
    /// Lake Formation does not scope down the permission of the assumed role. All
    /// permissions attached to the role via the SAML federation setup will be
    /// included in the role session.
    ///
    /// This decorated role is expected to access data in Amazon S3 by getting
    /// temporary access from Lake Formation which is authorized via the virtual API
    /// `GetDataAccess`.
    /// Therefore, all SAML roles that can be assumed via
    /// `AssumeDecoratedRoleWithSAML` must at a minimum include
    /// `lakeformation:GetDataAccess` in their role policies.
    /// A typical IAM policy attached to such a role would include the following
    /// actions:
    ///
    /// * glue:*Database*
    ///
    /// * glue:*Table*
    ///
    /// * glue:*Partition*
    ///
    /// * glue:*UserDefinedFunction*
    ///
    /// * lakeformation:GetDataAccess
    pub fn assumeDecoratedRoleWithSaml(self: *Self, allocator: std.mem.Allocator, input: assume_decorated_role_with_saml.AssumeDecoratedRoleWithSAMLInput, options: assume_decorated_role_with_saml.Options) !assume_decorated_role_with_saml.AssumeDecoratedRoleWithSAMLOutput {
        return assume_decorated_role_with_saml.execute(self, allocator, input, options);
    }

    /// Batch operation to grant permissions to the principal.
    pub fn batchGrantPermissions(self: *Self, allocator: std.mem.Allocator, input: batch_grant_permissions.BatchGrantPermissionsInput, options: batch_grant_permissions.Options) !batch_grant_permissions.BatchGrantPermissionsOutput {
        return batch_grant_permissions.execute(self, allocator, input, options);
    }

    /// Batch operation to revoke permissions from the principal.
    pub fn batchRevokePermissions(self: *Self, allocator: std.mem.Allocator, input: batch_revoke_permissions.BatchRevokePermissionsInput, options: batch_revoke_permissions.Options) !batch_revoke_permissions.BatchRevokePermissionsOutput {
        return batch_revoke_permissions.execute(self, allocator, input, options);
    }

    /// Attempts to cancel the specified transaction. Returns an exception if the
    /// transaction was previously committed.
    pub fn cancelTransaction(self: *Self, allocator: std.mem.Allocator, input: cancel_transaction.CancelTransactionInput, options: cancel_transaction.Options) !cancel_transaction.CancelTransactionOutput {
        return cancel_transaction.execute(self, allocator, input, options);
    }

    /// Attempts to commit the specified transaction. Returns an exception if the
    /// transaction was previously aborted. This API action is idempotent if called
    /// multiple times for the same transaction.
    pub fn commitTransaction(self: *Self, allocator: std.mem.Allocator, input: commit_transaction.CommitTransactionInput, options: commit_transaction.Options) !commit_transaction.CommitTransactionOutput {
        return commit_transaction.execute(self, allocator, input, options);
    }

    /// Creates a data cell filter to allow one to grant access to certain columns
    /// on certain rows.
    pub fn createDataCellsFilter(self: *Self, allocator: std.mem.Allocator, input: create_data_cells_filter.CreateDataCellsFilterInput, options: create_data_cells_filter.Options) !create_data_cells_filter.CreateDataCellsFilterOutput {
        return create_data_cells_filter.execute(self, allocator, input, options);
    }

    /// Creates an IAM Identity Center connection with Lake Formation to allow IAM
    /// Identity Center users and groups to access Data Catalog resources.
    pub fn createLakeFormationIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_lake_formation_identity_center_configuration.CreateLakeFormationIdentityCenterConfigurationInput, options: create_lake_formation_identity_center_configuration.Options) !create_lake_formation_identity_center_configuration.CreateLakeFormationIdentityCenterConfigurationOutput {
        return create_lake_formation_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Enforce Lake Formation permissions for the given databases, tables, and
    /// principals.
    pub fn createLakeFormationOptIn(self: *Self, allocator: std.mem.Allocator, input: create_lake_formation_opt_in.CreateLakeFormationOptInInput, options: create_lake_formation_opt_in.Options) !create_lake_formation_opt_in.CreateLakeFormationOptInOutput {
        return create_lake_formation_opt_in.execute(self, allocator, input, options);
    }

    /// Creates an LF-tag with the specified name and values.
    pub fn createLfTag(self: *Self, allocator: std.mem.Allocator, input: create_lf_tag.CreateLFTagInput, options: create_lf_tag.Options) !create_lf_tag.CreateLFTagOutput {
        return create_lf_tag.execute(self, allocator, input, options);
    }

    /// Creates a new LF-Tag expression with the provided name, description, catalog
    /// ID, and
    /// expression body. This call fails if a LF-Tag expression with the same name
    /// already exists in
    /// the caller’s account or if the underlying LF-Tags don't exist. To call this
    /// API operation,
    /// caller needs the following Lake Formation permissions:
    ///
    /// `CREATE_LF_TAG_EXPRESSION` on the root catalog resource.
    ///
    /// `GRANT_WITH_LF_TAG_EXPRESSION` on all underlying LF-Tag key:value pairs
    /// included in the expression.
    pub fn createLfTagExpression(self: *Self, allocator: std.mem.Allocator, input: create_lf_tag_expression.CreateLFTagExpressionInput, options: create_lf_tag_expression.Options) !create_lf_tag_expression.CreateLFTagExpressionOutput {
        return create_lf_tag_expression.execute(self, allocator, input, options);
    }

    /// Deletes a data cell filter.
    pub fn deleteDataCellsFilter(self: *Self, allocator: std.mem.Allocator, input: delete_data_cells_filter.DeleteDataCellsFilterInput, options: delete_data_cells_filter.Options) !delete_data_cells_filter.DeleteDataCellsFilterOutput {
        return delete_data_cells_filter.execute(self, allocator, input, options);
    }

    /// Deletes an IAM Identity Center connection with Lake Formation.
    pub fn deleteLakeFormationIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_lake_formation_identity_center_configuration.DeleteLakeFormationIdentityCenterConfigurationInput, options: delete_lake_formation_identity_center_configuration.Options) !delete_lake_formation_identity_center_configuration.DeleteLakeFormationIdentityCenterConfigurationOutput {
        return delete_lake_formation_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Remove the Lake Formation permissions enforcement of the given databases,
    /// tables, and principals.
    pub fn deleteLakeFormationOptIn(self: *Self, allocator: std.mem.Allocator, input: delete_lake_formation_opt_in.DeleteLakeFormationOptInInput, options: delete_lake_formation_opt_in.Options) !delete_lake_formation_opt_in.DeleteLakeFormationOptInOutput {
        return delete_lake_formation_opt_in.execute(self, allocator, input, options);
    }

    /// Deletes an LF-tag by its key name. The operation fails if the specified tag
    /// key doesn't
    /// exist. When you delete an LF-Tag:
    ///
    /// * The associated LF-Tag policy becomes invalid.
    ///
    /// * Resources that had this tag assigned will no longer have the tag policy
    ///   applied to
    /// them.
    pub fn deleteLfTag(self: *Self, allocator: std.mem.Allocator, input: delete_lf_tag.DeleteLFTagInput, options: delete_lf_tag.Options) !delete_lf_tag.DeleteLFTagOutput {
        return delete_lf_tag.execute(self, allocator, input, options);
    }

    /// Deletes the LF-Tag expression. The caller must be a data lake admin or have
    /// `DROP` permissions on the LF-Tag expression.
    /// Deleting a LF-Tag expression will also delete all `LFTagPolicy` permissions
    /// referencing the LF-Tag expression.
    pub fn deleteLfTagExpression(self: *Self, allocator: std.mem.Allocator, input: delete_lf_tag_expression.DeleteLFTagExpressionInput, options: delete_lf_tag_expression.Options) !delete_lf_tag_expression.DeleteLFTagExpressionOutput {
        return delete_lf_tag_expression.execute(self, allocator, input, options);
    }

    /// For a specific governed table, provides a list of Amazon S3 objects that
    /// will be written during the current transaction and that can be automatically
    /// deleted
    /// if the transaction is canceled. Without this call, no Amazon S3 objects are
    /// automatically deleted when a transaction cancels.
    ///
    /// The Glue ETL library function `write_dynamic_frame.from_catalog()` includes
    /// an option to automatically
    /// call `DeleteObjectsOnCancel` before writes. For more information, see
    /// [Rolling Back Amazon S3
    /// Writes](https://docs.aws.amazon.com/lake-formation/latest/dg/transactions-data-operations.html#rolling-back-writes).
    pub fn deleteObjectsOnCancel(self: *Self, allocator: std.mem.Allocator, input: delete_objects_on_cancel.DeleteObjectsOnCancelInput, options: delete_objects_on_cancel.Options) !delete_objects_on_cancel.DeleteObjectsOnCancelOutput {
        return delete_objects_on_cancel.execute(self, allocator, input, options);
    }

    /// Deregisters the resource as managed by the Data Catalog.
    ///
    /// When you deregister a path, Lake Formation removes the path from the inline
    /// policy attached to your service-linked role.
    pub fn deregisterResource(self: *Self, allocator: std.mem.Allocator, input: deregister_resource.DeregisterResourceInput, options: deregister_resource.Options) !deregister_resource.DeregisterResourceOutput {
        return deregister_resource.execute(self, allocator, input, options);
    }

    /// Retrieves the instance ARN and application ARN for the connection.
    pub fn describeLakeFormationIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_lake_formation_identity_center_configuration.DescribeLakeFormationIdentityCenterConfigurationInput, options: describe_lake_formation_identity_center_configuration.Options) !describe_lake_formation_identity_center_configuration.DescribeLakeFormationIdentityCenterConfigurationOutput {
        return describe_lake_formation_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Retrieves the current data access role for the given resource registered in
    /// Lake Formation.
    pub fn describeResource(self: *Self, allocator: std.mem.Allocator, input: describe_resource.DescribeResourceInput, options: describe_resource.Options) !describe_resource.DescribeResourceOutput {
        return describe_resource.execute(self, allocator, input, options);
    }

    /// Returns the details of a single transaction.
    pub fn describeTransaction(self: *Self, allocator: std.mem.Allocator, input: describe_transaction.DescribeTransactionInput, options: describe_transaction.Options) !describe_transaction.DescribeTransactionOutput {
        return describe_transaction.execute(self, allocator, input, options);
    }

    /// Indicates to the service that the specified transaction is still active and
    /// should not be treated as idle and aborted.
    ///
    /// Write transactions that remain idle for a long period are automatically
    /// aborted unless explicitly extended.
    pub fn extendTransaction(self: *Self, allocator: std.mem.Allocator, input: extend_transaction.ExtendTransactionInput, options: extend_transaction.Options) !extend_transaction.ExtendTransactionOutput {
        return extend_transaction.execute(self, allocator, input, options);
    }

    /// Returns a data cells filter.
    pub fn getDataCellsFilter(self: *Self, allocator: std.mem.Allocator, input: get_data_cells_filter.GetDataCellsFilterInput, options: get_data_cells_filter.Options) !get_data_cells_filter.GetDataCellsFilterOutput {
        return get_data_cells_filter.execute(self, allocator, input, options);
    }

    /// Returns the identity of the invoking principal.
    pub fn getDataLakePrincipal(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_principal.GetDataLakePrincipalInput, options: get_data_lake_principal.Options) !get_data_lake_principal.GetDataLakePrincipalOutput {
        return get_data_lake_principal.execute(self, allocator, input, options);
    }

    /// Retrieves the list of the data lake administrators of a Lake
    /// Formation-managed data lake.
    pub fn getDataLakeSettings(self: *Self, allocator: std.mem.Allocator, input: get_data_lake_settings.GetDataLakeSettingsInput, options: get_data_lake_settings.Options) !get_data_lake_settings.GetDataLakeSettingsOutput {
        return get_data_lake_settings.execute(self, allocator, input, options);
    }

    /// Returns the Lake Formation permissions for a specified table or database
    /// resource located
    /// at a path in Amazon S3. `GetEffectivePermissionsForPath` will not return
    /// databases and tables if the catalog is encrypted.
    pub fn getEffectivePermissionsForPath(self: *Self, allocator: std.mem.Allocator, input: get_effective_permissions_for_path.GetEffectivePermissionsForPathInput, options: get_effective_permissions_for_path.Options) !get_effective_permissions_for_path.GetEffectivePermissionsForPathOutput {
        return get_effective_permissions_for_path.execute(self, allocator, input, options);
    }

    /// Returns an LF-tag definition.
    pub fn getLfTag(self: *Self, allocator: std.mem.Allocator, input: get_lf_tag.GetLFTagInput, options: get_lf_tag.Options) !get_lf_tag.GetLFTagOutput {
        return get_lf_tag.execute(self, allocator, input, options);
    }

    /// Returns the details about the LF-Tag expression. The caller must be a data
    /// lake admin or must have `DESCRIBE` permission on the LF-Tag expression
    /// resource.
    pub fn getLfTagExpression(self: *Self, allocator: std.mem.Allocator, input: get_lf_tag_expression.GetLFTagExpressionInput, options: get_lf_tag_expression.Options) !get_lf_tag_expression.GetLFTagExpressionOutput {
        return get_lf_tag_expression.execute(self, allocator, input, options);
    }

    /// Returns the state of a query previously submitted. Clients are expected to
    /// poll `GetQueryState` to monitor the current state of the planning before
    /// retrieving the work units. A query state is only visible to the principal
    /// that made the initial call to `StartQueryPlanning`.
    pub fn getQueryState(self: *Self, allocator: std.mem.Allocator, input: get_query_state.GetQueryStateInput, options: get_query_state.Options) !get_query_state.GetQueryStateOutput {
        return get_query_state.execute(self, allocator, input, options);
    }

    /// Retrieves statistics on the planning and execution of a query.
    pub fn getQueryStatistics(self: *Self, allocator: std.mem.Allocator, input: get_query_statistics.GetQueryStatisticsInput, options: get_query_statistics.Options) !get_query_statistics.GetQueryStatisticsOutput {
        return get_query_statistics.execute(self, allocator, input, options);
    }

    /// Returns the LF-tags applied to a resource.
    pub fn getResourceLfTags(self: *Self, allocator: std.mem.Allocator, input: get_resource_lf_tags.GetResourceLFTagsInput, options: get_resource_lf_tags.Options) !get_resource_lf_tags.GetResourceLFTagsOutput {
        return get_resource_lf_tags.execute(self, allocator, input, options);
    }

    /// Returns the set of Amazon S3 objects that make up the specified governed
    /// table. A transaction ID or timestamp can be specified for time-travel
    /// queries.
    pub fn getTableObjects(self: *Self, allocator: std.mem.Allocator, input: get_table_objects.GetTableObjectsInput, options: get_table_objects.Options) !get_table_objects.GetTableObjectsOutput {
        return get_table_objects.execute(self, allocator, input, options);
    }

    /// Allows a user or application in a secure environment to access data in a
    /// specific Amazon S3 location registered with Lake Formation by providing
    /// temporary scoped credentials that are limited to the requested data location
    /// and
    /// the caller's authorized access level.
    ///
    /// The API operation returns an error in the following scenarios:
    ///
    /// * The data location is not registered with Lake Formation.
    ///
    /// * No Glue table is associated with the data location.
    ///
    /// * The caller doesn't have required permissions on the associated table. The
    ///   caller must have
    /// `SELECT` or `SUPER` permissions on the associated table, and
    /// credential vending for full table access must be enabled in the data lake
    /// settings.
    ///
    /// For more information, see [Application integration for full table
    /// access](https://docs.aws.amazon.com/lake-formation/latest/dg/full-table-credential-vending.html).
    ///
    /// * The data location is in a different Amazon Web Services Region. Lake
    ///   Formation doesn't
    /// support cross-Region access when vending credentials for a data location.
    /// Lake Formation only supports Amazon S3 paths registered within the same
    /// Region as the API
    /// call.
    pub fn getTemporaryDataLocationCredentials(self: *Self, allocator: std.mem.Allocator, input: get_temporary_data_location_credentials.GetTemporaryDataLocationCredentialsInput, options: get_temporary_data_location_credentials.Options) !get_temporary_data_location_credentials.GetTemporaryDataLocationCredentialsOutput {
        return get_temporary_data_location_credentials.execute(self, allocator, input, options);
    }

    /// This API is identical to `GetTemporaryTableCredentials` except that this is
    /// used when the target Data Catalog resource is of type Partition. Lake
    /// Formation restricts the permission of the vended credentials with the same
    /// scope down policy which restricts access to a single Amazon S3 prefix.
    pub fn getTemporaryGluePartitionCredentials(self: *Self, allocator: std.mem.Allocator, input: get_temporary_glue_partition_credentials.GetTemporaryGluePartitionCredentialsInput, options: get_temporary_glue_partition_credentials.Options) !get_temporary_glue_partition_credentials.GetTemporaryGluePartitionCredentialsOutput {
        return get_temporary_glue_partition_credentials.execute(self, allocator, input, options);
    }

    /// Allows a caller in a secure environment to assume a role with permission to
    /// access Amazon S3. In order to vend such credentials, Lake Formation assumes
    /// the role associated with a registered location, for example an Amazon S3
    /// bucket, with a scope down policy which restricts the access to a single
    /// prefix.
    ///
    /// To call this API, the role that the service assumes must have
    /// `lakeformation:GetDataAccess` permission on the resource.
    pub fn getTemporaryGlueTableCredentials(self: *Self, allocator: std.mem.Allocator, input: get_temporary_glue_table_credentials.GetTemporaryGlueTableCredentialsInput, options: get_temporary_glue_table_credentials.Options) !get_temporary_glue_table_credentials.GetTemporaryGlueTableCredentialsOutput {
        return get_temporary_glue_table_credentials.execute(self, allocator, input, options);
    }

    /// Returns the work units resulting from the query. Work units can be executed
    /// in any order and in parallel.
    pub fn getWorkUnitResults(self: *Self, allocator: std.mem.Allocator, input: get_work_unit_results.GetWorkUnitResultsInput, options: get_work_unit_results.Options) !get_work_unit_results.GetWorkUnitResultsOutput {
        return get_work_unit_results.execute(self, allocator, input, options);
    }

    /// Retrieves the work units generated by the `StartQueryPlanning` operation.
    pub fn getWorkUnits(self: *Self, allocator: std.mem.Allocator, input: get_work_units.GetWorkUnitsInput, options: get_work_units.Options) !get_work_units.GetWorkUnitsOutput {
        return get_work_units.execute(self, allocator, input, options);
    }

    /// Grants permissions to the principal to access metadata in the Data Catalog
    /// and data organized in underlying data storage such as Amazon S3.
    ///
    /// For information about permissions, see [Security and Access Control to
    /// Metadata and
    /// Data](https://docs.aws.amazon.com/lake-formation/latest/dg/security-data-access.html).
    pub fn grantPermissions(self: *Self, allocator: std.mem.Allocator, input: grant_permissions.GrantPermissionsInput, options: grant_permissions.Options) !grant_permissions.GrantPermissionsOutput {
        return grant_permissions.execute(self, allocator, input, options);
    }

    /// Lists all the data cell filters on a table.
    pub fn listDataCellsFilter(self: *Self, allocator: std.mem.Allocator, input: list_data_cells_filter.ListDataCellsFilterInput, options: list_data_cells_filter.Options) !list_data_cells_filter.ListDataCellsFilterOutput {
        return list_data_cells_filter.execute(self, allocator, input, options);
    }

    /// Retrieve the current list of resources and principals that are opt in to
    /// enforce Lake Formation permissions.
    pub fn listLakeFormationOptIns(self: *Self, allocator: std.mem.Allocator, input: list_lake_formation_opt_ins.ListLakeFormationOptInsInput, options: list_lake_formation_opt_ins.Options) !list_lake_formation_opt_ins.ListLakeFormationOptInsOutput {
        return list_lake_formation_opt_ins.execute(self, allocator, input, options);
    }

    /// Returns the LF-Tag expressions in caller’s account filtered based on
    /// caller's permissions. Data Lake and read only admins implicitly can see all
    /// tag expressions in their account, else caller needs DESCRIBE permissions on
    /// tag expression.
    pub fn listLfTagExpressions(self: *Self, allocator: std.mem.Allocator, input: list_lf_tag_expressions.ListLFTagExpressionsInput, options: list_lf_tag_expressions.Options) !list_lf_tag_expressions.ListLFTagExpressionsOutput {
        return list_lf_tag_expressions.execute(self, allocator, input, options);
    }

    /// Lists LF-tags that the requester has permission to view.
    pub fn listLfTags(self: *Self, allocator: std.mem.Allocator, input: list_lf_tags.ListLFTagsInput, options: list_lf_tags.Options) !list_lf_tags.ListLFTagsOutput {
        return list_lf_tags.execute(self, allocator, input, options);
    }

    /// Returns a list of the principal permissions on the resource, filtered by the
    /// permissions of the caller. For example, if you are granted an ALTER
    /// permission, you are able to see only the principal permissions for ALTER.
    ///
    /// This operation returns only those permissions that have been explicitly
    /// granted. If both
    /// `Principal` and `Resource` parameters are provided, the response
    /// returns effective permissions rather than the explicitly granted
    /// permissions.
    ///
    /// For information about permissions, see [Security and Access Control to
    /// Metadata and
    /// Data](https://docs.aws.amazon.com/lake-formation/latest/dg/security-data-access.html).
    pub fn listPermissions(self: *Self, allocator: std.mem.Allocator, input: list_permissions.ListPermissionsInput, options: list_permissions.Options) !list_permissions.ListPermissionsOutput {
        return list_permissions.execute(self, allocator, input, options);
    }

    /// Lists the resources registered to be managed by the Data Catalog.
    pub fn listResources(self: *Self, allocator: std.mem.Allocator, input: list_resources.ListResourcesInput, options: list_resources.Options) !list_resources.ListResourcesOutput {
        return list_resources.execute(self, allocator, input, options);
    }

    /// Returns the configuration of all storage optimizers associated with a
    /// specified table.
    pub fn listTableStorageOptimizers(self: *Self, allocator: std.mem.Allocator, input: list_table_storage_optimizers.ListTableStorageOptimizersInput, options: list_table_storage_optimizers.Options) !list_table_storage_optimizers.ListTableStorageOptimizersOutput {
        return list_table_storage_optimizers.execute(self, allocator, input, options);
    }

    /// Returns metadata about transactions and their status. To prevent the
    /// response from growing indefinitely, only uncommitted transactions and those
    /// available for time-travel queries are returned.
    ///
    /// This operation can help you identify uncommitted transactions or to get
    /// information about transactions.
    pub fn listTransactions(self: *Self, allocator: std.mem.Allocator, input: list_transactions.ListTransactionsInput, options: list_transactions.Options) !list_transactions.ListTransactionsOutput {
        return list_transactions.execute(self, allocator, input, options);
    }

    /// Sets the list of data lake administrators who have admin privileges on all
    /// resources managed by Lake Formation. For more information on admin
    /// privileges, see [Granting Lake Formation
    /// Permissions](https://docs.aws.amazon.com/lake-formation/latest/dg/lake-formation-permissions.html).
    ///
    /// This API replaces the current list of data lake admins with the new list
    /// being passed. To add an admin, fetch the current list and add the new admin
    /// to that list and pass that list in this API.
    pub fn putDataLakeSettings(self: *Self, allocator: std.mem.Allocator, input: put_data_lake_settings.PutDataLakeSettingsInput, options: put_data_lake_settings.Options) !put_data_lake_settings.PutDataLakeSettingsOutput {
        return put_data_lake_settings.execute(self, allocator, input, options);
    }

    /// Registers the resource as managed by the Data Catalog.
    ///
    /// To add or update data, Lake Formation needs read/write access to the chosen
    /// data location. Choose a role that you know has permission to do this, or
    /// choose the AWSServiceRoleForLakeFormationDataAccess service-linked role.
    /// When you register the first Amazon S3 path, the service-linked role and a
    /// new inline policy are created on your behalf. Lake Formation adds the first
    /// path to the inline policy and attaches it to the service-linked role. When
    /// you register subsequent paths, Lake Formation adds the path to the existing
    /// policy.
    ///
    /// The following request registers a new location and gives Lake Formation
    /// permission to use the service-linked role to access that location.
    ///
    /// `ResourceArn = arn:aws:s3:::my-bucket/
    /// UseServiceLinkedRole = true`
    ///
    /// If `UseServiceLinkedRole` is not set to true, you must provide or set the
    /// `RoleArn`:
    ///
    /// `arn:aws:iam::12345:role/my-data-access-role`
    pub fn registerResource(self: *Self, allocator: std.mem.Allocator, input: register_resource.RegisterResourceInput, options: register_resource.Options) !register_resource.RegisterResourceOutput {
        return register_resource.execute(self, allocator, input, options);
    }

    /// Removes an LF-tag from the resource. Only database, table, or
    /// tableWithColumns resource are allowed. To tag columns, use the column
    /// inclusion list in `tableWithColumns` to specify column input.
    pub fn removeLfTagsFromResource(self: *Self, allocator: std.mem.Allocator, input: remove_lf_tags_from_resource.RemoveLFTagsFromResourceInput, options: remove_lf_tags_from_resource.Options) !remove_lf_tags_from_resource.RemoveLFTagsFromResourceOutput {
        return remove_lf_tags_from_resource.execute(self, allocator, input, options);
    }

    /// Revokes permissions to the principal to access metadata in the Data Catalog
    /// and data organized in underlying data storage such as Amazon S3.
    pub fn revokePermissions(self: *Self, allocator: std.mem.Allocator, input: revoke_permissions.RevokePermissionsInput, options: revoke_permissions.Options) !revoke_permissions.RevokePermissionsOutput {
        return revoke_permissions.execute(self, allocator, input, options);
    }

    /// This operation allows a search on `DATABASE` resources by `TagCondition`.
    /// This operation is used by admins who want to grant user permissions on
    /// certain `TagConditions`. Before making a grant, the admin can use
    /// `SearchDatabasesByTags` to find all resources where the given
    /// `TagConditions` are valid to verify whether the returned resources can be
    /// shared.
    pub fn searchDatabasesByLfTags(self: *Self, allocator: std.mem.Allocator, input: search_databases_by_lf_tags.SearchDatabasesByLFTagsInput, options: search_databases_by_lf_tags.Options) !search_databases_by_lf_tags.SearchDatabasesByLFTagsOutput {
        return search_databases_by_lf_tags.execute(self, allocator, input, options);
    }

    /// This operation allows a search on `TABLE` resources by `LFTag`s. This will
    /// be used by admins who want to grant user permissions on certain LF-tags.
    /// Before making a grant, the admin can use `SearchTablesByLFTags` to find all
    /// resources where the given `LFTag`s are valid to verify whether the returned
    /// resources can be shared.
    pub fn searchTablesByLfTags(self: *Self, allocator: std.mem.Allocator, input: search_tables_by_lf_tags.SearchTablesByLFTagsInput, options: search_tables_by_lf_tags.Options) !search_tables_by_lf_tags.SearchTablesByLFTagsOutput {
        return search_tables_by_lf_tags.execute(self, allocator, input, options);
    }

    /// Submits a request to process a query statement.
    ///
    /// This operation generates work units that can be retrieved with the
    /// `GetWorkUnits` operation as soon as the query state is WORKUNITS_AVAILABLE
    /// or FINISHED.
    pub fn startQueryPlanning(self: *Self, allocator: std.mem.Allocator, input: start_query_planning.StartQueryPlanningInput, options: start_query_planning.Options) !start_query_planning.StartQueryPlanningOutput {
        return start_query_planning.execute(self, allocator, input, options);
    }

    /// Starts a new transaction and returns its transaction ID. Transaction IDs are
    /// opaque objects that you can use to identify a transaction.
    pub fn startTransaction(self: *Self, allocator: std.mem.Allocator, input: start_transaction.StartTransactionInput, options: start_transaction.Options) !start_transaction.StartTransactionOutput {
        return start_transaction.execute(self, allocator, input, options);
    }

    /// Updates a data cell filter.
    pub fn updateDataCellsFilter(self: *Self, allocator: std.mem.Allocator, input: update_data_cells_filter.UpdateDataCellsFilterInput, options: update_data_cells_filter.Options) !update_data_cells_filter.UpdateDataCellsFilterOutput {
        return update_data_cells_filter.execute(self, allocator, input, options);
    }

    /// Updates the IAM Identity Center connection parameters.
    pub fn updateLakeFormationIdentityCenterConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_lake_formation_identity_center_configuration.UpdateLakeFormationIdentityCenterConfigurationInput, options: update_lake_formation_identity_center_configuration.Options) !update_lake_formation_identity_center_configuration.UpdateLakeFormationIdentityCenterConfigurationOutput {
        return update_lake_formation_identity_center_configuration.execute(self, allocator, input, options);
    }

    /// Updates the list of possible values for the specified LF-tag key. If the
    /// LF-tag does not exist, the operation throws an EntityNotFoundException. The
    /// values in the delete key values will be deleted from list of possible
    /// values. If any value in the delete key values is attached to a resource,
    /// then API errors out with a 400 Exception - "Update not allowed". Untag the
    /// attribute before deleting the LF-tag key's value.
    pub fn updateLfTag(self: *Self, allocator: std.mem.Allocator, input: update_lf_tag.UpdateLFTagInput, options: update_lf_tag.Options) !update_lf_tag.UpdateLFTagOutput {
        return update_lf_tag.execute(self, allocator, input, options);
    }

    /// Updates the name of the LF-Tag expression to the new description and
    /// expression body provided.
    /// Updating a LF-Tag expression immediately changes the permission boundaries
    /// of all existing `LFTagPolicy` permission grants that reference the given
    /// LF-Tag expression.
    pub fn updateLfTagExpression(self: *Self, allocator: std.mem.Allocator, input: update_lf_tag_expression.UpdateLFTagExpressionInput, options: update_lf_tag_expression.Options) !update_lf_tag_expression.UpdateLFTagExpressionOutput {
        return update_lf_tag_expression.execute(self, allocator, input, options);
    }

    /// Updates the data access role used for vending access to the given
    /// (registered) resource in Lake Formation.
    pub fn updateResource(self: *Self, allocator: std.mem.Allocator, input: update_resource.UpdateResourceInput, options: update_resource.Options) !update_resource.UpdateResourceOutput {
        return update_resource.execute(self, allocator, input, options);
    }

    /// Updates the manifest of Amazon S3 objects that make up the specified
    /// governed table.
    pub fn updateTableObjects(self: *Self, allocator: std.mem.Allocator, input: update_table_objects.UpdateTableObjectsInput, options: update_table_objects.Options) !update_table_objects.UpdateTableObjectsOutput {
        return update_table_objects.execute(self, allocator, input, options);
    }

    /// Updates the configuration of the storage optimizers for a table.
    pub fn updateTableStorageOptimizer(self: *Self, allocator: std.mem.Allocator, input: update_table_storage_optimizer.UpdateTableStorageOptimizerInput, options: update_table_storage_optimizer.Options) !update_table_storage_optimizer.UpdateTableStorageOptimizerOutput {
        return update_table_storage_optimizer.execute(self, allocator, input, options);
    }

    pub fn getEffectivePermissionsForPathPaginator(self: *Self, params: get_effective_permissions_for_path.GetEffectivePermissionsForPathInput) paginator.GetEffectivePermissionsForPathPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTableObjectsPaginator(self: *Self, params: get_table_objects.GetTableObjectsInput) paginator.GetTableObjectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getWorkUnitsPaginator(self: *Self, params: get_work_units.GetWorkUnitsInput) paginator.GetWorkUnitsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataCellsFilterPaginator(self: *Self, params: list_data_cells_filter.ListDataCellsFilterInput) paginator.ListDataCellsFilterPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLakeFormationOptInsPaginator(self: *Self, params: list_lake_formation_opt_ins.ListLakeFormationOptInsInput) paginator.ListLakeFormationOptInsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLfTagExpressionsPaginator(self: *Self, params: list_lf_tag_expressions.ListLFTagExpressionsInput) paginator.ListLFTagExpressionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLfTagsPaginator(self: *Self, params: list_lf_tags.ListLFTagsInput) paginator.ListLFTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPermissionsPaginator(self: *Self, params: list_permissions.ListPermissionsInput) paginator.ListPermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listResourcesPaginator(self: *Self, params: list_resources.ListResourcesInput) paginator.ListResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTableStorageOptimizersPaginator(self: *Self, params: list_table_storage_optimizers.ListTableStorageOptimizersInput) paginator.ListTableStorageOptimizersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTransactionsPaginator(self: *Self, params: list_transactions.ListTransactionsInput) paginator.ListTransactionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchDatabasesByLfTagsPaginator(self: *Self, params: search_databases_by_lf_tags.SearchDatabasesByLFTagsInput) paginator.SearchDatabasesByLFTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchTablesByLfTagsPaginator(self: *Self, params: search_tables_by_lf_tags.SearchTablesByLFTagsInput) paginator.SearchTablesByLFTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
