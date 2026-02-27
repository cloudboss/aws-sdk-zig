const aws = @import("aws");
const std = @import("std");

const batch_execute_statement = @import("batch_execute_statement.zig");
const begin_transaction = @import("begin_transaction.zig");
const commit_transaction = @import("commit_transaction.zig");
const execute_sql = @import("execute_sql.zig");
const execute_statement = @import("execute_statement.zig");
const rollback_transaction = @import("rollback_transaction.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "RDS Data";

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

    /// Runs a batch SQL statement over an array of data.
    ///
    /// You can run bulk update and insert operations for multiple records using a
    /// DML
    /// statement with different parameter sets. Bulk operations can provide a
    /// significant
    /// performance improvement over individual insert and update operations.
    ///
    /// If a call isn't part of a transaction because it doesn't include the
    /// `transactionID` parameter,
    /// changes that result from the call are committed automatically.
    ///
    /// There isn't a fixed upper limit on the number of parameter sets. However,
    /// the maximum size of the HTTP request
    /// submitted through the Data API is 4 MiB. If the request exceeds this limit,
    /// the Data API returns an error and doesn't
    /// process the request. This 4-MiB limit includes the size of the HTTP headers
    /// and the JSON notation in the request. Thus, the
    /// number of parameter sets that you can include depends on a combination of
    /// factors, such as the size of the SQL statement and
    /// the size of each parameter set.
    ///
    /// The response size limit is 1 MiB. If the call returns more than 1 MiB of
    /// response data, the call is terminated.
    pub fn batchExecuteStatement(self: *Self, allocator: std.mem.Allocator, input: batch_execute_statement.BatchExecuteStatementInput, options: batch_execute_statement.Options) !batch_execute_statement.BatchExecuteStatementOutput {
        return batch_execute_statement.execute(self, allocator, input, options);
    }

    /// Starts a SQL transaction.
    ///
    /// A transaction can run for a maximum of 24 hours. A transaction is terminated
    /// and rolled back automatically after 24
    /// hours.
    ///
    /// A transaction times out if no calls use its transaction ID in three minutes.
    /// If a transaction times out before it's
    /// committed, it's rolled back automatically.
    ///
    /// For Aurora MySQL, DDL statements inside a transaction cause an implicit
    /// commit. We recommend that you run each MySQL DDL statement in a separate
    /// `ExecuteStatement` call with `continueAfterTimeout` enabled.
    pub fn beginTransaction(self: *Self, allocator: std.mem.Allocator, input: begin_transaction.BeginTransactionInput, options: begin_transaction.Options) !begin_transaction.BeginTransactionOutput {
        return begin_transaction.execute(self, allocator, input, options);
    }

    /// Ends a SQL transaction started with the `BeginTransaction` operation and
    /// commits the changes.
    pub fn commitTransaction(self: *Self, allocator: std.mem.Allocator, input: commit_transaction.CommitTransactionInput, options: commit_transaction.Options) !commit_transaction.CommitTransactionOutput {
        return commit_transaction.execute(self, allocator, input, options);
    }

    /// Runs one or more SQL statements.
    ///
    /// This operation isn't supported for Aurora Serverless v2 and provisioned DB
    /// clusters.
    /// For Aurora Serverless v1 DB clusters, the operation is deprecated.
    /// Use the `BatchExecuteStatement` or `ExecuteStatement` operation.
    pub fn executeSql(self: *Self, allocator: std.mem.Allocator, input: execute_sql.ExecuteSqlInput, options: execute_sql.Options) !execute_sql.ExecuteSqlOutput {
        return execute_sql.execute(self, allocator, input, options);
    }

    /// Runs a SQL statement against a database.
    ///
    /// If a call isn't part of a transaction because it doesn't include the
    /// `transactionID` parameter, changes that result from the call are
    /// committed automatically.
    ///
    /// If the binary response data from the database is more than 1 MB, the call is
    /// terminated.
    pub fn executeStatement(self: *Self, allocator: std.mem.Allocator, input: execute_statement.ExecuteStatementInput, options: execute_statement.Options) !execute_statement.ExecuteStatementOutput {
        return execute_statement.execute(self, allocator, input, options);
    }

    /// Performs a rollback of a transaction. Rolling back a transaction cancels its
    /// changes.
    pub fn rollbackTransaction(self: *Self, allocator: std.mem.Allocator, input: rollback_transaction.RollbackTransactionInput, options: rollback_transaction.Options) !rollback_transaction.RollbackTransactionOutput {
        return rollback_transaction.execute(self, allocator, input, options);
    }
};
