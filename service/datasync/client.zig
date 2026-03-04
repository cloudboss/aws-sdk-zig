const aws = @import("aws");
const std = @import("std");

const cancel_task_execution = @import("cancel_task_execution.zig");
const create_agent = @import("create_agent.zig");
const create_location_azure_blob = @import("create_location_azure_blob.zig");
const create_location_efs = @import("create_location_efs.zig");
const create_location_fsx_lustre = @import("create_location_fsx_lustre.zig");
const create_location_fsx_ontap = @import("create_location_fsx_ontap.zig");
const create_location_fsx_open_zfs = @import("create_location_fsx_open_zfs.zig");
const create_location_fsx_windows = @import("create_location_fsx_windows.zig");
const create_location_hdfs = @import("create_location_hdfs.zig");
const create_location_nfs = @import("create_location_nfs.zig");
const create_location_object_storage = @import("create_location_object_storage.zig");
const create_location_s3 = @import("create_location_s3.zig");
const create_location_smb = @import("create_location_smb.zig");
const create_task = @import("create_task.zig");
const delete_agent = @import("delete_agent.zig");
const delete_location = @import("delete_location.zig");
const delete_task = @import("delete_task.zig");
const describe_agent = @import("describe_agent.zig");
const describe_location_azure_blob = @import("describe_location_azure_blob.zig");
const describe_location_efs = @import("describe_location_efs.zig");
const describe_location_fsx_lustre = @import("describe_location_fsx_lustre.zig");
const describe_location_fsx_ontap = @import("describe_location_fsx_ontap.zig");
const describe_location_fsx_open_zfs = @import("describe_location_fsx_open_zfs.zig");
const describe_location_fsx_windows = @import("describe_location_fsx_windows.zig");
const describe_location_hdfs = @import("describe_location_hdfs.zig");
const describe_location_nfs = @import("describe_location_nfs.zig");
const describe_location_object_storage = @import("describe_location_object_storage.zig");
const describe_location_s3 = @import("describe_location_s3.zig");
const describe_location_smb = @import("describe_location_smb.zig");
const describe_task = @import("describe_task.zig");
const describe_task_execution = @import("describe_task_execution.zig");
const list_agents = @import("list_agents.zig");
const list_locations = @import("list_locations.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_task_executions = @import("list_task_executions.zig");
const list_tasks = @import("list_tasks.zig");
const start_task_execution = @import("start_task_execution.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_agent = @import("update_agent.zig");
const update_location_azure_blob = @import("update_location_azure_blob.zig");
const update_location_efs = @import("update_location_efs.zig");
const update_location_fsx_lustre = @import("update_location_fsx_lustre.zig");
const update_location_fsx_ontap = @import("update_location_fsx_ontap.zig");
const update_location_fsx_open_zfs = @import("update_location_fsx_open_zfs.zig");
const update_location_fsx_windows = @import("update_location_fsx_windows.zig");
const update_location_hdfs = @import("update_location_hdfs.zig");
const update_location_nfs = @import("update_location_nfs.zig");
const update_location_object_storage = @import("update_location_object_storage.zig");
const update_location_s3 = @import("update_location_s3.zig");
const update_location_smb = @import("update_location_smb.zig");
const update_task = @import("update_task.zig");
const update_task_execution = @import("update_task_execution.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "DataSync";

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

    /// Stops an DataSync task execution that's in progress. The transfer of some
    /// files are abruptly interrupted. File contents that're transferred to the
    /// destination might be
    /// incomplete or inconsistent with the source files.
    ///
    /// However, if you start a new task execution using the same task and allow it
    /// to finish,
    /// file content on the destination will be complete and consistent. This
    /// applies to other
    /// unexpected failures that interrupt a task execution. In all of these cases,
    /// DataSync
    /// successfully completes the transfer when you start the next task execution.
    pub fn cancelTaskExecution(self: *Self, allocator: std.mem.Allocator, input: cancel_task_execution.CancelTaskExecutionInput, options: CallOptions) !cancel_task_execution.CancelTaskExecutionOutput {
        return cancel_task_execution.execute(self, allocator, input, options);
    }

    /// Activates an DataSync agent that you deploy in your storage environment.
    /// The activation process associates the agent with your Amazon Web Services
    /// account.
    ///
    /// If you haven't deployed an agent yet, see [Do I need a DataSync
    /// agent?](https://docs.aws.amazon.com/datasync/latest/userguide/do-i-need-datasync-agent.html)
    pub fn createAgent(self: *Self, allocator: std.mem.Allocator, input: create_agent.CreateAgentInput, options: CallOptions) !create_agent.CreateAgentOutput {
        return create_agent.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for a Microsoft Azure Blob Storage
    /// container. DataSync can use this location as a transfer source or
    /// destination.
    /// You can make transfers with or without a [DataSync
    /// agent](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#azure-blob-creating-agent) that connects to your
    /// container.
    ///
    /// Before you begin, make sure you know [how DataSync accesses Azure Blob
    /// Storage](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#azure-blob-access) and works with [access tiers](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#azure-blob-access-tiers) and [blob types](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html#blob-types).
    pub fn createLocationAzureBlob(self: *Self, allocator: std.mem.Allocator, input: create_location_azure_blob.CreateLocationAzureBlobInput, options: CallOptions) !create_location_azure_blob.CreateLocationAzureBlobOutput {
        return create_location_azure_blob.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon EFS file system.
    /// DataSync can use this location as a source or destination for transferring
    /// data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses
    /// Amazon EFS file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html#create-efs-location-access).
    pub fn createLocationEfs(self: *Self, allocator: std.mem.Allocator, input: create_location_efs.CreateLocationEfsInput, options: CallOptions) !create_location_efs.CreateLocationEfsOutput {
        return create_location_efs.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon FSx for Lustre file
    /// system. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses FSx for Lustre file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-lustre-location.html#create-lustre-location-access).
    pub fn createLocationFsxLustre(self: *Self, allocator: std.mem.Allocator, input: create_location_fsx_lustre.CreateLocationFsxLustreInput, options: CallOptions) !create_location_fsx_lustre.CreateLocationFsxLustreOutput {
        return create_location_fsx_lustre.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon FSx for NetApp ONTAP file
    /// system. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses FSx for ONTAP file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html#create-ontap-location-access).
    pub fn createLocationFsxOntap(self: *Self, allocator: std.mem.Allocator, input: create_location_fsx_ontap.CreateLocationFsxOntapInput, options: CallOptions) !create_location_fsx_ontap.CreateLocationFsxOntapOutput {
        return create_location_fsx_ontap.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon FSx for OpenZFS file
    /// system. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses
    /// FSx for OpenZFS file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-openzfs-location.html#create-openzfs-access).
    ///
    /// Request parameters related to `SMB` aren't supported with the
    /// `CreateLocationFsxOpenZfs` operation.
    pub fn createLocationFsxOpenZfs(self: *Self, allocator: std.mem.Allocator, input: create_location_fsx_open_zfs.CreateLocationFsxOpenZfsInput, options: CallOptions) !create_location_fsx_open_zfs.CreateLocationFsxOpenZfsOutput {
        return create_location_fsx_open_zfs.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon FSx for Windows File Server file
    /// system. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses
    /// FSx for Windows File Server file
    /// systems](https://docs.aws.amazon.com/datasync/latest/userguide/create-fsx-location.html#create-fsx-location-access).
    pub fn createLocationFsxWindows(self: *Self, allocator: std.mem.Allocator, input: create_location_fsx_windows.CreateLocationFsxWindowsInput, options: CallOptions) !create_location_fsx_windows.CreateLocationFsxWindowsOutput {
        return create_location_fsx_windows.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for a Hadoop Distributed File System
    /// (HDFS). DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses HDFS
    /// clusters](https://docs.aws.amazon.com/datasync/latest/userguide/create-hdfs-location.html#accessing-hdfs).
    pub fn createLocationHdfs(self: *Self, allocator: std.mem.Allocator, input: create_location_hdfs.CreateLocationHdfsInput, options: CallOptions) !create_location_hdfs.CreateLocationHdfsOutput {
        return create_location_hdfs.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for a Network File System (NFS) file
    /// server. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync
    /// [accesses NFS file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html#accessing-nfs).
    pub fn createLocationNfs(self: *Self, allocator: std.mem.Allocator, input: create_location_nfs.CreateLocationNfsInput, options: CallOptions) !create_location_nfs.CreateLocationNfsOutput {
        return create_location_nfs.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an object storage system. DataSync can use
    /// this location as a source or destination for transferring data. You
    /// can make transfers with or without a [DataSync
    /// agent](https://docs.aws.amazon.com/datasync/latest/userguide/do-i-need-datasync-agent.html#when-agent-required).
    ///
    /// Before you begin, make sure that you understand the
    /// [prerequisites](https://docs.aws.amazon.com/datasync/latest/userguide/create-object-location.html#create-object-location-prerequisites) for DataSync to work with object storage systems.
    pub fn createLocationObjectStorage(self: *Self, allocator: std.mem.Allocator, input: create_location_object_storage.CreateLocationObjectStorageInput, options: CallOptions) !create_location_object_storage.CreateLocationObjectStorageOutput {
        return create_location_object_storage.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for an Amazon S3 bucket.
    /// DataSync can use this location as a source or destination for transferring
    /// data.
    ///
    /// Before you begin, make sure that you read the following topics:
    ///
    /// * [Storage
    /// class considerations with Amazon S3
    /// locations](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes)
    ///
    /// * [Evaluating S3 request costs when using
    ///   DataSync](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#create-s3-location-s3-requests)
    ///
    /// For more information, see [Configuring
    /// transfers with Amazon
    /// S3](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html).
    pub fn createLocationS3(self: *Self, allocator: std.mem.Allocator, input: create_location_s3.CreateLocationS3Input, options: CallOptions) !create_location_s3.CreateLocationS3Output {
        return create_location_s3.execute(self, allocator, input, options);
    }

    /// Creates a transfer *location* for a Server Message Block (SMB) file
    /// server. DataSync can use this location as a source or destination for
    /// transferring data.
    ///
    /// Before you begin, make sure that you understand how DataSync accesses SMB
    /// file servers. For more information, see [Providing DataSync access to SMB
    /// file
    /// servers](https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html#configuring-smb-permissions).
    pub fn createLocationSmb(self: *Self, allocator: std.mem.Allocator, input: create_location_smb.CreateLocationSmbInput, options: CallOptions) !create_location_smb.CreateLocationSmbOutput {
        return create_location_smb.execute(self, allocator, input, options);
    }

    /// Configures a *task*, which defines where and how DataSync
    /// transfers your data.
    ///
    /// A task includes a source location, destination location, and transfer
    /// options (such as
    /// bandwidth limits, scheduling, and more).
    ///
    /// If you're planning to transfer data to or from an Amazon S3 location, review
    /// [how
    /// DataSync can affect your S3 request
    /// charges](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#create-s3-location-s3-requests) and the [DataSync pricing page](http://aws.amazon.com/datasync/pricing/) before
    /// you begin.
    pub fn createTask(self: *Self, allocator: std.mem.Allocator, input: create_task.CreateTaskInput, options: CallOptions) !create_task.CreateTaskOutput {
        return create_task.execute(self, allocator, input, options);
    }

    /// Removes an DataSync agent resource from your Amazon Web Services account.
    ///
    /// Keep in mind that this operation (which can't be undone) doesn't remove the
    /// agent's
    /// virtual machine (VM) or Amazon EC2 instance from your storage environment.
    /// For next
    /// steps, you can delete the VM or instance from your storage environment or
    /// reuse it to [activate a new
    /// agent](https://docs.aws.amazon.com/datasync/latest/userguide/activate-agent.html).
    pub fn deleteAgent(self: *Self, allocator: std.mem.Allocator, input: delete_agent.DeleteAgentInput, options: CallOptions) !delete_agent.DeleteAgentOutput {
        return delete_agent.execute(self, allocator, input, options);
    }

    /// Deletes a transfer location resource from DataSync.
    pub fn deleteLocation(self: *Self, allocator: std.mem.Allocator, input: delete_location.DeleteLocationInput, options: CallOptions) !delete_location.DeleteLocationOutput {
        return delete_location.execute(self, allocator, input, options);
    }

    /// Deletes a transfer task resource from DataSync.
    pub fn deleteTask(self: *Self, allocator: std.mem.Allocator, input: delete_task.DeleteTaskInput, options: CallOptions) !delete_task.DeleteTaskOutput {
        return delete_task.execute(self, allocator, input, options);
    }

    /// Returns information about an DataSync agent, such as its name, service
    /// endpoint type, and status.
    pub fn describeAgent(self: *Self, allocator: std.mem.Allocator, input: describe_agent.DescribeAgentInput, options: CallOptions) !describe_agent.DescribeAgentOutput {
        return describe_agent.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for Microsoft Azure
    /// Blob Storage is configured.
    pub fn describeLocationAzureBlob(self: *Self, allocator: std.mem.Allocator, input: describe_location_azure_blob.DescribeLocationAzureBlobInput, options: CallOptions) !describe_location_azure_blob.DescribeLocationAzureBlobOutput {
        return describe_location_azure_blob.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an Amazon EFS
    /// file system is configured.
    pub fn describeLocationEfs(self: *Self, allocator: std.mem.Allocator, input: describe_location_efs.DescribeLocationEfsInput, options: CallOptions) !describe_location_efs.DescribeLocationEfsOutput {
        return describe_location_efs.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an Amazon FSx
    /// for Lustre file system is configured.
    pub fn describeLocationFsxLustre(self: *Self, allocator: std.mem.Allocator, input: describe_location_fsx_lustre.DescribeLocationFsxLustreInput, options: CallOptions) !describe_location_fsx_lustre.DescribeLocationFsxLustreOutput {
        return describe_location_fsx_lustre.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an Amazon FSx
    /// for NetApp ONTAP file system is configured.
    ///
    /// If your location uses SMB, the `DescribeLocationFsxOntap` operation doesn't
    /// actually return a `Password`.
    pub fn describeLocationFsxOntap(self: *Self, allocator: std.mem.Allocator, input: describe_location_fsx_ontap.DescribeLocationFsxOntapInput, options: CallOptions) !describe_location_fsx_ontap.DescribeLocationFsxOntapOutput {
        return describe_location_fsx_ontap.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an Amazon FSx
    /// for OpenZFS file system is configured.
    ///
    /// Response elements related to `SMB` aren't supported with the
    /// `DescribeLocationFsxOpenZfs` operation.
    pub fn describeLocationFsxOpenZfs(self: *Self, allocator: std.mem.Allocator, input: describe_location_fsx_open_zfs.DescribeLocationFsxOpenZfsInput, options: CallOptions) !describe_location_fsx_open_zfs.DescribeLocationFsxOpenZfsOutput {
        return describe_location_fsx_open_zfs.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an Amazon FSx
    /// for Windows File Server file system is configured.
    pub fn describeLocationFsxWindows(self: *Self, allocator: std.mem.Allocator, input: describe_location_fsx_windows.DescribeLocationFsxWindowsInput, options: CallOptions) !describe_location_fsx_windows.DescribeLocationFsxWindowsOutput {
        return describe_location_fsx_windows.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for a Hadoop
    /// Distributed File System (HDFS) is configured.
    pub fn describeLocationHdfs(self: *Self, allocator: std.mem.Allocator, input: describe_location_hdfs.DescribeLocationHdfsInput, options: CallOptions) !describe_location_hdfs.DescribeLocationHdfsOutput {
        return describe_location_hdfs.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for a Network
    /// File System (NFS) file server is configured.
    pub fn describeLocationNfs(self: *Self, allocator: std.mem.Allocator, input: describe_location_nfs.DescribeLocationNfsInput, options: CallOptions) !describe_location_nfs.DescribeLocationNfsOutput {
        return describe_location_nfs.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an object
    /// storage system is configured.
    pub fn describeLocationObjectStorage(self: *Self, allocator: std.mem.Allocator, input: describe_location_object_storage.DescribeLocationObjectStorageInput, options: CallOptions) !describe_location_object_storage.DescribeLocationObjectStorageOutput {
        return describe_location_object_storage.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for an S3 bucket
    /// is configured.
    pub fn describeLocationS3(self: *Self, allocator: std.mem.Allocator, input: describe_location_s3.DescribeLocationS3Input, options: CallOptions) !describe_location_s3.DescribeLocationS3Output {
        return describe_location_s3.execute(self, allocator, input, options);
    }

    /// Provides details about how an DataSync transfer location for a Server
    /// Message Block (SMB) file server is configured.
    pub fn describeLocationSmb(self: *Self, allocator: std.mem.Allocator, input: describe_location_smb.DescribeLocationSmbInput, options: CallOptions) !describe_location_smb.DescribeLocationSmbOutput {
        return describe_location_smb.execute(self, allocator, input, options);
    }

    /// Provides information about a *task*, which defines where and how
    /// DataSync transfers your data.
    pub fn describeTask(self: *Self, allocator: std.mem.Allocator, input: describe_task.DescribeTaskInput, options: CallOptions) !describe_task.DescribeTaskOutput {
        return describe_task.execute(self, allocator, input, options);
    }

    /// Provides information about an execution of your DataSync task. You can
    /// use this operation to help monitor the progress of an ongoing data transfer
    /// or check the
    /// results of the transfer.
    ///
    /// Some `DescribeTaskExecution` response elements are only relevant to a
    /// specific task mode. For information, see [Understanding task mode
    /// differences](https://docs.aws.amazon.com/datasync/latest/userguide/choosing-task-mode.html#task-mode-differences) and [Understanding data
    /// transfer performance
    /// counters](https://docs.aws.amazon.com/datasync/latest/userguide/transfer-performance-counters.html).
    pub fn describeTaskExecution(self: *Self, allocator: std.mem.Allocator, input: describe_task_execution.DescribeTaskExecutionInput, options: CallOptions) !describe_task_execution.DescribeTaskExecutionOutput {
        return describe_task_execution.execute(self, allocator, input, options);
    }

    /// Returns a list of DataSync agents that belong to an Amazon Web Services
    /// account in the Amazon Web Services Region specified in the request.
    ///
    /// With pagination, you can reduce the number of agents returned in a response.
    /// If you get
    /// a truncated list of agents in a response, the response contains a marker
    /// that you can specify
    /// in your next request to fetch the next page of agents.
    ///
    /// `ListAgents` is eventually consistent. This means the result of running the
    /// operation might not reflect that you just created or deleted an agent. For
    /// example, if you
    /// create an agent with
    /// [CreateAgent](https://docs.aws.amazon.com/datasync/latest/userguide/API_CreateAgent.html) and then
    /// immediately run `ListAgents`, that agent might not show up in the list right
    /// away.
    /// In situations like this, you can always confirm whether an agent has been
    /// created (or deleted)
    /// by using
    /// [DescribeAgent](https://docs.aws.amazon.com/datasync/latest/userguide/API_DescribeAgent.html).
    pub fn listAgents(self: *Self, allocator: std.mem.Allocator, input: list_agents.ListAgentsInput, options: CallOptions) !list_agents.ListAgentsOutput {
        return list_agents.execute(self, allocator, input, options);
    }

    /// Returns a list of source and destination locations.
    ///
    /// If you have more locations than are returned in a response (that is, the
    /// response
    /// returns only a truncated list of your agents), the response contains a token
    /// that you can
    /// specify in your next request to fetch the next page of locations.
    pub fn listLocations(self: *Self, allocator: std.mem.Allocator, input: list_locations.ListLocationsInput, options: CallOptions) !list_locations.ListLocationsOutput {
        return list_locations.execute(self, allocator, input, options);
    }

    /// Returns all the tags associated with an Amazon Web Services resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of executions for an DataSync transfer task.
    pub fn listTaskExecutions(self: *Self, allocator: std.mem.Allocator, input: list_task_executions.ListTaskExecutionsInput, options: CallOptions) !list_task_executions.ListTaskExecutionsOutput {
        return list_task_executions.execute(self, allocator, input, options);
    }

    /// Returns a list of the DataSync tasks you created.
    pub fn listTasks(self: *Self, allocator: std.mem.Allocator, input: list_tasks.ListTasksInput, options: CallOptions) !list_tasks.ListTasksOutput {
        return list_tasks.execute(self, allocator, input, options);
    }

    /// Starts an DataSync transfer task. For each task, you can only run one task
    /// execution at a time.
    ///
    /// There are several steps to a task execution. For more information, see [Task
    /// execution
    /// statuses](https://docs.aws.amazon.com/datasync/latest/userguide/working-with-task-executions.html#understand-task-execution-statuses).
    ///
    /// If you're planning to transfer data to or from an Amazon S3 location, review
    /// [how
    /// DataSync can affect your S3 request
    /// charges](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#create-s3-location-s3-requests) and the [DataSync pricing page](http://aws.amazon.com/datasync/pricing/) before
    /// you begin.
    pub fn startTaskExecution(self: *Self, allocator: std.mem.Allocator, input: start_task_execution.StartTaskExecutionInput, options: CallOptions) !start_task_execution.StartTaskExecutionOutput {
        return start_task_execution.execute(self, allocator, input, options);
    }

    /// Applies a *tag* to an Amazon Web Services resource. Tags are
    /// key-value pairs that can help you manage, filter, and search for your
    /// resources.
    ///
    /// These include DataSync resources, such as locations, tasks, and task
    /// executions.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from an Amazon Web Services resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the name of an DataSync agent.
    pub fn updateAgent(self: *Self, allocator: std.mem.Allocator, input: update_agent.UpdateAgentInput, options: CallOptions) !update_agent.UpdateAgentOutput {
        return update_agent.execute(self, allocator, input, options);
    }

    /// Modifies the following configurations of the Microsoft Azure Blob Storage
    /// transfer
    /// location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync transfers with Azure Blob
    /// Storage](https://docs.aws.amazon.com/datasync/latest/userguide/creating-azure-blob-location.html).
    pub fn updateLocationAzureBlob(self: *Self, allocator: std.mem.Allocator, input: update_location_azure_blob.UpdateLocationAzureBlobInput, options: CallOptions) !update_location_azure_blob.UpdateLocationAzureBlobOutput {
        return update_location_azure_blob.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon EFS transfer
    /// location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with Amazon
    /// EFS](https://docs.aws.amazon.com/datasync/latest/userguide/create-efs-location.html).
    pub fn updateLocationEfs(self: *Self, allocator: std.mem.Allocator, input: update_location_efs.UpdateLocationEfsInput, options: CallOptions) !update_location_efs.UpdateLocationEfsOutput {
        return update_location_efs.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon FSx for Lustre
    /// transfer location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with FSx for
    /// Lustre](https://docs.aws.amazon.com/datasync/latest/userguide/create-lustre-location.html).
    pub fn updateLocationFsxLustre(self: *Self, allocator: std.mem.Allocator, input: update_location_fsx_lustre.UpdateLocationFsxLustreInput, options: CallOptions) !update_location_fsx_lustre.UpdateLocationFsxLustreOutput {
        return update_location_fsx_lustre.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon FSx for NetApp
    /// ONTAP
    /// transfer location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with FSx for
    /// ONTAP](https://docs.aws.amazon.com/datasync/latest/userguide/create-ontap-location.html).
    pub fn updateLocationFsxOntap(self: *Self, allocator: std.mem.Allocator, input: update_location_fsx_ontap.UpdateLocationFsxOntapInput, options: CallOptions) !update_location_fsx_ontap.UpdateLocationFsxOntapOutput {
        return update_location_fsx_ontap.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon FSx for
    /// OpenZFS
    /// transfer location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with FSx for
    /// OpenZFS](https://docs.aws.amazon.com/datasync/latest/userguide/create-openzfs-location.html).
    ///
    /// Request parameters related to `SMB` aren't supported with the
    /// `UpdateLocationFsxOpenZfs` operation.
    pub fn updateLocationFsxOpenZfs(self: *Self, allocator: std.mem.Allocator, input: update_location_fsx_open_zfs.UpdateLocationFsxOpenZfsInput, options: CallOptions) !update_location_fsx_open_zfs.UpdateLocationFsxOpenZfsOutput {
        return update_location_fsx_open_zfs.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon FSx for
    /// Windows File Server
    /// transfer location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with FSx for Windows File
    /// Server](https://docs.aws.amazon.com/datasync/latest/userguide/create-fsx-location.html).
    pub fn updateLocationFsxWindows(self: *Self, allocator: std.mem.Allocator, input: update_location_fsx_windows.UpdateLocationFsxWindowsInput, options: CallOptions) !update_location_fsx_windows.UpdateLocationFsxWindowsOutput {
        return update_location_fsx_windows.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Hadoop Distributed
    /// File System
    /// (HDFS) transfer location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with an HDFS
    /// cluster](https://docs.aws.amazon.com/datasync/latest/userguide/create-hdfs-location.html).
    pub fn updateLocationHdfs(self: *Self, allocator: std.mem.Allocator, input: update_location_hdfs.UpdateLocationHdfsInput, options: CallOptions) !update_location_hdfs.UpdateLocationHdfsOutput {
        return update_location_hdfs.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Network File System
    /// (NFS) transfer
    /// location that you're using with DataSync.
    ///
    /// For more information, see [Configuring transfers with an NFS
    /// file
    /// server](https://docs.aws.amazon.com/datasync/latest/userguide/create-nfs-location.html).
    pub fn updateLocationNfs(self: *Self, allocator: std.mem.Allocator, input: update_location_nfs.UpdateLocationNfsInput, options: CallOptions) !update_location_nfs.UpdateLocationNfsOutput {
        return update_location_nfs.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the object storage
    /// transfer location
    /// that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with an object storage
    /// system](https://docs.aws.amazon.com/datasync/latest/userguide/create-object-location.html).
    pub fn updateLocationObjectStorage(self: *Self, allocator: std.mem.Allocator, input: update_location_object_storage.UpdateLocationObjectStorageInput, options: CallOptions) !update_location_object_storage.UpdateLocationObjectStorageOutput {
        return update_location_object_storage.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Amazon S3 transfer
    /// location
    /// that you're using with DataSync.
    ///
    /// Before you begin, make sure that you read the following topics:
    ///
    /// * [Storage
    /// class considerations with Amazon S3
    /// locations](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#using-storage-classes)
    ///
    /// * [Evaluating S3 request costs when using
    ///   DataSync](https://docs.aws.amazon.com/datasync/latest/userguide/create-s3-location.html#create-s3-location-s3-requests)
    pub fn updateLocationS3(self: *Self, allocator: std.mem.Allocator, input: update_location_s3.UpdateLocationS3Input, options: CallOptions) !update_location_s3.UpdateLocationS3Output {
        return update_location_s3.execute(self, allocator, input, options);
    }

    /// Modifies the following configuration parameters of the Server Message Block
    /// (SMB) transfer
    /// location that you're using with DataSync.
    ///
    /// For more information, see [Configuring DataSync
    /// transfers with an SMB file
    /// server](https://docs.aws.amazon.com/datasync/latest/userguide/create-smb-location.html).
    pub fn updateLocationSmb(self: *Self, allocator: std.mem.Allocator, input: update_location_smb.UpdateLocationSmbInput, options: CallOptions) !update_location_smb.UpdateLocationSmbOutput {
        return update_location_smb.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a *task*, which defines where and how
    /// DataSync transfers your data.
    pub fn updateTask(self: *Self, allocator: std.mem.Allocator, input: update_task.UpdateTaskInput, options: CallOptions) !update_task.UpdateTaskOutput {
        return update_task.execute(self, allocator, input, options);
    }

    /// Updates the configuration of a running DataSync task execution.
    ///
    /// Currently, the only `Option` that you can modify with
    /// `UpdateTaskExecution` is `
    /// [BytesPerSecond](https://docs.aws.amazon.com/datasync/latest/userguide/API_Options.html#DataSync-Type-Options-BytesPerSecond)
    /// `, which throttles bandwidth for a running or queued task
    /// execution.
    pub fn updateTaskExecution(self: *Self, allocator: std.mem.Allocator, input: update_task_execution.UpdateTaskExecutionInput, options: CallOptions) !update_task_execution.UpdateTaskExecutionOutput {
        return update_task_execution.execute(self, allocator, input, options);
    }

    pub fn listAgentsPaginator(self: *Self, params: list_agents.ListAgentsInput) paginator.ListAgentsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listLocationsPaginator(self: *Self, params: list_locations.ListLocationsInput) paginator.ListLocationsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTaskExecutionsPaginator(self: *Self, params: list_task_executions.ListTaskExecutionsInput) paginator.ListTaskExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTasksPaginator(self: *Self, params: list_tasks.ListTasksInput) paginator.ListTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
