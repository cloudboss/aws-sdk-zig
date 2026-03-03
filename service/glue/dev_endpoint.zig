const aws = @import("aws");

const WorkerType = @import("worker_type.zig").WorkerType;

/// A development endpoint where a developer can remotely debug extract,
/// transform, and load
/// (ETL) scripts.
pub const DevEndpoint = struct {
    /// A map of arguments used to configure the `DevEndpoint`.
    ///
    /// Valid arguments are:
    ///
    /// * `"--enable-glue-datacatalog": ""`
    ///
    /// You can specify a version of Python support for development endpoints by
    /// using the `Arguments` parameter in the `CreateDevEndpoint` or
    /// `UpdateDevEndpoint` APIs. If no arguments are provided, the version defaults
    /// to Python 2.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Web Services Availability Zone where this `DevEndpoint` is
    /// located.
    availability_zone: ?[]const u8 = null,

    /// The point in time at which this DevEndpoint was created.
    created_timestamp: ?i64 = null,

    /// The name of the `DevEndpoint`.
    endpoint_name: ?[]const u8 = null,

    /// The path to one or more Java `.jar` files in an S3 bucket that should be
    /// loaded
    /// in your `DevEndpoint`.
    ///
    /// You can only use pure Java/Scala libraries with a `DevEndpoint`.
    extra_jars_s3_path: ?[]const u8 = null,

    /// The paths to one or more Python libraries in an Amazon S3 bucket that should
    /// be loaded in
    /// your `DevEndpoint`. Multiple values must be complete paths separated by a
    /// comma.
    ///
    /// You can only use pure Python libraries with a `DevEndpoint`. Libraries that
    /// rely on
    /// C extensions, such as the [pandas](http://pandas.pydata.org/) Python data
    /// analysis library, are not currently supported.
    extra_python_libs_s3_path: ?[]const u8 = null,

    /// The reason for a current failure in this `DevEndpoint`.
    failure_reason: ?[]const u8 = null,

    /// Glue version determines the versions of Apache Spark and Python that Glue
    /// supports. The Python version indicates the version supported for running
    /// your ETL scripts on development endpoints.
    ///
    /// For more information about the available Glue versions and corresponding
    /// Spark and Python versions, see [Glue
    /// version](https://docs.aws.amazon.com/glue/latest/dg/add-job.html) in the
    /// developer guide.
    ///
    /// Development endpoints that are created without specifying a Glue version
    /// default to Glue 0.9.
    ///
    /// You can specify a version of Python support for development endpoints by
    /// using the `Arguments` parameter in the `CreateDevEndpoint` or
    /// `UpdateDevEndpoint` APIs. If no arguments are provided, the version defaults
    /// to Python 2.
    glue_version: ?[]const u8 = null,

    /// The point in time at which this `DevEndpoint` was last modified.
    last_modified_timestamp: ?i64 = null,

    /// The status of the last update.
    last_update_status: ?[]const u8 = null,

    /// The number of Glue Data Processing Units (DPUs) allocated to this
    /// `DevEndpoint`.
    number_of_nodes: i32 = 0,

    /// The number of workers of a defined `workerType` that are allocated to the
    /// development endpoint.
    ///
    /// The maximum number of workers you can define are 299 for `G.1X`, and 149 for
    /// `G.2X`.
    number_of_workers: ?i32 = null,

    /// A private IP address to access the `DevEndpoint` within a VPC if the
    /// `DevEndpoint` is created within one. The `PrivateAddress` field is
    /// present only when you create the `DevEndpoint` within your VPC.
    private_address: ?[]const u8 = null,

    /// The public IP address used by this `DevEndpoint`. The
    /// `PublicAddress` field is present only when you create a non-virtual private
    /// cloud
    /// (VPC) `DevEndpoint`.
    public_address: ?[]const u8 = null,

    /// The public key to be used by this `DevEndpoint` for authentication. This
    /// attribute is provided for backward compatibility because the recommended
    /// attribute to use is
    /// public keys.
    public_key: ?[]const u8 = null,

    /// A list of public keys to be used by the `DevEndpoints` for authentication.
    /// Using this attribute is preferred over a single public key because the
    /// public keys allow you
    /// to have a different private key per client.
    ///
    /// If you previously created an endpoint with a public key, you must remove
    /// that key to be
    /// able to set a list of public keys. Call the `UpdateDevEndpoint` API
    /// operation
    /// with the public key content in the `deletePublicKeys` attribute, and the
    /// list of
    /// new keys in the `addPublicKeys` attribute.
    public_keys: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used in this
    /// `DevEndpoint`.
    role_arn: ?[]const u8 = null,

    /// The name of the `SecurityConfiguration` structure to be used with this
    /// `DevEndpoint`.
    security_configuration: ?[]const u8 = null,

    /// A list of security group identifiers used in this `DevEndpoint`.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of this `DevEndpoint`.
    status: ?[]const u8 = null,

    /// The subnet ID for this `DevEndpoint`.
    subnet_id: ?[]const u8 = null,

    /// The ID of the virtual private cloud (VPC) used by this `DevEndpoint`.
    vpc_id: ?[]const u8 = null,

    /// The type of predefined worker that is allocated to the development endpoint.
    /// Accepts a value of Standard, G.1X, or G.2X.
    ///
    /// * For the `Standard` worker type, each worker provides 4 vCPU, 16 GB of
    ///   memory and a 50GB disk, and 2 executors per worker.
    ///
    /// * For the `G.1X` worker type, each worker maps to 1 DPU (4 vCPU, 16 GB of
    ///   memory, 64 GB disk), and provides 1 executor per worker. We recommend this
    ///   worker type for memory-intensive jobs.
    ///
    /// * For the `G.2X` worker type, each worker maps to 2 DPU (8 vCPU, 32 GB of
    ///   memory, 128 GB disk), and provides 1 executor per worker. We recommend
    ///   this worker type for memory-intensive jobs.
    ///
    /// Known issue: when a development endpoint is created with the `G.2X`
    /// `WorkerType` configuration, the Spark drivers for the development endpoint
    /// will run on 4 vCPU, 16 GB of memory, and a 64 GB disk.
    worker_type: ?WorkerType = null,

    /// The YARN endpoint address used by this `DevEndpoint`.
    yarn_endpoint_address: ?[]const u8 = null,

    /// The Apache Zeppelin port for the remote Apache Spark interpreter.
    zeppelin_remote_spark_interpreter_port: i32 = 0,

    pub const json_field_names = .{
        .arguments = "Arguments",
        .availability_zone = "AvailabilityZone",
        .created_timestamp = "CreatedTimestamp",
        .endpoint_name = "EndpointName",
        .extra_jars_s3_path = "ExtraJarsS3Path",
        .extra_python_libs_s3_path = "ExtraPythonLibsS3Path",
        .failure_reason = "FailureReason",
        .glue_version = "GlueVersion",
        .last_modified_timestamp = "LastModifiedTimestamp",
        .last_update_status = "LastUpdateStatus",
        .number_of_nodes = "NumberOfNodes",
        .number_of_workers = "NumberOfWorkers",
        .private_address = "PrivateAddress",
        .public_address = "PublicAddress",
        .public_key = "PublicKey",
        .public_keys = "PublicKeys",
        .role_arn = "RoleArn",
        .security_configuration = "SecurityConfiguration",
        .security_group_ids = "SecurityGroupIds",
        .status = "Status",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
        .worker_type = "WorkerType",
        .yarn_endpoint_address = "YarnEndpointAddress",
        .zeppelin_remote_spark_interpreter_port = "ZeppelinRemoteSparkInterpreterPort",
    };
};
