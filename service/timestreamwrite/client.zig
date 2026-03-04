const aws = @import("aws");
const std = @import("std");

const create_batch_load_task = @import("create_batch_load_task.zig");
const create_database = @import("create_database.zig");
const create_table = @import("create_table.zig");
const delete_database = @import("delete_database.zig");
const delete_table = @import("delete_table.zig");
const describe_batch_load_task = @import("describe_batch_load_task.zig");
const describe_database = @import("describe_database.zig");
const describe_endpoints = @import("describe_endpoints.zig");
const describe_table = @import("describe_table.zig");
const list_batch_load_tasks = @import("list_batch_load_tasks.zig");
const list_databases = @import("list_databases.zig");
const list_tables = @import("list_tables.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const resume_batch_load_task = @import("resume_batch_load_task.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_database = @import("update_database.zig");
const update_table = @import("update_table.zig");
const write_records = @import("write_records.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Timestream Write";

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

    /// Creates a new Timestream batch load task. A batch load task processes data
    /// from
    /// a CSV source in an S3 location and writes to a Timestream table. A mapping
    /// from
    /// source to target is defined in a batch load task. Errors and events are
    /// written to a report
    /// at an S3 location. For the report, if the KMS key is not specified, the
    /// report will be encrypted with an S3 managed key when `SSE_S3` is the option.
    /// Otherwise an error is thrown. For more information, see [Amazon Web Services
    /// managed
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk). [Service quotas apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). For
    /// details, see [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.create-batch-load.html).
    pub fn createBatchLoadTask(self: *Self, allocator: std.mem.Allocator, input: create_batch_load_task.CreateBatchLoadTaskInput, options: CallOptions) !create_batch_load_task.CreateBatchLoadTaskOutput {
        return create_batch_load_task.execute(self, allocator, input, options);
    }

    /// Creates a new Timestream database. If the KMS key is not
    /// specified, the database will be encrypted with a Timestream managed KMS key
    /// located in your account. For more information, see [Amazon Web Services
    /// managed
    /// keys](https://docs.aws.amazon.com/kms/latest/developerguide/concepts.html#aws-managed-cmk). [Service quotas apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). For
    /// details, see [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.create-db.html).
    pub fn createDatabase(self: *Self, allocator: std.mem.Allocator, input: create_database.CreateDatabaseInput, options: CallOptions) !create_database.CreateDatabaseOutput {
        return create_database.execute(self, allocator, input, options);
    }

    /// Adds a new table to an existing database in your account. In an Amazon Web
    /// Services account, table names must be at least unique within each Region if
    /// they are in the same
    /// database. You might have identical table names in the same Region if the
    /// tables are in
    /// separate databases. While creating the table, you must specify the table
    /// name, database
    /// name, and the retention properties. [Service quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). See
    /// [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.create-table.html) for details.
    pub fn createTable(self: *Self, allocator: std.mem.Allocator, input: create_table.CreateTableInput, options: CallOptions) !create_table.CreateTableOutput {
        return create_table.execute(self, allocator, input, options);
    }

    /// Deletes a given Timestream database. *This is an irreversible
    /// operation. After a database is deleted, the time-series data from its tables
    /// cannot be
    /// recovered.*
    ///
    /// All tables in the database must be deleted first, or a ValidationException
    /// error will
    /// be thrown.
    ///
    /// Due to the nature of distributed retries, the operation can return either
    /// success or
    /// a ResourceNotFoundException. Clients should consider them equivalent.
    ///
    /// See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.delete-db.html)
    /// for details.
    pub fn deleteDatabase(self: *Self, allocator: std.mem.Allocator, input: delete_database.DeleteDatabaseInput, options: CallOptions) !delete_database.DeleteDatabaseOutput {
        return delete_database.execute(self, allocator, input, options);
    }

    /// Deletes a given Timestream table. This is an irreversible operation. After a
    /// Timestream database table is deleted, the time-series data stored in the
    /// table
    /// cannot be recovered.
    ///
    /// Due to the nature of distributed retries, the operation can return either
    /// success or
    /// a ResourceNotFoundException. Clients should consider them equivalent.
    ///
    /// See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.delete-table.html) for details.
    pub fn deleteTable(self: *Self, allocator: std.mem.Allocator, input: delete_table.DeleteTableInput, options: CallOptions) !delete_table.DeleteTableOutput {
        return delete_table.execute(self, allocator, input, options);
    }

    /// Returns information about the batch load task, including configurations,
    /// mappings,
    /// progress, and other details. [Service quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). See
    /// [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.describe-batch-load.html) for details.
    pub fn describeBatchLoadTask(self: *Self, allocator: std.mem.Allocator, input: describe_batch_load_task.DescribeBatchLoadTaskInput, options: CallOptions) !describe_batch_load_task.DescribeBatchLoadTaskOutput {
        return describe_batch_load_task.execute(self, allocator, input, options);
    }

    /// Returns information about the database, including the database name, time
    /// that the
    /// database was created, and the total number of tables found within the
    /// database. [Service
    /// quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). See [code sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.describe-db.html)
    /// for details.
    pub fn describeDatabase(self: *Self, allocator: std.mem.Allocator, input: describe_database.DescribeDatabaseInput, options: CallOptions) !describe_database.DescribeDatabaseOutput {
        return describe_database.execute(self, allocator, input, options);
    }

    /// Returns a list of available endpoints to make Timestream API calls against.
    /// This API operation is available through both the Write and Query APIs.
    ///
    /// Because the Timestream SDKs are designed to transparently work with the
    /// service’s architecture, including the management and mapping of the service
    /// endpoints,
    /// *we don't recommend that you use this API operation unless*:
    ///
    /// * You are using [VPC endpoints (Amazon Web Services PrivateLink) with
    ///   Timestream](https://docs.aws.amazon.com/timestream/latest/developerguide/VPCEndpoints)
    ///
    /// * Your application uses a programming language that does not yet have SDK
    /// support
    ///
    /// * You require better control over the client-side implementation
    ///
    /// For detailed information on how and when to use and implement
    /// DescribeEndpoints, see
    /// [The
    /// Endpoint Discovery
    /// Pattern](https://docs.aws.amazon.com/timestream/latest/developerguide/Using.API.html#Using-API.endpoint-discovery).
    pub fn describeEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_endpoints.DescribeEndpointsInput, options: CallOptions) !describe_endpoints.DescribeEndpointsOutput {
        return describe_endpoints.execute(self, allocator, input, options);
    }

    /// Returns information about the table, including the table name, database
    /// name, retention
    /// duration of the memory store and the magnetic store. [Service quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). See
    /// [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.describe-table.html) for details.
    pub fn describeTable(self: *Self, allocator: std.mem.Allocator, input: describe_table.DescribeTableInput, options: CallOptions) !describe_table.DescribeTableOutput {
        return describe_table.execute(self, allocator, input, options);
    }

    /// Provides a list of batch load tasks, along with the name, status, when the
    /// task is
    /// resumable until, and other details. See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.list-batch-load-tasks.html) for details.
    pub fn listBatchLoadTasks(self: *Self, allocator: std.mem.Allocator, input: list_batch_load_tasks.ListBatchLoadTasksInput, options: CallOptions) !list_batch_load_tasks.ListBatchLoadTasksOutput {
        return list_batch_load_tasks.execute(self, allocator, input, options);
    }

    /// Returns a list of your Timestream databases. [Service quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html). See
    /// [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.list-db.html) for
    /// details.
    pub fn listDatabases(self: *Self, allocator: std.mem.Allocator, input: list_databases.ListDatabasesInput, options: CallOptions) !list_databases.ListDatabasesOutput {
        return list_databases.execute(self, allocator, input, options);
    }

    /// Provides a list of tables, along with the name, status, and retention
    /// properties of each
    /// table. See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.list-table.html)
    /// for details.
    pub fn listTables(self: *Self, allocator: std.mem.Allocator, input: list_tables.ListTablesInput, options: CallOptions) !list_tables.ListTablesOutput {
        return list_tables.execute(self, allocator, input, options);
    }

    /// Lists all tags on a Timestream resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    pub fn resumeBatchLoadTask(self: *Self, allocator: std.mem.Allocator, input: resume_batch_load_task.ResumeBatchLoadTaskInput, options: CallOptions) !resume_batch_load_task.ResumeBatchLoadTaskOutput {
        return resume_batch_load_task.execute(self, allocator, input, options);
    }

    /// Associates a set of tags with a Timestream resource. You can then activate
    /// these user-defined tags so that they appear on the Billing and Cost
    /// Management console for
    /// cost allocation tracking.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of tags from a Timestream resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Modifies the KMS key for an existing database. While updating the
    /// database, you must specify the database name and the identifier of the new
    /// KMS key to be used (`KmsKeyId`). If there are any concurrent
    /// `UpdateDatabase` requests, first writer wins.
    ///
    /// See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.update-db.html)
    /// for details.
    pub fn updateDatabase(self: *Self, allocator: std.mem.Allocator, input: update_database.UpdateDatabaseInput, options: CallOptions) !update_database.UpdateDatabaseOutput {
        return update_database.execute(self, allocator, input, options);
    }

    /// Modifies the retention duration of the memory store and magnetic store for
    /// your Timestream table. Note that the change in retention duration takes
    /// effect immediately.
    /// For example, if the retention period of the memory store was initially set
    /// to 2 hours and
    /// then changed to 24 hours, the memory store will be capable of holding 24
    /// hours of data, but
    /// will be populated with 24 hours of data 22 hours after this change was made.
    /// Timestream does not retrieve data from the magnetic store to populate the
    /// memory store.
    ///
    /// See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.update-table.html) for details.
    pub fn updateTable(self: *Self, allocator: std.mem.Allocator, input: update_table.UpdateTableInput, options: CallOptions) !update_table.UpdateTableOutput {
        return update_table.execute(self, allocator, input, options);
    }

    /// Enables you to write your time-series data into Timestream. You can specify
    /// a
    /// single data point or a batch of data points to be inserted into the system.
    /// Timestream offers you a flexible schema that auto detects the column names
    /// and data
    /// types for your Timestream tables based on the dimension names and data types
    /// of
    /// the data points you specify when invoking writes into the database.
    ///
    /// Timestream supports eventual consistency read semantics. This means that
    /// when
    /// you query data immediately after writing a batch of data into Timestream,
    /// the
    /// query results might not reflect the results of a recently completed write
    /// operation. The
    /// results may also include some stale data. If you repeat the query request
    /// after a short
    /// time, the results should return the latest data. [Service quotas
    /// apply](https://docs.aws.amazon.com/timestream/latest/developerguide/ts-limits.html).
    ///
    /// See [code
    /// sample](https://docs.aws.amazon.com/timestream/latest/developerguide/code-samples.write.html) for
    /// details.
    ///
    /// **Upserts**
    ///
    /// You can use the `Version` parameter in a `WriteRecords` request to
    /// update data points. Timestream tracks a version number with each record.
    /// `Version` defaults to `1` when it's not specified for the record
    /// in the request. Timestream updates an existing record’s measure value along
    /// with
    /// its `Version` when it receives a write request with a higher
    /// `Version` number for that record. When it receives an update request where
    /// the measure value is the same as that of the existing record, Timestream
    /// still
    /// updates `Version`, if it is greater than the existing value of
    /// `Version`. You can update a data point as many times as desired, as long as
    /// the value of `Version` continuously increases.
    ///
    /// For example, suppose you write a new record without indicating `Version` in
    /// the request. Timestream stores this record, and set `Version` to
    /// `1`. Now, suppose you try to update this record with a
    /// `WriteRecords` request of the same record with a different measure value
    /// but,
    /// like before, do not provide `Version`. In this case, Timestream will
    /// reject this update with a `RejectedRecordsException` since the updated
    /// record’s
    /// version is not greater than the existing value of Version.
    ///
    /// However, if you were to resend the update request with `Version` set to
    /// `2`, Timestream would then succeed in updating the record’s value,
    /// and the `Version` would be set to `2`. Next, suppose you sent a
    /// `WriteRecords` request with this same record and an identical measure value,
    /// but with `Version` set to `3`. In this case, Timestream
    /// would only update `Version` to `3`. Any further updates would need to
    /// send a version number greater than `3`, or the update requests would receive
    /// a
    /// `RejectedRecordsException`.
    pub fn writeRecords(self: *Self, allocator: std.mem.Allocator, input: write_records.WriteRecordsInput, options: CallOptions) !write_records.WriteRecordsOutput {
        return write_records.execute(self, allocator, input, options);
    }

    pub fn listBatchLoadTasksPaginator(self: *Self, params: list_batch_load_tasks.ListBatchLoadTasksInput) paginator.ListBatchLoadTasksPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listDatabasesPaginator(self: *Self, params: list_databases.ListDatabasesInput) paginator.ListDatabasesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listTablesPaginator(self: *Self, params: list_tables.ListTablesInput) paginator.ListTablesPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }
};
