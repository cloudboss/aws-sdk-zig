const AttributeDefinition = @import("attribute_definition.zig").AttributeDefinition;
const BillingMode = @import("billing_mode.zig").BillingMode;
const GlobalSecondaryIndex = @import("global_secondary_index.zig").GlobalSecondaryIndex;
const KeySchemaElement = @import("key_schema_element.zig").KeySchemaElement;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const SSESpecification = @import("sse_specification.zig").SSESpecification;

/// The parameters for the table created as part of the import operation.
pub const TableCreationParameters = struct {
    /// The attributes of the table created as part of the import operation.
    attribute_definitions: []const AttributeDefinition,

    /// The billing mode for provisioning the table created as part of the import
    /// operation.
    billing_mode: ?BillingMode = null,

    /// The Global Secondary Indexes (GSI) of the table to be created as part of the
    /// import
    /// operation.
    global_secondary_indexes: ?[]const GlobalSecondaryIndex = null,

    /// The primary key and option sort key of the table created as part of the
    /// import
    /// operation.
    key_schema: []const KeySchemaElement,

    on_demand_throughput: ?OnDemandThroughput = null,

    provisioned_throughput: ?ProvisionedThroughput = null,

    sse_specification: ?SSESpecification = null,

    /// The name of the table created as part of the import operation.
    table_name: []const u8,

    pub const json_field_names = .{
        .attribute_definitions = "AttributeDefinitions",
        .billing_mode = "BillingMode",
        .global_secondary_indexes = "GlobalSecondaryIndexes",
        .key_schema = "KeySchema",
        .on_demand_throughput = "OnDemandThroughput",
        .provisioned_throughput = "ProvisionedThroughput",
        .sse_specification = "SSESpecification",
        .table_name = "TableName",
    };
};
