const aws = @import("aws");

const EndpointManagement = @import("endpoint_management.zig").EndpointManagement;
const LastUpdate = @import("last_update.zig").LastUpdate;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const EnvironmentStatus = @import("environment_status.zig").EnvironmentStatus;
const WebserverAccessMode = @import("webserver_access_mode.zig").WebserverAccessMode;

/// Describes an Amazon Managed Workflows for Apache Airflow (MWAA) environment.
pub const Environment = struct {
    /// A list of key-value pairs containing the Apache Airflow configuration
    /// options attached to your environment. For more information, see [Apache
    /// Airflow configuration
    /// options](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-env-variables.html).
    airflow_configuration_options: ?[]const aws.map.StringMapEntry = null,

    /// The Apache Airflow version on your environment.
    ///
    /// Valid values: `1.10.12`, `2.0.2`, `2.2.2`,
    /// `2.4.3`, `2.5.1`, `2.6.3`, `2.7.2`,
    /// `2.8.1`, `2.9.2`, `2.10.1`, and `2.10.3`.
    airflow_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon MWAA environment.
    arn: ?[]const u8 = null,

    /// The queue ARN for the environment's [Celery
    /// Executor](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/celery.html). Amazon MWAA uses a Celery Executor
    /// to distribute tasks across multiple workers. When you create an environment
    /// in a shared VPC, you must provide access to the Celery Executor queue from
    /// your VPC.
    celery_executor_queue: ?[]const u8 = null,

    /// The day and time the environment was created.
    created_at: ?i64 = null,

    /// The relative path to the DAGs folder in your Amazon S3 bucket. For example,
    /// `s3://mwaa-environment/dags`. For more information, see [Adding or updating
    /// DAGs](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-folder.html).
    dag_s3_path: ?[]const u8 = null,

    /// The VPC endpoint for the environment's Amazon RDS database.
    database_vpc_endpoint_service: ?[]const u8 = null,

    /// Defines whether the VPC endpoints configured for the environment are
    /// created, and managed, by the customer or by Amazon MWAA. If set to
    /// `SERVICE`, Amazon MWAA will create and manage the required VPC endpoints in
    /// your VPC. If set to `CUSTOMER`, you must create, and manage, the VPC
    /// endpoints in your VPC.
    endpoint_management: ?EndpointManagement = null,

    /// The environment class type. Valid values: `mw1.micro`, `mw1.small`,
    /// `mw1.medium`, `mw1.large`, `mw1.xlarge`, and `mw1.2xlarge`. For more
    /// information, see [Amazon MWAA environment
    /// class](https://docs.aws.amazon.com/mwaa/latest/userguide/environment-class.html).
    environment_class: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the execution role in IAM that allows MWAA
    /// to access Amazon Web Services resources in your environment. For example,
    /// `arn:aws:iam::123456789:role/my-execution-role`. For more information, see
    /// [Amazon MWAA Execution
    /// role](https://docs.aws.amazon.com/mwaa/latest/userguide/mwaa-create-role.html).
    execution_role_arn: ?[]const u8 = null,

    /// The KMS encryption key used to encrypt the data in your environment.
    kms_key: ?[]const u8 = null,

    /// The status of the last update on the environment.
    last_update: ?LastUpdate = null,

    /// The Apache Airflow logs published to CloudWatch Logs.
    logging_configuration: ?LoggingConfiguration = null,

    /// The maximum number of web servers that you want to run in your environment.
    /// Amazon MWAA scales the number of Apache Airflow web servers up to the number
    /// you specify for `MaxWebservers`
    /// when you interact with your Apache Airflow environment using Apache Airflow
    /// REST API, or
    /// the Apache Airflow CLI. For example, in scenarios where your workload
    /// requires network calls to the Apache Airflow REST API with a high
    /// transaction-per-second (TPS)
    /// rate, Amazon MWAA will increase the number of web servers up to the number
    /// set in `MaxWebserers`. As TPS rates decrease
    /// Amazon MWAA disposes of the additional web servers, and scales down to the
    /// number set in `MinxWebserers`.
    ///
    /// Valid values: For environments larger than mw1.micro, accepts values from
    /// `2` to `5`. Defaults to `2` for all environment
    /// sizes except mw1.micro, which defaults to `1`.
    max_webservers: ?i32 = null,

    /// The maximum number of workers that run in your environment. For example,
    /// `20`.
    max_workers: ?i32 = null,

    /// The minimum number of web servers that you want to run in your environment.
    /// Amazon MWAA scales the number of Apache Airflow web servers up to the number
    /// you specify for `MaxWebservers`
    /// when you interact with your Apache Airflow environment using Apache Airflow
    /// REST API, or
    /// the Apache Airflow CLI. As the transaction-per-second rate, and the network
    /// load, decrease,
    /// Amazon MWAA disposes of the additional web servers, and scales down to the
    /// number set in `MinxWebserers`.
    ///
    /// Valid values: For environments larger than mw1.micro, accepts values from
    /// `2` to `5`. Defaults to `2` for all environment
    /// sizes except mw1.micro, which defaults to `1`.
    min_webservers: ?i32 = null,

    /// The minimum number of workers that run in your environment. For example,
    /// `2`.
    min_workers: ?i32 = null,

    /// The name of the Amazon MWAA environment. For example, `MyMWAAEnvironment`.
    name: ?[]const u8 = null,

    /// Describes the VPC networking components used to secure and enable network
    /// traffic between the Amazon Web Services resources for your environment. For
    /// more information, see [About networking on Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/networking-about.html).
    network_configuration: ?NetworkConfiguration = null,

    /// The version of the `plugins.zip` file in your Amazon S3 bucket. You must
    /// specify the [version
    /// ID](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html) that Amazon S3 assigns to the file.
    ///
    /// Version IDs are Unicode, UTF-8 encoded, URL-ready, opaque strings that are
    /// no more than 1,024 bytes long. The following is an example:
    ///
    /// `3sL4kqtJlcpXroDTDmJ+rmSpXd3dIbrHY+MTRCxf3vjVBH40Nr8X8gdRQBpUMLUo`
    ///
    /// For more information, see [Installing custom
    /// plugins](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import-plugins.html).
    plugins_s3_object_version: ?[]const u8 = null,

    /// The relative path to the file in your Amazon S3 bucket. For example,
    /// `s3://mwaa-environment/plugins.zip`. For more information, see [Installing
    /// custom
    /// plugins](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-dag-import-plugins.html).
    plugins_s3_path: ?[]const u8 = null,

    /// The version of the `requirements.txt ` file on your Amazon S3 bucket. You
    /// must specify the [version
    /// ID](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html) that Amazon S3 assigns to the file.
    ///
    /// Version IDs are Unicode, UTF-8 encoded, URL-ready, opaque strings that are
    /// no more than 1,024 bytes long. The following is an example:
    ///
    /// `3sL4kqtJlcpXroDTDmJ+rmSpXd3dIbrHY+MTRCxf3vjVBH40Nr8X8gdRQBpUMLUo`
    ///
    /// For more information, see [Installing Python
    /// dependencies](https://docs.aws.amazon.com/mwaa/latest/userguide/working-dags-dependencies.html).
    requirements_s3_object_version: ?[]const u8 = null,

    /// The relative path to the `requirements.txt` file in your Amazon S3 bucket.
    /// For example, `s3://mwaa-environment/requirements.txt`. For more information,
    /// see
    /// [Installing Python
    /// dependencies](https://docs.aws.amazon.com/mwaa/latest/userguide/working-dags-dependencies.html).
    requirements_s3_path: ?[]const u8 = null,

    /// The number of Apache Airflow schedulers that run in your Amazon MWAA
    /// environment.
    schedulers: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the service-linked role of the
    /// environment. For more information, see [Amazon MWAA Service-linked
    /// role](https://docs.aws.amazon.com/mwaa/latest/userguide/mwaa-slr.html).
    service_role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Amazon S3 bucket where your DAG code
    /// and supporting files are stored. For example,
    /// `arn:aws:s3:::my-airflow-bucket-unique-name`. For more information, see
    /// [Create an Amazon S3 bucket for Amazon
    /// MWAA](https://docs.aws.amazon.com/mwaa/latest/userguide/mwaa-s3-bucket.html).
    source_bucket_arn: ?[]const u8 = null,

    /// The version of the startup shell script in your Amazon S3 bucket. You must
    /// specify the [version
    /// ID](https://docs.aws.amazon.com/AmazonS3/latest/userguide/versioning-workflows.html) that Amazon S3 assigns to the file.
    ///
    /// Version IDs are Unicode, UTF-8 encoded, URL-ready, opaque strings that are
    /// no more than 1,024 bytes long. The following is an example:
    ///
    /// `3sL4kqtJlcpXroDTDmJ+rmSpXd3dIbrHY+MTRCxf3vjVBH40Nr8X8gdRQBpUMLUo`
    ///
    /// For more information, see [Using a startup
    /// script](https://docs.aws.amazon.com/mwaa/latest/userguide/using-startup-script.html).
    startup_script_s3_object_version: ?[]const u8 = null,

    /// The relative path to the startup shell script in your Amazon S3 bucket. For
    /// example, `s3://mwaa-environment/startup.sh`.
    ///
    /// Amazon MWAA runs the script as your environment starts, and before running
    /// the Apache Airflow process.
    /// You can use this script to install dependencies, modify Apache Airflow
    /// configuration options, and set environment variables. For more information,
    /// see
    /// [Using a startup
    /// script](https://docs.aws.amazon.com/mwaa/latest/userguide/using-startup-script.html).
    startup_script_s3_path: ?[]const u8 = null,

    /// The status of the Amazon MWAA environment.
    ///
    /// Valid values:
    ///
    /// * `CREATING` - Indicates the request to create the environment is in
    ///   progress.
    ///
    /// * `CREATING_SNAPSHOT` - Indicates the request to update environment details,
    ///   or upgrade the environment version, is in progress and Amazon MWAA is
    ///   creating a storage volume snapshot of the Amazon RDS
    /// database cluster associated with the environment. A database snapshot is a
    /// backup created at a specific point in time. Amazon MWAA uses snapshots to
    /// recover environment metadata if the process to update or upgrade
    /// an environment fails.
    ///
    /// * `CREATE_FAILED` - Indicates the request to create the environment failed,
    ///   and the environment could not be created.
    ///
    /// * `AVAILABLE` - Indicates the request was successful and the environment is
    ///   ready to use.
    ///
    /// * `PENDING` - Indicates the request was successful, but the process to
    ///   create the environment is paused until you create the required
    /// VPC endpoints in your VPC. After you create the VPC endpoints, the process
    /// resumes.
    ///
    /// * `UPDATING` - Indicates the request to update the environment is in
    ///   progress.
    ///
    /// * `ROLLING_BACK` - Indicates the request to update environment details, or
    ///   upgrade the environment version, failed and Amazon MWAA is restoring the
    ///   environment using the latest storage volume snapshot.
    ///
    /// * `DELETING` - Indicates the request to delete the environment is in
    ///   progress.
    ///
    /// * `DELETED` - Indicates the request to delete the environment is complete,
    ///   and the environment has been deleted.
    ///
    /// * `UNAVAILABLE` - Indicates the request failed, but the environment did not
    ///   return to its previous state and is not stable.
    ///
    /// * `UPDATE_FAILED` - Indicates the request to update the environment failed,
    ///   and the environment was restored to its previous state successfully and is
    ///   ready to use.
    ///
    /// * `MAINTENANCE` - Indicates that the environment is undergoing maintenance.
    ///   Depending on the type of work Amazon MWAA is performing,
    /// your environment might become unavailable during this process. After all
    /// operations are done, your environment will return to its status prior to
    /// mainteneace operations.
    ///
    /// We recommend reviewing our troubleshooting guide for a list of common errors
    /// and their solutions. For more information, see [Amazon MWAA
    /// troubleshooting](https://docs.aws.amazon.com/mwaa/latest/userguide/troubleshooting.html).
    status: ?EnvironmentStatus = null,

    /// The key-value tag pairs associated to your environment. For example,
    /// `"Environment": "Staging"`. For more information, see [Tagging Amazon Web
    /// Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Apache Airflow *web server* access mode. For more information, see
    /// [Apache Airflow access
    /// modes](https://docs.aws.amazon.com/mwaa/latest/userguide/configuring-networking.html).
    webserver_access_mode: ?WebserverAccessMode = null,

    /// The Apache Airflow *web server* host name for the Amazon MWAA environment.
    /// For more information, see [Accessing the Apache Airflow
    /// UI](https://docs.aws.amazon.com/mwaa/latest/userguide/access-airflow-ui.html).
    webserver_url: ?[]const u8 = null,

    /// The VPC endpoint for the environment's web server.
    webserver_vpc_endpoint_service: ?[]const u8 = null,

    /// The day and time of the week in Coordinated Universal Time (UTC) 24-hour
    /// standard time that weekly maintenance updates are scheduled. For example:
    /// `TUE:03:30`.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .airflow_configuration_options = "AirflowConfigurationOptions",
        .airflow_version = "AirflowVersion",
        .arn = "Arn",
        .celery_executor_queue = "CeleryExecutorQueue",
        .created_at = "CreatedAt",
        .dag_s3_path = "DagS3Path",
        .database_vpc_endpoint_service = "DatabaseVpcEndpointService",
        .endpoint_management = "EndpointManagement",
        .environment_class = "EnvironmentClass",
        .execution_role_arn = "ExecutionRoleArn",
        .kms_key = "KmsKey",
        .last_update = "LastUpdate",
        .logging_configuration = "LoggingConfiguration",
        .max_webservers = "MaxWebservers",
        .max_workers = "MaxWorkers",
        .min_webservers = "MinWebservers",
        .min_workers = "MinWorkers",
        .name = "Name",
        .network_configuration = "NetworkConfiguration",
        .plugins_s3_object_version = "PluginsS3ObjectVersion",
        .plugins_s3_path = "PluginsS3Path",
        .requirements_s3_object_version = "RequirementsS3ObjectVersion",
        .requirements_s3_path = "RequirementsS3Path",
        .schedulers = "Schedulers",
        .service_role_arn = "ServiceRoleArn",
        .source_bucket_arn = "SourceBucketArn",
        .startup_script_s3_object_version = "StartupScriptS3ObjectVersion",
        .startup_script_s3_path = "StartupScriptS3Path",
        .status = "Status",
        .tags = "Tags",
        .webserver_access_mode = "WebserverAccessMode",
        .webserver_url = "WebserverUrl",
        .webserver_vpc_endpoint_service = "WebserverVpcEndpointService",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};
