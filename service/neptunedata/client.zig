const aws = @import("aws");
const std = @import("std");

const cancel_gremlin_query = @import("cancel_gremlin_query.zig");
const cancel_loader_job = @import("cancel_loader_job.zig");
const cancel_ml_data_processing_job = @import("cancel_ml_data_processing_job.zig");
const cancel_ml_model_training_job = @import("cancel_ml_model_training_job.zig");
const cancel_ml_model_transform_job = @import("cancel_ml_model_transform_job.zig");
const cancel_open_cypher_query = @import("cancel_open_cypher_query.zig");
const create_ml_endpoint = @import("create_ml_endpoint.zig");
const delete_ml_endpoint = @import("delete_ml_endpoint.zig");
const delete_propertygraph_statistics = @import("delete_propertygraph_statistics.zig");
const delete_sparql_statistics = @import("delete_sparql_statistics.zig");
const execute_fast_reset = @import("execute_fast_reset.zig");
const execute_gremlin_explain_query = @import("execute_gremlin_explain_query.zig");
const execute_gremlin_profile_query = @import("execute_gremlin_profile_query.zig");
const execute_gremlin_query = @import("execute_gremlin_query.zig");
const execute_open_cypher_explain_query = @import("execute_open_cypher_explain_query.zig");
const execute_open_cypher_query = @import("execute_open_cypher_query.zig");
const get_engine_status = @import("get_engine_status.zig");
const get_gremlin_query_status = @import("get_gremlin_query_status.zig");
const get_loader_job_status = @import("get_loader_job_status.zig");
const get_ml_data_processing_job = @import("get_ml_data_processing_job.zig");
const get_ml_endpoint = @import("get_ml_endpoint.zig");
const get_ml_model_training_job = @import("get_ml_model_training_job.zig");
const get_ml_model_transform_job = @import("get_ml_model_transform_job.zig");
const get_open_cypher_query_status = @import("get_open_cypher_query_status.zig");
const get_propertygraph_statistics = @import("get_propertygraph_statistics.zig");
const get_propertygraph_stream = @import("get_propertygraph_stream.zig");
const get_propertygraph_summary = @import("get_propertygraph_summary.zig");
const get_rdf_graph_summary = @import("get_rdf_graph_summary.zig");
const get_sparql_statistics = @import("get_sparql_statistics.zig");
const get_sparql_stream = @import("get_sparql_stream.zig");
const list_gremlin_queries = @import("list_gremlin_queries.zig");
const list_loader_jobs = @import("list_loader_jobs.zig");
const list_ml_data_processing_jobs = @import("list_ml_data_processing_jobs.zig");
const list_ml_endpoints = @import("list_ml_endpoints.zig");
const list_ml_model_training_jobs = @import("list_ml_model_training_jobs.zig");
const list_ml_model_transform_jobs = @import("list_ml_model_transform_jobs.zig");
const list_open_cypher_queries = @import("list_open_cypher_queries.zig");
const manage_propertygraph_statistics = @import("manage_propertygraph_statistics.zig");
const manage_sparql_statistics = @import("manage_sparql_statistics.zig");
const start_loader_job = @import("start_loader_job.zig");
const start_ml_data_processing_job = @import("start_ml_data_processing_job.zig");
const start_ml_model_training_job = @import("start_ml_model_training_job.zig");
const start_ml_model_transform_job = @import("start_ml_model_transform_job.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "neptunedata";

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

    /// Cancels a Gremlin query. See [Gremlin query
    /// cancellation](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-api-status-cancel.html) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelquery) IAM action in that cluster.
    pub fn cancelGremlinQuery(self: *Self, allocator: std.mem.Allocator, input: cancel_gremlin_query.CancelGremlinQueryInput, options: cancel_gremlin_query.Options) !cancel_gremlin_query.CancelGremlinQueryOutput {
        return cancel_gremlin_query.execute(self, allocator, input, options);
    }

    /// Cancels a specified load job. This is an HTTP `DELETE` request. See [Neptune
    /// Loader Get-Status
    /// API](https://docs.aws.amazon.com/neptune/latest/userguide/load-api-reference-status.htm) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelLoaderJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelloaderjob) IAM action in that cluster..
    pub fn cancelLoaderJob(self: *Self, allocator: std.mem.Allocator, input: cancel_loader_job.CancelLoaderJobInput, options: cancel_loader_job.Options) !cancel_loader_job.CancelLoaderJobOutput {
        return cancel_loader_job.execute(self, allocator, input, options);
    }

    /// Cancels a Neptune ML data processing job. See [The `dataprocessing`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-dataprocessing.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelMLDataProcessingJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelmldataprocessingjob) IAM action in that cluster.
    pub fn cancelMlDataProcessingJob(self: *Self, allocator: std.mem.Allocator, input: cancel_ml_data_processing_job.CancelMLDataProcessingJobInput, options: cancel_ml_data_processing_job.Options) !cancel_ml_data_processing_job.CancelMLDataProcessingJobOutput {
        return cancel_ml_data_processing_job.execute(self, allocator, input, options);
    }

    /// Cancels a Neptune ML model training job. See [Model training using the
    /// `modeltraining`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-modeltraining.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelMLModelTrainingJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelmlmodeltrainingjob) IAM action in that cluster.
    pub fn cancelMlModelTrainingJob(self: *Self, allocator: std.mem.Allocator, input: cancel_ml_model_training_job.CancelMLModelTrainingJobInput, options: cancel_ml_model_training_job.Options) !cancel_ml_model_training_job.CancelMLModelTrainingJobOutput {
        return cancel_ml_model_training_job.execute(self, allocator, input, options);
    }

    /// Cancels a specified model transform job. See [Use a trained model to
    /// generate new model
    /// artifacts](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-model-transform.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelMLModelTransformJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelmlmodeltransformjob) IAM action in that cluster.
    pub fn cancelMlModelTransformJob(self: *Self, allocator: std.mem.Allocator, input: cancel_ml_model_transform_job.CancelMLModelTransformJobInput, options: cancel_ml_model_transform_job.Options) !cancel_ml_model_transform_job.CancelMLModelTransformJobOutput {
        return cancel_ml_model_transform_job.execute(self, allocator, input, options);
    }

    /// Cancels a specified openCypher query. See [Neptune openCypher status
    /// endpoint](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-opencypher-status.html) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CancelQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#cancelquery) IAM action in that cluster.
    pub fn cancelOpenCypherQuery(self: *Self, allocator: std.mem.Allocator, input: cancel_open_cypher_query.CancelOpenCypherQueryInput, options: cancel_open_cypher_query.Options) !cancel_open_cypher_query.CancelOpenCypherQueryOutput {
        return cancel_open_cypher_query.execute(self, allocator, input, options);
    }

    /// Creates a new Neptune ML inference endpoint that lets you query one specific
    /// model that the model-training process constructed. See [Managing inference
    /// endpoints using the endpoints
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-endpoints.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:CreateMLEndpoint](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#createmlendpoint) IAM action in that cluster.
    pub fn createMlEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_ml_endpoint.CreateMLEndpointInput, options: create_ml_endpoint.Options) !create_ml_endpoint.CreateMLEndpointOutput {
        return create_ml_endpoint.execute(self, allocator, input, options);
    }

    /// Cancels the creation of a Neptune ML inference endpoint. See [Managing
    /// inference endpoints using the endpoints
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-endpoints.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:DeleteMLEndpoint](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletemlendpoint) IAM action in that cluster.
    pub fn deleteMlEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_ml_endpoint.DeleteMLEndpointInput, options: delete_ml_endpoint.Options) !delete_ml_endpoint.DeleteMLEndpointOutput {
        return delete_ml_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes statistics for Gremlin and openCypher (property graph) data.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:DeleteStatistics](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletestatistics) IAM action in that cluster.
    pub fn deletePropertygraphStatistics(self: *Self, allocator: std.mem.Allocator, input: delete_propertygraph_statistics.DeletePropertygraphStatisticsInput, options: delete_propertygraph_statistics.Options) !delete_propertygraph_statistics.DeletePropertygraphStatisticsOutput {
        return delete_propertygraph_statistics.execute(self, allocator, input, options);
    }

    /// Deletes SPARQL statistics
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:DeleteStatistics](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletestatistics) IAM action in that cluster.
    pub fn deleteSparqlStatistics(self: *Self, allocator: std.mem.Allocator, input: delete_sparql_statistics.DeleteSparqlStatisticsInput, options: delete_sparql_statistics.Options) !delete_sparql_statistics.DeleteSparqlStatisticsOutput {
        return delete_sparql_statistics.execute(self, allocator, input, options);
    }

    /// The fast reset REST API lets you reset a Neptune graph quicky and easily,
    /// removing all of its data.
    ///
    /// Neptune fast reset is a two-step process. First you call `ExecuteFastReset`
    /// with `action` set to `initiateDatabaseReset`. This returns a UUID token
    /// which you then include when calling `ExecuteFastReset` again with `action`
    /// set to `performDatabaseReset`. See [Empty an Amazon Neptune DB cluster using
    /// the fast reset
    /// API](https://docs.aws.amazon.com/neptune/latest/userguide/manage-console-fast-reset.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ResetDatabase](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#resetdatabase) IAM action in that cluster.
    pub fn executeFastReset(self: *Self, allocator: std.mem.Allocator, input: execute_fast_reset.ExecuteFastResetInput, options: execute_fast_reset.Options) !execute_fast_reset.ExecuteFastResetOutput {
        return execute_fast_reset.execute(self, allocator, input, options);
    }

    /// Executes a Gremlin Explain query.
    ///
    /// Amazon Neptune has added a Gremlin feature named `explain` that provides is
    /// a self-service tool for understanding the execution approach being taken by
    /// the Neptune engine for the query. You invoke it by adding an `explain`
    /// parameter to an HTTP call that submits a Gremlin query.
    ///
    /// The explain feature provides information about the logical structure of
    /// query execution plans. You can use this information to identify potential
    /// evaluation and execution bottlenecks and to tune your query, as explained in
    /// [Tuning Gremlin
    /// queries](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-traversal-tuning.html). You can also use query hints to improve query execution plans.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows one of the following IAM actions in that
    /// cluster, depending on the query:
    ///
    /// *
    ///   [neptune-db:ReadDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#readdataviaquery)
    /// *
    ///   [neptune-db:WriteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#writedataviaquery)
    /// *
    ///   [neptune-db:DeleteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletedataviaquery)
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of Gremlin queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn executeGremlinExplainQuery(self: *Self, allocator: std.mem.Allocator, input: execute_gremlin_explain_query.ExecuteGremlinExplainQueryInput, options: execute_gremlin_explain_query.Options) !execute_gremlin_explain_query.ExecuteGremlinExplainQueryOutput {
        return execute_gremlin_explain_query.execute(self, allocator, input, options);
    }

    /// Executes a Gremlin Profile query, which runs a specified traversal, collects
    /// various metrics about the run, and produces a profile report as output. See
    /// [Gremlin profile API in
    /// Neptune](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-profile-api.html) for details.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ReadDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#readdataviaquery) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of Gremlin queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn executeGremlinProfileQuery(self: *Self, allocator: std.mem.Allocator, input: execute_gremlin_profile_query.ExecuteGremlinProfileQueryInput, options: execute_gremlin_profile_query.Options) !execute_gremlin_profile_query.ExecuteGremlinProfileQueryOutput {
        return execute_gremlin_profile_query.execute(self, allocator, input, options);
    }

    /// This commands executes a Gremlin query. Amazon Neptune is compatible with
    /// Apache TinkerPop3 and Gremlin, so you can use the Gremlin traversal language
    /// to query the graph, as described under [The
    /// Graph](https://tinkerpop.apache.org/docs/current/reference/#graph) in the
    /// Apache TinkerPop3 documentation. More details can also be found in
    /// [Accessing a Neptune graph with
    /// Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-gremlin.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that enables one of the following IAM actions in that
    /// cluster, depending on the query:
    ///
    /// *
    ///   [neptune-db:ReadDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#readdataviaquery)
    /// *
    ///   [neptune-db:WriteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#writedataviaquery)
    /// *
    ///   [neptune-db:DeleteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletedataviaquery)
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of Gremlin queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn executeGremlinQuery(self: *Self, allocator: std.mem.Allocator, input: execute_gremlin_query.ExecuteGremlinQueryInput, options: execute_gremlin_query.Options) !execute_gremlin_query.ExecuteGremlinQueryOutput {
        return execute_gremlin_query.execute(self, allocator, input, options);
    }

    /// Executes an openCypher `explain` request. See [The openCypher explain
    /// feature](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-opencypher-explain.html) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ReadDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#readdataviaquery) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:OpenCypher](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of openCypher queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn executeOpenCypherExplainQuery(self: *Self, allocator: std.mem.Allocator, input: execute_open_cypher_explain_query.ExecuteOpenCypherExplainQueryInput, options: execute_open_cypher_explain_query.Options) !execute_open_cypher_explain_query.ExecuteOpenCypherExplainQueryOutput {
        return execute_open_cypher_explain_query.execute(self, allocator, input, options);
    }

    /// Executes an openCypher query. See [Accessing the Neptune Graph with
    /// openCypher](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-opencypher.html) for more information.
    ///
    /// Neptune supports building graph applications using openCypher, which is
    /// currently one of the most popular query languages among developers working
    /// with graph databases. Developers, business analysts, and data scientists
    /// like openCypher's declarative, SQL-inspired syntax because it provides a
    /// familiar structure in which to querying property graphs.
    ///
    /// The openCypher language was originally developed by Neo4j, then open-sourced
    /// in 2015 and contributed to the [openCypher project](https://opencypher.org/)
    /// under an Apache 2 open-source license.
    ///
    /// Note that when invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows one of the following IAM actions in that
    /// cluster, depending on the query:
    ///
    /// *
    ///   [neptune-db:ReadDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#readdataviaquery)
    /// *
    ///   [neptune-db:WriteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#writedataviaquery)
    /// *
    ///   [neptune-db:DeleteDataViaQuery](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#deletedataviaquery)
    ///
    /// Note also that the
    /// [neptune-db:QueryLanguage:OpenCypher](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of openCypher queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn executeOpenCypherQuery(self: *Self, allocator: std.mem.Allocator, input: execute_open_cypher_query.ExecuteOpenCypherQueryInput, options: execute_open_cypher_query.Options) !execute_open_cypher_query.ExecuteOpenCypherQueryOutput {
        return execute_open_cypher_query.execute(self, allocator, input, options);
    }

    /// Retrieves the status of the graph database on the host.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetEngineStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getenginestatus) IAM action in that cluster.
    pub fn getEngineStatus(self: *Self, allocator: std.mem.Allocator, input: get_engine_status.GetEngineStatusInput, options: get_engine_status.Options) !get_engine_status.GetEngineStatusOutput {
        return get_engine_status.execute(self, allocator, input, options);
    }

    /// Gets the status of a specified Gremlin query.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetQueryStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getquerystatus) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of Gremlin queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn getGremlinQueryStatus(self: *Self, allocator: std.mem.Allocator, input: get_gremlin_query_status.GetGremlinQueryStatusInput, options: get_gremlin_query_status.Options) !get_gremlin_query_status.GetGremlinQueryStatusOutput {
        return get_gremlin_query_status.execute(self, allocator, input, options);
    }

    /// Gets status information about a specified load job. Neptune keeps track of
    /// the most recent 1,024 bulk load jobs, and stores the last 10,000 error
    /// details per job.
    ///
    /// See [Neptune Loader Get-Status
    /// API](https://docs.aws.amazon.com/neptune/latest/userguide/load-api-reference-status.htm) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetLoaderJobStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getloaderjobstatus) IAM action in that cluster..
    pub fn getLoaderJobStatus(self: *Self, allocator: std.mem.Allocator, input: get_loader_job_status.GetLoaderJobStatusInput, options: get_loader_job_status.Options) !get_loader_job_status.GetLoaderJobStatusOutput {
        return get_loader_job_status.execute(self, allocator, input, options);
    }

    /// Retrieves information about a specified data processing job. See [The
    /// `dataprocessing`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-dataprocessing.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:neptune-db:GetMLDataProcessingJobStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getmldataprocessingjobstatus) IAM action in that cluster.
    pub fn getMlDataProcessingJob(self: *Self, allocator: std.mem.Allocator, input: get_ml_data_processing_job.GetMLDataProcessingJobInput, options: get_ml_data_processing_job.Options) !get_ml_data_processing_job.GetMLDataProcessingJobOutput {
        return get_ml_data_processing_job.execute(self, allocator, input, options);
    }

    /// Retrieves details about an inference endpoint. See [Managing inference
    /// endpoints using the endpoints
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-endpoints.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetMLEndpointStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getmlendpointstatus) IAM action in that cluster.
    pub fn getMlEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_ml_endpoint.GetMLEndpointInput, options: get_ml_endpoint.Options) !get_ml_endpoint.GetMLEndpointOutput {
        return get_ml_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves information about a Neptune ML model training job. See [Model
    /// training using the `modeltraining`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-modeltraining.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetMLModelTrainingJobStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getmlmodeltrainingjobstatus) IAM action in that cluster.
    pub fn getMlModelTrainingJob(self: *Self, allocator: std.mem.Allocator, input: get_ml_model_training_job.GetMLModelTrainingJobInput, options: get_ml_model_training_job.Options) !get_ml_model_training_job.GetMLModelTrainingJobOutput {
        return get_ml_model_training_job.execute(self, allocator, input, options);
    }

    /// Gets information about a specified model transform job. See [Use a trained
    /// model to generate new model
    /// artifacts](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-model-transform.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetMLModelTransformJobStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getmlmodeltransformjobstatus) IAM action in that cluster.
    pub fn getMlModelTransformJob(self: *Self, allocator: std.mem.Allocator, input: get_ml_model_transform_job.GetMLModelTransformJobInput, options: get_ml_model_transform_job.Options) !get_ml_model_transform_job.GetMLModelTransformJobOutput {
        return get_ml_model_transform_job.execute(self, allocator, input, options);
    }

    /// Retrieves the status of a specified openCypher query.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetQueryStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getquerystatus) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:OpenCypher](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of openCypher queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn getOpenCypherQueryStatus(self: *Self, allocator: std.mem.Allocator, input: get_open_cypher_query_status.GetOpenCypherQueryStatusInput, options: get_open_cypher_query_status.Options) !get_open_cypher_query_status.GetOpenCypherQueryStatusOutput {
        return get_open_cypher_query_status.execute(self, allocator, input, options);
    }

    /// Gets property graph statistics (Gremlin and openCypher).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetStatisticsStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getstatisticsstatus) IAM action in that cluster.
    pub fn getPropertygraphStatistics(self: *Self, allocator: std.mem.Allocator, input: get_propertygraph_statistics.GetPropertygraphStatisticsInput, options: get_propertygraph_statistics.Options) !get_propertygraph_statistics.GetPropertygraphStatisticsOutput {
        return get_propertygraph_statistics.execute(self, allocator, input, options);
    }

    /// Gets a stream for a property graph.
    ///
    /// With the Neptune Streams feature, you can generate a complete sequence of
    /// change-log entries that record every change made to your graph data as it
    /// happens. `GetPropertygraphStream` lets you collect these change-log entries
    /// for a property graph.
    ///
    /// The Neptune streams feature needs to be enabled on your Neptune DBcluster.
    /// To enable streams, set the
    /// [neptune_streams](https://docs.aws.amazon.com/neptune/latest/userguide/parameters.html#parameters-db-cluster-parameters-neptune_streams) DB cluster parameter to `1`.
    ///
    /// See [Capturing graph changes in real time using Neptune
    /// streams](https://docs.aws.amazon.com/neptune/latest/userguide/streams.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetStreamRecords](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getstreamrecords) IAM action in that cluster.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that enables one of the following IAM actions, depending on
    /// the query:
    ///
    /// Note that you can restrict property-graph queries using the following IAM
    /// context keys:
    ///
    /// *
    ///   [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys)
    /// *
    ///   [neptune-db:QueryLanguage:OpenCypher](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys)
    ///
    /// See [Condition keys available in Neptune IAM data-access policy
    /// statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn getPropertygraphStream(self: *Self, allocator: std.mem.Allocator, input: get_propertygraph_stream.GetPropertygraphStreamInput, options: get_propertygraph_stream.Options) !get_propertygraph_stream.GetPropertygraphStreamOutput {
        return get_propertygraph_stream.execute(self, allocator, input, options);
    }

    /// Gets a graph summary for a property graph.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetGraphSummary](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getgraphsummary) IAM action in that cluster.
    pub fn getPropertygraphSummary(self: *Self, allocator: std.mem.Allocator, input: get_propertygraph_summary.GetPropertygraphSummaryInput, options: get_propertygraph_summary.Options) !get_propertygraph_summary.GetPropertygraphSummaryOutput {
        return get_propertygraph_summary.execute(self, allocator, input, options);
    }

    /// Gets a graph summary for an RDF graph.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetGraphSummary](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getgraphsummary) IAM action in that cluster.
    pub fn getRdfGraphSummary(self: *Self, allocator: std.mem.Allocator, input: get_rdf_graph_summary.GetRDFGraphSummaryInput, options: get_rdf_graph_summary.Options) !get_rdf_graph_summary.GetRDFGraphSummaryOutput {
        return get_rdf_graph_summary.execute(self, allocator, input, options);
    }

    /// Gets RDF statistics (SPARQL).
    pub fn getSparqlStatistics(self: *Self, allocator: std.mem.Allocator, input: get_sparql_statistics.GetSparqlStatisticsInput, options: get_sparql_statistics.Options) !get_sparql_statistics.GetSparqlStatisticsOutput {
        return get_sparql_statistics.execute(self, allocator, input, options);
    }

    /// Gets a stream for an RDF graph.
    ///
    /// With the Neptune Streams feature, you can generate a complete sequence of
    /// change-log entries that record every change made to your graph data as it
    /// happens. `GetSparqlStream` lets you collect these change-log entries for an
    /// RDF graph.
    ///
    /// The Neptune streams feature needs to be enabled on your Neptune DBcluster.
    /// To enable streams, set the
    /// [neptune_streams](https://docs.aws.amazon.com/neptune/latest/userguide/parameters.html#parameters-db-cluster-parameters-neptune_streams) DB cluster parameter to `1`.
    ///
    /// See [Capturing graph changes in real time using Neptune
    /// streams](https://docs.aws.amazon.com/neptune/latest/userguide/streams.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetStreamRecords](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getstreamrecords) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Sparql](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of SPARQL queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn getSparqlStream(self: *Self, allocator: std.mem.Allocator, input: get_sparql_stream.GetSparqlStreamInput, options: get_sparql_stream.Options) !get_sparql_stream.GetSparqlStreamOutput {
        return get_sparql_stream.execute(self, allocator, input, options);
    }

    /// Lists active Gremlin queries. See [Gremlin query status
    /// API](https://docs.aws.amazon.com/neptune/latest/userguide/gremlin-api-status.html) for details about the output.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetQueryStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getquerystatus) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:Gremlin](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of Gremlin queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn listGremlinQueries(self: *Self, allocator: std.mem.Allocator, input: list_gremlin_queries.ListGremlinQueriesInput, options: list_gremlin_queries.Options) !list_gremlin_queries.ListGremlinQueriesOutput {
        return list_gremlin_queries.execute(self, allocator, input, options);
    }

    /// Retrieves a list of the `loadIds` for all active loader jobs.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ListLoaderJobs](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#listloaderjobs) IAM action in that cluster..
    pub fn listLoaderJobs(self: *Self, allocator: std.mem.Allocator, input: list_loader_jobs.ListLoaderJobsInput, options: list_loader_jobs.Options) !list_loader_jobs.ListLoaderJobsOutput {
        return list_loader_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of Neptune ML data processing jobs. See [Listing active
    /// data-processing jobs using the Neptune ML dataprocessing
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-dataprocessing.html#machine-learning-api-dataprocessing-list-jobs).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ListMLDataProcessingJobs](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#listmldataprocessingjobs) IAM action in that cluster.
    pub fn listMlDataProcessingJobs(self: *Self, allocator: std.mem.Allocator, input: list_ml_data_processing_jobs.ListMLDataProcessingJobsInput, options: list_ml_data_processing_jobs.Options) !list_ml_data_processing_jobs.ListMLDataProcessingJobsOutput {
        return list_ml_data_processing_jobs.execute(self, allocator, input, options);
    }

    /// Lists existing inference endpoints. See [Managing inference endpoints using
    /// the endpoints
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-endpoints.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ListMLEndpoints](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#listmlendpoints) IAM action in that cluster.
    pub fn listMlEndpoints(self: *Self, allocator: std.mem.Allocator, input: list_ml_endpoints.ListMLEndpointsInput, options: list_ml_endpoints.Options) !list_ml_endpoints.ListMLEndpointsOutput {
        return list_ml_endpoints.execute(self, allocator, input, options);
    }

    /// Lists Neptune ML model-training jobs. See [Model training using the
    /// `modeltraining`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-modeltraining.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:neptune-db:ListMLModelTrainingJobs](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#neptune-db:listmlmodeltrainingjobs) IAM action in that cluster.
    pub fn listMlModelTrainingJobs(self: *Self, allocator: std.mem.Allocator, input: list_ml_model_training_jobs.ListMLModelTrainingJobsInput, options: list_ml_model_training_jobs.Options) !list_ml_model_training_jobs.ListMLModelTrainingJobsOutput {
        return list_ml_model_training_jobs.execute(self, allocator, input, options);
    }

    /// Returns a list of model transform job IDs. See [Use a trained model to
    /// generate new model
    /// artifacts](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-model-transform.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ListMLModelTransformJobs](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#listmlmodeltransformjobs) IAM action in that cluster.
    pub fn listMlModelTransformJobs(self: *Self, allocator: std.mem.Allocator, input: list_ml_model_transform_jobs.ListMLModelTransformJobsInput, options: list_ml_model_transform_jobs.Options) !list_ml_model_transform_jobs.ListMLModelTransformJobsOutput {
        return list_ml_model_transform_jobs.execute(self, allocator, input, options);
    }

    /// Lists active openCypher queries. See [Neptune openCypher status
    /// endpoint](https://docs.aws.amazon.com/neptune/latest/userguide/access-graph-opencypher-status.html) for more information.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:GetQueryStatus](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#getquerystatus) IAM action in that cluster.
    ///
    /// Note that the
    /// [neptune-db:QueryLanguage:OpenCypher](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html#iam-neptune-condition-keys) IAM condition key can be used in the policy document to restrict the use of openCypher queries (see [Condition keys available in Neptune IAM data-access policy statements](https://docs.aws.amazon.com/neptune/latest/userguide/iam-data-condition-keys.html)).
    pub fn listOpenCypherQueries(self: *Self, allocator: std.mem.Allocator, input: list_open_cypher_queries.ListOpenCypherQueriesInput, options: list_open_cypher_queries.Options) !list_open_cypher_queries.ListOpenCypherQueriesOutput {
        return list_open_cypher_queries.execute(self, allocator, input, options);
    }

    /// Manages the generation and use of property graph statistics.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ManageStatistics](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#managestatistics) IAM action in that cluster.
    pub fn managePropertygraphStatistics(self: *Self, allocator: std.mem.Allocator, input: manage_propertygraph_statistics.ManagePropertygraphStatisticsInput, options: manage_propertygraph_statistics.Options) !manage_propertygraph_statistics.ManagePropertygraphStatisticsOutput {
        return manage_propertygraph_statistics.execute(self, allocator, input, options);
    }

    /// Manages the generation and use of RDF graph statistics.
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:ManageStatistics](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#managestatistics) IAM action in that cluster.
    pub fn manageSparqlStatistics(self: *Self, allocator: std.mem.Allocator, input: manage_sparql_statistics.ManageSparqlStatisticsInput, options: manage_sparql_statistics.Options) !manage_sparql_statistics.ManageSparqlStatisticsOutput {
        return manage_sparql_statistics.execute(self, allocator, input, options);
    }

    /// Starts a Neptune bulk loader job to load data from an Amazon S3 bucket into
    /// a Neptune DB instance. See [Using the Amazon Neptune Bulk Loader to Ingest
    /// Data](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:StartLoaderJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#startloaderjob) IAM action in that cluster.
    pub fn startLoaderJob(self: *Self, allocator: std.mem.Allocator, input: start_loader_job.StartLoaderJobInput, options: start_loader_job.Options) !start_loader_job.StartLoaderJobOutput {
        return start_loader_job.execute(self, allocator, input, options);
    }

    /// Creates a new Neptune ML data processing job for processing the graph data
    /// exported from Neptune for training. See [The `dataprocessing`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-dataprocessing.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:StartMLModelDataProcessingJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#startmlmodeldataprocessingjob) IAM action in that cluster.
    pub fn startMlDataProcessingJob(self: *Self, allocator: std.mem.Allocator, input: start_ml_data_processing_job.StartMLDataProcessingJobInput, options: start_ml_data_processing_job.Options) !start_ml_data_processing_job.StartMLDataProcessingJobOutput {
        return start_ml_data_processing_job.execute(self, allocator, input, options);
    }

    /// Creates a new Neptune ML model training job. See [Model training using the
    /// `modeltraining`
    /// command](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-api-modeltraining.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:StartMLModelTrainingJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#startmlmodeltrainingjob) IAM action in that cluster.
    pub fn startMlModelTrainingJob(self: *Self, allocator: std.mem.Allocator, input: start_ml_model_training_job.StartMLModelTrainingJobInput, options: start_ml_model_training_job.Options) !start_ml_model_training_job.StartMLModelTrainingJobOutput {
        return start_ml_model_training_job.execute(self, allocator, input, options);
    }

    /// Creates a new model transform job. See [Use a trained model to generate new
    /// model
    /// artifacts](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-model-transform.html).
    ///
    /// When invoking this operation in a Neptune cluster that has IAM
    /// authentication enabled, the IAM user or role making the request must have a
    /// policy attached that allows the
    /// [neptune-db:StartMLModelTransformJob](https://docs.aws.amazon.com/neptune/latest/userguide/iam-dp-actions.html#startmlmodeltransformjob) IAM action in that cluster.
    pub fn startMlModelTransformJob(self: *Self, allocator: std.mem.Allocator, input: start_ml_model_transform_job.StartMLModelTransformJobInput, options: start_ml_model_transform_job.Options) !start_ml_model_transform_job.StartMLModelTransformJobOutput {
        return start_ml_model_transform_job.execute(self, allocator, input, options);
    }
};
