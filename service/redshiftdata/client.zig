const aws = @import("aws");
const std = @import("std");

const batch_execute_statement = @import("batch_execute_statement.zig");
const cancel_statement = @import("cancel_statement.zig");
const describe_statement = @import("describe_statement.zig");
const describe_table = @import("describe_table.zig");
const execute_statement = @import("execute_statement.zig");
const get_statement_result = @import("get_statement_result.zig");
const get_statement_result_v2 = @import("get_statement_result_v2.zig");
const list_databases = @import("list_databases.zig");
const list_schemas = @import("list_schemas.zig");
const list_statements = @import("list_statements.zig");
const list_tables = @import("list_tables.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Redshift Data";

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

    /// Runs one or more SQL statements, which can be data manipulation language
    /// (DML) or data definition language (DDL). Depending on the authorization
    /// method, use one of the following combinations of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn batchExecuteStatement(self: *Self, allocator: std.mem.Allocator, input: batch_execute_statement.BatchExecuteStatementInput, options: CallOptions) !batch_execute_statement.BatchExecuteStatementOutput {
        return batch_execute_statement.execute(self, allocator, input, options);
    }

    /// Cancels a running query. To be canceled, a query must be running.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn cancelStatement(self: *Self, allocator: std.mem.Allocator, input: cancel_statement.CancelStatementInput, options: CallOptions) !cancel_statement.CancelStatementOutput {
        return cancel_statement.execute(self, allocator, input, options);
    }

    /// Describes the details about a specific instance when a query was run by the
    /// Amazon Redshift Data API. The information includes when the query started,
    /// when it finished, the query status, the number of rows returned, and the SQL
    /// statement.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn describeStatement(self: *Self, allocator: std.mem.Allocator, input: describe_statement.DescribeStatementInput, options: CallOptions) !describe_statement.DescribeStatementOutput {
        return describe_statement.execute(self, allocator, input, options);
    }

    /// Describes the detailed information about a table from metadata in the
    /// cluster. The information includes its columns. A token is returned to page
    /// through the column list. Depending on the authorization method, use one of
    /// the following combinations of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn describeTable(self: *Self, allocator: std.mem.Allocator, input: describe_table.DescribeTableInput, options: CallOptions) !describe_table.DescribeTableOutput {
        return describe_table.execute(self, allocator, input, options);
    }

    /// Runs an SQL statement, which can be data manipulation language (DML) or data
    /// definition language (DDL). This statement must be a single SQL statement.
    /// Depending on the authorization method, use one of the following combinations
    /// of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn executeStatement(self: *Self, allocator: std.mem.Allocator, input: execute_statement.ExecuteStatementInput, options: CallOptions) !execute_statement.ExecuteStatementOutput {
        return execute_statement.execute(self, allocator, input, options);
    }

    /// Fetches the temporarily cached result of an SQL statement in JSON format.
    /// The `ExecuteStatement` or `BatchExecuteStatement` operation that ran the SQL
    /// statement must have specified `ResultFormat` as `JSON` , or let the format
    /// default to JSON. A token is returned to page through the statement results.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn getStatementResult(self: *Self, allocator: std.mem.Allocator, input: get_statement_result.GetStatementResultInput, options: CallOptions) !get_statement_result.GetStatementResultOutput {
        return get_statement_result.execute(self, allocator, input, options);
    }

    /// Fetches the temporarily cached result of an SQL statement in CSV format. The
    /// `ExecuteStatement` or `BatchExecuteStatement` operation that ran the SQL
    /// statement must have specified `ResultFormat` as `CSV`. A token is returned
    /// to page through the statement results.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn getStatementResultV2(self: *Self, allocator: std.mem.Allocator, input: get_statement_result_v2.GetStatementResultV2Input, options: CallOptions) !get_statement_result_v2.GetStatementResultV2Output {
        return get_statement_result_v2.execute(self, allocator, input, options);
    }

    /// List the databases in a cluster. A token is returned to page through the
    /// database list. Depending on the authorization method, use one of the
    /// following combinations of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn listDatabases(self: *Self, allocator: std.mem.Allocator, input: list_databases.ListDatabasesInput, options: CallOptions) !list_databases.ListDatabasesOutput {
        return list_databases.execute(self, allocator, input, options);
    }

    /// Lists the schemas in a database. A token is returned to page through the
    /// schema list. Depending on the authorization method, use one of the following
    /// combinations of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn listSchemas(self: *Self, allocator: std.mem.Allocator, input: list_schemas.ListSchemasInput, options: CallOptions) !list_schemas.ListSchemasOutput {
        return list_schemas.execute(self, allocator, input, options);
    }

    /// List of SQL statements. By default, only finished statements are shown. A
    /// token is returned to page through the statement list.
    ///
    /// When you use identity-enhanced role sessions to list statements, you must
    /// provide either the `cluster-identifier` or `workgroup-name` parameter. This
    /// ensures that the IdC user can only access the Amazon Redshift IdC
    /// applications they are assigned. For more information, see [ Trusted identity
    /// propagation
    /// overview](https://docs.aws.amazon.com/singlesignon/latest/userguide/trustedidentitypropagation-overview.html).
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn listStatements(self: *Self, allocator: std.mem.Allocator, input: list_statements.ListStatementsInput, options: CallOptions) !list_statements.ListStatementsOutput {
        return list_statements.execute(self, allocator, input, options);
    }

    /// List the tables in a database. If neither `SchemaPattern` nor `TablePattern`
    /// are specified, then all tables in the database are returned. A token is
    /// returned to page through the table list. Depending on the authorization
    /// method, use one of the following combinations of request parameters:
    ///
    /// * Secrets Manager - when connecting to a cluster, provide the `secret-arn`
    ///   of a secret stored in Secrets Manager which has `username` and `password`.
    ///   The specified secret contains credentials to connect to the `database` you
    ///   specify. When you are connecting to a cluster, you also supply the
    ///   database name, If you provide a cluster identifier
    ///   (`dbClusterIdentifier`), it must match the cluster identifier stored in
    ///   the secret. When you are connecting to a serverless workgroup, you also
    ///   supply the database name.
    /// * Temporary credentials - when connecting to your data warehouse, choose one
    ///   of the following options:
    ///
    /// * When connecting to a serverless workgroup, specify the workgroup name and
    ///   database name. The database user name is derived from the IAM identity.
    ///   For example, `arn:iam::123456789012:user:foo` has the database user name
    ///   `IAM:foo`. Also, permission to call the
    ///   `redshift-serverless:GetCredentials` operation is required.
    /// * When connecting to a cluster as an IAM identity, specify the cluster
    ///   identifier and the database name. The database user name is derived from
    ///   the IAM identity. For example, `arn:iam::123456789012:user:foo` has the
    ///   database user name `IAM:foo`. Also, permission to call the
    ///   `redshift:GetClusterCredentialsWithIAM` operation is required.
    /// * When connecting to a cluster as a database user, specify the cluster
    ///   identifier, the database name, and the database user name. Also,
    ///   permission to call the `redshift:GetClusterCredentials` operation is
    ///   required.
    ///
    /// For more information about the Amazon Redshift Data API and CLI usage
    /// examples, see [Using the Amazon Redshift Data
    /// API](https://docs.aws.amazon.com/redshift/latest/mgmt/data-api.html) in the
    /// *Amazon Redshift Management Guide*.
    pub fn listTables(self: *Self, allocator: std.mem.Allocator, input: list_tables.ListTablesInput, options: CallOptions) !list_tables.ListTablesOutput {
        return list_tables.execute(self, allocator, input, options);
    }

    pub fn describeTablePaginator(self: *Self, params: describe_table.DescribeTableInput) paginator.DescribeTablePaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getStatementResultPaginator(self: *Self, params: get_statement_result.GetStatementResultInput) paginator.GetStatementResultPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn getStatementResultV2Paginator(self: *Self, params: get_statement_result_v2.GetStatementResultV2Input) paginator.GetStatementResultV2Paginator {
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

    pub fn listSchemasPaginator(self: *Self, params: list_schemas.ListSchemasInput) paginator.ListSchemasPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listStatementsPaginator(self: *Self, params: list_statements.ListStatementsInput) paginator.ListStatementsPaginator {
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
