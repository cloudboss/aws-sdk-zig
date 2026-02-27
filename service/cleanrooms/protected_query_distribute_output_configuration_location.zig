const ProtectedQueryMemberOutputConfiguration = @import("protected_query_member_output_configuration.zig").ProtectedQueryMemberOutputConfiguration;
const ProtectedQueryS3OutputConfiguration = @import("protected_query_s3_output_configuration.zig").ProtectedQueryS3OutputConfiguration;

/// Specifies where you'll distribute the results of your protected query. You
/// must configure either an S3 destination or a collaboration member
/// destination.
pub const ProtectedQueryDistributeOutputConfigurationLocation = union(enum) {
    member: ?ProtectedQueryMemberOutputConfiguration,
    s_3: ?ProtectedQueryS3OutputConfiguration,

    pub const json_field_names = .{
        .member = "member",
        .s_3 = "s3",
    };
};
