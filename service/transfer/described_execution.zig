const FileLocation = @import("file_location.zig").FileLocation;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const PosixProfile = @import("posix_profile.zig").PosixProfile;
const ExecutionResults = @import("execution_results.zig").ExecutionResults;
const ServiceMetadata = @import("service_metadata.zig").ServiceMetadata;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;

/// The details for an execution object.
pub const DescribedExecution = struct {
    /// A unique identifier for the execution of a workflow.
    execution_id: ?[]const u8,

    /// The IAM role associated with the execution.
    execution_role: ?[]const u8,

    /// A structure that describes the Amazon S3 or EFS file location. This is the
    /// file location when the execution begins: if the file is being copied, this
    /// is the initial (as opposed to destination) file location.
    initial_file_location: ?FileLocation,

    /// The IAM logging role associated with the execution.
    logging_configuration: ?LoggingConfiguration,

    posix_profile: ?PosixProfile,

    /// A structure that describes the execution results. This includes a list of
    /// the steps along with the details of each step, error type and message (if
    /// any), and the `OnExceptionSteps` structure.
    results: ?ExecutionResults,

    /// A container object for the session details that are associated with a
    /// workflow.
    service_metadata: ?ServiceMetadata,

    /// The status is one of the execution. Can be in progress, completed, exception
    /// encountered, or handling the exception.
    status: ?ExecutionStatus,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .execution_role = "ExecutionRole",
        .initial_file_location = "InitialFileLocation",
        .logging_configuration = "LoggingConfiguration",
        .posix_profile = "PosixProfile",
        .results = "Results",
        .service_metadata = "ServiceMetadata",
        .status = "Status",
    };
};
