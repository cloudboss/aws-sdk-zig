const FileLocation = @import("file_location.zig").FileLocation;
const ServiceMetadata = @import("service_metadata.zig").ServiceMetadata;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// Returns properties of the execution that is specified.
pub const ListedExecution = struct {
    /// A unique identifier for the execution of a workflow.
    execution_id: ?[]const u8 = null,

    /// A structure that describes the Amazon S3 or EFS file location. This is the
    /// file location when the execution begins: if the file is being copied, this
    /// is the initial (as opposed to destination) file location.
    initial_file_location: ?FileLocation = null,

    /// A container object for the session details that are associated with a
    /// workflow.
    service_metadata: ?ServiceMetadata = null,

    /// The status is one of the execution. Can be in progress, completed, exception
    /// encountered, or handling the exception.
    status: ?ExecutionStatus = null,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .initial_file_location = "InitialFileLocation",
        .service_metadata = "ServiceMetadata",
        .status = "Status",
    };
};
