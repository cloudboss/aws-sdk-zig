const aws = @import("aws");
const std = @import("std");

const add_instance_fleet = @import("add_instance_fleet.zig");
const add_instance_groups = @import("add_instance_groups.zig");
const add_job_flow_steps = @import("add_job_flow_steps.zig");
const add_tags = @import("add_tags.zig");
const cancel_steps = @import("cancel_steps.zig");
const create_persistent_app_ui = @import("create_persistent_app_ui.zig");
const create_security_configuration = @import("create_security_configuration.zig");
const create_studio = @import("create_studio.zig");
const create_studio_session_mapping = @import("create_studio_session_mapping.zig");
const delete_security_configuration = @import("delete_security_configuration.zig");
const delete_studio = @import("delete_studio.zig");
const delete_studio_session_mapping = @import("delete_studio_session_mapping.zig");
const describe_cluster = @import("describe_cluster.zig");
const describe_job_flows = @import("describe_job_flows.zig");
const describe_notebook_execution = @import("describe_notebook_execution.zig");
const describe_persistent_app_ui = @import("describe_persistent_app_ui.zig");
const describe_release_label = @import("describe_release_label.zig");
const describe_security_configuration = @import("describe_security_configuration.zig");
const describe_step = @import("describe_step.zig");
const describe_studio = @import("describe_studio.zig");
const get_auto_termination_policy = @import("get_auto_termination_policy.zig");
const get_block_public_access_configuration = @import("get_block_public_access_configuration.zig");
const get_cluster_session_credentials = @import("get_cluster_session_credentials.zig");
const get_managed_scaling_policy = @import("get_managed_scaling_policy.zig");
const get_on_cluster_app_ui_presigned_url = @import("get_on_cluster_app_ui_presigned_url.zig");
const get_persistent_app_ui_presigned_url = @import("get_persistent_app_ui_presigned_url.zig");
const get_studio_session_mapping = @import("get_studio_session_mapping.zig");
const list_bootstrap_actions = @import("list_bootstrap_actions.zig");
const list_clusters = @import("list_clusters.zig");
const list_instance_fleets = @import("list_instance_fleets.zig");
const list_instance_groups = @import("list_instance_groups.zig");
const list_instances = @import("list_instances.zig");
const list_notebook_executions = @import("list_notebook_executions.zig");
const list_release_labels = @import("list_release_labels.zig");
const list_security_configurations = @import("list_security_configurations.zig");
const list_steps = @import("list_steps.zig");
const list_studio_session_mappings = @import("list_studio_session_mappings.zig");
const list_studios = @import("list_studios.zig");
const list_supported_instance_types = @import("list_supported_instance_types.zig");
const modify_cluster = @import("modify_cluster.zig");
const modify_instance_fleet = @import("modify_instance_fleet.zig");
const modify_instance_groups = @import("modify_instance_groups.zig");
const put_auto_scaling_policy = @import("put_auto_scaling_policy.zig");
const put_auto_termination_policy = @import("put_auto_termination_policy.zig");
const put_block_public_access_configuration = @import("put_block_public_access_configuration.zig");
const put_managed_scaling_policy = @import("put_managed_scaling_policy.zig");
const remove_auto_scaling_policy = @import("remove_auto_scaling_policy.zig");
const remove_auto_termination_policy = @import("remove_auto_termination_policy.zig");
const remove_managed_scaling_policy = @import("remove_managed_scaling_policy.zig");
const remove_tags = @import("remove_tags.zig");
const run_job_flow = @import("run_job_flow.zig");
const set_keep_job_flow_alive_when_no_steps = @import("set_keep_job_flow_alive_when_no_steps.zig");
const set_termination_protection = @import("set_termination_protection.zig");
const set_unhealthy_node_replacement = @import("set_unhealthy_node_replacement.zig");
const set_visible_to_all_users = @import("set_visible_to_all_users.zig");
const start_notebook_execution = @import("start_notebook_execution.zig");
const stop_notebook_execution = @import("stop_notebook_execution.zig");
const terminate_job_flows = @import("terminate_job_flows.zig");
const update_studio = @import("update_studio.zig");
const update_studio_session_mapping = @import("update_studio_session_mapping.zig");
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EMR";

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

    /// Adds an instance fleet to a running cluster.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x.
    pub fn addInstanceFleet(self: *Self, allocator: std.mem.Allocator, input: add_instance_fleet.AddInstanceFleetInput, options: add_instance_fleet.Options) !add_instance_fleet.AddInstanceFleetOutput {
        return add_instance_fleet.execute(self, allocator, input, options);
    }

    /// Adds one or more instance groups to a running cluster.
    pub fn addInstanceGroups(self: *Self, allocator: std.mem.Allocator, input: add_instance_groups.AddInstanceGroupsInput, options: add_instance_groups.Options) !add_instance_groups.AddInstanceGroupsOutput {
        return add_instance_groups.execute(self, allocator, input, options);
    }

    /// AddJobFlowSteps adds new steps to a running cluster. A maximum of 256 steps
    /// are allowed
    /// in each job flow.
    ///
    /// If your cluster is long-running (such as a Hive data warehouse) or complex,
    /// you may
    /// require more than 256 steps to process your data. You can bypass the
    /// 256-step limitation in
    /// various ways, including using SSH to connect to the master node and
    /// submitting queries
    /// directly to the software running on the master node, such as Hive and
    /// Hadoop.
    ///
    /// A step specifies the location of a JAR file stored either on the master node
    /// of the
    /// cluster or in Amazon S3. Each step is performed by the main function of the
    /// main
    /// class of the JAR file. The main class can be specified either in the
    /// manifest of the JAR or
    /// by using the MainFunction parameter of the step.
    ///
    /// Amazon EMR executes each step in the order listed. For a step to be
    /// considered
    /// complete, the main function must exit with a zero exit code and all Hadoop
    /// jobs started
    /// while the step was running must have completed and run successfully.
    ///
    /// You can only add steps to a cluster that is in one of the following states:
    /// STARTING,
    /// BOOTSTRAPPING, RUNNING, or WAITING.
    ///
    /// The string values passed into `HadoopJarStep` object cannot exceed a total
    /// of 10240 characters.
    pub fn addJobFlowSteps(self: *Self, allocator: std.mem.Allocator, input: add_job_flow_steps.AddJobFlowStepsInput, options: add_job_flow_steps.Options) !add_job_flow_steps.AddJobFlowStepsOutput {
        return add_job_flow_steps.execute(self, allocator, input, options);
    }

    /// Adds tags to an Amazon EMR resource, such as a cluster or an Amazon EMR
    /// Studio. Tags make it easier to associate resources in various ways, such as
    /// grouping
    /// clusters to track your Amazon EMR resource allocation costs. For more
    /// information,
    /// see [Tag
    /// Clusters](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html).
    pub fn addTags(self: *Self, allocator: std.mem.Allocator, input: add_tags.AddTagsInput, options: add_tags.Options) !add_tags.AddTagsOutput {
        return add_tags.execute(self, allocator, input, options);
    }

    /// Cancels a pending step or steps in a running cluster. Available only in
    /// Amazon EMR versions 4.8.0 and later, excluding version 5.0.0. A maximum of
    /// 256 steps are allowed in
    /// each CancelSteps request. CancelSteps is idempotent but asynchronous; it
    /// does not guarantee
    /// that a step will be canceled, even if the request is successfully submitted.
    /// When you use
    /// Amazon EMR releases 5.28.0 and later, you can cancel steps that are in a
    /// `PENDING` or `RUNNING` state. In earlier versions of Amazon EMR, you can
    /// only cancel steps that are in a `PENDING` state.
    pub fn cancelSteps(self: *Self, allocator: std.mem.Allocator, input: cancel_steps.CancelStepsInput, options: cancel_steps.Options) !cancel_steps.CancelStepsOutput {
        return cancel_steps.execute(self, allocator, input, options);
    }

    /// Creates a persistent application user interface.
    pub fn createPersistentAppUi(self: *Self, allocator: std.mem.Allocator, input: create_persistent_app_ui.CreatePersistentAppUIInput, options: create_persistent_app_ui.Options) !create_persistent_app_ui.CreatePersistentAppUIOutput {
        return create_persistent_app_ui.execute(self, allocator, input, options);
    }

    /// Creates a security configuration, which is stored in the service and can be
    /// specified
    /// when a cluster is created.
    pub fn createSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_security_configuration.CreateSecurityConfigurationInput, options: create_security_configuration.Options) !create_security_configuration.CreateSecurityConfigurationOutput {
        return create_security_configuration.execute(self, allocator, input, options);
    }

    /// Creates a new Amazon EMR Studio.
    pub fn createStudio(self: *Self, allocator: std.mem.Allocator, input: create_studio.CreateStudioInput, options: create_studio.Options) !create_studio.CreateStudioOutput {
        return create_studio.execute(self, allocator, input, options);
    }

    /// Maps a user or group to the Amazon EMR Studio specified by
    /// `StudioId`, and applies a session policy to refine Studio permissions for
    /// that
    /// user or group. Use `CreateStudioSessionMapping` to assign users to a Studio
    /// when
    /// you use IAM Identity Center authentication. For instructions on how to
    /// assign users to a
    /// Studio when you use IAM authentication, see [Assign a user or group to your
    /// EMR
    /// Studio](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-studio-manage-users.html#emr-studio-assign-users-groups).
    pub fn createStudioSessionMapping(self: *Self, allocator: std.mem.Allocator, input: create_studio_session_mapping.CreateStudioSessionMappingInput, options: create_studio_session_mapping.Options) !create_studio_session_mapping.CreateStudioSessionMappingOutput {
        return create_studio_session_mapping.execute(self, allocator, input, options);
    }

    /// Deletes a security configuration.
    pub fn deleteSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_security_configuration.DeleteSecurityConfigurationInput, options: delete_security_configuration.Options) !delete_security_configuration.DeleteSecurityConfigurationOutput {
        return delete_security_configuration.execute(self, allocator, input, options);
    }

    /// Removes an Amazon EMR Studio from the Studio metadata store.
    pub fn deleteStudio(self: *Self, allocator: std.mem.Allocator, input: delete_studio.DeleteStudioInput, options: delete_studio.Options) !delete_studio.DeleteStudioOutput {
        return delete_studio.execute(self, allocator, input, options);
    }

    /// Removes a user or group from an Amazon EMR Studio.
    pub fn deleteStudioSessionMapping(self: *Self, allocator: std.mem.Allocator, input: delete_studio_session_mapping.DeleteStudioSessionMappingInput, options: delete_studio_session_mapping.Options) !delete_studio_session_mapping.DeleteStudioSessionMappingOutput {
        return delete_studio_session_mapping.execute(self, allocator, input, options);
    }

    /// Provides cluster-level details including status, hardware and software
    /// configuration,
    /// VPC settings, and so on.
    pub fn describeCluster(self: *Self, allocator: std.mem.Allocator, input: describe_cluster.DescribeClusterInput, options: describe_cluster.Options) !describe_cluster.DescribeClusterOutput {
        return describe_cluster.execute(self, allocator, input, options);
    }

    /// This API is no longer supported and will eventually be removed. We recommend
    /// you use
    /// ListClusters, DescribeCluster, ListSteps, ListInstanceGroups and
    /// ListBootstrapActions instead.
    ///
    /// DescribeJobFlows returns a list of job flows that match all of the supplied
    /// parameters.
    /// The parameters can include a list of job flow IDs, job flow states, and
    /// restrictions on job
    /// flow creation date and time.
    ///
    /// Regardless of supplied parameters, only job flows created within the last
    /// two months are
    /// returned.
    ///
    /// If no parameters are supplied, then job flows matching either of the
    /// following criteria
    /// are returned:
    ///
    /// * Job flows created and completed in the last two weeks
    ///
    /// * Job flows created within the last two months that are in one of the
    ///   following
    /// states: `RUNNING`, `WAITING`, `SHUTTING_DOWN`,
    /// `STARTING`
    ///
    /// Amazon EMR can return a maximum of 512 job flow descriptions.
    pub fn describeJobFlows(self: *Self, allocator: std.mem.Allocator, input: describe_job_flows.DescribeJobFlowsInput, options: describe_job_flows.Options) !describe_job_flows.DescribeJobFlowsOutput {
        return describe_job_flows.execute(self, allocator, input, options);
    }

    /// Provides details of a notebook execution.
    pub fn describeNotebookExecution(self: *Self, allocator: std.mem.Allocator, input: describe_notebook_execution.DescribeNotebookExecutionInput, options: describe_notebook_execution.Options) !describe_notebook_execution.DescribeNotebookExecutionOutput {
        return describe_notebook_execution.execute(self, allocator, input, options);
    }

    /// Describes a persistent application user interface.
    pub fn describePersistentAppUi(self: *Self, allocator: std.mem.Allocator, input: describe_persistent_app_ui.DescribePersistentAppUIInput, options: describe_persistent_app_ui.Options) !describe_persistent_app_ui.DescribePersistentAppUIOutput {
        return describe_persistent_app_ui.execute(self, allocator, input, options);
    }

    /// Provides Amazon EMR release label details, such as the releases available
    /// the
    /// Region where the API request is run, and the available applications for a
    /// specific Amazon EMR release label. Can also list Amazon EMR releases that
    /// support a
    /// specified version of Spark.
    pub fn describeReleaseLabel(self: *Self, allocator: std.mem.Allocator, input: describe_release_label.DescribeReleaseLabelInput, options: describe_release_label.Options) !describe_release_label.DescribeReleaseLabelOutput {
        return describe_release_label.execute(self, allocator, input, options);
    }

    /// Provides the details of a security configuration by returning the
    /// configuration
    /// JSON.
    pub fn describeSecurityConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_security_configuration.DescribeSecurityConfigurationInput, options: describe_security_configuration.Options) !describe_security_configuration.DescribeSecurityConfigurationOutput {
        return describe_security_configuration.execute(self, allocator, input, options);
    }

    /// Provides more detail about the cluster step.
    pub fn describeStep(self: *Self, allocator: std.mem.Allocator, input: describe_step.DescribeStepInput, options: describe_step.Options) !describe_step.DescribeStepOutput {
        return describe_step.execute(self, allocator, input, options);
    }

    /// Returns details for the specified Amazon EMR Studio including ID, Name, VPC,
    /// Studio access URL, and so on.
    pub fn describeStudio(self: *Self, allocator: std.mem.Allocator, input: describe_studio.DescribeStudioInput, options: describe_studio.Options) !describe_studio.DescribeStudioOutput {
        return describe_studio.execute(self, allocator, input, options);
    }

    /// Returns the auto-termination policy for an Amazon EMR cluster.
    pub fn getAutoTerminationPolicy(self: *Self, allocator: std.mem.Allocator, input: get_auto_termination_policy.GetAutoTerminationPolicyInput, options: get_auto_termination_policy.Options) !get_auto_termination_policy.GetAutoTerminationPolicyOutput {
        return get_auto_termination_policy.execute(self, allocator, input, options);
    }

    /// Returns the Amazon EMR block public access configuration for your Amazon Web
    /// Services account in the current Region. For more information see [Configure
    /// Block
    /// Public Access for Amazon
    /// EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/configure-block-public-access.html) in the *Amazon EMR
    /// Management Guide*.
    pub fn getBlockPublicAccessConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_block_public_access_configuration.GetBlockPublicAccessConfigurationInput, options: get_block_public_access_configuration.Options) !get_block_public_access_configuration.GetBlockPublicAccessConfigurationOutput {
        return get_block_public_access_configuration.execute(self, allocator, input, options);
    }

    /// Provides temporary, HTTP basic credentials that are associated with a given
    /// runtime
    /// IAM role and used by a cluster with fine-grained access control
    /// activated. You can use these credentials to connect to cluster endpoints
    /// that support
    /// username and password authentication.
    pub fn getClusterSessionCredentials(self: *Self, allocator: std.mem.Allocator, input: get_cluster_session_credentials.GetClusterSessionCredentialsInput, options: get_cluster_session_credentials.Options) !get_cluster_session_credentials.GetClusterSessionCredentialsOutput {
        return get_cluster_session_credentials.execute(self, allocator, input, options);
    }

    /// Fetches the attached managed scaling policy for an Amazon EMR cluster.
    pub fn getManagedScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: get_managed_scaling_policy.GetManagedScalingPolicyInput, options: get_managed_scaling_policy.Options) !get_managed_scaling_policy.GetManagedScalingPolicyOutput {
        return get_managed_scaling_policy.execute(self, allocator, input, options);
    }

    /// The presigned URL properties for the cluster's application user interface.
    pub fn getOnClusterAppUiPresignedUrl(self: *Self, allocator: std.mem.Allocator, input: get_on_cluster_app_ui_presigned_url.GetOnClusterAppUIPresignedURLInput, options: get_on_cluster_app_ui_presigned_url.Options) !get_on_cluster_app_ui_presigned_url.GetOnClusterAppUIPresignedURLOutput {
        return get_on_cluster_app_ui_presigned_url.execute(self, allocator, input, options);
    }

    /// The presigned URL properties for the cluster's application user interface.
    pub fn getPersistentAppUiPresignedUrl(self: *Self, allocator: std.mem.Allocator, input: get_persistent_app_ui_presigned_url.GetPersistentAppUIPresignedURLInput, options: get_persistent_app_ui_presigned_url.Options) !get_persistent_app_ui_presigned_url.GetPersistentAppUIPresignedURLOutput {
        return get_persistent_app_ui_presigned_url.execute(self, allocator, input, options);
    }

    /// Fetches mapping details for the specified Amazon EMR Studio and identity
    /// (user
    /// or group).
    pub fn getStudioSessionMapping(self: *Self, allocator: std.mem.Allocator, input: get_studio_session_mapping.GetStudioSessionMappingInput, options: get_studio_session_mapping.Options) !get_studio_session_mapping.GetStudioSessionMappingOutput {
        return get_studio_session_mapping.execute(self, allocator, input, options);
    }

    /// Provides information about the bootstrap actions associated with a cluster.
    pub fn listBootstrapActions(self: *Self, allocator: std.mem.Allocator, input: list_bootstrap_actions.ListBootstrapActionsInput, options: list_bootstrap_actions.Options) !list_bootstrap_actions.ListBootstrapActionsOutput {
        return list_bootstrap_actions.execute(self, allocator, input, options);
    }

    /// Provides the status of all clusters visible to this Amazon Web Services
    /// account. Allows
    /// you to filter the list of clusters based on certain criteria; for example,
    /// filtering by
    /// cluster creation date and time or by status. This call returns a maximum of
    /// 50 clusters in
    /// unsorted order per call, but returns a marker to track the paging of the
    /// cluster list
    /// across multiple ListClusters calls.
    pub fn listClusters(self: *Self, allocator: std.mem.Allocator, input: list_clusters.ListClustersInput, options: list_clusters.Options) !list_clusters.ListClustersOutput {
        return list_clusters.execute(self, allocator, input, options);
    }

    /// Lists all available details about the instance fleets in a cluster.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    pub fn listInstanceFleets(self: *Self, allocator: std.mem.Allocator, input: list_instance_fleets.ListInstanceFleetsInput, options: list_instance_fleets.Options) !list_instance_fleets.ListInstanceFleetsOutput {
        return list_instance_fleets.execute(self, allocator, input, options);
    }

    /// Provides all available details about the instance groups in a cluster.
    pub fn listInstanceGroups(self: *Self, allocator: std.mem.Allocator, input: list_instance_groups.ListInstanceGroupsInput, options: list_instance_groups.Options) !list_instance_groups.ListInstanceGroupsOutput {
        return list_instance_groups.execute(self, allocator, input, options);
    }

    /// Provides information for all active Amazon EC2 instances and Amazon EC2
    /// instances terminated in the last 30 days, up to a maximum of 2,000. Amazon
    /// EC2
    /// instances in any of the following states are considered active:
    /// AWAITING_FULFILLMENT,
    /// PROVISIONING, BOOTSTRAPPING, RUNNING.
    pub fn listInstances(self: *Self, allocator: std.mem.Allocator, input: list_instances.ListInstancesInput, options: list_instances.Options) !list_instances.ListInstancesOutput {
        return list_instances.execute(self, allocator, input, options);
    }

    /// Provides summaries of all notebook executions. You can filter the list based
    /// on multiple
    /// criteria such as status, time range, and editor id. Returns a maximum of 50
    /// notebook
    /// executions and a marker to track the paging of a longer notebook execution
    /// list across
    /// multiple `ListNotebookExecutions` calls.
    pub fn listNotebookExecutions(self: *Self, allocator: std.mem.Allocator, input: list_notebook_executions.ListNotebookExecutionsInput, options: list_notebook_executions.Options) !list_notebook_executions.ListNotebookExecutionsOutput {
        return list_notebook_executions.execute(self, allocator, input, options);
    }

    /// Retrieves release labels of Amazon EMR services in the Region where the API
    /// is
    /// called.
    pub fn listReleaseLabels(self: *Self, allocator: std.mem.Allocator, input: list_release_labels.ListReleaseLabelsInput, options: list_release_labels.Options) !list_release_labels.ListReleaseLabelsOutput {
        return list_release_labels.execute(self, allocator, input, options);
    }

    /// Lists all the security configurations visible to this account, providing
    /// their creation
    /// dates and times, and their names. This call returns a maximum of 50 clusters
    /// per call, but
    /// returns a marker to track the paging of the cluster list across multiple
    /// ListSecurityConfigurations calls.
    pub fn listSecurityConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_security_configurations.ListSecurityConfigurationsInput, options: list_security_configurations.Options) !list_security_configurations.ListSecurityConfigurationsOutput {
        return list_security_configurations.execute(self, allocator, input, options);
    }

    /// Provides a list of steps for the cluster in reverse order unless you specify
    /// `stepIds` with the request or filter by `StepStates`. You can
    /// specify a maximum of 10 `stepIDs`. The CLI automatically
    /// paginates results to return a list greater than 50 steps. To return more
    /// than 50 steps
    /// using the CLI, specify a `Marker`, which is a pagination token
    /// that indicates the next set of steps to retrieve.
    pub fn listSteps(self: *Self, allocator: std.mem.Allocator, input: list_steps.ListStepsInput, options: list_steps.Options) !list_steps.ListStepsOutput {
        return list_steps.execute(self, allocator, input, options);
    }

    /// Returns a list of all user or group session mappings for the Amazon EMR
    /// Studio
    /// specified by `StudioId`.
    pub fn listStudioSessionMappings(self: *Self, allocator: std.mem.Allocator, input: list_studio_session_mappings.ListStudioSessionMappingsInput, options: list_studio_session_mappings.Options) !list_studio_session_mappings.ListStudioSessionMappingsOutput {
        return list_studio_session_mappings.execute(self, allocator, input, options);
    }

    /// Returns a list of all Amazon EMR Studios associated with the Amazon Web
    /// Services account. The list includes details such as ID, Studio Access URL,
    /// and
    /// creation time for each Studio.
    pub fn listStudios(self: *Self, allocator: std.mem.Allocator, input: list_studios.ListStudiosInput, options: list_studios.Options) !list_studios.ListStudiosOutput {
        return list_studios.execute(self, allocator, input, options);
    }

    /// A list of the instance types that Amazon EMR supports. You can filter the
    /// list by Amazon Web Services Region and Amazon EMR release.
    pub fn listSupportedInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: list_supported_instance_types.ListSupportedInstanceTypesInput, options: list_supported_instance_types.Options) !list_supported_instance_types.ListSupportedInstanceTypesOutput {
        return list_supported_instance_types.execute(self, allocator, input, options);
    }

    /// Modifies the number of steps that can be executed concurrently for the
    /// cluster specified
    /// using ClusterID.
    pub fn modifyCluster(self: *Self, allocator: std.mem.Allocator, input: modify_cluster.ModifyClusterInput, options: modify_cluster.Options) !modify_cluster.ModifyClusterOutput {
        return modify_cluster.execute(self, allocator, input, options);
    }

    /// Modifies the target On-Demand and target Spot capacities for the instance
    /// fleet with the
    /// specified InstanceFleetID within the cluster specified using ClusterID. The
    /// call either
    /// succeeds or fails atomically.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    pub fn modifyInstanceFleet(self: *Self, allocator: std.mem.Allocator, input: modify_instance_fleet.ModifyInstanceFleetInput, options: modify_instance_fleet.Options) !modify_instance_fleet.ModifyInstanceFleetOutput {
        return modify_instance_fleet.execute(self, allocator, input, options);
    }

    /// ModifyInstanceGroups modifies the number of nodes and configuration settings
    /// of an
    /// instance group. The input parameters include the new target instance count
    /// for the group
    /// and the instance group ID. The call will either succeed or fail atomically.
    pub fn modifyInstanceGroups(self: *Self, allocator: std.mem.Allocator, input: modify_instance_groups.ModifyInstanceGroupsInput, options: modify_instance_groups.Options) !modify_instance_groups.ModifyInstanceGroupsOutput {
        return modify_instance_groups.execute(self, allocator, input, options);
    }

    /// Creates or updates an automatic scaling policy for a core instance group or
    /// task
    /// instance group in an Amazon EMR cluster. The automatic scaling policy
    /// defines how
    /// an instance group dynamically adds and terminates Amazon EC2 instances in
    /// response
    /// to the value of a CloudWatch metric.
    pub fn putAutoScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: put_auto_scaling_policy.PutAutoScalingPolicyInput, options: put_auto_scaling_policy.Options) !put_auto_scaling_policy.PutAutoScalingPolicyOutput {
        return put_auto_scaling_policy.execute(self, allocator, input, options);
    }

    /// Auto-termination is supported in Amazon EMR releases 5.30.0 and 6.1.0 and
    /// later. For more information, see [Using an
    /// auto-termination
    /// policy](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-auto-termination-policy.html).
    ///
    /// Creates or updates an auto-termination policy for an Amazon EMR cluster. An
    /// auto-termination policy defines the amount of idle time in seconds after
    /// which a cluster
    /// automatically terminates. For alternative cluster termination options, see
    /// [Control
    /// cluster
    /// termination](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-termination.html).
    pub fn putAutoTerminationPolicy(self: *Self, allocator: std.mem.Allocator, input: put_auto_termination_policy.PutAutoTerminationPolicyInput, options: put_auto_termination_policy.Options) !put_auto_termination_policy.PutAutoTerminationPolicyOutput {
        return put_auto_termination_policy.execute(self, allocator, input, options);
    }

    /// Creates or updates an Amazon EMR block public access configuration for your
    /// Amazon Web Services account in the current Region. For more information see
    /// [Configure Block
    /// Public Access for Amazon
    /// EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/configure-block-public-access.html) in the *Amazon EMR
    /// Management Guide*.
    pub fn putBlockPublicAccessConfiguration(self: *Self, allocator: std.mem.Allocator, input: put_block_public_access_configuration.PutBlockPublicAccessConfigurationInput, options: put_block_public_access_configuration.Options) !put_block_public_access_configuration.PutBlockPublicAccessConfigurationOutput {
        return put_block_public_access_configuration.execute(self, allocator, input, options);
    }

    /// Creates or updates a managed scaling policy for an Amazon EMR cluster. The
    /// managed scaling policy defines the limits for resources, such as Amazon EC2
    /// instances that can be added or terminated from a cluster. The policy only
    /// applies to the
    /// core and task nodes. The master node cannot be scaled after initial
    /// configuration.
    pub fn putManagedScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: put_managed_scaling_policy.PutManagedScalingPolicyInput, options: put_managed_scaling_policy.Options) !put_managed_scaling_policy.PutManagedScalingPolicyOutput {
        return put_managed_scaling_policy.execute(self, allocator, input, options);
    }

    /// Removes an automatic scaling policy from a specified instance group within
    /// an Amazon EMR cluster.
    pub fn removeAutoScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: remove_auto_scaling_policy.RemoveAutoScalingPolicyInput, options: remove_auto_scaling_policy.Options) !remove_auto_scaling_policy.RemoveAutoScalingPolicyOutput {
        return remove_auto_scaling_policy.execute(self, allocator, input, options);
    }

    /// Removes an auto-termination policy from an Amazon EMR cluster.
    pub fn removeAutoTerminationPolicy(self: *Self, allocator: std.mem.Allocator, input: remove_auto_termination_policy.RemoveAutoTerminationPolicyInput, options: remove_auto_termination_policy.Options) !remove_auto_termination_policy.RemoveAutoTerminationPolicyOutput {
        return remove_auto_termination_policy.execute(self, allocator, input, options);
    }

    /// Removes a managed scaling policy from a specified Amazon EMR cluster.
    pub fn removeManagedScalingPolicy(self: *Self, allocator: std.mem.Allocator, input: remove_managed_scaling_policy.RemoveManagedScalingPolicyInput, options: remove_managed_scaling_policy.Options) !remove_managed_scaling_policy.RemoveManagedScalingPolicyOutput {
        return remove_managed_scaling_policy.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon EMR resource, such as a cluster or Amazon EMR
    /// Studio. Tags make it easier to associate resources in various ways, such as
    /// grouping
    /// clusters to track your Amazon EMR resource allocation costs. For more
    /// information,
    /// see [Tag
    /// Clusters](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-tags.html).
    ///
    /// The following example removes the stack tag with value Prod from a cluster:
    pub fn removeTags(self: *Self, allocator: std.mem.Allocator, input: remove_tags.RemoveTagsInput, options: remove_tags.Options) !remove_tags.RemoveTagsOutput {
        return remove_tags.execute(self, allocator, input, options);
    }

    /// RunJobFlow creates and starts running a new cluster (job flow). The cluster
    /// runs the
    /// steps specified. After the steps complete, the cluster stops and the HDFS
    /// partition is
    /// lost. To prevent loss of data, configure the last step of the job flow to
    /// store results in
    /// Amazon S3. If the JobFlowInstancesConfig
    /// `KeepJobFlowAliveWhenNoSteps` parameter is set to `TRUE`, the cluster
    /// transitions to the WAITING state rather than shutting down after the steps
    /// have completed.
    ///
    /// For additional protection, you can set the JobFlowInstancesConfig
    /// `TerminationProtected` parameter to `TRUE` to lock the cluster and
    /// prevent it from being terminated by API call, user intervention, or in the
    /// event of a job
    /// flow error.
    ///
    /// A maximum of 256 steps are allowed in each job flow.
    ///
    /// If your cluster is long-running (such as a Hive data warehouse) or complex,
    /// you may
    /// require more than 256 steps to process your data. You can bypass the
    /// 256-step limitation in
    /// various ways, including using the SSH shell to connect to the master node
    /// and submitting
    /// queries directly to the software running on the master node, such as Hive
    /// and
    /// Hadoop.
    ///
    /// For long-running clusters, we recommend that you periodically store your
    /// results.
    ///
    /// The instance fleets configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions. The RunJobFlow request can
    /// contain
    /// InstanceFleets parameters or InstanceGroups parameters, but not both.
    pub fn runJobFlow(self: *Self, allocator: std.mem.Allocator, input: run_job_flow.RunJobFlowInput, options: run_job_flow.Options) !run_job_flow.RunJobFlowOutput {
        return run_job_flow.execute(self, allocator, input, options);
    }

    /// You can use the `SetKeepJobFlowAliveWhenNoSteps` to configure a cluster (job
    /// flow) to terminate after the step execution, i.e., all your
    /// steps are executed. If you want a transient cluster that shuts down after
    /// the last of the current executing steps are completed,
    /// you can configure `SetKeepJobFlowAliveWhenNoSteps` to false. If you want a
    /// long running cluster, configure `SetKeepJobFlowAliveWhenNoSteps` to true.
    ///
    /// For more information, see [Managing Cluster
    /// Termination](https://docs.aws.amazon.com/emr/latest/ManagementGuide/UsingEMR_TerminationProtection.html) in the *Amazon EMR Management Guide*.
    pub fn setKeepJobFlowAliveWhenNoSteps(self: *Self, allocator: std.mem.Allocator, input: set_keep_job_flow_alive_when_no_steps.SetKeepJobFlowAliveWhenNoStepsInput, options: set_keep_job_flow_alive_when_no_steps.Options) !set_keep_job_flow_alive_when_no_steps.SetKeepJobFlowAliveWhenNoStepsOutput {
        return set_keep_job_flow_alive_when_no_steps.execute(self, allocator, input, options);
    }

    /// SetTerminationProtection locks a cluster (job flow) so the Amazon EC2
    /// instances
    /// in the cluster cannot be terminated by user intervention, an API call, or in
    /// the event of a
    /// job-flow error. The cluster still terminates upon successful completion of
    /// the job flow.
    /// Calling `SetTerminationProtection` on a cluster is similar to calling the
    /// Amazon EC2
    /// `DisableAPITermination` API on all Amazon EC2 instances in a
    /// cluster.
    ///
    /// `SetTerminationProtection` is used to prevent accidental termination of a
    /// cluster and to ensure that in the event of an error, the instances persist
    /// so that you can
    /// recover any data stored in their ephemeral instance storage.
    ///
    /// To terminate a cluster that has been locked by setting
    /// `SetTerminationProtection` to `true`, you must first unlock the
    /// job flow by a subsequent call to `SetTerminationProtection` in which you set
    /// the
    /// value to `false`.
    ///
    /// For more information, see [Managing Cluster
    /// Termination](https://docs.aws.amazon.com/emr/latest/ManagementGuide/UsingEMR_TerminationProtection.html) in the *Amazon EMR Management Guide*.
    pub fn setTerminationProtection(self: *Self, allocator: std.mem.Allocator, input: set_termination_protection.SetTerminationProtectionInput, options: set_termination_protection.Options) !set_termination_protection.SetTerminationProtectionOutput {
        return set_termination_protection.execute(self, allocator, input, options);
    }

    /// Specify whether to enable unhealthy node replacement, which lets Amazon EMR
    /// gracefully
    /// replace core nodes on a cluster if any nodes become unhealthy. For example,
    /// a node becomes
    /// unhealthy if disk usage is above 90%. If unhealthy node replacement is on
    /// and `TerminationProtected` are off,
    /// Amazon EMR immediately terminates the unhealthy core nodes. To use unhealthy
    /// node replacement
    /// and retain unhealthy core nodes, use to turn on
    /// termination protection. In such cases, Amazon EMR adds
    /// the unhealthy nodes to a denylist, reducing job interruptions and failures.
    ///
    /// If unhealthy node replacement is on, Amazon EMR
    /// notifies YARN and other applications on the cluster to stop scheduling tasks
    /// with these nodes, moves the data, and then terminates the nodes.
    ///
    /// For more information, see [graceful
    /// node
    /// replacement](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-node-replacement.html) in the *Amazon EMR Management Guide*.
    pub fn setUnhealthyNodeReplacement(self: *Self, allocator: std.mem.Allocator, input: set_unhealthy_node_replacement.SetUnhealthyNodeReplacementInput, options: set_unhealthy_node_replacement.Options) !set_unhealthy_node_replacement.SetUnhealthyNodeReplacementOutput {
        return set_unhealthy_node_replacement.execute(self, allocator, input, options);
    }

    /// The SetVisibleToAllUsers parameter is no longer supported. Your cluster may
    /// be
    /// visible to all users in your account. To restrict cluster access using an
    /// IAM policy, see [Identity and Access
    /// Management for Amazon
    /// EMR](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-plan-access-IAM.html).
    ///
    /// Sets the Cluster$VisibleToAllUsers value for an Amazon EMR
    /// cluster. When `true`, IAM principals in the Amazon Web Services account can
    /// perform Amazon EMR cluster actions that their IAM policies allow. When
    /// `false`, only the IAM
    /// principal that created the cluster and the Amazon Web Services account root
    /// user can perform
    /// Amazon EMR actions on the cluster, regardless of IAM permissions
    /// policies attached to other IAM principals.
    ///
    /// This action works on running clusters. When you create a cluster, use the
    /// RunJobFlowInput$VisibleToAllUsers parameter.
    ///
    /// For more information, see [Understanding the Amazon EMR Cluster
    /// VisibleToAllUsers
    /// Setting](https://docs.aws.amazon.com/emr/latest/ManagementGuide/security_IAM_emr-with-IAM.html#security_set_visible_to_all_users) in the
    /// *Amazon EMR Management Guide*.
    pub fn setVisibleToAllUsers(self: *Self, allocator: std.mem.Allocator, input: set_visible_to_all_users.SetVisibleToAllUsersInput, options: set_visible_to_all_users.Options) !set_visible_to_all_users.SetVisibleToAllUsersOutput {
        return set_visible_to_all_users.execute(self, allocator, input, options);
    }

    /// Starts a notebook execution.
    pub fn startNotebookExecution(self: *Self, allocator: std.mem.Allocator, input: start_notebook_execution.StartNotebookExecutionInput, options: start_notebook_execution.Options) !start_notebook_execution.StartNotebookExecutionOutput {
        return start_notebook_execution.execute(self, allocator, input, options);
    }

    /// Stops a notebook execution.
    pub fn stopNotebookExecution(self: *Self, allocator: std.mem.Allocator, input: stop_notebook_execution.StopNotebookExecutionInput, options: stop_notebook_execution.Options) !stop_notebook_execution.StopNotebookExecutionOutput {
        return stop_notebook_execution.execute(self, allocator, input, options);
    }

    /// TerminateJobFlows shuts a list of clusters (job flows) down. When a job flow
    /// is shut
    /// down, any step not yet completed is canceled and the Amazon EC2 instances on
    /// which
    /// the cluster is running are stopped. Any log files not already saved are
    /// uploaded to Amazon S3 if a LogUri was specified when the cluster was
    /// created.
    ///
    /// The maximum number of clusters allowed is 10. The call to
    /// `TerminateJobFlows`
    /// is asynchronous. Depending on the configuration of the cluster, it may take
    /// up to 1-5
    /// minutes for the cluster to completely terminate and release allocated
    /// resources, such as
    /// Amazon EC2 instances.
    pub fn terminateJobFlows(self: *Self, allocator: std.mem.Allocator, input: terminate_job_flows.TerminateJobFlowsInput, options: terminate_job_flows.Options) !terminate_job_flows.TerminateJobFlowsOutput {
        return terminate_job_flows.execute(self, allocator, input, options);
    }

    /// Updates an Amazon EMR Studio configuration, including attributes such as
    /// name,
    /// description, and subnets.
    pub fn updateStudio(self: *Self, allocator: std.mem.Allocator, input: update_studio.UpdateStudioInput, options: update_studio.Options) !update_studio.UpdateStudioOutput {
        return update_studio.execute(self, allocator, input, options);
    }

    /// Updates the session policy attached to the user or group for the specified
    /// Amazon EMR Studio.
    pub fn updateStudioSessionMapping(self: *Self, allocator: std.mem.Allocator, input: update_studio_session_mapping.UpdateStudioSessionMappingInput, options: update_studio_session_mapping.Options) !update_studio_session_mapping.UpdateStudioSessionMappingOutput {
        return update_studio_session_mapping.execute(self, allocator, input, options);
    }

    pub fn listBootstrapActionsPaginator(self: *Self, params: list_bootstrap_actions.ListBootstrapActionsInput) paginator.ListBootstrapActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listClustersPaginator(self: *Self, params: list_clusters.ListClustersInput) paginator.ListClustersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceFleetsPaginator(self: *Self, params: list_instance_fleets.ListInstanceFleetsInput) paginator.ListInstanceFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstanceGroupsPaginator(self: *Self, params: list_instance_groups.ListInstanceGroupsInput) paginator.ListInstanceGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listInstancesPaginator(self: *Self, params: list_instances.ListInstancesInput) paginator.ListInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listNotebookExecutionsPaginator(self: *Self, params: list_notebook_executions.ListNotebookExecutionsInput) paginator.ListNotebookExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listReleaseLabelsPaginator(self: *Self, params: list_release_labels.ListReleaseLabelsInput) paginator.ListReleaseLabelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSecurityConfigurationsPaginator(self: *Self, params: list_security_configurations.ListSecurityConfigurationsInput) paginator.ListSecurityConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStepsPaginator(self: *Self, params: list_steps.ListStepsInput) paginator.ListStepsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStudioSessionMappingsPaginator(self: *Self, params: list_studio_session_mappings.ListStudioSessionMappingsInput) paginator.ListStudioSessionMappingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStudiosPaginator(self: *Self, params: list_studios.ListStudiosInput) paginator.ListStudiosPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSupportedInstanceTypesPaginator(self: *Self, params: list_supported_instance_types.ListSupportedInstanceTypesInput) paginator.ListSupportedInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilClusterRunning(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilClusterTerminated(self: *Self, params: describe_cluster.DescribeClusterInput) aws.waiter.WaiterError!void {
        var w = waiters.ClusterTerminatedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilStepComplete(self: *Self, params: describe_step.DescribeStepInput) aws.waiter.WaiterError!void {
        var w = waiters.StepCompleteWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
