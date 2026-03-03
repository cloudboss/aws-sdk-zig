const aws = @import("aws");
const std = @import("std");

const add_application_cloud_watch_logging_option = @import("add_application_cloud_watch_logging_option.zig");
const add_application_input = @import("add_application_input.zig");
const add_application_input_processing_configuration = @import("add_application_input_processing_configuration.zig");
const add_application_output = @import("add_application_output.zig");
const add_application_reference_data_source = @import("add_application_reference_data_source.zig");
const add_application_vpc_configuration = @import("add_application_vpc_configuration.zig");
const create_application = @import("create_application.zig");
const create_application_presigned_url = @import("create_application_presigned_url.zig");
const create_application_snapshot = @import("create_application_snapshot.zig");
const delete_application = @import("delete_application.zig");
const delete_application_cloud_watch_logging_option = @import("delete_application_cloud_watch_logging_option.zig");
const delete_application_input_processing_configuration = @import("delete_application_input_processing_configuration.zig");
const delete_application_output = @import("delete_application_output.zig");
const delete_application_reference_data_source = @import("delete_application_reference_data_source.zig");
const delete_application_snapshot = @import("delete_application_snapshot.zig");
const delete_application_vpc_configuration = @import("delete_application_vpc_configuration.zig");
const describe_application = @import("describe_application.zig");
const describe_application_operation = @import("describe_application_operation.zig");
const describe_application_snapshot = @import("describe_application_snapshot.zig");
const describe_application_version = @import("describe_application_version.zig");
const discover_input_schema = @import("discover_input_schema.zig");
const list_application_operations = @import("list_application_operations.zig");
const list_application_snapshots = @import("list_application_snapshots.zig");
const list_application_versions = @import("list_application_versions.zig");
const list_applications = @import("list_applications.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const rollback_application = @import("rollback_application.zig");
const start_application = @import("start_application.zig");
const stop_application = @import("stop_application.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_application = @import("update_application.zig");
const update_application_maintenance_configuration = @import("update_application_maintenance_configuration.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kinesis Analytics V2";

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

    /// Adds an Amazon CloudWatch log stream to monitor application configuration
    /// errors.
    pub fn addApplicationCloudWatchLoggingOption(self: *Self, allocator: std.mem.Allocator, input: add_application_cloud_watch_logging_option.AddApplicationCloudWatchLoggingOptionInput, options: CallOptions) !add_application_cloud_watch_logging_option.AddApplicationCloudWatchLoggingOptionOutput {
        return add_application_cloud_watch_logging_option.execute(self, allocator, input, options);
    }

    /// Adds a streaming source to your SQL-based Kinesis Data Analytics
    /// application.
    ///
    /// You can add a streaming source when you create an application, or you can
    /// use this
    /// operation to add a streaming source after you create an application. For
    /// more information, see
    /// CreateApplication.
    ///
    /// Any configuration update, including adding a streaming source using this
    /// operation,
    /// results in a new version of the application. You can use the
    /// DescribeApplication operation
    /// to find the current application version.
    pub fn addApplicationInput(self: *Self, allocator: std.mem.Allocator, input: add_application_input.AddApplicationInputInput, options: CallOptions) !add_application_input.AddApplicationInputOutput {
        return add_application_input.execute(self, allocator, input, options);
    }

    /// Adds an InputProcessingConfiguration to a SQL-based Kinesis Data Analytics
    /// application. An input processor pre-processes records
    /// on the input stream before the
    /// application's SQL code executes. Currently, the only input processor
    /// available is [Amazon Lambda](https://docs.aws.amazon.com/lambda/).
    pub fn addApplicationInputProcessingConfiguration(self: *Self, allocator: std.mem.Allocator, input: add_application_input_processing_configuration.AddApplicationInputProcessingConfigurationInput, options: CallOptions) !add_application_input_processing_configuration.AddApplicationInputProcessingConfigurationOutput {
        return add_application_input_processing_configuration.execute(self, allocator, input, options);
    }

    /// Adds an external destination to your SQL-based Kinesis Data Analytics
    /// application.
    ///
    /// If you want Kinesis Data Analytics to deliver data from an in-application
    /// stream within
    /// your application to an external destination (such as an Kinesis data stream,
    /// a Kinesis Data
    /// Firehose delivery stream, or an Amazon Lambda function), you add the
    /// relevant configuration to
    /// your application using this operation. You can configure one or more outputs
    /// for your
    /// application. Each output configuration maps an in-application stream and an
    /// external
    /// destination.
    ///
    /// You can use one of the output configurations to deliver data from your
    /// in-application error stream to an external destination so that you can
    /// analyze the
    /// errors.
    ///
    /// Any configuration update, including adding a streaming source using this
    /// operation, results in a new version of the application. You can use the
    /// DescribeApplication operation to find the current application
    /// version.
    pub fn addApplicationOutput(self: *Self, allocator: std.mem.Allocator, input: add_application_output.AddApplicationOutputInput, options: CallOptions) !add_application_output.AddApplicationOutputOutput {
        return add_application_output.execute(self, allocator, input, options);
    }

    /// Adds a reference data source to an existing SQL-based Kinesis Data Analytics
    /// application.
    ///
    /// Kinesis Data Analytics reads reference data (that is, an Amazon S3 object)
    /// and creates an
    /// in-application table within your application. In the request, you provide
    /// the source (S3
    /// bucket name and object key name), name of the in-application table to
    /// create, and the
    /// necessary mapping information that describes how data in an Amazon S3 object
    /// maps to columns
    /// in the resulting in-application table.
    pub fn addApplicationReferenceDataSource(self: *Self, allocator: std.mem.Allocator, input: add_application_reference_data_source.AddApplicationReferenceDataSourceInput, options: CallOptions) !add_application_reference_data_source.AddApplicationReferenceDataSourceOutput {
        return add_application_reference_data_source.execute(self, allocator, input, options);
    }

    /// Adds a Virtual Private Cloud (VPC) configuration to the application.
    /// Applications can use VPCs to store
    /// and access resources securely.
    ///
    /// Note the following about VPC configurations for Managed Service for Apache
    /// Flink applications:
    ///
    /// * VPC configurations are not supported for SQL applications.
    ///
    /// * When a VPC is added to a Managed Service for Apache Flink application, the
    ///   application can no longer be accessed from the
    /// Internet directly. To enable Internet access to the application, add an
    /// Internet gateway to your VPC.
    pub fn addApplicationVpcConfiguration(self: *Self, allocator: std.mem.Allocator, input: add_application_vpc_configuration.AddApplicationVpcConfigurationInput, options: CallOptions) !add_application_vpc_configuration.AddApplicationVpcConfigurationOutput {
        return add_application_vpc_configuration.execute(self, allocator, input, options);
    }

    /// Creates a Managed Service for Apache Flink application. For information
    /// about creating a
    /// Managed Service for Apache Flink application, see [Creating an
    /// Application](https://docs.aws.amazon.com/kinesisanalytics/latest/java/getting-started.html).
    pub fn createApplication(self: *Self, allocator: std.mem.Allocator, input: create_application.CreateApplicationInput, options: CallOptions) !create_application.CreateApplicationOutput {
        return create_application.execute(self, allocator, input, options);
    }

    /// Creates and returns a URL that you can use to connect to
    /// an application's extension.
    ///
    /// The IAM role or user used to call this API defines the permissions to access
    /// the
    /// extension. After the presigned URL is created, no additional permission is
    /// required to access
    /// this URL. IAM authorization policies for this API are also enforced for
    /// every HTTP request
    /// that attempts to connect to the extension.
    ///
    /// You control the amount of time that the URL will be valid using the
    /// `SessionExpirationDurationInSeconds`
    /// parameter. If you do not provide this parameter, the returned URL is valid
    /// for twelve hours.
    ///
    /// The URL that you get from a call to CreateApplicationPresignedUrl must be
    /// used within 3 minutes
    /// to be valid.
    /// If you first try to use the URL after the 3-minute limit expires, the
    /// service returns an HTTP 403 Forbidden error.
    pub fn createApplicationPresignedUrl(self: *Self, allocator: std.mem.Allocator, input: create_application_presigned_url.CreateApplicationPresignedUrlInput, options: CallOptions) !create_application_presigned_url.CreateApplicationPresignedUrlOutput {
        return create_application_presigned_url.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of the application's state data.
    pub fn createApplicationSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_application_snapshot.CreateApplicationSnapshotInput, options: CallOptions) !create_application_snapshot.CreateApplicationSnapshotOutput {
        return create_application_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes the specified application. Managed Service for Apache Flink halts
    /// application execution and deletes the application.
    pub fn deleteApplication(self: *Self, allocator: std.mem.Allocator, input: delete_application.DeleteApplicationInput, options: CallOptions) !delete_application.DeleteApplicationOutput {
        return delete_application.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon CloudWatch log stream from an SQL-based Kinesis Data
    /// Analytics application.
    pub fn deleteApplicationCloudWatchLoggingOption(self: *Self, allocator: std.mem.Allocator, input: delete_application_cloud_watch_logging_option.DeleteApplicationCloudWatchLoggingOptionInput, options: CallOptions) !delete_application_cloud_watch_logging_option.DeleteApplicationCloudWatchLoggingOptionOutput {
        return delete_application_cloud_watch_logging_option.execute(self, allocator, input, options);
    }

    /// Deletes an InputProcessingConfiguration from an input.
    pub fn deleteApplicationInputProcessingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_application_input_processing_configuration.DeleteApplicationInputProcessingConfigurationInput, options: CallOptions) !delete_application_input_processing_configuration.DeleteApplicationInputProcessingConfigurationOutput {
        return delete_application_input_processing_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the output destination configuration from your SQL-based Kinesis
    /// Data Analytics application's configuration.
    /// Kinesis Data Analytics will no longer write data from
    /// the corresponding in-application stream to the external output destination.
    pub fn deleteApplicationOutput(self: *Self, allocator: std.mem.Allocator, input: delete_application_output.DeleteApplicationOutputInput, options: CallOptions) !delete_application_output.DeleteApplicationOutputOutput {
        return delete_application_output.execute(self, allocator, input, options);
    }

    /// Deletes a reference data source configuration from the specified SQL-based
    /// Kinesis Data Analytics application's configuration.
    ///
    /// If the application is running, Kinesis Data Analytics immediately removes
    /// the in-application table
    /// that you created using the AddApplicationReferenceDataSource operation.
    pub fn deleteApplicationReferenceDataSource(self: *Self, allocator: std.mem.Allocator, input: delete_application_reference_data_source.DeleteApplicationReferenceDataSourceInput, options: CallOptions) !delete_application_reference_data_source.DeleteApplicationReferenceDataSourceOutput {
        return delete_application_reference_data_source.execute(self, allocator, input, options);
    }

    /// Deletes a snapshot of application state.
    pub fn deleteApplicationSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_application_snapshot.DeleteApplicationSnapshotInput, options: CallOptions) !delete_application_snapshot.DeleteApplicationSnapshotOutput {
        return delete_application_snapshot.execute(self, allocator, input, options);
    }

    /// Removes a VPC configuration from a Managed Service for Apache Flink
    /// application.
    pub fn deleteApplicationVpcConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_application_vpc_configuration.DeleteApplicationVpcConfigurationInput, options: CallOptions) !delete_application_vpc_configuration.DeleteApplicationVpcConfigurationOutput {
        return delete_application_vpc_configuration.execute(self, allocator, input, options);
    }

    /// Returns information about a specific Managed Service for Apache Flink
    /// application.
    ///
    /// If you want to retrieve a list of all applications in your account,
    /// use the ListApplications operation.
    pub fn describeApplication(self: *Self, allocator: std.mem.Allocator, input: describe_application.DescribeApplicationInput, options: CallOptions) !describe_application.DescribeApplicationOutput {
        return describe_application.execute(self, allocator, input, options);
    }

    /// Provides a detailed description of a specified application operation. To see
    /// a list of all the operations of an application, invoke the
    /// ListApplicationOperations operation.
    ///
    /// This operation is supported only for Managed Service for Apache Flink.
    pub fn describeApplicationOperation(self: *Self, allocator: std.mem.Allocator, input: describe_application_operation.DescribeApplicationOperationInput, options: CallOptions) !describe_application_operation.DescribeApplicationOperationOutput {
        return describe_application_operation.execute(self, allocator, input, options);
    }

    /// Returns information about a snapshot of application state data.
    pub fn describeApplicationSnapshot(self: *Self, allocator: std.mem.Allocator, input: describe_application_snapshot.DescribeApplicationSnapshotInput, options: CallOptions) !describe_application_snapshot.DescribeApplicationSnapshotOutput {
        return describe_application_snapshot.execute(self, allocator, input, options);
    }

    /// Provides a detailed description of a specified version of the application.
    /// To see a list of all the versions of an application, invoke the
    /// ListApplicationVersions operation.
    ///
    /// This operation is supported only for Managed Service for Apache Flink.
    pub fn describeApplicationVersion(self: *Self, allocator: std.mem.Allocator, input: describe_application_version.DescribeApplicationVersionInput, options: CallOptions) !describe_application_version.DescribeApplicationVersionOutput {
        return describe_application_version.execute(self, allocator, input, options);
    }

    /// Infers a schema for a SQL-based Kinesis Data Analytics application by
    /// evaluating
    /// sample records on the specified streaming source (Kinesis data stream or
    /// Kinesis Data Firehose
    /// delivery stream) or Amazon S3 object. In the response, the operation returns
    /// the inferred
    /// schema and also the sample records that the operation used to infer the
    /// schema.
    ///
    /// You can use the inferred schema when configuring a streaming source for your
    /// application.
    /// When you create an application using the Kinesis Data Analytics console, the
    /// console uses this
    /// operation to infer a schema and show it in the console user interface.
    pub fn discoverInputSchema(self: *Self, allocator: std.mem.Allocator, input: discover_input_schema.DiscoverInputSchemaInput, options: CallOptions) !discover_input_schema.DiscoverInputSchemaOutput {
        return discover_input_schema.execute(self, allocator, input, options);
    }

    /// Lists all the operations performed for the specified application such as
    /// UpdateApplication, StartApplication etc.
    /// The response also includes a summary of the operation.
    ///
    /// To get the complete description of a specific operation, invoke the
    /// DescribeApplicationOperation operation.
    ///
    /// This operation is supported only for Managed Service for Apache Flink.
    pub fn listApplicationOperations(self: *Self, allocator: std.mem.Allocator, input: list_application_operations.ListApplicationOperationsInput, options: CallOptions) !list_application_operations.ListApplicationOperationsOutput {
        return list_application_operations.execute(self, allocator, input, options);
    }

    /// Lists information about the current application snapshots.
    pub fn listApplicationSnapshots(self: *Self, allocator: std.mem.Allocator, input: list_application_snapshots.ListApplicationSnapshotsInput, options: CallOptions) !list_application_snapshots.ListApplicationSnapshotsOutput {
        return list_application_snapshots.execute(self, allocator, input, options);
    }

    /// Lists all the versions for the specified application, including versions
    /// that were rolled back. The response also includes a summary of the
    /// configuration
    /// associated with each version.
    ///
    /// To get the complete description of a specific application version, invoke
    /// the DescribeApplicationVersion operation.
    ///
    /// This operation is supported only for Managed Service for Apache Flink.
    pub fn listApplicationVersions(self: *Self, allocator: std.mem.Allocator, input: list_application_versions.ListApplicationVersionsInput, options: CallOptions) !list_application_versions.ListApplicationVersionsOutput {
        return list_application_versions.execute(self, allocator, input, options);
    }

    /// Returns a list of Managed Service for Apache Flink applications in your
    /// account. For each
    /// application, the response includes the application name, Amazon Resource
    /// Name (ARN), and
    /// status.
    ///
    /// If you want detailed information about a specific application, use
    /// DescribeApplication.
    pub fn listApplications(self: *Self, allocator: std.mem.Allocator, input: list_applications.ListApplicationsInput, options: CallOptions) !list_applications.ListApplicationsOutput {
        return list_applications.execute(self, allocator, input, options);
    }

    /// Retrieves the list of key-value tags assigned to the application. For more
    /// information, see
    /// [Using
    /// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/java/how-tagging.html).
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Reverts the application to the previous running version. You can roll back
    /// an
    /// application if you suspect it is stuck in a transient status or in the
    /// running status.
    ///
    /// You can roll back an application only if it is in the `UPDATING`,
    /// `AUTOSCALING`, or `RUNNING` statuses.
    ///
    /// When you rollback an application, it loads state data from the last
    /// successful snapshot.
    /// If the application has no snapshots, Managed Service for Apache Flink
    /// rejects the rollback request.
    pub fn rollbackApplication(self: *Self, allocator: std.mem.Allocator, input: rollback_application.RollbackApplicationInput, options: CallOptions) !rollback_application.RollbackApplicationOutput {
        return rollback_application.execute(self, allocator, input, options);
    }

    /// Starts the specified Managed Service for Apache Flink application. After
    /// creating an application, you must exclusively call this operation to
    /// start your application.
    pub fn startApplication(self: *Self, allocator: std.mem.Allocator, input: start_application.StartApplicationInput, options: CallOptions) !start_application.StartApplicationOutput {
        return start_application.execute(self, allocator, input, options);
    }

    /// Stops the application from processing data. You can stop
    /// an application only if it is in the running status, unless you set the
    /// `Force`
    /// parameter to `true`.
    ///
    /// You can use the DescribeApplication operation to find the application
    /// status.
    ///
    /// Managed Service for Apache Flink takes a snapshot when the application is
    /// stopped, unless `Force` is set
    /// to `true`.
    pub fn stopApplication(self: *Self, allocator: std.mem.Allocator, input: stop_application.StopApplicationInput, options: CallOptions) !stop_application.StopApplicationOutput {
        return stop_application.execute(self, allocator, input, options);
    }

    /// Adds one or more key-value tags to a Managed Service for Apache Flink
    /// application. Note that the maximum number of application
    /// tags includes system tags. The maximum number of user-defined application
    /// tags is 50.
    /// For more information, see [Using
    /// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/java/how-tagging.html).
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a Managed Service for Apache Flink
    /// application. For more information, see
    /// [Using
    /// Tagging](https://docs.aws.amazon.com/kinesisanalytics/latest/java/how-tagging.html).
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing Managed Service for Apache Flink application. Using this
    /// operation, you
    /// can update application code, input configuration, and output configuration.
    ///
    /// Managed Service for Apache Flink updates the `ApplicationVersionId` each
    /// time you update
    /// your application.
    pub fn updateApplication(self: *Self, allocator: std.mem.Allocator, input: update_application.UpdateApplicationInput, options: CallOptions) !update_application.UpdateApplicationOutput {
        return update_application.execute(self, allocator, input, options);
    }

    /// Updates the maintenance configuration of the Managed Service for Apache
    /// Flink application.
    ///
    /// You can invoke this operation on an application that is in one of the two
    /// following
    /// states: `READY` or `RUNNING`. If you invoke it when the application is
    /// in a state other than these two states, it throws a
    /// `ResourceInUseException`. The
    /// service makes use of the updated configuration the next time it schedules
    /// maintenance for the
    /// application. If you invoke this operation after the service schedules
    /// maintenance, the service
    /// will apply the configuration update the next time it schedules maintenance
    /// for the
    /// application. This means that you might not see the maintenance configuration
    /// update applied to
    /// the maintenance process that follows a successful invocation of this
    /// operation, but to the
    /// following maintenance process instead.
    ///
    /// To see the current maintenance configuration of your application, invoke the
    /// DescribeApplication operation.
    ///
    /// For information about application maintenance, see [Managed Service for
    /// Apache Flink for Apache Flink
    /// Maintenance](https://docs.aws.amazon.com/kinesisanalytics/latest/java/maintenance.html).
    ///
    /// This operation is supported only for Managed Service for Apache Flink.
    pub fn updateApplicationMaintenanceConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_application_maintenance_configuration.UpdateApplicationMaintenanceConfigurationInput, options: CallOptions) !update_application_maintenance_configuration.UpdateApplicationMaintenanceConfigurationOutput {
        return update_application_maintenance_configuration.execute(self, allocator, input, options);
    }

    pub fn listApplicationOperationsPaginator(self: *Self, params: list_application_operations.ListApplicationOperationsInput) paginator.ListApplicationOperationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationSnapshotsPaginator(self: *Self, params: list_application_snapshots.ListApplicationSnapshotsInput) paginator.ListApplicationSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationVersionsPaginator(self: *Self, params: list_application_versions.ListApplicationVersionsInput) paginator.ListApplicationVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listApplicationsPaginator(self: *Self, params: list_applications.ListApplicationsInput) paginator.ListApplicationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
