const aws = @import("aws");
const std = @import("std");

const create_keyspace = @import("create_keyspace.zig");
const create_table = @import("create_table.zig");
const create_type = @import("create_type.zig");
const delete_keyspace = @import("delete_keyspace.zig");
const delete_table = @import("delete_table.zig");
const delete_type = @import("delete_type.zig");
const get_keyspace = @import("get_keyspace.zig");
const get_table = @import("get_table.zig");
const get_table_auto_scaling_settings = @import("get_table_auto_scaling_settings.zig");
const get_type = @import("get_type.zig");
const list_keyspaces = @import("list_keyspaces.zig");
const list_tables = @import("list_tables.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_types = @import("list_types.zig");
const restore_table = @import("restore_table.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_keyspace = @import("update_keyspace.zig");
const update_table = @import("update_table.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Keyspaces";

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

    /// The `CreateKeyspace` operation adds a new keyspace to your account. In an
    /// Amazon Web Services account, keyspace names must be unique within each
    /// Region.
    ///
    /// `CreateKeyspace` is an asynchronous operation. You can monitor the creation
    /// status of the new keyspace by using the `GetKeyspace` operation.
    ///
    /// For more information, see [Create a
    /// keyspace](https://docs.aws.amazon.com/keyspaces/latest/devguide/getting-started.keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
    pub fn createKeyspace(self: *Self, allocator: std.mem.Allocator, input: create_keyspace.CreateKeyspaceInput, options: create_keyspace.Options) !create_keyspace.CreateKeyspaceOutput {
        return create_keyspace.execute(self, allocator, input, options);
    }

    /// The `CreateTable` operation adds a new table to the specified keyspace.
    /// Within a keyspace, table names must be unique.
    ///
    /// `CreateTable` is an asynchronous operation. When the request is received,
    /// the status of the table is set to `CREATING`. You can monitor the creation
    /// status of the new table by using the `GetTable` operation, which returns the
    /// current `status` of the table. You can start using a table when the status
    /// is `ACTIVE`.
    ///
    /// For more information, see [Create a
    /// table](https://docs.aws.amazon.com/keyspaces/latest/devguide/getting-started.tables.html) in the *Amazon Keyspaces Developer Guide*.
    pub fn createTable(self: *Self, allocator: std.mem.Allocator, input: create_table.CreateTableInput, options: create_table.Options) !create_table.CreateTableOutput {
        return create_table.execute(self, allocator, input, options);
    }

    /// The `CreateType` operation creates a new user-defined type in the specified
    /// keyspace.
    ///
    /// To configure the required permissions, see [Permissions to create a
    /// UDT](https://docs.aws.amazon.com/keyspaces/latest/devguide/configure-udt-permissions.html#udt-permissions-create) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// For more information, see [User-defined types
    /// (UDTs)](https://docs.aws.amazon.com/keyspaces/latest/devguide/udts.html) in
    /// the *Amazon Keyspaces Developer Guide*.
    pub fn createType(self: *Self, allocator: std.mem.Allocator, input: create_type.CreateTypeInput, options: create_type.Options) !create_type.CreateTypeOutput {
        return create_type.execute(self, allocator, input, options);
    }

    /// The `DeleteKeyspace` operation deletes a keyspace and all of its tables.
    pub fn deleteKeyspace(self: *Self, allocator: std.mem.Allocator, input: delete_keyspace.DeleteKeyspaceInput, options: delete_keyspace.Options) !delete_keyspace.DeleteKeyspaceOutput {
        return delete_keyspace.execute(self, allocator, input, options);
    }

    /// The `DeleteTable` operation deletes a table and all of its data. After a
    /// `DeleteTable` request is received, the specified table is in the `DELETING`
    /// state until Amazon Keyspaces completes the deletion. If the table is in the
    /// `ACTIVE` state, you can delete it. If a table is either in the `CREATING` or
    /// `UPDATING` states, then Amazon Keyspaces returns a `ResourceInUseException`.
    /// If the specified table does not exist, Amazon Keyspaces returns a
    /// `ResourceNotFoundException`. If the table is already in the `DELETING`
    /// state, no error is returned.
    pub fn deleteTable(self: *Self, allocator: std.mem.Allocator, input: delete_table.DeleteTableInput, options: delete_table.Options) !delete_table.DeleteTableOutput {
        return delete_table.execute(self, allocator, input, options);
    }

    /// The `DeleteType` operation deletes a user-defined type (UDT). You can only
    /// delete a type that is not used in a table or another UDT.
    ///
    /// To configure the required permissions, see [Permissions to delete a
    /// UDT](https://docs.aws.amazon.com/keyspaces/latest/devguide/configure-udt-permissions.html#udt-permissions-drop) in the *Amazon Keyspaces Developer Guide*.
    pub fn deleteType(self: *Self, allocator: std.mem.Allocator, input: delete_type.DeleteTypeInput, options: delete_type.Options) !delete_type.DeleteTypeOutput {
        return delete_type.execute(self, allocator, input, options);
    }

    /// Returns the name of the specified keyspace, the Amazon Resource Name (ARN),
    /// the replication strategy, the Amazon Web Services Regions of a multi-Region
    /// keyspace, and the status of newly added Regions after an `UpdateKeyspace`
    /// operation.
    pub fn getKeyspace(self: *Self, allocator: std.mem.Allocator, input: get_keyspace.GetKeyspaceInput, options: get_keyspace.Options) !get_keyspace.GetKeyspaceOutput {
        return get_keyspace.execute(self, allocator, input, options);
    }

    /// Returns information about the table, including the table's name and current
    /// status, the keyspace name, configuration settings, and metadata.
    ///
    /// To read table metadata using `GetTable`, the IAM principal needs `Select`
    /// action permissions for the table and the system keyspace.
    pub fn getTable(self: *Self, allocator: std.mem.Allocator, input: get_table.GetTableInput, options: get_table.Options) !get_table.GetTableOutput {
        return get_table.execute(self, allocator, input, options);
    }

    /// Returns auto scaling related settings of the specified table in JSON format.
    /// If the table is a multi-Region table, the Amazon Web Services Region
    /// specific auto scaling settings of the table are included.
    ///
    /// Amazon Keyspaces auto scaling helps you provision throughput capacity for
    /// variable workloads efficiently by increasing and decreasing your table's
    /// read and write capacity automatically in response to application traffic.
    /// For more information, see [Managing throughput capacity automatically with
    /// Amazon Keyspaces auto
    /// scaling](https://docs.aws.amazon.com/keyspaces/latest/devguide/autoscaling.html) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// `GetTableAutoScalingSettings` can't be used as an action in an IAM policy.
    ///
    /// To define permissions for `GetTableAutoScalingSettings`, you must allow the
    /// following two actions in the IAM policy statement's `Action` element:
    ///
    /// * `application-autoscaling:DescribeScalableTargets`
    /// * `application-autoscaling:DescribeScalingPolicies`
    pub fn getTableAutoScalingSettings(self: *Self, allocator: std.mem.Allocator, input: get_table_auto_scaling_settings.GetTableAutoScalingSettingsInput, options: get_table_auto_scaling_settings.Options) !get_table_auto_scaling_settings.GetTableAutoScalingSettingsOutput {
        return get_table_auto_scaling_settings.execute(self, allocator, input, options);
    }

    /// The `GetType` operation returns information about the type, for example the
    /// field definitions, the timestamp when the type was last modified, the level
    /// of nesting, the status, and details about if the type is used in other types
    /// and tables.
    ///
    /// To read keyspace metadata using `GetType`, the IAM principal needs `Select`
    /// action permissions for the system keyspace. To configure the required
    /// permissions, see [Permissions to view a
    /// UDT](https://docs.aws.amazon.com/keyspaces/latest/devguide/configure-udt-permissions.html#udt-permissions-view) in the *Amazon Keyspaces Developer Guide*.
    pub fn getType(self: *Self, allocator: std.mem.Allocator, input: get_type.GetTypeInput, options: get_type.Options) !get_type.GetTypeOutput {
        return get_type.execute(self, allocator, input, options);
    }

    /// The `ListKeyspaces` operation returns a list of keyspaces.
    pub fn listKeyspaces(self: *Self, allocator: std.mem.Allocator, input: list_keyspaces.ListKeyspacesInput, options: list_keyspaces.Options) !list_keyspaces.ListKeyspacesOutput {
        return list_keyspaces.execute(self, allocator, input, options);
    }

    /// The `ListTables` operation returns a list of tables for a specified
    /// keyspace.
    ///
    /// To read keyspace metadata using `ListTables`, the IAM principal needs
    /// `Select` action permissions for the system keyspace.
    pub fn listTables(self: *Self, allocator: std.mem.Allocator, input: list_tables.ListTablesInput, options: list_tables.Options) !list_tables.ListTablesOutput {
        return list_tables.execute(self, allocator, input, options);
    }

    /// Returns a list of all tags associated with the specified Amazon Keyspaces
    /// resource.
    ///
    /// To read keyspace metadata using `ListTagsForResource`, the IAM principal
    /// needs `Select` action permissions for the specified resource and the system
    /// keyspace.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// The `ListTypes` operation returns a list of types for a specified keyspace.
    ///
    /// To read keyspace metadata using `ListTypes`, the IAM principal needs
    /// `Select` action permissions for the system keyspace. To configure the
    /// required permissions, see [Permissions to view a
    /// UDT](https://docs.aws.amazon.com/keyspaces/latest/devguide/configure-udt-permissions.html#udt-permissions-view) in the *Amazon Keyspaces Developer Guide*.
    pub fn listTypes(self: *Self, allocator: std.mem.Allocator, input: list_types.ListTypesInput, options: list_types.Options) !list_types.ListTypesOutput {
        return list_types.execute(self, allocator, input, options);
    }

    /// Restores the table to the specified point in time within the
    /// `earliest_restorable_timestamp` and the current time. For more information
    /// about restore points, see [ Time window for PITR continuous
    /// backups](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery_HowItWorks.html#howitworks_backup_window) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// Any number of users can execute up to 4 concurrent restores (any type of
    /// restore) in a given account.
    ///
    /// When you restore using point in time recovery, Amazon Keyspaces restores
    /// your source table's schema and data to the state based on the selected
    /// timestamp `(day:hour:minute:second)` to a new table. The Time to Live (TTL)
    /// settings are also restored to the state based on the selected timestamp.
    ///
    /// In addition to the table's schema, data, and TTL settings, `RestoreTable`
    /// restores the capacity mode, auto scaling settings, encryption settings, and
    /// point-in-time recovery settings from the source table. Unlike the table's
    /// schema data and TTL settings, which are restored based on the selected
    /// timestamp, these settings are always restored based on the table's settings
    /// as of the current time or when the table was deleted.
    ///
    /// You can also overwrite these settings during restore:
    ///
    /// * Read/write capacity mode
    /// * Provisioned throughput capacity units
    /// * Auto scaling settings
    /// * Point-in-time (PITR) settings
    /// * Tags
    ///
    /// For more information, see [PITR restore
    /// settings](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery_HowItWorks.html#howitworks_backup_settings) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// Note that the following settings are not restored, and you must configure
    /// them manually for the new table:
    ///
    /// * Identity and Access Management (IAM) policies
    /// * Amazon CloudWatch metrics and alarms
    pub fn restoreTable(self: *Self, allocator: std.mem.Allocator, input: restore_table.RestoreTableInput, options: restore_table.Options) !restore_table.RestoreTableOutput {
        return restore_table.execute(self, allocator, input, options);
    }

    /// Associates a set of tags with a Amazon Keyspaces resource. You can then
    /// activate these user-defined tags so that they appear on the Cost Management
    /// Console for cost allocation tracking. For more information, see [Adding tags
    /// and labels to Amazon Keyspaces
    /// resources](https://docs.aws.amazon.com/keyspaces/latest/devguide/tagging-keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// For IAM policy examples that show how to control access to Amazon Keyspaces
    /// resources based on tags, see [Amazon Keyspaces resource access based on
    /// tags](https://docs.aws.amazon.com/keyspaces/latest/devguide/security_iam_id-based-policy-examples.html#security_iam_id-based-policy-examples-tags) in the *Amazon Keyspaces Developer Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the association of tags from a Amazon Keyspaces resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Adds a new Amazon Web Services Region to the keyspace. You can add a new
    /// Region to a keyspace that is either a single or a multi-Region keyspace.
    /// Amazon Keyspaces is going to replicate all tables in the keyspace to the new
    /// Region. To successfully replicate all tables to the new Region, they must
    /// use client-side timestamps for conflict resolution. To enable client-side
    /// timestamps, specify `clientSideTimestamps.status = enabled` when invoking
    /// the API. For more information about client-side timestamps, see [Client-side
    /// timestamps in Amazon
    /// Keyspaces](https://docs.aws.amazon.com/keyspaces/latest/devguide/client-side-timestamps.html) in the *Amazon Keyspaces Developer Guide*.
    ///
    /// To add a Region to a keyspace using the `UpdateKeyspace` API, the IAM
    /// principal needs permissions for the following IAM actions:
    ///
    /// * `cassandra:Alter`
    /// * `cassandra:AlterMultiRegionResource`
    /// * `cassandra:Create`
    /// * `cassandra:CreateMultiRegionResource`
    /// * `cassandra:Select`
    /// * `cassandra:SelectMultiRegionResource`
    /// * `cassandra:Modify`
    /// * `cassandra:ModifyMultiRegionResource`
    ///
    /// If the keyspace contains a table that is configured in provisioned mode with
    /// auto scaling enabled, the following additional IAM actions need to be
    /// allowed.
    ///
    /// * `application-autoscaling:RegisterScalableTarget`
    /// * `application-autoscaling:DeregisterScalableTarget`
    /// * `application-autoscaling:DescribeScalableTargets`
    /// * `application-autoscaling:PutScalingPolicy`
    /// * `application-autoscaling:DescribeScalingPolicies`
    ///
    /// To use the `UpdateKeyspace` API, the IAM principal also needs permissions to
    /// create a service-linked role with the following elements:
    ///
    /// * `iam:CreateServiceLinkedRole` - The **action** the principal can perform.
    /// *
    ///   `arn:aws:iam::*:role/aws-service-role/replication.cassandra.amazonaws.com/AWSServiceRoleForKeyspacesReplication` - The **resource** that the action can be performed on.
    /// * `iam:AWSServiceName: replication.cassandra.amazonaws.com` - The only
    ///   Amazon Web Services service that this role can be attached to is Amazon
    ///   Keyspaces.
    ///
    /// For more information, see [Configure the IAM permissions required to add an
    /// Amazon Web Services Region to a
    /// keyspace](https://docs.aws.amazon.com/keyspaces/latest/devguide/howitworks_replication_permissions_addReplica.html) in the *Amazon Keyspaces Developer Guide*.
    pub fn updateKeyspace(self: *Self, allocator: std.mem.Allocator, input: update_keyspace.UpdateKeyspaceInput, options: update_keyspace.Options) !update_keyspace.UpdateKeyspaceOutput {
        return update_keyspace.execute(self, allocator, input, options);
    }

    /// Adds new columns to the table or updates one of the table's settings, for
    /// example capacity mode, auto scaling, encryption, point-in-time recovery, or
    /// ttl settings. Note that you can only update one specific table setting per
    /// update operation.
    pub fn updateTable(self: *Self, allocator: std.mem.Allocator, input: update_table.UpdateTableInput, options: update_table.Options) !update_table.UpdateTableOutput {
        return update_table.execute(self, allocator, input, options);
    }

    pub fn listKeyspacesPaginator(self: *Self, params: list_keyspaces.ListKeyspacesInput) paginator.ListKeyspacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTablesPaginator(self: *Self, params: list_tables.ListTablesInput) paginator.ListTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTagsForResourcePaginator(self: *Self, params: list_tags_for_resource.ListTagsForResourceInput) paginator.ListTagsForResourcePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listTypesPaginator(self: *Self, params: list_types.ListTypesInput) paginator.ListTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
