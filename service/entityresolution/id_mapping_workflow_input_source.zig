const IdNamespaceType = @import("id_namespace_type.zig").IdNamespaceType;

/// An object containing `inputSourceARN`, `schemaName`, and `type`.
pub const IdMappingWorkflowInputSource = struct {
    /// An Glue table Amazon Resource Name (ARN) or a matching workflow ARN for the
    /// input source table.
    input_source_arn: []const u8,

    /// The name of the schema to be retrieved.
    schema_name: ?[]const u8,

    /// The type of ID namespace. There are two types: `SOURCE` and `TARGET`.
    ///
    /// The `SOURCE` contains configurations for `sourceId` data that will be
    /// processed in an ID mapping workflow.
    ///
    /// The `TARGET` contains a configuration of `targetId` which all `sourceIds`
    /// will resolve to.
    @"type": ?IdNamespaceType,

    pub const json_field_names = .{
        .input_source_arn = "inputSourceARN",
        .schema_name = "schemaName",
        .@"type" = "type",
    };
};
