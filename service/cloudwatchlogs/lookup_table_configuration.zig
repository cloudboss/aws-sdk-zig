const aws = @import("aws");

/// Configuration for a lookup table destination. Use it to automatically
/// refresh a lookup
/// table with query results on a schedule.
pub const LookupTableConfiguration = struct {
    /// A description of the lookup table.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key to use to encrypt the lookup table data. If you
    /// don't specify a key, the data is encrypted with an Amazon Web Services-owned
    /// key.
    kms_key_id: ?[]const u8 = null,

    /// The ARN of the IAM role that grants permissions to create or update the
    /// lookup table
    /// with query results.
    role_arn: []const u8,

    /// The name of the lookup table to create or update with query results. The
    /// name can
    /// contain only alphanumeric characters and underscores.
    table_name: []const u8,

    /// Key-value pairs to associate with the lookup table for resource management
    /// and cost
    /// allocation. The service applies tags only during initial table creation.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .role_arn = "roleArn",
        .table_name = "tableName",
        .tags = "tags",
    };
};
