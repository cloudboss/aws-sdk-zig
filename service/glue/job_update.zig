const aws = @import("aws");

const CodeGenConfigurationNode = @import("code_gen_configuration_node.zig").CodeGenConfigurationNode;
const JobCommand = @import("job_command.zig").JobCommand;
const ConnectionsList = @import("connections_list.zig").ConnectionsList;
const ExecutionClass = @import("execution_class.zig").ExecutionClass;
const ExecutionProperty = @import("execution_property.zig").ExecutionProperty;
const JobMode = @import("job_mode.zig").JobMode;
const NotificationProperty = @import("notification_property.zig").NotificationProperty;
const SourceControlDetails = @import("source_control_details.zig").SourceControlDetails;
const WorkerType = @import("worker_type.zig").WorkerType;

/// Specifies information used to update an existing job definition. The
/// previous job
/// definition is completely overwritten by this information.
pub const JobUpdate = struct {
    /// This field is deprecated. Use `MaxCapacity` instead.
    ///
    /// The number of Glue data processing units (DPUs) to allocate to this job. You
    /// can
    /// allocate a minimum of 2 DPUs; the default is 10. A DPU is a relative measure
    /// of processing
    /// power that consists of 4 vCPUs of compute capacity and 16 GB of memory. For
    /// more information,
    /// see the [Glue pricing
    /// page](https://aws.amazon.com/glue/pricing/).
    allocated_capacity: i32 = 0,

    /// The representation of a directed acyclic graph on which both the Glue Studio
    /// visual component and Glue Studio code generation is based.
    code_gen_configuration_nodes: ?[]const aws.map.MapEntry(CodeGenConfigurationNode),

    /// The `JobCommand` that runs this job (required).
    command: ?JobCommand,

    /// The connections used for this job.
    connections: ?ConnectionsList,

    /// The default arguments for every run of this job, specified as name-value
    /// pairs.
    ///
    /// You can specify arguments here that your own job-execution script
    /// consumes, as well as arguments that Glue itself consumes.
    ///
    /// Job arguments may be logged. Do not pass plaintext secrets as arguments.
    /// Retrieve secrets
    /// from a Glue Connection, Secrets Manager or other secret management
    /// mechanism if you intend to keep them within the Job.
    ///
    /// For information about how to specify and consume your own Job arguments, see
    /// the [Calling Glue APIs in
    /// Python](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python-calling.html) topic in the developer guide.
    ///
    /// For information about the arguments you can provide to this field when
    /// configuring Spark jobs,
    /// see the [Special Parameters Used by
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html) topic in the developer guide.
    ///
    /// For information about the arguments you can provide to this field when
    /// configuring Ray
    /// jobs, see [Using
    /// job parameters in Ray
    /// jobs](https://docs.aws.amazon.com/glue/latest/dg/author-job-ray-job-parameters.html) in the developer guide.
    default_arguments: ?[]const aws.map.StringMapEntry,

    /// Description of the job being defined.
    description: ?[]const u8,

    /// Indicates whether the job is run with a standard or flexible execution
    /// class. The standard execution-class is ideal for time-sensitive workloads
    /// that require fast job startup and dedicated resources.
    ///
    /// The flexible execution class is appropriate for time-insensitive jobs whose
    /// start and completion times may vary.
    ///
    /// Only jobs with Glue version 3.0 and above and command type `glueetl` will be
    /// allowed to set `ExecutionClass` to `FLEX`. The flexible execution class is
    /// available for Spark jobs.
    execution_class: ?ExecutionClass,

    /// An `ExecutionProperty` specifying the maximum number of concurrent runs
    /// allowed
    /// for this job.
    execution_property: ?ExecutionProperty,

    /// In Spark jobs, `GlueVersion` determines the versions of Apache Spark and
    /// Python
    /// that Glue available in a job. The Python version indicates the version
    /// supported for jobs of type Spark.
    ///
    /// Ray jobs should set `GlueVersion` to `4.0` or greater. However,
    /// the versions of Ray, Python and additional libraries available in your Ray
    /// job are determined
    /// by the `Runtime` parameter of the Job command.
    ///
    /// For more information about the available Glue versions and corresponding
    /// Spark and Python versions, see [Glue
    /// version](https://docs.aws.amazon.com/glue/latest/dg/add-job.html) in the
    /// developer
    /// guide.
    ///
    /// Jobs that are created without specifying a Glue version default to Glue 0.9.
    glue_version: ?[]const u8,

    /// A mode that describes how a job was created. Valid values are:
    ///
    /// * `SCRIPT` - The job was created using the Glue Studio script editor.
    ///
    /// * `VISUAL` - The job was created using the Glue Studio visual editor.
    ///
    /// * `NOTEBOOK` - The job was created using an interactive sessions notebook.
    ///
    /// When the `JobMode` field is missing or null, `SCRIPT` is assigned as the
    /// default value.
    job_mode: ?JobMode,

    /// Specifies whether job run queuing is enabled for the job runs for this job.
    ///
    /// A value of true means job run queuing is enabled for the job runs. If false
    /// or not populated, the job runs will not be considered for queueing.
    ///
    /// If this field does not match the value set in the job run, then the value
    /// from the job run field will be used.
    job_run_queuing_enabled: ?bool,

    /// This field is reserved for future use.
    log_uri: ?[]const u8,

    /// This field specifies a day of the week and hour for a maintenance window for
    /// streaming jobs. Glue periodically performs maintenance activities. During
    /// these maintenance windows, Glue will need to restart your streaming jobs.
    ///
    /// Glue will restart the job within 3 hours of the specified maintenance
    /// window. For instance, if you set up the maintenance window for Monday at
    /// 10:00AM GMT, your jobs will be restarted between 10:00AM GMT to 1:00PM GMT.
    maintenance_window: ?[]const u8,

    /// For Glue version 1.0 or earlier jobs, using the standard worker type, the
    /// number of
    /// Glue data processing units (DPUs) that can be allocated when this job runs.
    /// A DPU is
    /// a relative measure of processing power that consists of 4 vCPUs of compute
    /// capacity and 16 GB
    /// of memory. For more information, see the [
    /// Glue pricing page](https://aws.amazon.com/glue/pricing/).
    ///
    /// For Glue version 2.0+ jobs, you cannot specify a `Maximum capacity`.
    /// Instead, you should specify a `Worker type` and the `Number of workers`.
    ///
    /// Do not set `MaxCapacity` if using `WorkerType` and `NumberOfWorkers`.
    ///
    /// The value that can be allocated for `MaxCapacity` depends on whether you are
    /// running a Python shell job, an Apache Spark ETL job, or an Apache Spark
    /// streaming ETL
    /// job:
    ///
    /// * When you specify a Python shell job (`JobCommand.Name`="pythonshell"), you
    ///   can
    /// allocate either 0.0625 or 1 DPU. The default is 0.0625 DPU.
    ///
    /// * When you specify an Apache Spark ETL job (`JobCommand.Name`="glueetl") or
    ///   Apache
    /// Spark streaming ETL job (`JobCommand.Name`="gluestreaming"), you can
    /// allocate from 2 to 100 DPUs.
    /// The default is 10 DPUs. This job type cannot have a fractional DPU
    /// allocation.
    max_capacity: ?f64,

    /// The maximum number of times to retry this job if it fails.
    max_retries: i32 = 0,

    /// Arguments for this job that are not overridden when providing job arguments
    /// in a job run, specified as name-value pairs.
    non_overridable_arguments: ?[]const aws.map.StringMapEntry,

    /// Specifies the configuration properties of a job notification.
    notification_property: ?NotificationProperty,

    /// The number of workers of a defined `workerType` that are allocated when a
    /// job runs.
    number_of_workers: ?i32,

    /// The name or Amazon Resource Name (ARN) of the IAM role associated with this
    /// job
    /// (required).
    role: ?[]const u8,

    /// The name of the `SecurityConfiguration` structure to be used with this
    /// job.
    security_configuration: ?[]const u8,

    /// The details for a source control configuration for a job, allowing
    /// synchronization of job artifacts to or from a remote repository.
    source_control_details: ?SourceControlDetails,

    /// The job timeout in minutes. This is the maximum time that a job run
    /// can consume resources before it is terminated and enters `TIMEOUT`
    /// status.
    ///
    /// Jobs must have timeout values less than 7 days or 10080 minutes. Otherwise,
    /// the jobs will throw an exception.
    ///
    /// When the value is left blank, the timeout is defaulted to 2880 minutes.
    ///
    /// Any existing Glue jobs that had a timeout value greater than 7 days will be
    /// defaulted to 7 days. For instance if you have specified a timeout of 20 days
    /// for a batch job, it will be stopped on the 7th day.
    ///
    /// For streaming jobs, if you have set up a maintenance window, it will be
    /// restarted during the maintenance window after 7 days.
    timeout: ?i32,

    /// The type of predefined worker that is allocated when a job runs. Accepts a
    /// value of
    /// G.1X, G.2X, G.4X, G.8X or G.025X for Spark jobs. Accepts the value Z.2X for
    /// Ray jobs. For more information, see
    /// [Defining job properties for Spark jobs
    /// ](https://docs.aws.amazon.com/glue/latest/dg/add-job.html#create-job)
    worker_type: ?WorkerType,

    pub const json_field_names = .{
        .allocated_capacity = "AllocatedCapacity",
        .code_gen_configuration_nodes = "CodeGenConfigurationNodes",
        .command = "Command",
        .connections = "Connections",
        .default_arguments = "DefaultArguments",
        .description = "Description",
        .execution_class = "ExecutionClass",
        .execution_property = "ExecutionProperty",
        .glue_version = "GlueVersion",
        .job_mode = "JobMode",
        .job_run_queuing_enabled = "JobRunQueuingEnabled",
        .log_uri = "LogUri",
        .maintenance_window = "MaintenanceWindow",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .non_overridable_arguments = "NonOverridableArguments",
        .notification_property = "NotificationProperty",
        .number_of_workers = "NumberOfWorkers",
        .role = "Role",
        .security_configuration = "SecurityConfiguration",
        .source_control_details = "SourceControlDetails",
        .timeout = "Timeout",
        .worker_type = "WorkerType",
    };
};
