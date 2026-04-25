const aws = @import("aws");
const std = @import("std");

const create_export = @import("create_export.zig");
const delete_export = @import("delete_export.zig");
const get_execution = @import("get_execution.zig");
const get_export = @import("get_export.zig");
const get_table = @import("get_table.zig");
const list_executions = @import("list_executions.zig");
const list_exports = @import("list_exports.zig");
const list_tables = @import("list_tables.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_export = @import("update_export.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "BCM Data Exports";

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

    /// Creates a data export and specifies the data query, the delivery preference,
    /// and any optional resource tags.
    ///
    /// A `DataQuery` consists of both a `QueryStatement` and `TableConfigurations`.
    ///
    /// The `QueryStatement` is an SQL statement. Data Exports only supports a
    /// limited subset of the SQL syntax. For more information on the SQL syntax
    /// that is supported, see [Data
    /// query](https://docs.aws.amazon.com/cur/latest/userguide/de-data-query.html).
    /// To view the available tables and columns, see the [Data Exports table
    /// dictionary](https://docs.aws.amazon.com/cur/latest/userguide/de-table-dictionary.html).
    ///
    /// The `TableConfigurations` is a collection of specified `TableProperties` for
    /// the table being queried in the `QueryStatement`. TableProperties are
    /// additional configurations you can provide to change the data and schema of a
    /// table. Each table can have different TableProperties. However, tables are
    /// not required to have any TableProperties. Each table property has a default
    /// value that it assumes if not specified. For more information on table
    /// configurations, see [Data
    /// query](https://docs.aws.amazon.com/cur/latest/userguide/de-data-query.html).
    /// To view the table properties available for each table, see the [Data Exports
    /// table
    /// dictionary](https://docs.aws.amazon.com/cur/latest/userguide/de-table-dictionary.html) or use the `ListTables` API to get a response of all tables and their available properties.
    pub fn createExport(self: *Self, allocator: std.mem.Allocator, input: create_export.CreateExportInput, options: CallOptions) !create_export.CreateExportOutput {
        return create_export.execute(self, allocator, input, options);
    }

    /// Deletes an existing data export.
    pub fn deleteExport(self: *Self, allocator: std.mem.Allocator, input: delete_export.DeleteExportInput, options: CallOptions) !delete_export.DeleteExportOutput {
        return delete_export.execute(self, allocator, input, options);
    }

    /// Exports data based on the source data update.
    pub fn getExecution(self: *Self, allocator: std.mem.Allocator, input: get_execution.GetExecutionInput, options: CallOptions) !get_execution.GetExecutionOutput {
        return get_execution.execute(self, allocator, input, options);
    }

    /// Views the definition of an existing data export.
    pub fn getExport(self: *Self, allocator: std.mem.Allocator, input: get_export.GetExportInput, options: CallOptions) !get_export.GetExportOutput {
        return get_export.execute(self, allocator, input, options);
    }

    /// Returns the metadata for the specified table and table properties. This
    /// includes the list of columns in the table schema, their data types, and
    /// column descriptions.
    pub fn getTable(self: *Self, allocator: std.mem.Allocator, input: get_table.GetTableInput, options: CallOptions) !get_table.GetTableOutput {
        return get_table.execute(self, allocator, input, options);
    }

    /// Lists the historical executions for the export.
    pub fn listExecutions(self: *Self, allocator: std.mem.Allocator, input: list_executions.ListExecutionsInput, options: CallOptions) !list_executions.ListExecutionsOutput {
        return list_executions.execute(self, allocator, input, options);
    }

    /// Lists all data export definitions.
    pub fn listExports(self: *Self, allocator: std.mem.Allocator, input: list_exports.ListExportsInput, options: CallOptions) !list_exports.ListExportsOutput {
        return list_exports.execute(self, allocator, input, options);
    }

    /// Lists all available tables in data exports.
    pub fn listTables(self: *Self, allocator: std.mem.Allocator, input: list_tables.ListTablesInput, options: CallOptions) !list_tables.ListTablesOutput {
        return list_tables.execute(self, allocator, input, options);
    }

    /// List tags associated with an existing data export.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Adds tags for an existing data export definition.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Deletes tags associated with an existing data export definition.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates an existing data export by overwriting all export parameters. All
    /// export parameters must be provided in the UpdateExport request.
    pub fn updateExport(self: *Self, allocator: std.mem.Allocator, input: update_export.UpdateExportInput, options: CallOptions) !update_export.UpdateExportOutput {
        return update_export.execute(self, allocator, input, options);
    }

    pub fn listExecutionsPaginator(self: *Self, params: list_executions.ListExecutionsInput) paginator.ListExecutionsPaginator {
        return .{
            .client = self,
            .params = params,
        };
    }

    pub fn listExportsPaginator(self: *Self, params: list_exports.ListExportsInput) paginator.ListExportsPaginator {
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
