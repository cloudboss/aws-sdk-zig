/// Specifies additional options for DynamoDB ELT catalog operations.
pub const DDBELTCatalogAdditionalOptions = struct {
    /// Specifies the DynamoDB export configuration for the ELT operation.
    dynamodb_export: ?[]const u8 = null,

    /// Specifies whether to unnest DynamoDB JSON format. When set to `true`, nested
    /// JSON structures in DynamoDB items are flattened.
    dynamodb_unnest_ddb_json: bool = false,

    pub const json_field_names = .{
        .dynamodb_export = "DynamodbExport",
        .dynamodb_unnest_ddb_json = "DynamodbUnnestDDBJson",
    };
};
