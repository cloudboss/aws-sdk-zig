const aws = @import("aws");
const std = @import("std");

const batch_get_named_query = @import("batch_get_named_query.zig");
const batch_get_prepared_statement = @import("batch_get_prepared_statement.zig");
const batch_get_query_execution = @import("batch_get_query_execution.zig");
const cancel_capacity_reservation = @import("cancel_capacity_reservation.zig");
const create_capacity_reservation = @import("create_capacity_reservation.zig");
const create_data_catalog = @import("create_data_catalog.zig");
const create_named_query = @import("create_named_query.zig");
const create_notebook = @import("create_notebook.zig");
const create_prepared_statement = @import("create_prepared_statement.zig");
const create_presigned_notebook_url = @import("create_presigned_notebook_url.zig");
const create_work_group = @import("create_work_group.zig");
const delete_capacity_reservation = @import("delete_capacity_reservation.zig");
const delete_data_catalog = @import("delete_data_catalog.zig");
const delete_named_query = @import("delete_named_query.zig");
const delete_notebook = @import("delete_notebook.zig");
const delete_prepared_statement = @import("delete_prepared_statement.zig");
const delete_work_group = @import("delete_work_group.zig");
const export_notebook = @import("export_notebook.zig");
const get_calculation_execution = @import("get_calculation_execution.zig");
const get_calculation_execution_code = @import("get_calculation_execution_code.zig");
const get_calculation_execution_status = @import("get_calculation_execution_status.zig");
const get_capacity_assignment_configuration = @import("get_capacity_assignment_configuration.zig");
const get_capacity_reservation = @import("get_capacity_reservation.zig");
const get_data_catalog = @import("get_data_catalog.zig");
const get_database = @import("get_database.zig");
const get_named_query = @import("get_named_query.zig");
const get_notebook_metadata = @import("get_notebook_metadata.zig");
const get_prepared_statement = @import("get_prepared_statement.zig");
const get_query_execution = @import("get_query_execution.zig");
const get_query_results = @import("get_query_results.zig");
const get_query_runtime_statistics = @import("get_query_runtime_statistics.zig");
const get_resource_dashboard = @import("get_resource_dashboard.zig");
const get_session = @import("get_session.zig");
const get_session_endpoint = @import("get_session_endpoint.zig");
const get_session_status = @import("get_session_status.zig");
const get_table_metadata = @import("get_table_metadata.zig");
const get_work_group = @import("get_work_group.zig");
const import_notebook = @import("import_notebook.zig");
const list_application_dpu_sizes = @import("list_application_dpu_sizes.zig");
const list_calculation_executions = @import("list_calculation_executions.zig");
const list_capacity_reservations = @import("list_capacity_reservations.zig");
const list_data_catalogs = @import("list_data_catalogs.zig");
const list_databases = @import("list_databases.zig");
const list_engine_versions = @import("list_engine_versions.zig");
const list_executors = @import("list_executors.zig");
const list_named_queries = @import("list_named_queries.zig");
const list_notebook_metadata = @import("list_notebook_metadata.zig");
const list_notebook_sessions = @import("list_notebook_sessions.zig");
const list_prepared_statements = @import("list_prepared_statements.zig");
const list_query_executions = @import("list_query_executions.zig");
const list_sessions = @import("list_sessions.zig");
const list_table_metadata = @import("list_table_metadata.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_work_groups = @import("list_work_groups.zig");
const put_capacity_assignment_configuration = @import("put_capacity_assignment_configuration.zig");
const start_calculation_execution = @import("start_calculation_execution.zig");
const start_query_execution = @import("start_query_execution.zig");
const start_session = @import("start_session.zig");
const stop_calculation_execution = @import("stop_calculation_execution.zig");
const stop_query_execution = @import("stop_query_execution.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_session = @import("terminate_session.zig");
const untag_resource = @import("untag_resource.zig");
const update_capacity_reservation = @import("update_capacity_reservation.zig");
const update_data_catalog = @import("update_data_catalog.zig");
const update_named_query = @import("update_named_query.zig");
const update_notebook = @import("update_notebook.zig");
const update_notebook_metadata = @import("update_notebook_metadata.zig");
const update_prepared_statement = @import("update_prepared_statement.zig");
const update_work_group = @import("update_work_group.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Athena";

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

    /// Returns the details of a single named query or a list of up to 50 queries,
    /// which you
    /// provide as an array of query ID strings. Requires you to have access to the
    /// workgroup in
    /// which the queries were saved. Use ListNamedQueriesInput to get the
    /// list of named query IDs in the specified workgroup. If information could not
    /// be
    /// retrieved for a submitted query ID, information about the query ID submitted
    /// is listed
    /// under UnprocessedNamedQueryId. Named queries differ from executed
    /// queries. Use BatchGetQueryExecutionInput to get details about each
    /// unique query execution, and ListQueryExecutionsInput to get a list of
    /// query execution IDs.
    pub fn batchGetNamedQuery(self: *Self, allocator: std.mem.Allocator, input: batch_get_named_query.BatchGetNamedQueryInput, options: batch_get_named_query.Options) !batch_get_named_query.BatchGetNamedQueryOutput {
        return batch_get_named_query.execute(self, allocator, input, options);
    }

    /// Returns the details of a single prepared statement or a list of up to 256
    /// prepared
    /// statements for the array of prepared statement names that you provide.
    /// Requires you to
    /// have access to the workgroup to which the prepared statements belong. If a
    /// prepared
    /// statement cannot be retrieved for the name specified, the statement is
    /// listed in
    /// `UnprocessedPreparedStatementNames`.
    pub fn batchGetPreparedStatement(self: *Self, allocator: std.mem.Allocator, input: batch_get_prepared_statement.BatchGetPreparedStatementInput, options: batch_get_prepared_statement.Options) !batch_get_prepared_statement.BatchGetPreparedStatementOutput {
        return batch_get_prepared_statement.execute(self, allocator, input, options);
    }

    /// Returns the details of a single query execution or a list of up to 50 query
    /// executions, which you provide as an array of query execution ID strings.
    /// Requires you to
    /// have access to the workgroup in which the queries ran. To get a list of
    /// query execution
    /// IDs, use ListQueryExecutionsInput$WorkGroup. Query executions differ
    /// from named (saved) queries. Use BatchGetNamedQueryInput to get details
    /// about named queries.
    pub fn batchGetQueryExecution(self: *Self, allocator: std.mem.Allocator, input: batch_get_query_execution.BatchGetQueryExecutionInput, options: batch_get_query_execution.Options) !batch_get_query_execution.BatchGetQueryExecutionOutput {
        return batch_get_query_execution.execute(self, allocator, input, options);
    }

    /// Cancels the capacity reservation with the specified name. Cancelled
    /// reservations
    /// remain in your account and will be deleted 45 days after cancellation.
    /// During the 45
    /// days, you cannot re-purpose or reuse a reservation that has been cancelled,
    /// but you can
    /// refer to its tags and view it for historical reference.
    pub fn cancelCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: cancel_capacity_reservation.CancelCapacityReservationInput, options: cancel_capacity_reservation.Options) !cancel_capacity_reservation.CancelCapacityReservationOutput {
        return cancel_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Creates a capacity reservation with the specified name and number of
    /// requested data
    /// processing units.
    pub fn createCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: create_capacity_reservation.CreateCapacityReservationInput, options: create_capacity_reservation.Options) !create_capacity_reservation.CreateCapacityReservationOutput {
        return create_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Creates (registers) a data catalog with the specified name and properties.
    /// Catalogs
    /// created are visible to all users of the same Amazon Web Services account.
    ///
    /// For a `FEDERATED` catalog, this API operation creates the following
    /// resources.
    ///
    /// * CFN Stack Name with a maximum length of 128 characters and prefix
    /// `athenafederatedcatalog-CATALOG_NAME_SANITIZED` with length 23
    /// characters.
    ///
    /// * Lambda Function Name with a maximum length of 64 characters and prefix
    /// `athenafederatedcatalog_CATALOG_NAME_SANITIZED` with length 23
    /// characters.
    ///
    /// * Glue Connection Name with a maximum length of 255 characters and a prefix
    /// `athenafederatedcatalog_CATALOG_NAME_SANITIZED` with length 23
    /// characters.
    pub fn createDataCatalog(self: *Self, allocator: std.mem.Allocator, input: create_data_catalog.CreateDataCatalogInput, options: create_data_catalog.Options) !create_data_catalog.CreateDataCatalogOutput {
        return create_data_catalog.execute(self, allocator, input, options);
    }

    /// Creates a named query in the specified workgroup. Requires that you have
    /// access to the
    /// workgroup.
    pub fn createNamedQuery(self: *Self, allocator: std.mem.Allocator, input: create_named_query.CreateNamedQueryInput, options: create_named_query.Options) !create_named_query.CreateNamedQueryOutput {
        return create_named_query.execute(self, allocator, input, options);
    }

    /// Creates an empty `ipynb` file in the specified Apache Spark enabled
    /// workgroup. Throws an error if a file in the workgroup with the same name
    /// already
    /// exists.
    pub fn createNotebook(self: *Self, allocator: std.mem.Allocator, input: create_notebook.CreateNotebookInput, options: create_notebook.Options) !create_notebook.CreateNotebookOutput {
        return create_notebook.execute(self, allocator, input, options);
    }

    /// Creates a prepared statement for use with SQL queries in Athena.
    pub fn createPreparedStatement(self: *Self, allocator: std.mem.Allocator, input: create_prepared_statement.CreatePreparedStatementInput, options: create_prepared_statement.Options) !create_prepared_statement.CreatePreparedStatementOutput {
        return create_prepared_statement.execute(self, allocator, input, options);
    }

    /// Gets an authentication token and the URL at which the notebook can be
    /// accessed. During
    /// programmatic access, `CreatePresignedNotebookUrl` must be called every 10
    /// minutes to refresh the authentication token. For information about granting
    /// programmatic
    /// access, see [Grant
    /// programmatic
    /// access](https://docs.aws.amazon.com/athena/latest/ug/setting-up.html#setting-up-grant-programmatic-access).
    pub fn createPresignedNotebookUrl(self: *Self, allocator: std.mem.Allocator, input: create_presigned_notebook_url.CreatePresignedNotebookUrlInput, options: create_presigned_notebook_url.Options) !create_presigned_notebook_url.CreatePresignedNotebookUrlOutput {
        return create_presigned_notebook_url.execute(self, allocator, input, options);
    }

    /// Creates a workgroup with the specified name. A workgroup can be an Apache
    /// Spark
    /// enabled workgroup or an Athena SQL workgroup.
    pub fn createWorkGroup(self: *Self, allocator: std.mem.Allocator, input: create_work_group.CreateWorkGroupInput, options: create_work_group.Options) !create_work_group.CreateWorkGroupOutput {
        return create_work_group.execute(self, allocator, input, options);
    }

    /// Deletes a cancelled capacity reservation. A reservation must be cancelled
    /// before it
    /// can be deleted. A deleted reservation is immediately removed from your
    /// account and can
    /// no longer be referenced, including by its ARN. A deleted reservation cannot
    /// be called by
    /// `GetCapacityReservation`, and deleted reservations do not appear in the
    /// output of `ListCapacityReservations`.
    pub fn deleteCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: delete_capacity_reservation.DeleteCapacityReservationInput, options: delete_capacity_reservation.Options) !delete_capacity_reservation.DeleteCapacityReservationOutput {
        return delete_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Deletes a data catalog.
    pub fn deleteDataCatalog(self: *Self, allocator: std.mem.Allocator, input: delete_data_catalog.DeleteDataCatalogInput, options: delete_data_catalog.Options) !delete_data_catalog.DeleteDataCatalogOutput {
        return delete_data_catalog.execute(self, allocator, input, options);
    }

    /// Deletes the named query if you have access to the workgroup in which the
    /// query was
    /// saved.
    pub fn deleteNamedQuery(self: *Self, allocator: std.mem.Allocator, input: delete_named_query.DeleteNamedQueryInput, options: delete_named_query.Options) !delete_named_query.DeleteNamedQueryOutput {
        return delete_named_query.execute(self, allocator, input, options);
    }

    /// Deletes the specified notebook.
    pub fn deleteNotebook(self: *Self, allocator: std.mem.Allocator, input: delete_notebook.DeleteNotebookInput, options: delete_notebook.Options) !delete_notebook.DeleteNotebookOutput {
        return delete_notebook.execute(self, allocator, input, options);
    }

    /// Deletes the prepared statement with the specified name from the specified
    /// workgroup.
    pub fn deletePreparedStatement(self: *Self, allocator: std.mem.Allocator, input: delete_prepared_statement.DeletePreparedStatementInput, options: delete_prepared_statement.Options) !delete_prepared_statement.DeletePreparedStatementOutput {
        return delete_prepared_statement.execute(self, allocator, input, options);
    }

    /// Deletes the workgroup with the specified name. The primary workgroup cannot
    /// be
    /// deleted.
    pub fn deleteWorkGroup(self: *Self, allocator: std.mem.Allocator, input: delete_work_group.DeleteWorkGroupInput, options: delete_work_group.Options) !delete_work_group.DeleteWorkGroupOutput {
        return delete_work_group.execute(self, allocator, input, options);
    }

    /// Exports the specified notebook and its metadata.
    pub fn exportNotebook(self: *Self, allocator: std.mem.Allocator, input: export_notebook.ExportNotebookInput, options: export_notebook.Options) !export_notebook.ExportNotebookOutput {
        return export_notebook.execute(self, allocator, input, options);
    }

    /// Describes a previously submitted calculation execution.
    pub fn getCalculationExecution(self: *Self, allocator: std.mem.Allocator, input: get_calculation_execution.GetCalculationExecutionInput, options: get_calculation_execution.Options) !get_calculation_execution.GetCalculationExecutionOutput {
        return get_calculation_execution.execute(self, allocator, input, options);
    }

    /// Retrieves the unencrypted code that was executed for the calculation.
    pub fn getCalculationExecutionCode(self: *Self, allocator: std.mem.Allocator, input: get_calculation_execution_code.GetCalculationExecutionCodeInput, options: get_calculation_execution_code.Options) !get_calculation_execution_code.GetCalculationExecutionCodeOutput {
        return get_calculation_execution_code.execute(self, allocator, input, options);
    }

    /// Gets the status of a current calculation.
    pub fn getCalculationExecutionStatus(self: *Self, allocator: std.mem.Allocator, input: get_calculation_execution_status.GetCalculationExecutionStatusInput, options: get_calculation_execution_status.Options) !get_calculation_execution_status.GetCalculationExecutionStatusOutput {
        return get_calculation_execution_status.execute(self, allocator, input, options);
    }

    /// Gets the capacity assignment configuration for a capacity reservation, if
    /// one
    /// exists.
    pub fn getCapacityAssignmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_capacity_assignment_configuration.GetCapacityAssignmentConfigurationInput, options: get_capacity_assignment_configuration.Options) !get_capacity_assignment_configuration.GetCapacityAssignmentConfigurationOutput {
        return get_capacity_assignment_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about the capacity reservation with the specified name.
    pub fn getCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: get_capacity_reservation.GetCapacityReservationInput, options: get_capacity_reservation.Options) !get_capacity_reservation.GetCapacityReservationOutput {
        return get_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Returns the specified data catalog.
    pub fn getDataCatalog(self: *Self, allocator: std.mem.Allocator, input: get_data_catalog.GetDataCatalogInput, options: get_data_catalog.Options) !get_data_catalog.GetDataCatalogOutput {
        return get_data_catalog.execute(self, allocator, input, options);
    }

    /// Returns a database object for the specified database and data catalog.
    pub fn getDatabase(self: *Self, allocator: std.mem.Allocator, input: get_database.GetDatabaseInput, options: get_database.Options) !get_database.GetDatabaseOutput {
        return get_database.execute(self, allocator, input, options);
    }

    /// Returns information about a single query. Requires that you have access to
    /// the
    /// workgroup in which the query was saved.
    pub fn getNamedQuery(self: *Self, allocator: std.mem.Allocator, input: get_named_query.GetNamedQueryInput, options: get_named_query.Options) !get_named_query.GetNamedQueryOutput {
        return get_named_query.execute(self, allocator, input, options);
    }

    /// Retrieves notebook metadata for the specified notebook ID.
    pub fn getNotebookMetadata(self: *Self, allocator: std.mem.Allocator, input: get_notebook_metadata.GetNotebookMetadataInput, options: get_notebook_metadata.Options) !get_notebook_metadata.GetNotebookMetadataOutput {
        return get_notebook_metadata.execute(self, allocator, input, options);
    }

    /// Retrieves the prepared statement with the specified name from the specified
    /// workgroup.
    pub fn getPreparedStatement(self: *Self, allocator: std.mem.Allocator, input: get_prepared_statement.GetPreparedStatementInput, options: get_prepared_statement.Options) !get_prepared_statement.GetPreparedStatementOutput {
        return get_prepared_statement.execute(self, allocator, input, options);
    }

    /// Returns information about a single execution of a query if you have access
    /// to the
    /// workgroup in which the query ran. Each time a query executes, information
    /// about the
    /// query execution is saved with a unique ID.
    pub fn getQueryExecution(self: *Self, allocator: std.mem.Allocator, input: get_query_execution.GetQueryExecutionInput, options: get_query_execution.Options) !get_query_execution.GetQueryExecutionOutput {
        return get_query_execution.execute(self, allocator, input, options);
    }

    /// Streams the results of a single query execution specified by
    /// `QueryExecutionId` from the Athena query results location in
    /// Amazon S3. For more information, see [Working with query results, recent
    /// queries, and
    /// output files](https://docs.aws.amazon.com/athena/latest/ug/querying.html) in
    /// the *Amazon Athena User Guide*.
    /// This request does not execute the query but returns results. Use
    /// StartQueryExecution to run a query.
    ///
    /// To stream query results successfully, the IAM principal with permission to
    /// call
    /// `GetQueryResults` also must have permissions to the Amazon S3
    /// `GetObject` action for the Athena query results location.
    ///
    /// IAM principals with permission to the Amazon S3
    /// `GetObject` action for the query results location are able to retrieve
    /// query results from Amazon S3 even if permission to the
    /// `GetQueryResults` action is denied. To restrict user or role access,
    /// ensure that Amazon S3 permissions to the Athena query location
    /// are denied.
    pub fn getQueryResults(self: *Self, allocator: std.mem.Allocator, input: get_query_results.GetQueryResultsInput, options: get_query_results.Options) !get_query_results.GetQueryResultsOutput {
        return get_query_results.execute(self, allocator, input, options);
    }

    /// Returns query execution runtime statistics related to a single execution of
    /// a query if
    /// you have access to the workgroup in which the query ran. Statistics from the
    /// `Timeline` section of the response object are available as soon as
    /// QueryExecutionStatus$State is in a SUCCEEDED or FAILED state. The
    /// remaining non-timeline statistics in the response (like stage-level input
    /// and output row
    /// count and data size) are updated asynchronously and may not be available
    /// immediately
    /// after a query completes or, in some cases, may not be returned. The
    /// non-timeline
    /// statistics are also not included when a query has row-level filters defined
    /// in Lake Formation.
    pub fn getQueryRuntimeStatistics(self: *Self, allocator: std.mem.Allocator, input: get_query_runtime_statistics.GetQueryRuntimeStatisticsInput, options: get_query_runtime_statistics.Options) !get_query_runtime_statistics.GetQueryRuntimeStatisticsOutput {
        return get_query_runtime_statistics.execute(self, allocator, input, options);
    }

    /// Gets the Live UI/Persistence UI for a session.
    pub fn getResourceDashboard(self: *Self, allocator: std.mem.Allocator, input: get_resource_dashboard.GetResourceDashboardInput, options: get_resource_dashboard.Options) !get_resource_dashboard.GetResourceDashboardOutput {
        return get_resource_dashboard.execute(self, allocator, input, options);
    }

    /// Gets the full details of a previously created session, including the session
    /// status
    /// and configuration.
    pub fn getSession(self: *Self, allocator: std.mem.Allocator, input: get_session.GetSessionInput, options: get_session.Options) !get_session.GetSessionOutput {
        return get_session.execute(self, allocator, input, options);
    }

    /// Gets a connection endpoint and authentication token for a given session Id.
    pub fn getSessionEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_session_endpoint.GetSessionEndpointInput, options: get_session_endpoint.Options) !get_session_endpoint.GetSessionEndpointOutput {
        return get_session_endpoint.execute(self, allocator, input, options);
    }

    /// Gets the current status of a session.
    pub fn getSessionStatus(self: *Self, allocator: std.mem.Allocator, input: get_session_status.GetSessionStatusInput, options: get_session_status.Options) !get_session_status.GetSessionStatusOutput {
        return get_session_status.execute(self, allocator, input, options);
    }

    /// Returns table metadata for the specified catalog, database, and table.
    pub fn getTableMetadata(self: *Self, allocator: std.mem.Allocator, input: get_table_metadata.GetTableMetadataInput, options: get_table_metadata.Options) !get_table_metadata.GetTableMetadataOutput {
        return get_table_metadata.execute(self, allocator, input, options);
    }

    /// Returns information about the workgroup with the specified name.
    pub fn getWorkGroup(self: *Self, allocator: std.mem.Allocator, input: get_work_group.GetWorkGroupInput, options: get_work_group.Options) !get_work_group.GetWorkGroupOutput {
        return get_work_group.execute(self, allocator, input, options);
    }

    /// Imports a single `ipynb` file to a Spark enabled workgroup. To import the
    /// notebook, the request must specify a value for either `Payload` or
    /// `NoteBookS3LocationUri`. If neither is specified or both are specified,
    /// an `InvalidRequestException` occurs. The maximum file size that can be
    /// imported is 10 megabytes. If an `ipynb` file with the same name already
    /// exists in the workgroup, throws an error.
    pub fn importNotebook(self: *Self, allocator: std.mem.Allocator, input: import_notebook.ImportNotebookInput, options: import_notebook.Options) !import_notebook.ImportNotebookOutput {
        return import_notebook.execute(self, allocator, input, options);
    }

    /// Returns the supported DPU sizes for the supported application runtimes (for
    /// example,
    /// `Athena notebook version 1`).
    pub fn listApplicationDpuSizes(self: *Self, allocator: std.mem.Allocator, input: list_application_dpu_sizes.ListApplicationDPUSizesInput, options: list_application_dpu_sizes.Options) !list_application_dpu_sizes.ListApplicationDPUSizesOutput {
        return list_application_dpu_sizes.execute(self, allocator, input, options);
    }

    /// Lists the calculations that have been submitted to a session in descending
    /// order.
    /// Newer calculations are listed first; older calculations are listed later.
    pub fn listCalculationExecutions(self: *Self, allocator: std.mem.Allocator, input: list_calculation_executions.ListCalculationExecutionsInput, options: list_calculation_executions.Options) !list_calculation_executions.ListCalculationExecutionsOutput {
        return list_calculation_executions.execute(self, allocator, input, options);
    }

    /// Lists the capacity reservations for the current account.
    pub fn listCapacityReservations(self: *Self, allocator: std.mem.Allocator, input: list_capacity_reservations.ListCapacityReservationsInput, options: list_capacity_reservations.Options) !list_capacity_reservations.ListCapacityReservationsOutput {
        return list_capacity_reservations.execute(self, allocator, input, options);
    }

    /// Lists the data catalogs in the current Amazon Web Services account.
    ///
    /// In the Athena console, data catalogs are listed as "data sources" on
    /// the **Data sources** page under the **Data source name** column.
    pub fn listDataCatalogs(self: *Self, allocator: std.mem.Allocator, input: list_data_catalogs.ListDataCatalogsInput, options: list_data_catalogs.Options) !list_data_catalogs.ListDataCatalogsOutput {
        return list_data_catalogs.execute(self, allocator, input, options);
    }

    /// Lists the databases in the specified data catalog.
    pub fn listDatabases(self: *Self, allocator: std.mem.Allocator, input: list_databases.ListDatabasesInput, options: list_databases.Options) !list_databases.ListDatabasesOutput {
        return list_databases.execute(self, allocator, input, options);
    }

    /// Returns a list of engine versions that are available to choose from,
    /// including the
    /// Auto option.
    pub fn listEngineVersions(self: *Self, allocator: std.mem.Allocator, input: list_engine_versions.ListEngineVersionsInput, options: list_engine_versions.Options) !list_engine_versions.ListEngineVersionsOutput {
        return list_engine_versions.execute(self, allocator, input, options);
    }

    /// Lists, in descending order, the executors that joined a session. Newer
    /// executors are
    /// listed first; older executors are listed later. The result can be optionally
    /// filtered by
    /// state.
    pub fn listExecutors(self: *Self, allocator: std.mem.Allocator, input: list_executors.ListExecutorsInput, options: list_executors.Options) !list_executors.ListExecutorsOutput {
        return list_executors.execute(self, allocator, input, options);
    }

    /// Provides a list of available query IDs only for queries saved in the
    /// specified
    /// workgroup. Requires that you have access to the specified workgroup. If a
    /// workgroup is
    /// not specified, lists the saved queries for the primary workgroup.
    pub fn listNamedQueries(self: *Self, allocator: std.mem.Allocator, input: list_named_queries.ListNamedQueriesInput, options: list_named_queries.Options) !list_named_queries.ListNamedQueriesOutput {
        return list_named_queries.execute(self, allocator, input, options);
    }

    /// Displays the notebook files for the specified workgroup in paginated format.
    pub fn listNotebookMetadata(self: *Self, allocator: std.mem.Allocator, input: list_notebook_metadata.ListNotebookMetadataInput, options: list_notebook_metadata.Options) !list_notebook_metadata.ListNotebookMetadataOutput {
        return list_notebook_metadata.execute(self, allocator, input, options);
    }

    /// Lists, in descending order, the sessions that have been created in a
    /// notebook that are
    /// in an active state like `CREATING`, `CREATED`, `IDLE`
    /// or `BUSY`. Newer sessions are listed first; older sessions are listed
    /// later.
    pub fn listNotebookSessions(self: *Self, allocator: std.mem.Allocator, input: list_notebook_sessions.ListNotebookSessionsInput, options: list_notebook_sessions.Options) !list_notebook_sessions.ListNotebookSessionsOutput {
        return list_notebook_sessions.execute(self, allocator, input, options);
    }

    /// Lists the prepared statements in the specified workgroup.
    pub fn listPreparedStatements(self: *Self, allocator: std.mem.Allocator, input: list_prepared_statements.ListPreparedStatementsInput, options: list_prepared_statements.Options) !list_prepared_statements.ListPreparedStatementsOutput {
        return list_prepared_statements.execute(self, allocator, input, options);
    }

    /// Provides a list of available query execution IDs for the queries in the
    /// specified
    /// workgroup. Athena keeps a query history for 45 days. If a workgroup is not
    /// specified, returns a list of query execution IDs for the primary workgroup.
    /// Requires you
    /// to have access to the workgroup in which the queries ran.
    pub fn listQueryExecutions(self: *Self, allocator: std.mem.Allocator, input: list_query_executions.ListQueryExecutionsInput, options: list_query_executions.Options) !list_query_executions.ListQueryExecutionsOutput {
        return list_query_executions.execute(self, allocator, input, options);
    }

    /// Lists the sessions in a workgroup that are in an active state like
    /// `CREATING`, `CREATED`, `IDLE`, or
    /// `BUSY`. Newer sessions are listed first; older sessions are listed
    /// later.
    pub fn listSessions(self: *Self, allocator: std.mem.Allocator, input: list_sessions.ListSessionsInput, options: list_sessions.Options) !list_sessions.ListSessionsOutput {
        return list_sessions.execute(self, allocator, input, options);
    }

    /// Lists the metadata for the tables in the specified data catalog database.
    pub fn listTableMetadata(self: *Self, allocator: std.mem.Allocator, input: list_table_metadata.ListTableMetadataInput, options: list_table_metadata.Options) !list_table_metadata.ListTableMetadataOutput {
        return list_table_metadata.execute(self, allocator, input, options);
    }

    /// Lists the tags associated with an Athena resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Lists available workgroups for the account.
    pub fn listWorkGroups(self: *Self, allocator: std.mem.Allocator, input: list_work_groups.ListWorkGroupsInput, options: list_work_groups.Options) !list_work_groups.ListWorkGroupsOutput {
        return list_work_groups.execute(self, allocator, input, options);
    }

    /// Puts a new capacity assignment configuration for a specified capacity
    /// reservation. If
    /// a capacity assignment configuration already exists for the capacity
    /// reservation,
    /// replaces the existing capacity assignment configuration.
    pub fn putCapacityAssignmentConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_capacity_assignment_configuration.PutCapacityAssignmentConfigurationInput, options: put_capacity_assignment_configuration.Options) !put_capacity_assignment_configuration.PutCapacityAssignmentConfigurationOutput {
        return put_capacity_assignment_configuration.execute(self, allocator, input, options);
    }

    /// Submits calculations for execution within a session. You can supply the code
    /// to run as
    /// an inline code block within the request.
    ///
    /// The request syntax requires the StartCalculationExecutionRequest$CodeBlock
    /// parameter or the CalculationConfiguration$CodeBlock parameter, but not both.
    /// Because
    /// CalculationConfiguration$CodeBlock is deprecated, use the
    /// StartCalculationExecutionRequest$CodeBlock parameter
    /// instead.
    pub fn startCalculationExecution(self: *Self, allocator: std.mem.Allocator, input: start_calculation_execution.StartCalculationExecutionInput, options: start_calculation_execution.Options) !start_calculation_execution.StartCalculationExecutionOutput {
        return start_calculation_execution.execute(self, allocator, input, options);
    }

    /// Runs the SQL query statements contained in the `Query`. Requires you to
    /// have access to the workgroup in which the query ran. Running queries against
    /// an external
    /// catalog requires GetDataCatalog permission to the catalog. For code
    /// samples using the Amazon Web Services SDK for Java, see [Examples and
    /// Code Samples](http://docs.aws.amazon.com/athena/latest/ug/code-samples.html)
    /// in the *Amazon Athena User
    /// Guide*.
    pub fn startQueryExecution(self: *Self, allocator: std.mem.Allocator, input: start_query_execution.StartQueryExecutionInput, options: start_query_execution.Options) !start_query_execution.StartQueryExecutionOutput {
        return start_query_execution.execute(self, allocator, input, options);
    }

    /// Creates a session for running calculations within a workgroup. The session
    /// is ready
    /// when it reaches an `IDLE` state.
    pub fn startSession(self: *Self, allocator: std.mem.Allocator, input: start_session.StartSessionInput, options: start_session.Options) !start_session.StartSessionOutput {
        return start_session.execute(self, allocator, input, options);
    }

    /// Requests the cancellation of a calculation. A `StopCalculationExecution`
    /// call on a calculation that is already in a terminal state (for example,
    /// `STOPPED`, `FAILED`, or `COMPLETED`) succeeds but
    /// has no effect.
    ///
    /// Cancelling a calculation is done on a best effort basis. If a calculation
    /// cannot
    /// be cancelled, you can be charged for its completion. If you are concerned
    /// about
    /// being charged for a calculation that cannot be cancelled, consider
    /// terminating the
    /// session in which the calculation is running.
    pub fn stopCalculationExecution(self: *Self, allocator: std.mem.Allocator, input: stop_calculation_execution.StopCalculationExecutionInput, options: stop_calculation_execution.Options) !stop_calculation_execution.StopCalculationExecutionOutput {
        return stop_calculation_execution.execute(self, allocator, input, options);
    }

    /// Stops a query execution. Requires you to have access to the workgroup in
    /// which the
    /// query ran.
    pub fn stopQueryExecution(self: *Self, allocator: std.mem.Allocator, input: stop_query_execution.StopQueryExecutionInput, options: stop_query_execution.Options) !stop_query_execution.StopQueryExecutionOutput {
        return stop_query_execution.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to an Athena resource. A tag is a label that you
    /// assign to a resource. Each tag consists of a key and an optional value, both
    /// of which
    /// you define. For example, you can use tags to categorize Athena workgroups,
    /// data catalogs, or capacity reservations by purpose, owner, or environment.
    /// Use a
    /// consistent set of tag keys to make it easier to search and filter the
    /// resources in your
    /// account. For best practices, see [Tagging
    /// Best
    /// Practices](https://docs.aws.amazon.com/whitepapers/latest/tagging-best-practices/tagging-best-practices.html). Tag keys can be from 1 to 128 UTF-8 Unicode characters, and
    /// tag values can be from 0 to 256 UTF-8 Unicode characters. Tags can use
    /// letters and
    /// numbers representable in UTF-8, and the following characters: + - = . _ : /
    /// @. Tag keys
    /// and values are case-sensitive. Tag keys must be unique per resource. If you
    /// specify more
    /// than one tag, separate them by commas.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Terminates an active session. A `TerminateSession` call on a session that
    /// is already inactive (for example, in a `FAILED`, `TERMINATED` or
    /// `TERMINATING` state) succeeds but has no effect. Calculations running in
    /// the session when `TerminateSession` is called are forcefully stopped, but
    /// may
    /// display as `FAILED` instead of `STOPPED`.
    pub fn terminateSession(self: *Self, allocator: std.mem.Allocator, input: terminate_session.TerminateSessionInput, options: terminate_session.Options) !terminate_session.TerminateSessionOutput {
        return terminate_session.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from an Athena resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the number of requested data processing units for the capacity
    /// reservation
    /// with the specified name.
    pub fn updateCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: update_capacity_reservation.UpdateCapacityReservationInput, options: update_capacity_reservation.Options) !update_capacity_reservation.UpdateCapacityReservationOutput {
        return update_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Updates the data catalog that has the specified name.
    pub fn updateDataCatalog(self: *Self, allocator: std.mem.Allocator, input: update_data_catalog.UpdateDataCatalogInput, options: update_data_catalog.Options) !update_data_catalog.UpdateDataCatalogOutput {
        return update_data_catalog.execute(self, allocator, input, options);
    }

    /// Updates a NamedQuery object. The database or workgroup cannot be
    /// updated.
    pub fn updateNamedQuery(self: *Self, allocator: std.mem.Allocator, input: update_named_query.UpdateNamedQueryInput, options: update_named_query.Options) !update_named_query.UpdateNamedQueryOutput {
        return update_named_query.execute(self, allocator, input, options);
    }

    /// Updates the contents of a Spark notebook.
    pub fn updateNotebook(self: *Self, allocator: std.mem.Allocator, input: update_notebook.UpdateNotebookInput, options: update_notebook.Options) !update_notebook.UpdateNotebookOutput {
        return update_notebook.execute(self, allocator, input, options);
    }

    /// Updates the metadata for a notebook.
    pub fn updateNotebookMetadata(self: *Self, allocator: std.mem.Allocator, input: update_notebook_metadata.UpdateNotebookMetadataInput, options: update_notebook_metadata.Options) !update_notebook_metadata.UpdateNotebookMetadataOutput {
        return update_notebook_metadata.execute(self, allocator, input, options);
    }

    /// Updates a prepared statement.
    pub fn updatePreparedStatement(self: *Self, allocator: std.mem.Allocator, input: update_prepared_statement.UpdatePreparedStatementInput, options: update_prepared_statement.Options) !update_prepared_statement.UpdatePreparedStatementOutput {
        return update_prepared_statement.execute(self, allocator, input, options);
    }

    /// Updates the workgroup with the specified name. The workgroup's name cannot
    /// be changed.
    /// Only `ConfigurationUpdates` can be specified.
    pub fn updateWorkGroup(self: *Self, allocator: std.mem.Allocator, input: update_work_group.UpdateWorkGroupInput, options: update_work_group.Options) !update_work_group.UpdateWorkGroupOutput {
        return update_work_group.execute(self, allocator, input, options);
    }

    pub fn getQueryResultsPaginator(self: *Self, params: get_query_results.GetQueryResultsInput) paginator.GetQueryResultsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationDpuSizesPaginator(self: *Self, params: list_application_dpu_sizes.ListApplicationDPUSizesInput) paginator.ListApplicationDPUSizesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCalculationExecutionsPaginator(self: *Self, params: list_calculation_executions.ListCalculationExecutionsInput) paginator.ListCalculationExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCapacityReservationsPaginator(self: *Self, params: list_capacity_reservations.ListCapacityReservationsInput) paginator.ListCapacityReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDataCatalogsPaginator(self: *Self, params: list_data_catalogs.ListDataCatalogsInput) paginator.ListDataCatalogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDatabasesPaginator(self: *Self, params: list_databases.ListDatabasesInput) paginator.ListDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEngineVersionsPaginator(self: *Self, params: list_engine_versions.ListEngineVersionsInput) paginator.ListEngineVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExecutorsPaginator(self: *Self, params: list_executors.ListExecutorsInput) paginator.ListExecutorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNamedQueriesPaginator(self: *Self, params: list_named_queries.ListNamedQueriesInput) paginator.ListNamedQueriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPreparedStatementsPaginator(self: *Self, params: list_prepared_statements.ListPreparedStatementsInput) paginator.ListPreparedStatementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listQueryExecutionsPaginator(self: *Self, params: list_query_executions.ListQueryExecutionsInput) paginator.ListQueryExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSessionsPaginator(self: *Self, params: list_sessions.ListSessionsInput) paginator.ListSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTableMetadataPaginator(self: *Self, params: list_table_metadata.ListTableMetadataInput) paginator.ListTableMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listWorkGroupsPaginator(self: *Self, params: list_work_groups.ListWorkGroupsInput) paginator.ListWorkGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
