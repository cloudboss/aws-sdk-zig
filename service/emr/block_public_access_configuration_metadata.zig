/// Properties that describe the Amazon Web Services principal that created the
/// `BlockPublicAccessConfiguration` using the
/// `PutBlockPublicAccessConfiguration` action as well as the date and time that
/// the configuration was created. Each time a configuration for block public
/// access is
/// updated, Amazon EMR updates this metadata.
pub const BlockPublicAccessConfigurationMetadata = struct {
    /// The Amazon Resource Name that created or last modified the configuration.
    created_by_arn: []const u8,

    /// The date and time that the configuration was created.
    creation_date_time: i64,

    pub const json_field_names = .{
        .created_by_arn = "CreatedByArn",
        .creation_date_time = "CreationDateTime",
    };
};
