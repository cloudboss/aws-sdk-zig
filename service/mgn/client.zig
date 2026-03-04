const aws = @import("aws");
const std = @import("std");

const archive_application = @import("archive_application.zig");
const archive_wave = @import("archive_wave.zig");
const associate_applications = @import("associate_applications.zig");
const associate_source_servers = @import("associate_source_servers.zig");
const change_server_life_cycle_state = @import("change_server_life_cycle_state.zig");
const create_application = @import("create_application.zig");
const create_connector = @import("create_connector.zig");
const create_launch_configuration_template = @import("create_launch_configuration_template.zig");
const create_replication_configuration_template = @import("create_replication_configuration_template.zig");
const create_wave = @import("create_wave.zig");
const delete_application = @import("delete_application.zig");
const delete_connector = @import("delete_connector.zig");
const delete_job = @import("delete_job.zig");
const delete_launch_configuration_template = @import("delete_launch_configuration_template.zig");
const delete_replication_configuration_template = @import("delete_replication_configuration_template.zig");
const delete_source_server = @import("delete_source_server.zig");
const delete_vcenter_client = @import("delete_vcenter_client.zig");
const delete_wave = @import("delete_wave.zig");
const describe_job_log_items = @import("describe_job_log_items.zig");
const describe_jobs = @import("describe_jobs.zig");
const describe_launch_configuration_templates = @import("describe_launch_configuration_templates.zig");
const describe_replication_configuration_templates = @import("describe_replication_configuration_templates.zig");
const describe_source_servers = @import("describe_source_servers.zig");
const describe_vcenter_clients = @import("describe_vcenter_clients.zig");
const disassociate_applications = @import("disassociate_applications.zig");
const disassociate_source_servers = @import("disassociate_source_servers.zig");
const disconnect_from_service = @import("disconnect_from_service.zig");
const finalize_cutover = @import("finalize_cutover.zig");
const get_launch_configuration = @import("get_launch_configuration.zig");
const get_replication_configuration = @import("get_replication_configuration.zig");
const initialize_service = @import("initialize_service.zig");
const list_applications = @import("list_applications.zig");
const list_connectors = @import("list_connectors.zig");
const list_export_errors = @import("list_export_errors.zig");
const list_exports = @import("list_exports.zig");
const list_import_errors = @import("list_import_errors.zig");
const list_imports = @import("list_imports.zig");
const list_managed_accounts = @import("list_managed_accounts.zig");
const list_source_server_actions = @import("list_source_server_actions.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_template_actions = @import("list_template_actions.zig");
const list_waves = @import("list_waves.zig");
const mark_as_archived = @import("mark_as_archived.zig");
const pause_replication = @import("pause_replication.zig");
const put_source_server_action = @import("put_source_server_action.zig");
const put_template_action = @import("put_template_action.zig");
const remove_source_server_action = @import("remove_source_server_action.zig");
const remove_template_action = @import("remove_template_action.zig");
const resume_replication = @import("resume_replication.zig");
const retry_data_replication = @import("retry_data_replication.zig");
const start_cutover = @import("start_cutover.zig");
const start_export = @import("start_export.zig");
const start_import = @import("start_import.zig");
const start_replication = @import("start_replication.zig");
const start_test = @import("start_test.zig");
const stop_replication = @import("stop_replication.zig");
const tag_resource = @import("tag_resource.zig");
const terminate_target_instances = @import("terminate_target_instances.zig");
const unarchive_application = @import("unarchive_application.zig");
const unarchive_wave = @import("unarchive_wave.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_connector = @import("update_connector.zig");
const update_launch_configuration = @import("update_launch_configuration.zig");
const update_launch_configuration_template = @import("update_launch_configuration_template.zig");
const update_replication_configuration = @import("update_replication_configuration.zig");
const update_replication_configuration_template = @import("update_replication_configuration_template.zig");
const update_source_server = @import("update_source_server.zig");
const update_source_server_replication_type = @import("update_source_server_replication_type.zig");
const update_wave = @import("update_wave.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "mgn";

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

    /// Archive application.
    pub fn archiveApplication(self: *Self, allocator: std.mem.Allocator, input: archive_application.ArchiveApplicationInput, options: CallOptions) !archive_application.ArchiveApplicationOutput {
        return archive_application.execute(self, allocator, input, options);
    }

    /// Archive wave.
    pub fn archiveWave(self: *Self, allocator: std.mem.Allocator, input: archive_wave.ArchiveWaveInput, options: CallOptions) !archive_wave.ArchiveWaveOutput {
        return archive_wave.execute(self, allocator, input, options);
    }

    /// Associate applications to wave.
    pub fn associateApplications(self: *Self, allocator: std.mem.Allocator, input: associate_applications.AssociateApplicationsInput, options: CallOptions) !associate_applications.AssociateApplicationsOutput {
        return associate_applications.execute(self, allocator, input, options);
    }

    /// Associate source servers to application.
    pub fn associateSourceServers(self: *Self, allocator: std.mem.Allocator, input: associate_source_servers.AssociateSourceServersInput, options: CallOptions) !associate_source_servers.AssociateSourceServersOutput {
        return associate_source_servers.execute(self, allocator, input, options);
    }

    /// Allows the user to set the SourceServer.LifeCycle.state property for
    /// specific Source Server IDs to one of the following: READY_FOR_TEST or
    /// READY_FOR_CUTOVER. This command only works if the Source Server is already
    /// launchable (dataReplicationInfo.lagDuration is not null.)
    pub fn changeServerLifeCycleState(self: *Self, allocator: std.mem.Allocator, input: change_server_life_cycle_state.ChangeServerLifeCycleStateInput, options: CallOptions) !change_server_life_cycle_state.ChangeServerLifeCycleStateOutput {
        return change_server_life_cycle_state.execute(self, allocator, input, options);
    }

    /// Create application.
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Create Connector.
    pub fn createConnector(self: *Self, allocator: std.mem.Allocator, input: create_connector.CreateConnectorInput, options: CallOptions) !create_connector.CreateConnectorOutput {
        return create_connector.execute(self, allocator, input, options);
    }

    /// Creates a new Launch Configuration Template.
    pub fn createLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_launch_configuration_template.CreateLaunchConfigurationTemplateInput, options: CallOptions) !create_launch_configuration_template.CreateLaunchConfigurationTemplateOutput {
        return create_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Creates a new ReplicationConfigurationTemplate.
    pub fn createReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: create_replication_configuration_template.CreateReplicationConfigurationTemplateInput, options: CallOptions) !create_replication_configuration_template.CreateReplicationConfigurationTemplateOutput {
        return create_replication_configuration_template.execute(self, allocator, input, options);
    }

    /// Create wave.
    pub fn createWave(self: *Self, allocator: std.mem.Allocator, input: create_wave.CreateWaveInput, options: CallOptions) !create_wave.CreateWaveOutput {
        return create_wave.execute(self, allocator, input, options);
    }

    /// Delete application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Delete Connector.
    pub fn deleteConnector(self: *Self, allocator: std.mem.Allocator, input: delete_connector.DeleteConnectorInput, options: CallOptions) !delete_connector.DeleteConnectorOutput {
        return delete_connector.execute(self, allocator, input, options);
    }

    /// Deletes a single Job by ID.
    pub fn deleteJob(self: *Self, allocator: std.mem.Allocator, input: delete_job.DeleteJobInput, options: CallOptions) !delete_job.DeleteJobOutput {
        return delete_job.execute(self, allocator, input, options);
    }

    /// Deletes a single Launch Configuration Template by ID.
    pub fn deleteLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_launch_configuration_template.DeleteLaunchConfigurationTemplateInput, options: CallOptions) !delete_launch_configuration_template.DeleteLaunchConfigurationTemplateOutput {
        return delete_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Deletes a single Replication Configuration Template by ID
    pub fn deleteReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_replication_configuration_template.DeleteReplicationConfigurationTemplateInput, options: CallOptions) !delete_replication_configuration_template.DeleteReplicationConfigurationTemplateOutput {
        return delete_replication_configuration_template.execute(self, allocator, input, options);
    }

    /// Deletes a single source server by ID.
    pub fn deleteSourceServer(self: *Self, allocator: std.mem.Allocator, input: delete_source_server.DeleteSourceServerInput, options: CallOptions) !delete_source_server.DeleteSourceServerOutput {
        return delete_source_server.execute(self, allocator, input, options);
    }

    /// Deletes a given vCenter client by ID.
    pub fn deleteVcenterClient(self: *Self, allocator: std.mem.Allocator, input: delete_vcenter_client.DeleteVcenterClientInput, options: CallOptions) !delete_vcenter_client.DeleteVcenterClientOutput {
        return delete_vcenter_client.execute(self, allocator, input, options);
    }

    /// Delete wave.
    pub fn deleteWave(self: *Self, allocator: std.mem.Allocator, input: delete_wave.DeleteWaveInput, options: CallOptions) !delete_wave.DeleteWaveOutput {
        return delete_wave.execute(self, allocator, input, options);
    }

    /// Retrieves detailed job log items with paging.
    pub fn describeJobLogItems(self: *Self, allocator: std.mem.Allocator, input: describe_job_log_items.DescribeJobLogItemsInput, options: CallOptions) !describe_job_log_items.DescribeJobLogItemsOutput {
        return describe_job_log_items.execute(self, allocator, input, options);
    }

    /// Returns a list of Jobs. Use the JobsID and fromDate and toData filters to
    /// limit which jobs are returned. The response is sorted by creationDataTime -
    /// latest date first. Jobs are normally created by the StartTest, StartCutover,
    /// and TerminateTargetInstances APIs. Jobs are also created by DiagnosticLaunch
    /// and TerminateDiagnosticInstances, which are APIs available only to *Support*
    /// and only used in response to relevant support tickets.
    pub fn describeJobs(self: *Self, allocator: std.mem.Allocator, input: describe_jobs.DescribeJobsInput, options: CallOptions) !describe_jobs.DescribeJobsOutput {
        return describe_jobs.execute(self, allocator, input, options);
    }

    /// Lists all Launch Configuration Templates, filtered by Launch Configuration
    /// Template IDs
    pub fn describeLaunchConfigurationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesInput, options: CallOptions) !describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesOutput {
        return describe_launch_configuration_templates.execute(self, allocator, input, options);
    }

    /// Lists all ReplicationConfigurationTemplates, filtered by Source Server IDs.
    pub fn describeReplicationConfigurationTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesInput, options: CallOptions) !describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesOutput {
        return describe_replication_configuration_templates.execute(self, allocator, input, options);
    }

    /// Retrieves all SourceServers or multiple SourceServers by ID.
    pub fn describeSourceServers(self: *Self, allocator: std.mem.Allocator, input: describe_source_servers.DescribeSourceServersInput, options: CallOptions) !describe_source_servers.DescribeSourceServersOutput {
        return describe_source_servers.execute(self, allocator, input, options);
    }

    /// Returns a list of the installed vCenter clients.
    pub fn describeVcenterClients(self: *Self, allocator: std.mem.Allocator, input: describe_vcenter_clients.DescribeVcenterClientsInput, options: CallOptions) !describe_vcenter_clients.DescribeVcenterClientsOutput {
        return describe_vcenter_clients.execute(self, allocator, input, options);
    }

    /// Disassociate applications from wave.
    pub fn disassociateApplications(self: *Self, allocator: std.mem.Allocator, input: disassociate_applications.DisassociateApplicationsInput, options: CallOptions) !disassociate_applications.DisassociateApplicationsOutput {
        return disassociate_applications.execute(self, allocator, input, options);
    }

    /// Disassociate source servers from application.
    pub fn disassociateSourceServers(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_servers.DisassociateSourceServersInput, options: CallOptions) !disassociate_source_servers.DisassociateSourceServersOutput {
        return disassociate_source_servers.execute(self, allocator, input, options);
    }

    /// Disconnects specific Source Servers from Application Migration Service. Data
    /// replication is stopped immediately. All AWS resources created by Application
    /// Migration Service for enabling the replication of these source servers will
    /// be terminated / deleted within 90 minutes. Launched Test or Cutover
    /// instances will NOT be terminated. If the agent on the source server has not
    /// been prevented from communicating with the Application Migration Service
    /// service, then it will receive a command to uninstall itself (within
    /// approximately 10 minutes). The following properties of the SourceServer will
    /// be changed immediately: dataReplicationInfo.dataReplicationState will be set
    /// to DISCONNECTED; The totalStorageBytes property for each of
    /// dataReplicationInfo.replicatedDisks will be set to zero;
    /// dataReplicationInfo.lagDuration and dataReplicationInfo.lagDuration will be
    /// nullified.
    pub fn disconnectFromService(self: *Self, allocator: std.mem.Allocator, input: disconnect_from_service.DisconnectFromServiceInput, options: CallOptions) !disconnect_from_service.DisconnectFromServiceOutput {
        return disconnect_from_service.execute(self, allocator, input, options);
    }

    /// Finalizes the cutover immediately for specific Source Servers. All AWS
    /// resources created by Application Migration Service for enabling the
    /// replication of these source servers will be terminated / deleted within 90
    /// minutes. Launched Test or Cutover instances will NOT be terminated. The AWS
    /// Replication Agent will receive a command to uninstall itself (within 10
    /// minutes). The following properties of the SourceServer will be changed
    /// immediately: dataReplicationInfo.dataReplicationState will be changed to
    /// DISCONNECTED; The SourceServer.lifeCycle.state will be changed to CUTOVER;
    /// The totalStorageBytes property fo each of
    /// dataReplicationInfo.replicatedDisks will be set to zero;
    /// dataReplicationInfo.lagDuration and dataReplicationInfo.lagDuration will be
    /// nullified.
    pub fn finalizeCutover(self: *Self, allocator: std.mem.Allocator, input: finalize_cutover.FinalizeCutoverInput, options: CallOptions) !finalize_cutover.FinalizeCutoverOutput {
        return finalize_cutover.execute(self, allocator, input, options);
    }

    /// Lists all LaunchConfigurations available, filtered by Source Server IDs.
    pub fn getLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_launch_configuration.GetLaunchConfigurationInput, options: CallOptions) !get_launch_configuration.GetLaunchConfigurationOutput {
        return get_launch_configuration.execute(self, allocator, input, options);
    }

    /// Lists all ReplicationConfigurations, filtered by Source Server ID.
    pub fn getReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_replication_configuration.GetReplicationConfigurationInput, options: CallOptions) !get_replication_configuration.GetReplicationConfigurationOutput {
        return get_replication_configuration.execute(self, allocator, input, options);
    }

    /// Initialize Application Migration Service.
    pub fn initializeService(self: *Self, allocator: std.mem.Allocator, input: initialize_service.InitializeServiceInput, options: CallOptions) !initialize_service.InitializeServiceOutput {
        return initialize_service.execute(self, allocator, input, options);
    }

    /// Retrieves all applications or multiple applications by ID.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// List Connectors.
    pub fn listConnectors(self: *Self, allocator: std.mem.Allocator, input: list_connectors.ListConnectorsInput, options: CallOptions) !list_connectors.ListConnectorsOutput {
        return list_connectors.execute(self, allocator, input, options);
    }

    /// List export errors.
    pub fn listExportErrors(self: *Self, allocator: std.mem.Allocator, input: list_export_errors.ListExportErrorsInput, options: CallOptions) !list_export_errors.ListExportErrorsOutput {
        return list_export_errors.execute(self, allocator, input, options);
    }

    /// List exports.
    pub fn listExports(self: *Self, allocator: std.mem.Allocator, input: list_exports.ListExportsInput, options: CallOptions) !list_exports.ListExportsOutput {
        return list_exports.execute(self, allocator, input, options);
    }

    /// List import errors.
    pub fn listImportErrors(self: *Self, allocator: std.mem.Allocator, input: list_import_errors.ListImportErrorsInput, options: CallOptions) !list_import_errors.ListImportErrorsOutput {
        return list_import_errors.execute(self, allocator, input, options);
    }

    /// List imports.
    pub fn listImports(self: *Self, allocator: std.mem.Allocator, input: list_imports.ListImportsInput, options: CallOptions) !list_imports.ListImportsOutput {
        return list_imports.execute(self, allocator, input, options);
    }

    /// List Managed Accounts.
    pub fn listManagedAccounts(self: *Self, allocator: std.mem.Allocator, input: list_managed_accounts.ListManagedAccountsInput, options: CallOptions) !list_managed_accounts.ListManagedAccountsOutput {
        return list_managed_accounts.execute(self, allocator, input, options);
    }

    /// List source server post migration custom actions.
    pub fn listSourceServerActions(self: *Self, allocator: std.mem.Allocator, input: list_source_server_actions.ListSourceServerActionsInput, options: CallOptions) !list_source_server_actions.ListSourceServerActionsOutput {
        return list_source_server_actions.execute(self, allocator, input, options);
    }

    /// List all tags for your Application Migration Service resources.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// List template post migration custom actions.
    pub fn listTemplateActions(self: *Self, allocator: std.mem.Allocator, input: list_template_actions.ListTemplateActionsInput, options: CallOptions) !list_template_actions.ListTemplateActionsOutput {
        return list_template_actions.execute(self, allocator, input, options);
    }

    /// Retrieves all waves or multiple waves by ID.
    pub fn listWaves(self: *Self, allocator: std.mem.Allocator, input: list_waves.ListWavesInput, options: CallOptions) !list_waves.ListWavesOutput {
        return list_waves.execute(self, allocator, input, options);
    }

    /// Archives specific Source Servers by setting the SourceServer.isArchived
    /// property to true for specified SourceServers by ID. This command only works
    /// for SourceServers with a lifecycle. state which equals DISCONNECTED or
    /// CUTOVER.
    pub fn markAsArchived(self: *Self, allocator: std.mem.Allocator, input: mark_as_archived.MarkAsArchivedInput, options: CallOptions) !mark_as_archived.MarkAsArchivedOutput {
        return mark_as_archived.execute(self, allocator, input, options);
    }

    /// Pause Replication.
    pub fn pauseReplication(self: *Self, allocator: std.mem.Allocator, input: pause_replication.PauseReplicationInput, options: CallOptions) !pause_replication.PauseReplicationOutput {
        return pause_replication.execute(self, allocator, input, options);
    }

    /// Put source server post migration custom action.
    pub fn putSourceServerAction(self: *Self, allocator: std.mem.Allocator, input: put_source_server_action.PutSourceServerActionInput, options: CallOptions) !put_source_server_action.PutSourceServerActionOutput {
        return put_source_server_action.execute(self, allocator, input, options);
    }

    /// Put template post migration custom action.
    pub fn putTemplateAction(self: *Self, allocator: std.mem.Allocator, input: put_template_action.PutTemplateActionInput, options: CallOptions) !put_template_action.PutTemplateActionOutput {
        return put_template_action.execute(self, allocator, input, options);
    }

    /// Remove source server post migration custom action.
    pub fn removeSourceServerAction(self: *Self, allocator: std.mem.Allocator, input: remove_source_server_action.RemoveSourceServerActionInput, options: CallOptions) !remove_source_server_action.RemoveSourceServerActionOutput {
        return remove_source_server_action.execute(self, allocator, input, options);
    }

    /// Remove template post migration custom action.
    pub fn removeTemplateAction(self: *Self, allocator: std.mem.Allocator, input: remove_template_action.RemoveTemplateActionInput, options: CallOptions) !remove_template_action.RemoveTemplateActionOutput {
        return remove_template_action.execute(self, allocator, input, options);
    }

    /// Resume Replication.
    pub fn resumeReplication(self: *Self, allocator: std.mem.Allocator, input: resume_replication.ResumeReplicationInput, options: CallOptions) !resume_replication.ResumeReplicationOutput {
        return resume_replication.execute(self, allocator, input, options);
    }

    /// Causes the data replication initiation sequence to begin immediately upon
    /// next Handshake for specified SourceServer IDs, regardless of when the
    /// previous initiation started. This command will not work if the SourceServer
    /// is not stalled or is in a DISCONNECTED or STOPPED state.
    pub fn retryDataReplication(self: *Self, allocator: std.mem.Allocator, input: retry_data_replication.RetryDataReplicationInput, options: CallOptions) !retry_data_replication.RetryDataReplicationOutput {
        return retry_data_replication.execute(self, allocator, input, options);
    }

    /// Launches a Cutover Instance for specific Source Servers. This command starts
    /// a LAUNCH job whose initiatedBy property is StartCutover and changes the
    /// SourceServer.lifeCycle.state property to CUTTING_OVER.
    pub fn startCutover(self: *Self, allocator: std.mem.Allocator, input: start_cutover.StartCutoverInput, options: CallOptions) !start_cutover.StartCutoverOutput {
        return start_cutover.execute(self, allocator, input, options);
    }

    /// Start export.
    pub fn startExport(self: *Self, allocator: std.mem.Allocator, input: start_export.StartExportInput, options: CallOptions) !start_export.StartExportOutput {
        return start_export.execute(self, allocator, input, options);
    }

    /// Start import.
    pub fn startImport(self: *Self, allocator: std.mem.Allocator, input: start_import.StartImportInput, options: CallOptions) !start_import.StartImportOutput {
        return start_import.execute(self, allocator, input, options);
    }

    /// Start replication for source server irrespective of its replication type.
    pub fn startReplication(self: *Self, allocator: std.mem.Allocator, input: start_replication.StartReplicationInput, options: CallOptions) !start_replication.StartReplicationOutput {
        return start_replication.execute(self, allocator, input, options);
    }

    /// Launches a Test Instance for specific Source Servers. This command starts a
    /// LAUNCH job whose initiatedBy property is StartTest and changes the
    /// SourceServer.lifeCycle.state property to TESTING.
    pub fn startTest(self: *Self, allocator: std.mem.Allocator, input: start_test.StartTestInput, options: CallOptions) !start_test.StartTestOutput {
        return start_test.execute(self, allocator, input, options);
    }

    /// Stop Replication.
    pub fn stopReplication(self: *Self, allocator: std.mem.Allocator, input: stop_replication.StopReplicationInput, options: CallOptions) !stop_replication.StopReplicationOutput {
        return stop_replication.execute(self, allocator, input, options);
    }

    /// Adds or overwrites only the specified tags for the specified Application
    /// Migration Service resource or resources. When you specify an existing tag
    /// key, the value is overwritten with the new value. Each resource can have a
    /// maximum of 50 tags. Each tag consists of a key and optional value.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Starts a job that terminates specific launched EC2 Test and Cutover
    /// instances. This command will not work for any Source Server with a
    /// lifecycle.state of TESTING, CUTTING_OVER, or CUTOVER.
    pub fn terminateTargetInstances(self: *Self, allocator: std.mem.Allocator, input: terminate_target_instances.TerminateTargetInstancesInput, options: CallOptions) !terminate_target_instances.TerminateTargetInstancesOutput {
        return terminate_target_instances.execute(self, allocator, input, options);
    }

    /// Unarchive application.
    pub fn unarchiveApplication(self: *Self, allocator: std.mem.Allocator, input: unarchive_application.UnarchiveApplicationInput, options: CallOptions) !unarchive_application.UnarchiveApplicationOutput {
        return unarchive_application.execute(self, allocator, input, options);
    }

    /// Unarchive wave.
    pub fn unarchiveWave(self: *Self, allocator: std.mem.Allocator, input: unarchive_wave.UnarchiveWaveInput, options: CallOptions) !unarchive_wave.UnarchiveWaveOutput {
        return unarchive_wave.execute(self, allocator, input, options);
    }

    /// Deletes the specified set of tags from the specified set of Application
    /// Migration Service resources.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Update Connector.
    pub fn updateConnector(self: *Self, allocator: std.mem.Allocator, input: update_connector.UpdateConnectorInput, options: CallOptions) !update_connector.UpdateConnectorOutput {
        return update_connector.execute(self, allocator, input, options);
    }

    /// Updates multiple LaunchConfigurations by Source Server ID.
    ///
    /// bootMode valid values are `LEGACY_BIOS | UEFI`
    pub fn updateLaunchConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_launch_configuration.UpdateLaunchConfigurationInput, options: CallOptions) !update_launch_configuration.UpdateLaunchConfigurationOutput {
        return update_launch_configuration.execute(self, allocator, input, options);
    }

    /// Updates an existing Launch Configuration Template by ID.
    pub fn updateLaunchConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_launch_configuration_template.UpdateLaunchConfigurationTemplateInput, options: CallOptions) !update_launch_configuration_template.UpdateLaunchConfigurationTemplateOutput {
        return update_launch_configuration_template.execute(self, allocator, input, options);
    }

    /// Allows you to update multiple ReplicationConfigurations by Source Server ID.
    pub fn updateReplicationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_replication_configuration.UpdateReplicationConfigurationInput, options: CallOptions) !update_replication_configuration.UpdateReplicationConfigurationOutput {
        return update_replication_configuration.execute(self, allocator, input, options);
    }

    /// Updates multiple ReplicationConfigurationTemplates by ID.
    pub fn updateReplicationConfigurationTemplate(self: *Self, allocator: std.mem.Allocator, input: update_replication_configuration_template.UpdateReplicationConfigurationTemplateInput, options: CallOptions) !update_replication_configuration_template.UpdateReplicationConfigurationTemplateOutput {
        return update_replication_configuration_template.execute(self, allocator, input, options);
    }

    /// Update Source Server.
    pub fn updateSourceServer(self: *Self, allocator: std.mem.Allocator, input: update_source_server.UpdateSourceServerInput, options: CallOptions) !update_source_server.UpdateSourceServerOutput {
        return update_source_server.execute(self, allocator, input, options);
    }

    /// Allows you to change between the AGENT_BASED replication type and the
    /// SNAPSHOT_SHIPPING replication type.
    ///
    /// SNAPSHOT_SHIPPING should be used for agentless replication.
    pub fn updateSourceServerReplicationType(self: *Self, allocator: std.mem.Allocator, input: update_source_server_replication_type.UpdateSourceServerReplicationTypeInput, options: CallOptions) !update_source_server_replication_type.UpdateSourceServerReplicationTypeOutput {
        return update_source_server_replication_type.execute(self, allocator, input, options);
    }

    /// Update wave.
    pub fn updateWave(self: *Self, allocator: std.mem.Allocator, input: update_wave.UpdateWaveInput, options: CallOptions) !update_wave.UpdateWaveOutput {
        return update_wave.execute(self, allocator, input, options);
    }

    pub fn describeJobLogItemsPaginator(self: *Self, params: describe_job_log_items.DescribeJobLogItemsInput) paginator.DescribeJobLogItemsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeJobsPaginator(self: *Self, params: describe_jobs.DescribeJobsInput) paginator.DescribeJobsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeLaunchConfigurationTemplatesPaginator(self: *Self, params: describe_launch_configuration_templates.DescribeLaunchConfigurationTemplatesInput) paginator.DescribeLaunchConfigurationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeReplicationConfigurationTemplatesPaginator(self: *Self, params: describe_replication_configuration_templates.DescribeReplicationConfigurationTemplatesInput) paginator.DescribeReplicationConfigurationTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeSourceServersPaginator(self: *Self, params: describe_source_servers.DescribeSourceServersInput) paginator.DescribeSourceServersPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn describeVcenterClientsPaginator(self: *Self, params: describe_vcenter_clients.DescribeVcenterClientsInput) paginator.DescribeVcenterClientsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listConnectorsPaginator(self: *Self, params: list_connectors.ListConnectorsInput) paginator.ListConnectorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExportErrorsPaginator(self: *Self, params: list_export_errors.ListExportErrorsInput) paginator.ListExportErrorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExportsPaginator(self: *Self, params: list_exports.ListExportsInput) paginator.ListExportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImportErrorsPaginator(self: *Self, params: list_import_errors.ListImportErrorsInput) paginator.ListImportErrorsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listImportsPaginator(self: *Self, params: list_imports.ListImportsInput) paginator.ListImportsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listManagedAccountsPaginator(self: *Self, params: list_managed_accounts.ListManagedAccountsInput) paginator.ListManagedAccountsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listSourceServerActionsPaginator(self: *Self, params: list_source_server_actions.ListSourceServerActionsInput) paginator.ListSourceServerActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTemplateActionsPaginator(self: *Self, params: list_template_actions.ListTemplateActionsInput) paginator.ListTemplateActionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listWavesPaginator(self: *Self, params: list_waves.ListWavesInput) paginator.ListWavesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
