const ProtectedQueryS3OutputConfiguration = @import("protected_query_s3_output_configuration.zig").ProtectedQueryS3OutputConfiguration;

/// Contains configurations for protected query results.
pub const MembershipProtectedQueryOutputConfiguration = union(enum) {
    s_3: ?ProtectedQueryS3OutputConfiguration,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
