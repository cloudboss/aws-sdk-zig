const aws = @import("aws");
const std = @import("std");

const associate_created_artifact = @import("associate_created_artifact.zig");
const associate_discovered_resource = @import("associate_discovered_resource.zig");
const associate_source_resource = @import("associate_source_resource.zig");
const create_progress_update_stream = @import("create_progress_update_stream.zig");
const delete_progress_update_stream = @import("delete_progress_update_stream.zig");
const describe_application_state = @import("describe_application_state.zig");
const describe_migration_task = @import("describe_migration_task.zig");
const disassociate_created_artifact = @import("disassociate_created_artifact.zig");
const disassociate_discovered_resource = @import("disassociate_discovered_resource.zig");
const disassociate_source_resource = @import("disassociate_source_resource.zig");
const import_migration_task = @import("import_migration_task.zig");
const list_application_states = @import("list_application_states.zig");
const list_created_artifacts = @import("list_created_artifacts.zig");
const list_discovered_resources = @import("list_discovered_resources.zig");
const list_migration_task_updates = @import("list_migration_task_updates.zig");
const list_migration_tasks = @import("list_migration_tasks.zig");
const list_progress_update_streams = @import("list_progress_update_streams.zig");
const list_source_resources = @import("list_source_resources.zig");
const notify_application_state = @import("notify_application_state.zig");
const notify_migration_task_state = @import("notify_migration_task_state.zig");
const put_resource_attributes = @import("put_resource_attributes.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Migration Hub";

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

    /// Associates a created artifact of an AWS cloud resource, the target receiving
    /// the
    /// migration, with the migration task performed by a migration tool. This API
    /// has the
    /// following traits:
    ///
    /// * Migration tools can call the `AssociateCreatedArtifact` operation to
    /// indicate which AWS artifact is associated with a migration task.
    ///
    /// * The created artifact name must be provided in ARN (Amazon Resource Name)
    ///   format
    /// which will contain information about type and region; for example:
    /// `arn:aws:ec2:us-east-1:488216288981:image/ami-6d0ba87b`.
    ///
    /// * Examples of the AWS resource behind the created artifact are, AMI's, EC2
    ///   instance,
    /// or DMS endpoint, etc.
    pub fn associateCreatedArtifact(self: *Self, allocator: std.mem.Allocator, input: associate_created_artifact.AssociateCreatedArtifactInput, options: associate_created_artifact.Options) !associate_created_artifact.AssociateCreatedArtifactOutput {
        return associate_created_artifact.execute(self, allocator, input, options);
    }

    /// Associates a discovered resource ID from Application Discovery Service with
    /// a migration
    /// task.
    pub fn associateDiscoveredResource(self: *Self, allocator: std.mem.Allocator, input: associate_discovered_resource.AssociateDiscoveredResourceInput, options: associate_discovered_resource.Options) !associate_discovered_resource.AssociateDiscoveredResourceOutput {
        return associate_discovered_resource.execute(self, allocator, input, options);
    }

    /// Associates a source resource with a migration task. For example, the source
    /// resource can
    /// be a source server, an application, or a migration wave.
    pub fn associateSourceResource(self: *Self, allocator: std.mem.Allocator, input: associate_source_resource.AssociateSourceResourceInput, options: associate_source_resource.Options) !associate_source_resource.AssociateSourceResourceOutput {
        return associate_source_resource.execute(self, allocator, input, options);
    }

    /// Creates a progress update stream which is an AWS resource used for access
    /// control as
    /// well as a namespace for migration task names that is implicitly linked to
    /// your AWS account.
    /// It must uniquely identify the migration tool as it is used for all updates
    /// made by the
    /// tool; however, it does not need to be unique for each AWS account because it
    /// is scoped to
    /// the AWS account.
    pub fn createProgressUpdateStream(self: *Self, allocator: std.mem.Allocator, input: create_progress_update_stream.CreateProgressUpdateStreamInput, options: create_progress_update_stream.Options) !create_progress_update_stream.CreateProgressUpdateStreamOutput {
        return create_progress_update_stream.execute(self, allocator, input, options);
    }

    /// Deletes a progress update stream, including all of its tasks, which was
    /// previously
    /// created as an AWS resource used for access control. This API has the
    /// following
    /// traits:
    ///
    /// * The only parameter needed for `DeleteProgressUpdateStream` is the
    /// stream name (same as a `CreateProgressUpdateStream` call).
    ///
    /// * The call will return, and a background process will asynchronously delete
    ///   the
    /// stream and all of its resources (tasks, associated resources, resource
    /// attributes,
    /// created artifacts).
    ///
    /// * If the stream takes time to be deleted, it might still show up on a
    /// `ListProgressUpdateStreams` call.
    ///
    /// * `CreateProgressUpdateStream`, `ImportMigrationTask`,
    /// `NotifyMigrationTaskState`, and all Associate[*] APIs related to the
    /// tasks belonging to the stream will throw "InvalidInputException" if the
    /// stream of the
    /// same name is in the process of being deleted.
    ///
    /// * Once the stream and all of its resources are deleted,
    /// `CreateProgressUpdateStream` for a stream of the same name will
    /// succeed, and that stream will be an entirely new logical resource (without
    /// any
    /// resources associated with the old stream).
    pub fn deleteProgressUpdateStream(self: *Self, allocator: std.mem.Allocator, input: delete_progress_update_stream.DeleteProgressUpdateStreamInput, options: delete_progress_update_stream.Options) !delete_progress_update_stream.DeleteProgressUpdateStreamOutput {
        return delete_progress_update_stream.execute(self, allocator, input, options);
    }

    /// Gets the migration status of an application.
    pub fn describeApplicationState(self: *Self, allocator: std.mem.Allocator, input: describe_application_state.DescribeApplicationStateInput, options: describe_application_state.Options) !describe_application_state.DescribeApplicationStateOutput {
        return describe_application_state.execute(self, allocator, input, options);
    }

    /// Retrieves a list of all attributes associated with a specific migration
    /// task.
    pub fn describeMigrationTask(self: *Self, allocator: std.mem.Allocator, input: describe_migration_task.DescribeMigrationTaskInput, options: describe_migration_task.Options) !describe_migration_task.DescribeMigrationTaskOutput {
        return describe_migration_task.execute(self, allocator, input, options);
    }

    /// Disassociates a created artifact of an AWS resource with a migration task
    /// performed by a
    /// migration tool that was previously associated. This API has the following
    /// traits:
    ///
    /// * A migration user can call the `DisassociateCreatedArtifacts` operation
    /// to disassociate a created AWS Artifact from a migration task.
    ///
    /// * The created artifact name must be provided in ARN (Amazon Resource Name)
    ///   format
    /// which will contain information about type and region; for example:
    /// `arn:aws:ec2:us-east-1:488216288981:image/ami-6d0ba87b`.
    ///
    /// * Examples of the AWS resource behind the created artifact are, AMI's, EC2
    ///   instance,
    /// or RDS instance, etc.
    pub fn disassociateCreatedArtifact(self: *Self, allocator: std.mem.Allocator, input: disassociate_created_artifact.DisassociateCreatedArtifactInput, options: disassociate_created_artifact.Options) !disassociate_created_artifact.DisassociateCreatedArtifactOutput {
        return disassociate_created_artifact.execute(self, allocator, input, options);
    }

    /// Disassociate an Application Discovery Service discovered resource from a
    /// migration
    /// task.
    pub fn disassociateDiscoveredResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_discovered_resource.DisassociateDiscoveredResourceInput, options: disassociate_discovered_resource.Options) !disassociate_discovered_resource.DisassociateDiscoveredResourceOutput {
        return disassociate_discovered_resource.execute(self, allocator, input, options);
    }

    /// Removes the association between a source resource and a migration task.
    pub fn disassociateSourceResource(self: *Self, allocator: std.mem.Allocator, input: disassociate_source_resource.DisassociateSourceResourceInput, options: disassociate_source_resource.Options) !disassociate_source_resource.DisassociateSourceResourceOutput {
        return disassociate_source_resource.execute(self, allocator, input, options);
    }

    /// Registers a new migration task which represents a server, database, etc.,
    /// being migrated
    /// to AWS by a migration tool.
    ///
    /// This API is a prerequisite to calling the `NotifyMigrationTaskState` API as
    /// the migration tool must first register the migration task with Migration
    /// Hub.
    pub fn importMigrationTask(self: *Self, allocator: std.mem.Allocator, input: import_migration_task.ImportMigrationTaskInput, options: import_migration_task.Options) !import_migration_task.ImportMigrationTaskOutput {
        return import_migration_task.execute(self, allocator, input, options);
    }

    /// Lists all the migration statuses for your applications. If you use the
    /// optional
    /// `ApplicationIds` parameter, only the migration statuses for those
    /// applications will be returned.
    pub fn listApplicationStates(self: *Self, allocator: std.mem.Allocator, input: list_application_states.ListApplicationStatesInput, options: list_application_states.Options) !list_application_states.ListApplicationStatesOutput {
        return list_application_states.execute(self, allocator, input, options);
    }

    /// Lists the created artifacts attached to a given migration task in an update
    /// stream. This
    /// API has the following traits:
    ///
    /// * Gets the list of the created artifacts while
    /// migration is taking place.
    ///
    /// * Shows the artifacts created by the migration tool that was associated by
    ///   the
    /// `AssociateCreatedArtifact` API.
    ///
    /// * Lists created artifacts in a paginated interface.
    pub fn listCreatedArtifacts(self: *Self, allocator: std.mem.Allocator, input: list_created_artifacts.ListCreatedArtifactsInput, options: list_created_artifacts.Options) !list_created_artifacts.ListCreatedArtifactsOutput {
        return list_created_artifacts.execute(self, allocator, input, options);
    }

    /// Lists discovered resources associated with the given `MigrationTask`.
    pub fn listDiscoveredResources(self: *Self, allocator: std.mem.Allocator, input: list_discovered_resources.ListDiscoveredResourcesInput, options: list_discovered_resources.Options) !list_discovered_resources.ListDiscoveredResourcesOutput {
        return list_discovered_resources.execute(self, allocator, input, options);
    }

    /// This is a paginated API that returns all the migration-task states for the
    /// specified
    /// `MigrationTaskName` and `ProgressUpdateStream`.
    pub fn listMigrationTaskUpdates(self: *Self, allocator: std.mem.Allocator, input: list_migration_task_updates.ListMigrationTaskUpdatesInput, options: list_migration_task_updates.Options) !list_migration_task_updates.ListMigrationTaskUpdatesOutput {
        return list_migration_task_updates.execute(self, allocator, input, options);
    }

    /// Lists all, or filtered by resource name, migration tasks associated with the
    /// user
    /// account making this call. This API has the following traits:
    ///
    /// * Can show a summary list of the most recent migration tasks.
    ///
    /// * Can show a summary list of migration tasks associated with a given
    ///   discovered
    /// resource.
    ///
    /// * Lists migration tasks in a paginated interface.
    pub fn listMigrationTasks(self: *Self, allocator: std.mem.Allocator, input: list_migration_tasks.ListMigrationTasksInput, options: list_migration_tasks.Options) !list_migration_tasks.ListMigrationTasksOutput {
        return list_migration_tasks.execute(self, allocator, input, options);
    }

    /// Lists progress update streams associated with the user account making this
    /// call.
    pub fn listProgressUpdateStreams(self: *Self, allocator: std.mem.Allocator, input: list_progress_update_streams.ListProgressUpdateStreamsInput, options: list_progress_update_streams.Options) !list_progress_update_streams.ListProgressUpdateStreamsOutput {
        return list_progress_update_streams.execute(self, allocator, input, options);
    }

    /// Lists all the source resource that are associated with the specified
    /// `MigrationTaskName` and `ProgressUpdateStream`.
    pub fn listSourceResources(self: *Self, allocator: std.mem.Allocator, input: list_source_resources.ListSourceResourcesInput, options: list_source_resources.Options) !list_source_resources.ListSourceResourcesOutput {
        return list_source_resources.execute(self, allocator, input, options);
    }

    /// Sets the migration state of an application. For a given application
    /// identified by the
    /// value passed to `ApplicationId`, its status is set or updated by passing one
    /// of
    /// three values to `Status`: `NOT_STARTED | IN_PROGRESS |
    /// COMPLETED`.
    pub fn notifyApplicationState(self: *Self, allocator: std.mem.Allocator, input: notify_application_state.NotifyApplicationStateInput, options: notify_application_state.Options) !notify_application_state.NotifyApplicationStateOutput {
        return notify_application_state.execute(self, allocator, input, options);
    }

    /// Notifies Migration Hub of the current status, progress, or other detail
    /// regarding a
    /// migration task. This API has the following traits:
    ///
    /// * Migration tools will call the `NotifyMigrationTaskState` API to share
    /// the latest progress and status.
    ///
    /// * `MigrationTaskName` is used for addressing updates to the correct
    /// target.
    ///
    /// * `ProgressUpdateStream` is used for access control and to provide a
    /// namespace for each migration tool.
    pub fn notifyMigrationTaskState(self: *Self, allocator: std.mem.Allocator, input: notify_migration_task_state.NotifyMigrationTaskStateInput, options: notify_migration_task_state.Options) !notify_migration_task_state.NotifyMigrationTaskStateOutput {
        return notify_migration_task_state.execute(self, allocator, input, options);
    }

    /// Provides identifying details of the resource being migrated so that it can
    /// be associated
    /// in the Application Discovery Service repository. This association occurs
    /// asynchronously
    /// after `PutResourceAttributes` returns.
    ///
    /// * Keep in mind that subsequent calls to PutResourceAttributes will override
    /// previously stored attributes. For example, if it is first called with a MAC
    /// address, but later, it is desired to *add* an IP address, it
    /// will then be required to call it with *both* the IP and MAC
    /// addresses to prevent overriding the MAC address.
    ///
    /// * Note the instructions regarding the special use case of the [
    /// `ResourceAttributeList`
    /// ](https://docs.aws.amazon.com/migrationhub/latest/ug/API_PutResourceAttributes.html#migrationhub-PutResourceAttributes-request-ResourceAttributeList) parameter when specifying any
    /// "VM" related value.
    ///
    /// Because this is an asynchronous call, it will always return 200, whether an
    /// association occurs or not. To confirm if an association was found based on
    /// the provided
    /// details, call `ListDiscoveredResources`.
    pub fn putResourceAttributes(self: *Self, allocator: std.mem.Allocator, input: put_resource_attributes.PutResourceAttributesInput, options: put_resource_attributes.Options) !put_resource_attributes.PutResourceAttributesOutput {
        return put_resource_attributes.execute(self, allocator, input, options);
    }

    pub fn listApplicationStatesPaginator(self: *Self, params: list_application_states.ListApplicationStatesInput) paginator.ListApplicationStatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listCreatedArtifactsPaginator(self: *Self, params: list_created_artifacts.ListCreatedArtifactsInput) paginator.ListCreatedArtifactsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listDiscoveredResourcesPaginator(self: *Self, params: list_discovered_resources.ListDiscoveredResourcesInput) paginator.ListDiscoveredResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMigrationTaskUpdatesPaginator(self: *Self, params: list_migration_task_updates.ListMigrationTaskUpdatesInput) paginator.ListMigrationTaskUpdatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMigrationTasksPaginator(self: *Self, params: list_migration_tasks.ListMigrationTasksInput) paginator.ListMigrationTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listProgressUpdateStreamsPaginator(self: *Self, params: list_progress_update_streams.ListProgressUpdateStreamsInput) paginator.ListProgressUpdateStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSourceResourcesPaginator(self: *Self, params: list_source_resources.ListSourceResourcesInput) paginator.ListSourceResourcesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
