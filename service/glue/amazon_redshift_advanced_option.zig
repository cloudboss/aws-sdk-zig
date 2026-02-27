/// Specifies an optional value when connecting to the Redshift cluster.
pub const AmazonRedshiftAdvancedOption = struct {
    /// The key for the additional connection option.
    key: ?[]const u8,

    /// The value for the additional connection option.
    value: ?[]const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
