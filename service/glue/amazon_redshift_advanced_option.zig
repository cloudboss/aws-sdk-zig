/// Specifies an optional value when connecting to the Redshift cluster.
pub const AmazonRedshiftAdvancedOption = struct {
    /// The key for the additional connection option.
    key: ?[]const u8 = null,

    /// The value for the additional connection option.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
