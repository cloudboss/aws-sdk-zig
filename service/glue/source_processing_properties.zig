/// The resource properties associated with the integration source.
pub const SourceProcessingProperties = struct {
    /// The IAM role to access the Glue connection.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .role_arn = "RoleArn",
    };
};
