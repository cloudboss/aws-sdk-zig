const aws = @import("aws");
const std = @import("std");

const associate_source_network_stack = @import("associate_source_network_stack.zig");
const create_extended_source_server = @import("create_extended_source_server.zig");
const create_launch_configuration_template = @import("create_launch_configuration_template.zig");
const create_replication_configuration_template = @import("create_replication_configuration_template.zig");
const create_source_network = @import("create_source_network.zig");
const delete_job = @import("delete_job.zig");
const delete_launch_action = @import("delete_launch_action.zig");
const delete_launch_configuration_template = @import("delete_launch_configuration_template.zig");
const delete_recovery_instance = @import("delete_recovery_instance.zig");
const delete_replication_configuration_template = @import("delete_replication_configuration_template.zig");
const delete_source_network = @import("delete_source_network.zig");
const delete_source_server = @import("delete_source_server.zig");
const describe_job_log_items = @import("describe_job_log_items.zig");
const describe_jobs = @import("describe_jobs.zig");
const describe_launch_configuration_templates = @import("describe_launch_configuration_templates.zig");
const describe_recovery_instances = @import("describe_recovery_instances.zig");
const describe_recovery_snapshots = @import("describe_recovery_snapshots.zig");
const describe_replication_configuration_templates = @import("describe_replication_configuration_templates.zig");
const describe_source_networks = @import("describe_source_networks.zig");
const describe_source_servers = @import("describe_source_servers.zig");
const disconnect_recovery_instance = @import("disconnect_recovery_instance.zig");
const disconnect_source_server = @import("disconnect_source_server.zig");
const export_source_network_cfn_template = @import("export_source_network_cfn_template.zig");
const get_failback_replication_configuration = @import("get_failback_replication_configuration.zig");
const get_launch_configuration = @import("get_launch_configuration.zig");
const get_replication_configuration = @import("get_replication_configuration.zig");
const initialize_service = @import("initialize_service.zig");
const list_extensible_source_servers = @import("list_extensible_source_servers.zig");
const list_launch_actions = @import("list_launch_actions.zig");
const list_staging_accounts = @import("list_staging_accounts.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_launch_action = @import("put_launch_action.zig");
const retry_data_replication = @import("retry_data_replication.zig");
const reverse_replication = @import("reverse_replication.zig");
const start_failback_launch = @import("start_failback_launch.zig");
const start_recovery = @import("start_recovery.zig");
const start_replication = @import("start_replication.zig");
const start_source_network_recovery = @import("start_source_network_recovery.zig");
const start_source_network_replication = @import("start_source_network_replication.zig");
const stop_failback = @import("stop_failback.zig");
const stop_replication = @import("stop_replication.zig");
const stop_source_network_replication = @import("stop_source_network_replication.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_recovery_instances = @import("terminate_recovery_instances.zig");
const untag_resource = @import("untag_resource.zig");
const update_failback_replication_configuration = @import("update_failback_replication_configuration.zig");
const update_launch_configuration = @import("update_launch_configuration.zig");
const update_launch_configuration_template = @import("update_launch_configuration_template.zig");
const update_replication_configuration = @import("update_replication_configuration.zig");
const update_replication_configuration_template = @import("update_replication_configuration_template.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "drs";

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

    /// Associate a Source Network to an existing CloudFormation Stack and modify
    /// launch templates to use this network. Can be used for reverting to
    /// previously deployed CloudFormation stacks.
    pub fn associateSourceNetworkStack(self: *Self, allocator: std.mem.Allocator, input: associate_source_network_stack.AssociateSourceNetworkStackInput, options: associate_source_network_stack.Options) !associate_source_network_stack.AssociateSourceNetworkStackOutput {
        return associate_source_network_stack.execute(self, allocator, input, options);
    }

    /// Create an extended source server in the target Account based on the source
    /// server in staging account.
    pub fn createExtendedSourceServer(self: *Self, allocator: std.mem.Allocator, input: create_extended_source_server.CreateExtendedSourceServerInput, options: create_extended_source_server.Options) !create_extended_source_server.CreateExtendedSourceServerOutput {
        return create_extended_source_server.execute(self, allocator, input, options);
    }

    /// Creates a new Launch Configuration Template.
    pub fn createLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_launch_configuration_template.CreateLaunchConfigurationTemplateInput, options: create_launch_configuration_template.Options) !create_launch_configuration_template.CreateLaunchConfigurationTemplateOutput {
        return create_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Creates a new ReplicationConfigurationTemplate.
    pub fn createReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_replication_configuration_template.CreateReplicationConfigurationTemplateInput, options: create_replication_configuration_template.Options) !create_replication_configuration_template.CreateReplicationConfigurationTemplateOutput {
        return create_replication_configuration_template.execute(self, allocator, input, options);
    }

    /// Create a new Source Network resource for a provided VPC ID.
    pub fn createSourceNetwork(self: *Self, allocator: std.mem.Allocator, input: create_source_network.CreateSourceNetworkInput, options: create_source_network.Options) !create_source_network.CreateSourceNetworkOutput {
        return create_source_network.execute(self, allocator, input, options);
    }

    /// Deletes a single Job by ID.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: delete_job.Options) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes a resource launch action.
    pub fn deleteLaunchAction(self: *Self, allocator: std.mem.Allocator, input: delete_launch_action.DeleteLaunchActionInput, options: delete_launch_action.Options) !delete_launch_action.DeleteLaunchActionOutput {
        return delete_launch_action.execute(self, allocator, input, options);
    }

    /// Deletes a single Launch Configuration Template by ID.
    pub fn deleteLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_launch_configuration_template.DeleteLaunchConfigurationTemplateInput, options: delete_launch_configuration_template.Options) !delete_launch_configuration_template.DeleteLaunchConfigurationTemplateOutput {
        return delete_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Deletes a single Recovery Instance by ID. This deletes the Recovery Instance
    /// resource from Elastic Disaster Recovery. The Recovery Instance must be
    /// disconnected first in order to delete it.
    pub fn deleteRecoveryInstance(self: *Self, allocator: std.mem.Allocator, input: delete_recovery_instance.DeleteRecoveryInstanceInput, options: delete_recovery_instance.Options) !delete_recovery_instance.DeleteRecoveryInstanceOutput {
        return delete_recovery_instance.execute(self, allocator, input, options);
    }

    /// Deletes a single Replication Configuration Template by ID
    pub fn deleteReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_replication_configuration_template.DeleteReplicationConfigurationTemplateInput, options: delete_replication_configuration_template.Options) !delete_replication_configuration_template.DeleteReplicationConfigurationTemplateOutput {
        return delete_replication_configuration_template.execute(self, allocator, input, options);
    }

    /// Delete Source Network resource.
    pub fn deleteSourceNetwork(self: *Self, allocator: std.mem.Allocator, input: delete_source_network.DeleteSourceNetworkInput, options: delete_source_network.Options) !delete_source_network.DeleteSourceNetworkOutput {
        return delete_source_network.execute(self, allocator, input, options);
    }

    /// Deletes a single Source Server by ID. The Source Server must be disconnected
    /// first.
    pub fn deleteSourceServer(self: *Self, allocator: std.mem.Allocator, input: delete_source_server.DeleteSourceServerInput, options: delete_source_server.Options) !delete_source_server.DeleteSourceServerOutput {
        return delete_source_server.execute(self, allocator, input, options);
    }

    /// Retrieves a detailed Job log with pagination.
    pub fn describeJobLogItems(self: *Self, allocator: std.mem.Allocator, input: describe_job_log_items.DescribeJobLogItemsInput, options: describe_job_log_items.Options) !describe_job_log_items.DescribeJobLogItemsOutput {
        return describe_job_log_items.execute(self, allocator, input, options);
    }

    /// Returns a list of Jobs. Use the JobsID and fromDate and toDate filters to
    /// limit which jobs are returned. The response is sorted by creationDataTime -
    /// latest date first. Jobs are created by the StartRecovery,
    /// TerminateRecoveryInstances and StartFailbackLaunch APIs. Jobs are also
    /// created by DiagnosticLaunch and TerminateDiagnosticInstances, which are APIs
    /// available only to *Support* and only used in response to relevant support
    /// tickets.
    pub fn describeJobs(self: *Self, allocator: std.mem.Allocator, input: describe_jobs.DescribeJobsInput, options: describe_jobs.Options) !describe_jobs.DescribeJobsOutput {
        return describe_jobs.execute(self, allocator, input, options);
    }

    /// Lists all Launch Configuration Templates, filtered by Launch Configuration
    /// Template IDs
    pub fn describeLaunchConfigurationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesInput, options: describe_launch_configuration_templates.Options) !describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesOutput {
        return describe_launch_configuration_templates.execute(self, allocator, input, options);
    }

    /// Lists all Recovery Instances or multiple Recovery Instances by ID.
    pub fn describeRecoveryInstances(self: *Self, allocator: std.mem.Allocator, input: describe_recovery_instances.DescribeRecoveryInstancesInput, options: describe_recovery_instances.Options) !describe_recovery_instances.DescribeRecoveryInstancesOutput {
        return describe_recovery_instances.execute(self, allocator, input, options);
    }

    /// Lists all Recovery Snapshots for a single Source Server.
    pub fn describeRecoverySnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_recovery_snapshots.DescribeRecoverySnapshotsInput, options: describe_recovery_snapshots.Options) !describe_recovery_snapshots.DescribeRecoverySnapshotsOutput {
        return describe_recovery_snapshots.execute(self, allocator, input, options);
    }

    /// Lists all ReplicationConfigurationTemplates, filtered by Source Server IDs.
    pub fn describeReplicationConfigurationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesInput, options: describe_replication_configuration_templates.Options) !describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesOutput {
        return describe_replication_configuration_templates.execute(self, allocator, input, options);
    }

    /// Lists all Source Networks or multiple Source Networks filtered by ID.
    pub fn describeSourceNetworks(self: *Self, allocator: std.mem.Allocator, input: describe_source_networks.DescribeSourceNetworksInput, options: describe_source_networks.Options) !describe_source_networks.DescribeSourceNetworksOutput {
        return describe_source_networks.execute(self, allocator, input, options);
    }

    /// Lists all Source Servers or multiple Source Servers filtered by ID.
    pub fn describeSourceServers(self: *Self, allocator: std.mem.Allocator, input: describe_source_servers.DescribeSourceServersInput, options: describe_source_servers.Options) !describe_source_servers.DescribeSourceServersOutput {
        return describe_source_servers.execute(self, allocator, input, options);
    }

    /// Disconnect a Recovery Instance from Elastic Disaster Recovery. Data
    /// replication is stopped immediately. All AWS resources created by Elastic
    /// Disaster Recovery for enabling the replication of the Recovery Instance will
    /// be terminated / deleted within 90 minutes. If the agent on the Recovery
    /// Instance has not been prevented from communicating with the Elastic Disaster
    /// Recovery service, then it will receive a command to uninstall itself (within
    /// approximately 10 minutes). The following properties of the Recovery Instance
    /// will be changed immediately: dataReplicationInfo.dataReplicationState will
    /// be set to DISCONNECTED; The totalStorageBytes property for each of
    /// dataReplicationInfo.replicatedDisks will be set to zero;
    /// dataReplicationInfo.lagDuration and dataReplicationInfo.lagDuration will be
    /// nullified.
    pub fn disconnectRecoveryInstance(self: *Self, allocator: std.mem.Allocator, input: disconnect_recovery_instance.DisconnectRecoveryInstanceInput, options: disconnect_recovery_instance.Options) !disconnect_recovery_instance.DisconnectRecoveryInstanceOutput {
        return disconnect_recovery_instance.execute(self, allocator, input, options);
    }

    /// Disconnects a specific Source Server from Elastic Disaster Recovery. Data
    /// replication is stopped immediately. All AWS resources created by Elastic
    /// Disaster Recovery for enabling the replication of the Source Server will be
    /// terminated / deleted within 90 minutes. You cannot disconnect a Source
    /// Server if it has a Recovery Instance. If the agent on the Source Server has
    /// not been prevented from communicating with the Elastic Disaster Recovery
    /// service, then it will receive a command to uninstall itself (within
    /// approximately 10 minutes). The following properties of the SourceServer will
    /// be changed immediately: dataReplicationInfo.dataReplicationState will be set
    /// to DISCONNECTED; The totalStorageBytes property for each of
    /// dataReplicationInfo.replicatedDisks will be set to zero;
    /// dataReplicationInfo.lagDuration and dataReplicationInfo.lagDuration will be
    /// nullified.
    pub fn disconnectSourceServer(self: *Self, allocator: std.mem.Allocator, input: disconnect_source_server.DisconnectSourceServerInput, options: disconnect_source_server.Options) !disconnect_source_server.DisconnectSourceServerOutput {
        return disconnect_source_server.execute(self, allocator, input, options);
    }

    /// Export the Source Network CloudFormation template to an S3 bucket.
    pub fn exportSourceNetworkCfnTemplate(self: *Self, allocator: std.mem.Allocator, input: export_source_network_cfn_template.ExportSourceNetworkCfnTemplateInput, options: export_source_network_cfn_template.Options) !export_source_network_cfn_template.ExportSourceNetworkCfnTemplateOutput {
        return export_source_network_cfn_template.execute(self, allocator, input, options);
    }

    /// Lists all Failback ReplicationConfigurations, filtered by Recovery Instance
    /// ID.
    pub fn getFailbackReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_failback_replication_configuration.GetFailbackReplicationConfigurationInput, options: get_failback_replication_configuration.Options) !get_failback_replication_configuration.GetFailbackReplicationConfigurationOutput {
        return get_failback_replication_configuration.execute(self, allocator, input, options);
    }

    /// Gets a LaunchConfiguration, filtered by Source Server IDs.
    pub fn getLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_launch_configuration.GetLaunchConfigurationInput, options: get_launch_configuration.Options) !get_launch_configuration.GetLaunchConfigurationOutput {
        return get_launch_configuration.execute(self, allocator, input, options);
    }

    /// Gets a ReplicationConfiguration, filtered by Source Server ID.
    pub fn getReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_replication_configuration.GetReplicationConfigurationInput, options: get_replication_configuration.Options) !get_replication_configuration.GetReplicationConfigurationOutput {
        return get_replication_configuration.execute(self, allocator, input, options);
    }

    /// Initialize Elastic Disaster Recovery.
    pub fn initializeService(self: *Self, allocator: std.mem.Allocator, input: initialize_service.InitializeServiceInput, options: initialize_service.Options) !initialize_service.InitializeServiceOutput {
        return initialize_service.execute(self, allocator, input, options);
    }

    /// Returns a list of source servers on a staging account that are extensible,
    /// which means that:
    /// a. The source server is not already extended into this Account.
    /// b. The source server on the Account we’re reading from is not an extension
    /// of another source server.
    pub fn listExtensibleSourceServers(self: *Self, allocator: std.mem.Allocator, input: list_extensible_source_servers.ListExtensibleSourceServersInput, options: list_extensible_source_servers.Options) !list_extensible_source_servers.ListExtensibleSourceServersOutput {
        return list_extensible_source_servers.execute(self, allocator, input, options);
    }

    /// Lists resource launch actions.
    pub fn listLaunchActions(self: *Self, allocator: std.mem.Allocator, input: list_launch_actions.ListLaunchActionsInput, options: list_launch_actions.Options) !list_launch_actions.ListLaunchActionsOutput {
        return list_launch_actions.execute(self, allocator, input, options);
    }

    /// Returns an array of staging accounts for existing extended source servers.
    pub fn listStagingAccounts(self: *Self, allocator: std.mem.Allocator, input: list_staging_accounts.ListStagingAccountsInput, options: list_staging_accounts.Options) !list_staging_accounts.ListStagingAccountsOutput {
        return list_staging_accounts.execute(self, allocator, input, options);
    }

    /// List all tags for your Elastic Disaster Recovery resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Puts a resource launch action.
    pub fn putLaunchAction(self: *Self, allocator: std.mem.Allocator, input: put_launch_action.PutLaunchActionInput, options: put_launch_action.Options) !put_launch_action.PutLaunchActionOutput {
        return put_launch_action.execute(self, allocator, input, options);
    }

    /// WARNING: RetryDataReplication is deprecated.
    /// Causes the data replication initiation sequence to begin immediately upon
    /// next Handshake for the specified Source Server ID, regardless of when the
    /// previous initiation started. This command will work only if the Source
    /// Server is stalled or is in a DISCONNECTED or STOPPED state.
    pub fn retryDataReplication(self: *Self, allocator: std.mem.Allocator, input: retry_data_replication.RetryDataReplicationInput, options: retry_data_replication.Options) !retry_data_replication.RetryDataReplicationOutput {
        return retry_data_replication.execute(self, allocator, input, options);
    }

    /// Start replication to origin / target region - applies only to protected
    /// instances that originated in EC2.
    /// For recovery instances on target region - starts replication back to origin
    /// region.
    /// For failback instances on origin region - starts replication to target
    /// region to re-protect them.
    pub fn reverseReplication(self: *Self, allocator: std.mem.Allocator, input: reverse_replication.ReverseReplicationInput, options: reverse_replication.Options) !reverse_replication.ReverseReplicationOutput {
        return reverse_replication.execute(self, allocator, input, options);
    }

    /// Initiates a Job for launching the machine that is being failed back to from
    /// the specified Recovery Instance. This will run conversion on the failback
    /// client and will reboot your machine, thus completing the failback process.
    pub fn startFailbackLaunch(self: *Self, allocator: std.mem.Allocator, input: start_failback_launch.StartFailbackLaunchInput, options: start_failback_launch.Options) !start_failback_launch.StartFailbackLaunchOutput {
        return start_failback_launch.execute(self, allocator, input, options);
    }

    /// Launches Recovery Instances for the specified Source Servers. For each
    /// Source Server you may choose a point in time snapshot to launch from, or use
    /// an on demand snapshot.
    pub fn startRecovery(self: *Self, allocator: std.mem.Allocator, input: start_recovery.StartRecoveryInput, options: start_recovery.Options) !start_recovery.StartRecoveryOutput {
        return start_recovery.execute(self, allocator, input, options);
    }

    /// Starts replication for a stopped Source Server. This action would make the
    /// Source Server protected again and restart billing for it.
    pub fn startReplication(self: *Self, allocator: std.mem.Allocator, input: start_replication.StartReplicationInput, options: start_replication.Options) !start_replication.StartReplicationOutput {
        return start_replication.execute(self, allocator, input, options);
    }

    /// Deploy VPC for the specified Source Network and modify launch templates to
    /// use this network. The VPC will be deployed using a dedicated CloudFormation
    /// stack.
    pub fn startSourceNetworkRecovery(self: *Self, allocator: std.mem.Allocator, input: start_source_network_recovery.StartSourceNetworkRecoveryInput, options: start_source_network_recovery.Options) !start_source_network_recovery.StartSourceNetworkRecoveryOutput {
        return start_source_network_recovery.execute(self, allocator, input, options);
    }

    /// Starts replication for a Source Network. This action would make the Source
    /// Network protected.
    pub fn startSourceNetworkReplication(self: *Self, allocator: std.mem.Allocator, input: start_source_network_replication.StartSourceNetworkReplicationInput, options: start_source_network_replication.Options) !start_source_network_replication.StartSourceNetworkReplicationOutput {
        return start_source_network_replication.execute(self, allocator, input, options);
    }

    /// Stops the failback process for a specified Recovery Instance. This changes
    /// the Failback State of the Recovery Instance back to FAILBACK_NOT_STARTED.
    pub fn stopFailback(self: *Self, allocator: std.mem.Allocator, input: stop_failback.StopFailbackInput, options: stop_failback.Options) !stop_failback.StopFailbackOutput {
        return stop_failback.execute(self, allocator, input, options);
    }

    /// Stops replication for a Source Server. This action would make the Source
    /// Server unprotected, delete its existing snapshots and stop billing for it.
    pub fn stopReplication(self: *Self, allocator: std.mem.Allocator, input: stop_replication.StopReplicationInput, options: stop_replication.Options) !stop_replication.StopReplicationOutput {
        return stop_replication.execute(self, allocator, input, options);
    }

    /// Stops replication for a Source Network. This action would make the Source
    /// Network unprotected.
    pub fn stopSourceNetworkReplication(self: *Self, allocator: std.mem.Allocator, input: stop_source_network_replication.StopSourceNetworkReplicationInput, options: stop_source_network_replication.Options) !stop_source_network_replication.StopSourceNetworkReplicationOutput {
        return stop_source_network_replication.execute(self, allocator, input, options);
    }

    /// Adds or overwrites only the specified tags for the specified Elastic
    /// Disaster Recovery resource or resources. When you specify an existing tag
    /// key, the value is overwritten with the new value. Each resource can have a
    /// maximum of 50 tags. Each tag consists of a key and optional value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Initiates a Job for terminating the EC2 resources associated with the
    /// specified Recovery Instances, and then will delete the Recovery Instances
    /// from the Elastic Disaster Recovery service.
    pub fn terminateRecoveryInstances(self: *Self, allocator: std.mem.Allocator, input: terminate_recovery_instances.TerminateRecoveryInstancesInput, options: terminate_recovery_instances.Options) !terminate_recovery_instances.TerminateRecoveryInstancesOutput {
        return terminate_recovery_instances.execute(self, allocator, input, options);
    }

    /// Deletes the specified set of tags from the specified set of Elastic Disaster
    /// Recovery resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Allows you to update the failback replication configuration of a Recovery
    /// Instance by ID.
    pub fn updateFailbackReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_failback_replication_configuration.UpdateFailbackReplicationConfigurationInput, options: update_failback_replication_configuration.Options) !update_failback_replication_configuration.UpdateFailbackReplicationConfigurationOutput {
        return update_failback_replication_configuration.execute(self, allocator, input, options);
    }

    /// Updates a LaunchConfiguration by Source Server ID.
    pub fn updateLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_launch_configuration.UpdateLaunchConfigurationInput, options: update_launch_configuration.Options) !update_launch_configuration.UpdateLaunchConfigurationOutput {
        return update_launch_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing Launch Configuration Template by ID.
    pub fn updateLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_launch_configuration_template.UpdateLaunchConfigurationTemplateInput, options: update_launch_configuration_template.Options) !update_launch_configuration_template.UpdateLaunchConfigurationTemplateOutput {
        return update_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Allows you to update a ReplicationConfiguration by Source Server ID.
    pub fn updateReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_replication_configuration.UpdateReplicationConfigurationInput, options: update_replication_configuration.Options) !update_replication_configuration.UpdateReplicationConfigurationOutput {
        return update_replication_configuration.execute(self, allocator, input, options);
    }

    /// Updates a ReplicationConfigurationTemplate by ID.
    pub fn updateReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_replication_configuration_template.UpdateReplicationConfigurationTemplateInput, options: update_replication_configuration_template.Options) !update_replication_configuration_template.UpdateReplicationConfigurationTemplateOutput {
        return update_replication_configuration_template.execute(self, allocator, input, options);
    }

    pub fn describeJobLogItemsPaginator(self: *Self, params: describe_job_log_items.DescribeJobLogItemsInput) paginator.DescribeJobLogItemsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeJobsPaginator(self: *Self, params: describe_jobs.DescribeJobsInput) paginator.DescribeJobsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLaunchConfigurationTemplatesPaginator(self: *Self, params: describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesInput) paginator.DescribeLaunchConfigurationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRecoveryInstancesPaginator(self: *Self, params: describe_recovery_instances.DescribeRecoveryInstancesInput) paginator.DescribeRecoveryInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRecoverySnapshotsPaginator(self: *Self, params: describe_recovery_snapshots.DescribeRecoverySnapshotsInput) paginator.DescribeRecoverySnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplicationConfigurationTemplatesPaginator(self: *Self, params: describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesInput) paginator.DescribeReplicationConfigurationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSourceNetworksPaginator(self: *Self, params: describe_source_networks.DescribeSourceNetworksInput) paginator.DescribeSourceNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSourceServersPaginator(self: *Self, params: describe_source_servers.DescribeSourceServersInput) paginator.DescribeSourceServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listExtensibleSourceServersPaginator(self: *Self, params: list_extensible_source_servers.ListExtensibleSourceServersInput) paginator.ListExtensibleSourceServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listLaunchActionsPaginator(self: *Self, params: list_launch_actions.ListLaunchActionsInput) paginator.ListLaunchActionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStagingAccountsPaginator(self: *Self, params: list_staging_accounts.ListStagingAccountsInput) paginator.ListStagingAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
